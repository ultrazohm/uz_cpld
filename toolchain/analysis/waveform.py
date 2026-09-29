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


def waveform_frame(source: str, title: str):
    """Embed a viewer that can grow to fit its complete signal selector."""
    return f'''<iframe src="{html.escape(source, quote=True)}" title="{html.escape(title, quote=True)}" style="width:100%;height:1202px;border:1px solid #ddd;box-sizing:border-box" loading="lazy"></iframe>
<script>(()=>{{
 const frame=document.currentScript.previousElementSibling;
 window.addEventListener('message',event=>{{
  if(event.source!==frame.contentWindow||event.data?.type!=='cpld-waveform-height')return;
  const height=event.data.height;
  if(Number.isFinite(height)&&height>=1200&&height<=100000)frame.style.height=(height+2)+'px';
 }});
}})();</script>'''


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
    page = '''<!doctype html><html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>TITLE</title><style>
*{box-sizing:border-box}html,body{height:100%;margin:0}
body{font:14px system-ui,sans-serif;padding:10px;color:#223;display:flex;flex-direction:column;gap:6px;min-height:1200px}
h2{font-size:18px;margin:0;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;flex-shrink:0}
#controls{flex-shrink:0;min-width:0}
button,input,select{font:inherit;padding:5px}button{cursor:pointer}
.toolbar{display:flex;flex-wrap:wrap;align-items:center;gap:6px;margin:6px 0}
.toolbar label{min-width:0}input,select{max-width:100%}
#filter{width:180px}#channels{border:1px solid #bbb;padding:4px;
display:grid;grid-template-columns:repeat(auto-fit,minmax(min(180px,100%),1fr));grid-auto-rows:24px;gap:2px}
#channels label{white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
#plot-region{flex:1;min-height:0;min-width:0;position:relative}
#wave{position:absolute;inset:0}p{line-height:1.5;margin:6px 0}
summary{cursor:pointer}
</style>
<script>PLOTLY</script></head><body><h2 title="TITLE">TITLE</h2><div id="controls">
<div class="toolbar"><label>Preset <select id="signals"></select></label>
<label>Find signal <input id="filter" type="search" placeholder="Filter signal list"></label>
<button id="select-matches" type="button">Add matches</button>
<button id="clear" type="button">Clear selection</button>
<span id="selected-count" role="status"></span></div>
<div id="channels" role="group" aria-label="Signals shown in waveform"></div>
<details><summary>Viewer help</summary>
<p>The full trace is shown initially. Choose signals, drag to zoom, and use Plotly's Reset axes to return to the full trace.
Hover for exact values. Time is in ns.
Binary signals use low/high levels. Unknown (X) and high-impedance (Z) values
appear at mid-level, with their actual value on hover; buses are scaled to their width.
This is RTL simulation, not a propagation-delay measurement.</p></details></div>
<div id="plot-region"><p id="empty" hidden>Select at least one signal to display.</p><div id="wave"></div></div>
<script>const data=PAYLOAD,picker=document.getElementById('signals');
const list=document.getElementById('channels'),filter=document.getElementById('filter');
const wave=document.getElementById('wave');
const region=document.getElementById('plot-region');
Object.keys(data.groups).forEach(name=>picker.add(new Option(name,name)));
let selected=new Set(data.groups[picker.value]),range=[0,data.duration],bound=false;
const channelRows=data.traces.map((t,id)=>{
 const label=document.createElement('label'),check=document.createElement('input');
 check.type='checkbox';check.onchange=()=>{
  if(check.checked)selected.add(id);else selected.delete(id);render()};
 label.title=t.name;label.append(check,' '+t.label);list.append(label);
 return {label,check};
});
function visibleIds(){const query=filter.value.trim().toLowerCase();
 return data.traces.map((t,id)=>({t,id})).filter(({t})=>t.name.toLowerCase().includes(query)).map(({id})=>id)}
function updateList(){const visible=new Set(visibleIds());
 channelRows.forEach(({label,check},id)=>{label.hidden=!visible.has(id);check.checked=selected.has(id)});
 document.getElementById('selected-count').textContent=`${selected.size} of ${data.traces.length} selected`;
}
let lastHeight;
function sizeViewer(){
 const plotHeight=Math.max(600,selected.size*32+75);
 const height=Math.max(1200,document.getElementById('controls').offsetHeight+document.querySelector('h2').offsetHeight+32+plotHeight);
 if(height!==lastHeight){
  lastHeight=height;document.body.style.minHeight=height+'px';
  if(window.parent!==window)window.parent.postMessage({type:'cpld-waveform-height',height},'*');
 }
}
function plotLayout(ids){
 const width=region.clientWidth,height=region.clientHeight,count=ids.length;
 const left=Math.min(300,width*.4,Math.max(80,...ids.map(id=>data.traces[id].label.length*7+20)));
 const margin={l:left,r:15,t:25,b:50},rows=ids.map((id,row)=>({id,row}));
 const chars=Math.max(5,Math.floor((left-12)/7));
 return {width,height,margin,yaxis:{
  tickvals:rows.map(({row})=>(count-1-row)*2+0.5),
  ticktext:rows.map(({id})=>{const label=data.traces[id].label;return label.length>chars?'…'+label.slice(1-chars):label}),
  tickfont:{size:12},range:[-0.5,count*2-0.5],fixedrange:true}};
}
function render(){const ids=[...selected].sort((a,b)=>a-b),count=ids.length;updateList();sizeViewer();
 document.getElementById('empty').hidden=count>0;wave.hidden=count===0;
 if(!count){Plotly.purge(wave);bound=false;return}
 const traces=ids.map((id,row)=>{const t=data.traces[id]; const offset=(count-1-row)*2;
 return {type:'scatter',mode:'lines',name:t.name,x:t.x,y:t.levels.map(v=>offset+v),
 text:t.text,line:{shape:'hv',width:2,dash:t.text.every(v=>/[^01]/.test(v))?'dot':'solid'},hovertemplate:'%{x:.6g} ns: %{text}<extra>'+t.name+'</extra>'};});
 Plotly.react(wave,traces,{...plotLayout(ids),showlegend:false,
 xaxis:{title:'Simulation time (ns)',range},
 hovermode:'closest',dragmode:'zoom'},
 {responsive:true,displaylogo:false}).then(()=>{if(!bound){
  wave.on('plotly_relayout',changes=>{
   if(!Object.keys(changes).some(key=>key==='xaxis.autorange'||key.startsWith('xaxis.range')))return;
   range=[...wave._fullLayout.xaxis.range]});bound=true}});
}
picker.onchange=()=>{selected=new Set(data.groups[picker.value]);render()};
filter.oninput=updateList;
document.getElementById('select-matches').onclick=()=>{visibleIds().forEach(id=>selected.add(id));render()};
document.getElementById('clear').onclick=()=>{selected.clear();render()};
let resizeFrame;
const observer=new ResizeObserver(()=>{cancelAnimationFrame(resizeFrame);resizeFrame=requestAnimationFrame(()=>{
 sizeViewer();
 if(!wave.data?.length)return;
 const layout=plotLayout([...selected].sort((a,b)=>a-b));
 Plotly.relayout(wave,{width:layout.width,height:layout.height,margin:layout.margin,
  'yaxis.tickvals':layout.yaxis.tickvals,'yaxis.ticktext':layout.yaxis.ticktext});
})});
observer.observe(region);observer.observe(document.getElementById('controls'));
render();</script></body></html>'''
    page = page.replace('TITLE', html.escape(title)).replace('PLOTLY', get_plotlyjs()).replace('PAYLOAD', payload)
    destination.write_text(page)
    return {'duration_ns': duration, 'signal_count': len(signals), 'vcd': vcd.name}
