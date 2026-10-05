"""Wrap a Graphviz SVG in a self-contained pan, zoom and search viewer."""
import html
from pathlib import Path


def write_rtl_viewer(svg: Path, destination: Path, title: str):
    source = svg.read_text()
    start = source.find('<svg ')
    if start < 0 or not source.rstrip().endswith('</svg>'):
        raise ValueError(f'Invalid SVG netlist: {svg}')
    drawing = source[start:]
    page = '''<!doctype html><html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>TITLE</title>
<style>
*{box-sizing:border-box}body{margin:0;font:14px system-ui,sans-serif;color:#223;background:#fff}
#viewer{height:100vh;min-height:420px;display:flex;flex-direction:column}
#toolbar{display:flex;align-items:center;flex-wrap:wrap;gap:8px;padding:8px;border-bottom:1px solid #bbb}
button,input{font:inherit;padding:5px 8px}button{cursor:pointer}
#search{min-width:180px;max-width:300px;flex:1}#count{min-width:80px}
#canvas{flex:1;min-height:0;overflow:hidden;background:#f8fafc}
#canvas svg{display:block;width:100%;height:100%;cursor:grab;touch-action:none}
#canvas svg.dragging{cursor:grabbing}
#canvas .rtl-match polygon,#canvas .rtl-match path,#canvas .rtl-match ellipse{stroke:#c92222;stroke-width:4}
#viewer:fullscreen{background:#fff}
</style></head><body><div id="viewer">
<div id="toolbar"><strong>TITLE</strong>
<button id="fit" type="button">Fit</button><button id="zoom-in" type="button" aria-label="Zoom in">+</button>
<button id="zoom-out" type="button" aria-label="Zoom out">−</button>
<input id="search" type="search" placeholder="Find signal or cell" aria-label="Find signal or cell">
<button id="next" type="button">Next match</button><span id="count" role="status"></span>
<button id="fullscreen" type="button">Full screen</button></div>
<div id="canvas">DRAWING</div></div>
<script>
const viewer=document.getElementById('viewer'),svg=document.querySelector('#canvas svg');
const original=svg.viewBox.baseVal;
const full={x:original.x,y:original.y,width:original.width,height:original.height};
let box={...full},matches=[],matchIndex=-1,drag=null;
function show(){svg.setAttribute('viewBox',`${box.x} ${box.y} ${box.width} ${box.height}`)}
function zoom(factor,clientX,clientY){
 const point=svg.createSVGPoint();point.x=clientX;point.y=clientY;
 const center=point.matrixTransform(svg.getScreenCTM().inverse());
 box={x:center.x-(center.x-box.x)*factor,y:center.y-(center.y-box.y)*factor,
      width:box.width*factor,height:box.height*factor};show();
}
document.getElementById('fit').onclick=()=>{box={...full};show()};
document.getElementById('zoom-in').onclick=()=>{const r=svg.getBoundingClientRect();zoom(.7,r.left+r.width/2,r.top+r.height/2)};
document.getElementById('zoom-out').onclick=()=>{const r=svg.getBoundingClientRect();zoom(1/.7,r.left+r.width/2,r.top+r.height/2)};
svg.addEventListener('wheel',e=>{e.preventDefault();zoom(e.deltaY<0 ? 0.8 : 1.25,e.clientX,e.clientY)},{passive:false});
svg.addEventListener('pointerdown',e=>{if(e.button!==0)return;drag={x:e.clientX,y:e.clientY};svg.setPointerCapture(e.pointerId);svg.classList.add('dragging')});
svg.addEventListener('pointermove',e=>{if(!drag)return;
 const matrix=svg.getScreenCTM().inverse(),from=svg.createSVGPoint(),to=svg.createSVGPoint();
 from.x=drag.x;from.y=drag.y;to.x=e.clientX;to.y=e.clientY;
 const a=from.matrixTransform(matrix),b=to.matrixTransform(matrix);
 box.x+=a.x-b.x;box.y+=a.y-b.y;drag={x:e.clientX,y:e.clientY};show();
});
function stopDrag(){drag=null;svg.classList.remove('dragging')}
svg.addEventListener('pointerup',stopDrag);svg.addEventListener('pointercancel',stopDrag);
document.getElementById('fullscreen').onclick=()=>viewer.requestFullscreen();
const search=document.getElementById('search'),count=document.getElementById('count');
function updateSearch(){
 const query=search.value.trim().toLowerCase();
 svg.querySelectorAll('g.node.rtl-match').forEach(node=>node.classList.remove('rtl-match'));
 matches=query?[...svg.querySelectorAll('g.node')].filter(node=>[...node.querySelectorAll('text')]
   .some(label=>label.textContent.toLowerCase().includes(query))):[];
 matches.forEach(node=>node.classList.add('rtl-match'));
 matchIndex=-1;count.textContent=query?`${matches.length} matches`:'';
}
function nextMatch(){
 if(!matches.length)return;
 matchIndex=(matchIndex+1)%matches.length;
 const node=matches[matchIndex],bounds=node.getBBox();
 const point=svg.createSVGPoint();point.x=bounds.x+bounds.width/2;point.y=bounds.y+bounds.height/2;
 const screen=point.matrixTransform(node.getScreenCTM());
 const center=screen.matrixTransform(svg.getScreenCTM().inverse());
 box.width=Math.min(full.width,Math.max(350,bounds.width*8));
 box.height=Math.min(full.height,box.width*svg.clientHeight/svg.clientWidth);
 box.x=center.x-box.width/2;box.y=center.y-box.height/2;show();
 count.textContent=`${matchIndex+1} of ${matches.length}`;
}
search.addEventListener('input',updateSearch);
search.addEventListener('keydown',e=>{if(e.key==='Enter')nextMatch()});
document.getElementById('next').onclick=nextMatch;
</script></body></html>'''
    destination.write_text(page.replace('TITLE', html.escape(title)).replace('DRAWING', drawing))
