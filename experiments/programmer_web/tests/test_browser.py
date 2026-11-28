import os
from pathlib import Path
import sys
import threading
import unittest

from playwright.sync_api import sync_playwright, expect

HERE = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(HERE))
from standalone import Session, ThreadingHTTPServer, handler


class BrowserTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.playwright = sync_playwright().start()
        cls.browser = cls.playwright.chromium.launch(executable_path=os.environ.get('CHROME_PATH', '/usr/bin/google-chrome'),
                                                    headless=True, args=['--no-sandbox'])

    @classmethod
    def tearDownClass(cls):
        cls.browser.close()
        cls.playwright.stop()

    def setUp(self):
        self.session = Session('/unused-demo-workspace', demo=True)
        self.server = ThreadingHTTPServer(('127.0.0.1', 0), handler(self.session))
        self.thread = threading.Thread(target=self.server.serve_forever, daemon=True)
        self.thread.start()
        self.page = self.browser.new_page(viewport={'width': 1120, 'height': 900})
        self.errors = []
        self.page.on('pageerror', lambda error: self.errors.append(str(error)))
        self.page.goto(f'http://127.0.0.1:{self.server.server_port}')
        expect(self.page.locator('#status')).to_have_text('Demo firmware ready.')

    def tearDown(self):
        self.page.close()
        if self.session.thread:
            self.session.thread.join(5)
        self.server.shutdown()
        self.server.server_close()
        self.thread.join()
        self.assertEqual(self.errors, [])

    def test_scan_and_reviewed_programming(self):
        self.page.locator('#scan').click()
        expect(self.page.locator('#devices')).to_contain_text('012BC043')
        self.page.locator('#target').select_option('dslot')
        expect(self.page.locator('#assignments select')).to_have_count(5)
        self.page.locator('#prepare').click()
        expect(self.page.locator('#review-dialog')).to_be_visible()
        expect(self.page.locator('#review-assignments .review-row')).to_have_count(5)
        expect(self.page.locator('#execute')).to_be_disabled()
        self.assertFalse(any(j['action'] == 'execute' for j in self.session.jobs.values()))
        self.page.locator('#physical-confirm').check()
        self.page.locator('#execute').click()
        expect(self.page.locator('#devices tr')).to_have_count(5)
        expect(self.page.locator('#status')).to_contain_text('hardware was not accessed')
        self.assertEqual(sum(j['action'] == 'execute' for j in self.session.jobs.values()), 1)

    def test_cancel_and_unvalidated_path_never_execute(self):
        self.page.locator('#prepare').click()
        expect(self.page.locator('#review-dialog')).to_be_visible()
        self.page.locator('#review-cancel').click()
        self.page.locator('#firmware-path').fill('/different/unvalidated.zip')
        self.page.locator('#prepare').click()
        expect(self.page.locator('#status')).to_contain_text('Click Use ZIP')
        self.assertFalse(any(j['action'] == 'execute' for j in self.session.jobs.values()))

    def test_download_and_save(self):
        self.page.locator('#releases').click()
        expect(self.page.locator('#release-dialog')).to_be_visible()
        self.page.locator('#download').click()
        expect(self.page.locator('#status')).to_have_text('Demo firmware ready.')
        self.page.locator('#save').click()
        self.page.locator('#confirm-yes').click()
        expect(self.page.locator('#status')).to_contain_text('no files or drivers were changed')

    def test_live_theme_values_and_narrow_layout(self):
        self.page.evaluate("""() => {
          document.body.style.setProperty('--vscode-editor-background', '#112233');
          document.body.style.setProperty('--vscode-input-background', '#223344');
          document.body.style.setProperty('--vscode-button-background', '#334455');
        }""")
        self.assertEqual(self.page.locator('body').evaluate('(e) => getComputedStyle(e).backgroundColor'), 'rgb(17, 34, 51)')
        self.assertEqual(self.page.locator('#firmware-path').evaluate('(e) => getComputedStyle(e).backgroundColor'), 'rgb(34, 51, 68)')
        self.assertEqual(self.page.locator('#prepare').evaluate('(e) => getComputedStyle(e).backgroundColor'), 'rgb(51, 68, 85)')
        self.page.evaluate("document.body.style.setProperty('--vscode-editor-background', '#f0e0d0')")
        self.assertEqual(self.page.locator('body').evaluate('(e) => getComputedStyle(e).backgroundColor'), 'rgb(240, 224, 208)')
        self.page.set_viewport_size({'width': 640, 'height': 850})
        self.assertLessEqual(self.page.evaluate('document.documentElement.scrollWidth'), 640)


if __name__ == '__main__':
    unittest.main()
