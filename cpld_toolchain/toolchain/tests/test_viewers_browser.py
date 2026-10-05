"""Opt-in browser checks for standalone documentation viewers."""
from contextlib import ExitStack
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
import os
from pathlib import Path
import tempfile
import threading
import unittest

from cpld_toolchain.toolchain.analysis.rtl_viewer import write_rtl_viewer
from cpld_toolchain.toolchain.analysis.waveform import waveform_frame, write_waveform
from cpld_toolchain.toolchain.tests.test_analysis import VCD


class QuietHandler(SimpleHTTPRequestHandler):
    def log_message(self, *args):
        pass


@unittest.skipUnless(os.environ.get('CPLD_BROWSER_TESTS') == '1',
                     'Set CPLD_BROWSER_TESTS=1 and install Playwright/Chromium')
class ViewerBrowserTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        from playwright.sync_api import sync_playwright

        stack = ExitStack()
        cls.addClassCleanup(stack.close)
        root = Path(stack.enter_context(tempfile.TemporaryDirectory()))
        (root / 'wave.vcd').write_bytes(VCD)
        write_waveform(root / 'wave.vcd', root / 'wave.html', 'Waveform test')
        declarations = ''.join(f'$var wire 1 s{i} signal_{i:02} $end\n' for i in range(96))
        initial = ''.join(f'0s{i}\n' for i in range(96))
        (root / 'many.vcd').write_text('$timescale 1 ns $end\n$scope module dut $end\n' +
                                      declarations + '$upscope $end\n$enddefinitions $end\n#0\n' +
                                      initial + '#100\n1s0\n#200\n')
        write_waveform(root / 'many.vcd', root / 'many.html', 'Many signals')
        (root / 'wave-frame.html').write_text(
            '<div style="width:700px">' + waveform_frame('many.html', 'Many signals') + '</div>')
        (root / 'netlist.svg').write_text(
            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2000 1000">'
            '<g transform="translate(200 100)"><g class="node">'
            '<rect width="120" height="50" fill="white" stroke="black"/>'
            '<text x="10" y="30">fpga_00</text></g></g></svg>')
        write_rtl_viewer(root / 'netlist.svg', root / 'rtl.html', 'RTL test')
        (root / 'index.html').write_text(
            '<iframe src="rtl.html" width="900" height="700" allowfullscreen></iframe>')
        server = ThreadingHTTPServer(('127.0.0.1', 0), partial(QuietHandler, directory=str(root)))
        stack.callback(server.server_close)
        stack.callback(server.shutdown)
        threading.Thread(target=server.serve_forever, daemon=True).start()
        cls.url = f'http://127.0.0.1:{server.server_port}'
        playwright = stack.enter_context(sync_playwright())
        executable = os.environ.get('CPLD_CHROMIUM_EXECUTABLE')
        cls.browser = playwright.chromium.launch(headless=True, executable_path=executable)
        stack.callback(cls.browser.close)

    def setUp(self):
        self.page = self.browser.new_page(viewport={'width': 1200, 'height': 900})
        self.addCleanup(self.page.close)
        self.errors = []
        self.page.on('pageerror', lambda error: self.errors.append(str(error)))

    def tearDown(self):
        self.assertEqual(self.errors, [], 'Unexpected browser JavaScript errors')

    def waveform(self):
        self.page.goto(self.url + '/wave.html')
        self.page.wait_for_function("document.getElementById('wave').data?.length > 0")

    def test_wave_selection_preserves_focus_and_clears_empty_message(self):
        self.waveform()
        self.page.fill('#filter', 'bus')
        checkbox = self.page.locator('#channels input:visible')
        checkbox.focus()
        checkbox.press('Space')
        self.assertTrue(self.page.evaluate("document.activeElement.matches('#channels input')"))
        self.page.click('#clear')
        self.assertTrue(self.page.locator('#empty').is_visible())
        self.assertTrue(self.page.locator('#wave').is_hidden())
        checkbox.check()
        self.page.wait_for_function('wave.data?.length === 1')
        self.assertTrue(self.page.locator('#empty').is_hidden())
        self.assertTrue(self.page.locator('#wave').is_visible())
        self.assertEqual(self.page.evaluate('wave.data[0].name'), 'dut.bus')
        self.assertEqual(self.page.evaluate('wave.data[0].text'), ['0011', '10XZ', '10XZ'])

    def test_wave_starts_full_range_and_keeps_plotly_zoom_and_reset(self):
        self.waveform()
        self.assertEqual(self.page.evaluate('wave._fullLayout.xaxis.range'), [0, 3])
        self.assertEqual(self.page.locator('#detail, #full, #start, #end, #apply').count(), 0)
        self.page.evaluate("Plotly.relayout(wave, {'xaxis.range[0]':1,'xaxis.range[1]':2.5})")
        self.page.select_option('#signals', 'All signals')
        self.assertEqual(self.page.evaluate('wave._fullLayout.xaxis.range'), [1, 2.5])
        self.page.locator('[data-title="Reset axes"]').click()
        self.assertEqual(self.page.evaluate('wave._fullLayout.xaxis.range'), [0, 3])

    def test_rtl_search_zoom_pan_fit_and_fullscreen(self):
        self.page.goto(self.url + '/index.html')
        frame = self.page.frames[1]
        frame.wait_for_selector('#canvas svg')
        frame.click('#zoom-in')
        self.assertAlmostEqual(frame.evaluate('svg.viewBox.baseVal.width'), 1400)
        frame.fill('#search', 'fpga_00')
        frame.click('#next')
        self.assertEqual(frame.locator('#count').inner_text(), '1 of 1')
        self.assertTrue(frame.evaluate('''() => {
            const node=document.querySelector('.rtl-match').getBoundingClientRect();
            const canvas=svg.getBoundingClientRect();
            return Math.abs(node.x+node.width/2-canvas.x-canvas.width/2)<2 &&
                   Math.abs(node.y+node.height/2-canvas.y-canvas.height/2)<2;
        }'''))
        bounds = frame.locator('#canvas').bounding_box()
        x, y = bounds['x'] + bounds['width']/2, bounds['y'] + bounds['height']/2
        before = frame.evaluate('svg.viewBox.baseVal.x')
        self.page.mouse.move(x, y)
        self.page.mouse.down()
        self.page.mouse.move(x+80, y+30, steps=5)
        self.page.mouse.up()
        self.assertNotEqual(frame.evaluate('svg.viewBox.baseVal.x'), before)
        frame.click('#fit')
        self.assertEqual(frame.evaluate('svg.viewBox.baseVal.width'), 2000)
        frame.click('#fullscreen')
        frame.wait_for_function("document.fullscreenElement?.id === 'viewer'")
        frame.evaluate('document.exitFullscreen()')

    def test_wave_grows_for_all_signals_without_inner_scrollbars(self):
        self.page.goto(self.url + '/wave-frame.html')
        frame = self.page.frames[1]
        frame.wait_for_selector('#wave', state='attached')
        frame.wait_for_function("document.getElementById('wave').data?.length > 0")
        frame.select_option('#signals', 'All signals')
        self.assertEqual(frame.evaluate('wave.data.length'), 96)
        for width in [700, 380, 900]:
            with self.subTest(width=width):
                self.page.locator('iframe').evaluate(
                    '(el,width)=>{el.style.width=width+"px"}', width)
                frame.wait_for_function('(width)=>innerWidth===width-2', arg=width)
                frame.wait_for_function('''() => {
                    const region=document.getElementById('plot-region');
                    return Math.abs(wave._fullLayout.width-region.clientWidth)<2 &&
                           Math.abs(wave._fullLayout.height-region.clientHeight)<2 &&
                           innerHeight>=document.body.scrollHeight &&
                           document.documentElement.scrollHeight<=document.documentElement.clientHeight &&
                           Math.abs(wave._fullLayout._size.h-96*32)<1;
                }''')
                metrics = frame.evaluate('''() => ({
                    root:[document.documentElement.scrollWidth,document.documentElement.clientWidth,
                          document.documentElement.scrollHeight,document.documentElement.clientHeight],
                    list:[list.scrollWidth,list.clientWidth,list.scrollHeight,list.clientHeight],
                    plot:wave.getBoundingClientRect().toJSON(),viewport:[innerWidth,innerHeight]
                })''')
                self.assertTrue(frame.evaluate('''() => {
                    const root=document.documentElement,list=document.getElementById('channels');
                    const plot=wave.getBoundingClientRect();
                    return root.scrollWidth<=root.clientWidth && root.scrollHeight<=root.clientHeight &&
                           list.scrollHeight<=list.clientHeight && list.scrollWidth<=list.clientWidth &&
                           plot.bottom<=innerHeight && plot.right<=innerWidth && plot.height>=600;
                }'''), metrics)
                self.assertEqual(frame.locator('#channels input:visible').count(), 96)
                self.assertEqual(frame.evaluate('wave._fullLayout.yaxis.ticktext.length'), 96)
                self.assertEqual(frame.evaluate('wave._fullLayout.xaxis.range'), [0, 200])
        full_height = frame.evaluate('innerHeight')
        frame.select_option('#signals', 'Overview')
        frame.wait_for_function('(height)=>innerHeight<height', arg=full_height)
        self.assertEqual(frame.locator('#channels input:visible').count(), 96)
        frame.fill('#filter', 'signal_95')
        self.assertEqual(frame.locator('#channels input:visible').count(), 1)
        frame.fill('#filter', '')
        self.assertEqual(frame.locator('#channels input:visible').count(), 96)
        self.assertTrue(self.page.evaluate('document.documentElement.scrollHeight>innerHeight'))


if __name__ == '__main__':
    unittest.main()
