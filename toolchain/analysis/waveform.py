"""Read VCD transitions and render an offline Plotly digital waveform viewer."""
from dataclasses import dataclass, field
import html
import json
from pathlib import Path

from vcd.reader import TokenKind, tokenize


@dataclass
class Signal:
    name: str
    width: int
    times: list = field(default_factory=list)
    values: list = field(default_factory=list)


def read_vcd(path: Path, end_time_ns: float | None = None):
    """Return signals and duration in ns; keep aliases and unknown values intact."""
    scopes, signals, codes = [], [], {}
    scale = None
    timestamp = 0
    units = {'s': 1e9, 'ms': 1e6, 'us': 1e3, 'ns': 1, 'ps': 1e-3, 'fs': 1e-6}
    with path.open('rb') as stream:
        for token in tokenize(stream):
            if token.kind == TokenKind.TIMESCALE:
                scale = token.timescale.magnitude * units[token.timescale.unit.value]
            elif token.kind == TokenKind.SCOPE:
                scopes.append(token.scope.ident)
            elif token.kind == TokenKind.UPSCOPE:
                scopes.pop()
            elif token.kind == TokenKind.VAR:
                var = token.var
                if var.type_.value not in ('wire', 'reg', 'integer', 'parameter'):
                    continue
                signal = Signal('.'.join(scopes + [var.reference]), var.size)
                signals.append(signal)
                codes.setdefault(var.id_code, []).append(signal)
            elif token.kind == TokenKind.CHANGE_TIME:
                timestamp = token.time_change
            elif token.kind in (TokenKind.CHANGE_SCALAR, TokenKind.CHANGE_VECTOR):
                if scale is None:
                    raise ValueError('VCD has no timescale')
                change = token.data
                for signal in codes.get(change.id_code, []):
                    value = (format(change.value, f'0{signal.width}b') if isinstance(change.value, int)
                             else change.value.upper())
                    time_ns = timestamp * scale
                    # VCD has no delta-cycle axis: retain the last value at a timestamp.
                    if signal.times and signal.times[-1] == time_ns:
                        signal.values[-1] = value
                    elif not signal.values or signal.values[-1] != value:
                        signal.times.append(time_ns)
                        signal.values.append(value)
    if scale is None or not signals:
        raise ValueError('VCD contains no supported digital signals or timescale')
    duration = timestamp * scale
    if end_time_ns is not None:
        if end_time_ns < duration:
            raise ValueError("Simulation end precedes the final VCD timestamp")
        duration = end_time_ns
    for signal in signals:
        if not signal.times:
            signal.times, signal.values = [0], ['X' * signal.width]
        elif signal.times[0] > 0:
            signal.times.insert(0, 0)
            signal.values.insert(0, 'X' * signal.width)
        if signal.times[-1] < duration:
            signal.times.append(duration)
            signal.values.append(signal.values[-1])
    return signals, duration


def write_waveform(vcd: Path, destination: Path, title: str, end_time_ns: float | None = None):
    """Write a standalone interactive HTML viewer with channel selection and zoom."""
    from plotly.offline import get_plotlyjs

    signals, duration = read_vcd(vcd, end_time_ns)
    traces = []
    for signal in signals:
        levels = [int(v, 2) / max(1, 2 ** signal.width - 1)
                  if set(v) <= {'0', '1'} else 0.5 for v in signal.values]
        traces.append({'name': signal.name, 'x': signal.times, 'levels': levels,
                       'text': signal.values, 'width': signal.width})
    # Full hierarchical names prevent collisions; channel shortcuts use leaf names.
    leaf = lambda trace: trace['name'].rsplit('.', 1)[-1]
    safety = ['reqsafestate', 'slotok', 'reqoe', 'enable_forwarding', 'user_enable_forwarding']
    controls = [i for i, t in enumerate(traces) if leaf(t) in safety]
    enable = [i for i, t in enumerate(traces) if leaf(t) in ('fpga_26', 'fpga_27', 'fpga_28', 'fpga_29')]
    groups = {}
    for channel in range(30):
        pair = [i for i, t in enumerate(traces) if leaf(t) in (f'fpga_{channel:02}', f'd_{channel:02}')]
        if pair:
            groups[f'Channel {channel:02} + controls'] = list(dict.fromkeys(controls + enable + pair))
    if not groups:
        groups['Overview'] = list(range(min(12, len(traces))))
    groups['All signals'] = list(range(len(traces)))
    for trace in traces:
        label = leaf(trace)
        trace['label'] = label if sum(leaf(t) == label for t in traces) == 1 else trace['name']
    payload = json.dumps({'traces': traces, 'groups': groups, 'duration': duration}).replace('<', '\\u003c')
    page = '''<!doctype html><html><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>TITLE</title><style>body{font:14px sans-serif;margin:12px;color:#223}
select{padding:6px} #wave{width:100%} p{line-height:1.5}</style>
<script>PLOTLY</script></head><body><h2>TITLE</h2>
<label>Signals <select id="signals"></select></label>
<label>Time window <select id="window"><option value="detail">First 150 ns</option>
<option value="full">Full trace</option></select></label>
<p>Drag to zoom; double-click to reset. Hover for exact values. Time is in ns.
Binary signals use low/high levels. Unknown (X) and high-impedance (Z) values
appear at mid-level, with their actual value on hover; buses are scaled to their width.
This is RTL simulation, not a propagation-delay measurement.</p><div id="wave"></div>
<script>const data=PAYLOAD; const picker=document.getElementById('signals');
Object.keys(data.groups).forEach(name=>picker.add(new Option(name,name)));
function render(){const ids=data.groups[picker.value]; const count=ids.length;
 const traces=ids.map((id,row)=>{const t=data.traces[id]; const offset=(count-1-row)*2;
 return {type:'scatter',mode:'lines',name:t.name,x:t.x,y:t.levels.map(v=>offset+v),
 text:t.text,line:{shape:'hv',width:2,dash:t.text.every(v=>/[^01]/.test(v))?'dot':'solid'},hovertemplate:'%{x:.6g} ns: %{text}<extra>'+t.name+'</extra>'};});
 Plotly.react('wave',traces,{height:Math.max(440,count*38+120),showlegend:false,
 margin:{l:205,r:25,t:20,b:70},xaxis:{title:'Simulation time (ns)',range:[0,document.getElementById('window').value==='full'?data.duration:Math.min(150,data.duration)]},
 yaxis:{tickvals:ids.map((_,i)=>(count-1-i)*2+0.5),ticktext:ids.map(id=>data.traces[id].label),
 range:[-0.5,count*2-0.5],fixedrange:true},hovermode:'closest',dragmode:'zoom'},
 {responsive:true,displaylogo:false});}
picker.onchange=render;document.getElementById('window').onchange=render;render();</script></body></html>'''
    page = page.replace('TITLE', html.escape(title)).replace('PLOTLY', get_plotlyjs()).replace('PAYLOAD', payload)
    destination.write_text(page)
    return {'duration_ns': duration, 'signal_count': len(signals), 'vcd': vcd.name}
