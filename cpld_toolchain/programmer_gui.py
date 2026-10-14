"""Optional desktop programmer. Tk is imported only when opening the window."""
import argparse
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import subprocess
import shutil
import sys
import tempfile

from . import repository_root, settings


def windows_dpi_awareness():
    """Let Tk use real screen pixels and the Windows font scale."""
    if sys.platform == 'win32':
        import ctypes
        try:
            ctypes.windll.shcore.SetProcessDpiAwareness(1)
        except (AttributeError, OSError):
            ctypes.windll.user32.SetProcessDPIAware()


def worker_command(request, result):
    if getattr(sys, 'frozen', False):
        # A windowed launcher shares the console executable's worker entry point.
        executable = Path(sys.executable).with_name('uz_cpld.exe' if sys.platform == 'win32' else 'uz_cpld')
        return [str(executable), '--programmer-gui-worker', str(request), str(result)]
    return [os.environ.get('UZ_CPLD_GUI_WORKER_PYTHON', sys.executable), '-m',
            'cpld_toolchain.programmer_service', str(request), str(result)]


def display_rows(devices):
    rows = []
    for device in devices:
        identity = device.get('identity')
        program = identity.get('program', 'Unknown') if identity else 'Unknown firmware' if 'usercode' in device else '—'
        revision = str(identity.get('revision', '—')) if identity else '—'
        if identity and not identity.get('known_build'):
            revision += ' (unknown build)'
        label = device['label'].replace('slot', 'D').replace('s3c', 'S3C')
        rows.append((label, device['idcode'], program, revision, device.get('usercode', '—')))
    return rows


class ProgrammerWindow:
    def __init__(self, root, directory):
        import tkinter as tk
        from tkinter import ttk, filedialog, messagebox, simpledialog
        self.tk, self.ttk = tk, ttk
        self.dialog, self.message, self.prompt = filedialog, messagebox, simpledialog
        self.root, self.workspace = root, Path(directory).resolve()
        self.process = None
        self.activity_timer = None
        self.log_stream = None
        self.catalog = {}
        self.firmware = ''
        self.firmware_sha = ''
        self.controls = []
        self.last_diagnostics = self.workspace / 'build/programmer/gui'
        self.release = tk.StringVar()
        self.assignments = {key: tk.StringVar() for key in ('s3c', '1', '2', '3', '4', '5')}
        self.backend = tk.StringVar(value='foss')
        self.serial, self.device_id = tk.StringVar(), tk.StringVar()
        self.status = tk.StringVar(value='Loading workspace…')
        self.source_text = tk.StringVar(value='No firmware selected')
        self.workspace_text = tk.StringVar(value=str(self.workspace))
        root.title('UltraZohm CPLD programmer')
        self.scale = max(1, root.winfo_fpixels('1i') / 96)
        width = min(self.px(1060), root.winfo_screenwidth() - self.px(40))
        height = min(self.px(680), root.winfo_screenheight() - self.px(80))
        root.geometry(f'{width}x{height}')
        root.minsize(min(self.px(760), width), min(self.px(480), height))
        root.configure(background='#f5f4f6')
        root.protocol('WM_DELETE_WINDOW', self.close)
        self.style()
        self.build()
        root.after(100, lambda: self.start('load'))

    def px(self, value):
        return round(value * self.scale)

    def style(self):
        from tkinter import font
        available = set(font.families(self.root))
        family = next((name for name in ('Segoe UI', 'Arial', 'DejaVu Sans') if name in available), 'TkDefaultFont')
        display = 'Space Grotesk' if 'Space Grotesk' in available else family
        style = self.ttk.Style(self.root)
        style.theme_use('clam')
        style.configure('.', font=(family, 10), background='#ffffff', foreground='#111111')
        style.configure('Page.TFrame', background='#f5f4f6')
        style.configure('Card.TFrame', background='#ffffff')
        style.configure('TLabel', background='#ffffff')
        style.configure('Title.TLabel', font=(display, 20, 'bold'), background='#f5f4f6')
        style.configure('Subtitle.TLabel', foreground='#4b4752', background='#f5f4f6')
        style.configure('Heading.TLabel', font=(display, 12, 'bold'))
        style.configure('Muted.TLabel', foreground='#4b4752')
        style.configure('TButton', padding=(12, 8), background='#eadcf7', foreground='#32104d',
                        borderwidth=1, bordercolor='#bca0d4', lightcolor='#eadcf7', darkcolor='#eadcf7',
                        focuscolor='#7600c9', focusthickness=2)
        style.map('TButton', background=[('disabled', '#e5e1e8'), ('pressed', '#ceb2e9'), ('active', '#ddc7f0')],
                  foreground=[('disabled', '#62596b')], bordercolor=[('focus', '#7600c9')])
        style.configure('Primary.TButton', background='#7600c9', foreground='#ffffff',
                        bordercolor='#7600c9', lightcolor='#7600c9', darkcolor='#7600c9', focuscolor='#ffffff')
        style.map('Primary.TButton', background=[('disabled', '#e5e1e8'), ('pressed', '#4f0089'), ('active', '#6300ad')],
                  foreground=[('disabled', '#62596b')], bordercolor=[('focus', '#32104d')])
        style.configure('TCombobox', padding=3, fieldbackground='#faf9fc', arrowsize=16,
                        bordercolor='#e8e6e6', lightcolor='#e8e6e6', darkcolor='#e8e6e6')
        style.map('TCombobox', fieldbackground=[('readonly', '#faf9fc')],
                  foreground=[('readonly', '#111111')], bordercolor=[('focus', '#8f00ff')])
        style.configure('TEntry', padding=3, fieldbackground='#faf9fc', bordercolor='#e8e6e6')
        style.map('TEntry', bordercolor=[('focus', '#8f00ff')])
        style.configure('Treeview', rowheight=self.px(23), borderwidth=0, fieldbackground='#ffffff')
        style.configure('Treeview.Heading', font=(family, 10, 'bold'), padding=4, background='#f5f4f6')
        style.map('Treeview', background=[('selected', '#f3ecfa')], foreground=[('selected', '#111111')])
        style.configure('Horizontal.TProgressbar', background='#8f00ff', troughcolor='#e8e6e6', borderwidth=0, thickness=self.px(4))
        self.root.option_add('*TCombobox*Listbox.font', (family, 10))

    def button(self, parent, text, command, primary=False):
        widget = self.ttk.Button(parent, text=text, command=command,
                                 style='Primary.TButton' if primary else 'TButton')
        self.controls.append((widget, 'normal'))
        return widget

    def combo(self, parent, variable, values=()):
        widget = self.ttk.Combobox(parent, textvariable=variable, values=values, state='readonly')
        self.controls.append((widget, 'readonly'))
        return widget

    def card(self, parent, title):
        frame = self.ttk.Frame(parent, style='Card.TFrame', padding=self.px(8))
        self.ttk.Label(frame, text=title, style='Heading.TLabel').pack(anchor='w', pady=(0, 6))
        return frame

    def build(self):
        ttk = self.ttk
        outer = ttk.Frame(self.root, style='Page.TFrame')
        outer.pack(fill='both', expand=True)
        self.canvas = self.tk.Canvas(outer, background='#f5f4f6', highlightthickness=0)
        self.canvas.pack(side='left', fill='both', expand=True)
        scroll = ttk.Scrollbar(outer, orient='vertical', command=self.canvas.yview)
        scroll.pack(side='right', fill='y')
        self.canvas.configure(yscrollcommand=scroll.set)
        page = ttk.Frame(self.canvas, style='Page.TFrame', padding=self.px(10))
        window = self.canvas.create_window(0, 0, anchor='nw', window=page)
        def resize(event=None):
            if hasattr(self, 'middle'):
                stacked = self.canvas.winfo_width() < self.px(920)
                if stacked != getattr(self, 'stacked', None):
                    self.stacked = stacked
                    self.setup_card.grid_configure(row=0, column=0, columnspan=2 if stacked else 1,
                                                    padx=(0, 0 if stacked else 8), pady=(0, 8 if stacked else 0))
                    self.source_card.grid_configure(row=1 if stacked else 0, column=0 if stacked else 1,
                                                     columnspan=2 if stacked else 1)
            self.canvas.itemconfigure(window, width=self.canvas.winfo_width(),
                                      height=max(self.canvas.winfo_height(), page.winfo_reqheight()))
            self.canvas.configure(scrollregion=self.canvas.bbox('all'))
        # Reflow changes the page's requested height after Tk's geometry pass.
        # Refresh then, so shorter viewports scroll rather than squeeze the table.
        def schedule_resize(event=None):
            self.root.after_idle(resize)
        self.canvas.bind('<Configure>', schedule_resize)
        page.bind('<Configure>', schedule_resize)
        def wheel(event):
            if isinstance(event.widget, (ttk.Combobox, ttk.Treeview)):
                return
            if self.canvas.bbox('all')[3] > self.canvas.winfo_height():
                steps = (-1 if event.num == 4 else 1) if event.num in (4, 5) else -int(event.delta / 120)
                self.canvas.yview_scroll(steps, 'units')
        for event in ('<MouseWheel>', '<Button-4>', '<Button-5>'):
            self.root.bind(event, wheel, add='+')
        ttk.Label(page, text='UltraZohm CPLD programmer', style='Title.TLabel').pack(anchor='w', pady=(0, 8))
        middle = self.middle = ttk.Frame(page, style='Page.TFrame')
        middle.bind('<Configure>', schedule_resize)
        middle.pack(fill='x', pady=(0, 8))
        middle.columnconfigure(0, weight=1, uniform='setup')
        middle.columnconfigure(1, weight=1, uniform='setup')
        device = self.setup_card = self.card(middle, '1  Setup')
        device.grid(row=0, column=0, sticky='nsew', padx=(0, 8))
        bar = ttk.Frame(device)
        bar.pack(fill='x')
        ttk.Label(bar, text='Backend').pack(side='left', padx=(0, 8))
        backend = self.combo(bar, self.backend, ('foss', 'diamond'))
        backend.configure(width=10)
        backend.pack(side='left', fill='x', expand=True)
        backend.bind('<<ComboboxSelected>>', self.clear_results)
        bar = ttk.Frame(device)
        bar.pack(fill='x', pady=(8, 0))
        self.button(bar, 'Setup drivers', self.drivers).pack(side='left', padx=(0, 8))
        self.button(bar, 'Probe options…', self.probe_options).pack(side='left')
        source = self.source_card = self.card(middle, '2  Firmware')
        source.grid(row=0, column=1, sticky='nsew')
        ttk.Label(source, textvariable=self.source_text, wraplength=self.px(420)).pack(anchor='w', fill='x', pady=(0, 8))
        bar = ttk.Frame(source)
        bar.pack(fill='x')
        self.button(bar, 'Choose ZIP', self.browse).pack(side='left', padx=(0, 8))
        self.button(bar, 'Download', self.download).pack(side='left')
        choices = self.choices_card = self.card(page, '3  Program')
        choices.pack(fill='x', pady=(0, 8))
        grid = ttk.Frame(choices)
        grid.pack(fill='x')
        grid.columnconfigure(1, weight=1)
        ttk.Label(grid, text='Release').grid(row=0, column=0, sticky='w', padx=(0, 8), pady=3)
        self.release_box = self.combo(grid, self.release)
        self.release_box.grid(row=0, column=1, sticky='ew', pady=3)
        self.release_box.bind('<<ComboboxSelected>>', lambda event: self.refresh_choices())
        self.program_boxes = {}
        for row, (key, variable) in enumerate(self.assignments.items(), 1):
            ttk.Label(grid, text='S3C' if key == 's3c' else f'D{key}').grid(
                row=row, column=0, sticky='w', padx=(0, 8), pady=3)
            box = self.combo(grid, variable)
            box.configure(width=12)
            box.grid(row=row, column=1, sticky='ew', pady=3)
            self.program_boxes[key] = box
        self.button(choices, 'Save assignments', self.save).pack(anchor='e', pady=(6, 0))
        actions = self.action_row = ttk.Frame(page, style='Page.TFrame')
        actions.pack(fill='x', pady=(0, 8))
        self.button(actions, 'Identify', lambda: self.start('identify')).pack(side='left', padx=(0, 8))
        self.button(actions, 'Scan', lambda: self.start('scan')).pack(side='left', padx=(0, 8))
        self.button(actions, 'Program S3C', lambda: self.program('s3c'), primary=True).pack(side='left', padx=(0, 8))
        self.button(actions, 'Program D-slots', lambda: self.program('dslot'), primary=True).pack(side='left', padx=(0, 12))
        chip = self.activity_icon = self.tk.Canvas(actions, width=self.px(24), height=self.px(24),
                              background='#f5f4f6', highlightthickness=0)
        chip.pack(side='left', padx=(0, 6))
        chip.create_rectangle(self.px(6), self.px(6), self.px(18), self.px(18),
                              outline='#7600c9', fill='#f5f4f6', width=self.px(2), tags='body')
        for offset in (9, 15):
            for x1, y1, x2, y2 in ((offset, 3, offset, 6), (offset, 18, offset, 21),
                                   (3, offset, 6, offset), (18, offset, 21, offset)):
                chip.create_line(*(self.px(v) for v in (x1, y1, x2, y2)), fill='#7600c9', width=self.px(2))
        self.progress = ttk.Progressbar(actions, mode='determinate', length=self.px(64))
        self.progress.pack(side='left')
        results = ttk.Frame(page, style='Card.TFrame', padding=self.px(8))
        results.pack(fill='x')
        status_label = self.ttk.Label(results, textvariable=self.status, wraplength=self.px(900))
        status_label.pack(anchor='w', fill='x', pady=(0, 8))
        results.bind('<Configure>', lambda event: status_label.configure(wraplength=max(self.px(100), event.width - self.px(16))))
        columns = ('position', 'device', 'program', 'revision', 'usercode')
        table_frame = ttk.Frame(results, height=self.px(6 * 23 + 48))
        table_frame.pack(fill='x')
        table_frame.grid_propagate(False)
        self.table = ttk.Treeview(table_frame, columns=columns, show='headings', height=6)
        for name, label, width in zip(columns, ('Position', 'Device ID', 'Installed program', 'Revision', 'USERCODE'),
                                       (85, 120, 280, 150, 130)):
            self.table.heading(name, text=label)
            self.table.column(name, width=self.px(width), minwidth=self.px(65))
        table_frame.columnconfigure(0, weight=1)
        table_frame.rowconfigure(0, weight=1)
        self.table.grid(row=0, column=0, sticky='nsew')
        scrollbar = ttk.Scrollbar(table_frame, orient='vertical', command=self.table.yview)
        scrollbar.grid(row=0, column=1, sticky='ns')
        horizontal = ttk.Scrollbar(table_frame, orient='horizontal', command=self.table.xview)
        horizontal.grid(row=1, column=0, sticky='ew')
        self.table.configure(yscrollcommand=scrollbar.set, xscrollcommand=horizontal.set)
        self.reset_results()
        footer = ttk.Frame(page, style='Page.TFrame')
        footer.pack(fill='x', pady=(8, 0))
        ttk.Label(footer, textvariable=self.workspace_text, style='Subtitle.TLabel', wraplength=560).pack(side='left')
        self.button(footer, 'Workspace', self.change_workspace).pack(side='right', padx=(8, 0))
        self.button(footer, 'Open diagnostics', self.diagnostics).pack(side='right')

    def selection(self):
        return dict(release=self.release.get(), s3c=self.assignments['s3c'].get(),
                    slots={str(i): self.assignments[str(i)].get() for i in range(1, 6)})

    def pulse_activity(self):
        if self.process is None:
            return
        fill = '#ddc7f0' if self.activity_icon.itemcget('body', 'fill') == '#7600c9' else '#7600c9'
        self.activity_icon.itemconfigure('body', fill=fill)
        self.activity_timer = self.root.after(450, self.pulse_activity)

    def stop_activity(self):
        if self.activity_timer is not None:
            self.root.after_cancel(self.activity_timer)
            self.activity_timer = None
        self.activity_icon.itemconfigure('body', fill='#f5f4f6')

    def reset_results(self, target=None):
        positions = ('S3C',) if target == 's3c' else tuple(f'D{i}' for i in range(1, 6)) if target == 'dslot' else ('S3C', 'D1', 'D2', 'D3', 'D4', 'D5')
        for position in positions:
            values = (position, '', '', '', '')
            if self.table.exists(position):
                self.table.item(position, values=values)
            else:
                self.table.insert('', 'end', iid=position, values=values)

    def show_devices(self, devices):
        rows = display_rows(devices)
        # Refresh the read chain while keeping the other chain's last results.
        positions = {row[0] for row in rows}
        if 'S3C' in positions:
            self.reset_results('s3c')
        if any(position.startswith('D') for position in positions):
            self.reset_results('dslot')
        for row in rows:
            if self.table.exists(row[0]):
                self.table.item(row[0], values=row)

    def clear_results(self, event=None):
        self.reset_results()
        self.status.set('Probe settings changed. Scan to check the connected chain.')

    def refresh_choices(self):
        targets = self.catalog.get(self.release.get(), {})
        for key, box in self.program_boxes.items():
            values = targets.get('s3c' if key == 's3c' else 'dslot', [])
            box.configure(values=values)
            if self.assignments[key].get() not in values:
                # Do not silently assign the alphabetically first program.
                self.assignments[key].set('')

    def browse(self):
        path = self.dialog.askopenfilename(parent=self.root, title='Select published firmware',
                                           filetypes=[('Firmware ZIP', '*.zip')])
        if path:
            self.start('select', firmware=path)

    def download(self):
        self.start('releases')

    def release_picker(self, releases):
        if not releases:
            self.message.showinfo('Download firmware', 'No compatible published firmware releases are available.', parent=self.root)
            return
        window = self.tk.Toplevel(self.root)
        window.title('Download firmware · GitHub releases')
        window.transient(self.root)
        window.resizable(True, False)
        width = min(self.px(880), self.root.winfo_screenwidth() - self.px(40))
        frame = self.ttk.Frame(window, padding=22)
        frame.pack(fill='both', expand=True)
        self.ttk.Label(frame, text='Choose a firmware version', style='Heading.TLabel').pack(anchor='w', pady=(0, 6))
        self.ttk.Label(frame, text='ultrazohm/uz_cpld · All published firmware releases · Newest first',
                       style='Muted.TLabel', wraplength=width - 44).pack(anchor='w', pady=(0, 14))
        labels = [f"{row['published_at'][:10]} {row['published_at'][11:16]} UTC  ·  "
                  f"{row['ref'].removeprefix('refs/heads/').removeprefix('refs/tags/')}  ·  "
                  f"{row['commit'][:8]}  ·  {row['tag']}" for row in releases]
        box = self.ttk.Combobox(frame, values=labels, state='readonly', width=1)
        box.current(0)
        box.pack(fill='x', pady=(0, 14))
        detail = self.tk.StringVar()
        detail_label = self.ttk.Label(frame, textvariable=detail, wraplength=width - 44, style='Muted.TLabel')
        detail_label.pack(anchor='w', fill='x', pady=(0, 18))
        frame.bind('<Configure>', lambda event: detail_label.configure(wraplength=max(100, event.width - 44)))
        def update(event=None):
            row = releases[box.current()]
            detail.set(f"{row['name']}\n{'Testing prerelease' if row['prerelease'] else 'Published release'}"
                       '\nDownload validates and selects this package. Hardware is not accessed.')
        box.bind('<<ComboboxSelected>>', update)
        update()
        buttons = self.ttk.Frame(frame)
        buttons.pack(fill='x')
        self.ttk.Button(buttons, text='Cancel', command=window.destroy).pack(side='left')
        def select():
            row = releases[box.current()]
            window.destroy()
            self.start('download', release_id=row['id'], release_commit=row['commit'])
        self.ttk.Button(buttons, text='Download & select', command=select, style='Primary.TButton').pack(side='right')
        window.update_idletasks()
        window.geometry(f'{width}x{window.winfo_reqheight()}')
        window.grab_set()
        box.focus_set()

    def save(self):
        exists = (self.workspace / 'selection.toml').exists()
        if exists and not self.message.askyesno('Replace assignments?',
                'Replace the saved selection.toml with the assignments displayed here?', parent=self.root):
            return
        self.start('save', override=exists)

    def program(self, target):
        from .programmer_service import validate_assignments
        try:
            validate_assignments({'cycles': self.catalog}, self.selection(), target)
        except Exception as exc:
            self.message.showerror('Choose assignments', str(exc), parent=self.root)
            return
        names = ['S3C: ' + self.assignments['s3c'].get()] if target == 's3c' else [
            f'D{i}: {self.assignments[str(i)].get()}' for i in range(1, 6)]
        if self.message.askyesno('Program Flash?',
                f'Target: {"S3C" if target == "s3c" else "D1–D5 chain"}\nRelease: {self.release.get()}\nBackend: {self.backend.get()}\n\n'
                + '\n'.join(names) + '\n\nThis erases, programs and verifies Flash.\n'
                'Confirm the physical JTAG access state is correct.', default='no', parent=self.root):
            self.start('program', target=target)

    def drivers(self):
        if sys.platform != 'win32':
            self.message.showinfo('Windows driver setup', 'Driver switching is available on Windows.\n'
                                  'On Linux, configure the openFPGALoader udev rules.', parent=self.root)
            return
        if self.message.askokcancel('Setup programmer driver',
                f'Configure channel B for {self.backend.get().upper()}.\nClose other programmer applications.\n'
                'Windows will request administrator approval.\nUse a device ID when multiple probes are connected.',
                parent=self.root):
            self.start('drivers')

    def probe_options(self):
        window = self.tk.Toplevel(self.root)
        window.title('Probe options')
        window.transient(self.root)
        window.resizable(False, False)
        width = min(self.px(620), self.root.winfo_screenwidth() - self.px(40))
        frame = self.ttk.Frame(window, padding=20)
        frame.pack(fill='both', expand=True)
        serial = self.tk.StringVar(value=self.serial.get())
        device_id = self.tk.StringVar(value=self.device_id.get())
        for label, variable in (('USB serial (FOSS; leave empty for the default probe)', serial),
                                ('Windows driver device ID (required with multiple probes)', device_id)):
            self.ttk.Label(frame, text=label, wraplength=width - 40).pack(anchor='w', pady=(0, 6))
            self.ttk.Entry(frame, textvariable=variable, width=1).pack(fill='x', pady=(0, 14))
        def save():
            self.serial.set(serial.get().strip())
            self.device_id.set(device_id.get().strip())
            self.clear_results()
            window.destroy()
        self.ttk.Button(frame, text='Apply', command=save, style='Primary.TButton').pack(anchor='e')
        window.update_idletasks()
        window.geometry(f'{width}x{window.winfo_reqheight()}')
        window.grab_set()

    def start(self, action, **extra):
        if self.process is not None:
            return
        if action in ('save', 'program') and not self.firmware:
            self.message.showinfo('Select firmware', 'Choose or download a firmware ZIP first.', parent=self.root)
            return
        try:
            base = self.workspace / 'build/programmer/gui'
            base.mkdir(parents=True, exist_ok=True)
            directory = Path(tempfile.mkdtemp(prefix=datetime.now(timezone.utc).strftime('%Y%m%d-%H%M%S-'), dir=base))
            request = dict(action=action, workspace=str(self.workspace), firmware=self.firmware,
                           expected_sha256=self.firmware_sha,
                           backend=self.backend.get(),
                           selection=self.selection(), serial=self.serial.get().strip(), device_id=self.device_id.get().strip())
            request.update(extra)
            request_path = directory / 'request.json'
            settings.atomic_json(request_path, request)
            self.result_path = directory / 'response.json'
            self.last_diagnostics = directory
            self.log_stream = (directory / 'operation.log').open('w', encoding='utf-8')
            env = dict(os.environ, PYINSTALLER_RESET_ENVIRONMENT='1', UZ_CPLD_GUI_WORKER='1')
            # Retain the import path in repo mode even after selecting a new workspace.
            if not getattr(sys, 'frozen', False):
                env['PYTHONPATH'] = os.pathsep.join(filter(None, [str(Path(__file__).resolve().parent.parent), env.get('PYTHONPATH')]))
            self.process = subprocess.Popen(worker_command(request_path, self.result_path),
                    stdout=self.log_stream, stderr=subprocess.STDOUT, stdin=subprocess.DEVNULL, env=env,
                    creationflags=subprocess.CREATE_NO_WINDOW if sys.platform == 'win32' else 0)
        except (OSError, ValueError) as exc:
            if self.log_stream:
                self.log_stream.close()
            self.message.showerror('Could not start operation', str(exc), parent=self.root)
            return
        for widget, _ in self.controls:
            widget.configure(state='disabled')
        self.status.set({'program': 'Programming and verifying Flash…', 'scan': 'Scanning JTAG chain…',
                         'identify': 'Reading firmware identities…', 'drivers': 'Setting up driver; approve the Windows prompt…',
                         'download': 'Downloading and validating firmware…',
                         'releases': 'Fetching published firmware releases from GitHub…'}.get(action, 'Validating workspace and firmware…'))
        self.progress.configure(mode='indeterminate')
        self.progress.start(12)
        self.pulse_activity()
        if action in ('program', 'scan', 'identify') and extra.get('target'):
            self.reset_results(extra['target'])
        self.root.after(100, self.poll)

    def poll(self):
        if self.process.poll() is None:
            self.root.after(100, self.poll)
            return
        code = self.process.returncode
        self.process = None
        self.log_stream.close()
        self.log_stream = None
        self.progress.stop()
        self.stop_activity()
        self.progress.configure(mode='determinate', value=0)
        for widget, state in self.controls:
            widget.configure(state=state)
        try:
            result = json.loads(self.result_path.read_text())
        except (OSError, ValueError):
            result = dict(ok=False, message=f'Operation stopped unexpectedly (exit {code}). Open diagnostics for details.')
        self.status.set(result['message'])
        if not result['ok']:
            self.message.showerror('Operation failed', result['message'] + '\n\nFull details are saved in diagnostics.', parent=self.root)
            return
        if 'releases' in result:
            self.release_picker(result['releases'])
        if 'cycles' in result:
            self.reset_results()
            self.firmware = result.get('firmware', '')
            self.firmware_sha = result.get('sha256', '')
            self.catalog = result['cycles']
            self.release_box.configure(values=sorted(self.catalog))
            saved = result.get('selection', self.selection())
            self.release.set(saved.get('release') if saved.get('release') in self.catalog else
                             next(iter(sorted(self.catalog)), ''))
            self.assignments['s3c'].set(saved.get('s3c', ''))
            for i in range(1, 6):
                self.assignments[str(i)].set(saved.get('slots', {}).get(str(i), ''))
            self.refresh_choices()
            self.source_text.set(f"Commit {result.get('commit', '')[:12]} · {Path(self.firmware).name}" if self.firmware else 'No firmware selected')
        if 'devices' in result:
            self.show_devices(result['devices'])

    def change_workspace(self):
        directory = self.dialog.askdirectory(parent=self.root, title='Choose programmer workspace', initialdir=self.workspace)
        if directory:
            self.workspace = Path(directory).resolve()
            self.workspace_text.set(str(self.workspace))
            self.firmware, self.catalog = '', {}
            self.firmware_sha = ''
            self.source_text.set('No firmware selected')
            self.release.set('')
            for var in self.assignments.values():
                var.set('')
            self.reset_results()
            self.start('load')

    def diagnostics(self):
        path = self.last_diagnostics
        if not path.exists():
            self.message.showinfo('Diagnostics', 'No diagnostics have been recorded yet.', parent=self.root)
        elif sys.platform == 'win32':
            os.startfile(path)
        else:
            subprocess.Popen(['xdg-open', str(path)])

    def close(self):
        if self.process is not None:
            self.message.showinfo('Operation in progress', 'Wait for the operation to finish before closing.\n'
                                  'Programming and driver setup must finish before releasing the probe.', parent=self.root)
        else:
            self.root.destroy()


def tk_python():
    """Find an existing optional UI runtime; never install or change Python."""
    explicit = os.environ.get('UZ_CPLD_GUI_PYTHON')
    candidates = [[explicit]] if explicit else [[getattr(sys, '_base_executable', sys.executable)]]
    if not explicit:
        # Activation shadows system Python with the same managed interpreter
        # whose Tcl files are missing. Search every PATH directory, not just
        # shutil.which's first match.
        for directory in os.environ.get('PATH', os.defpath).split(os.pathsep):
            if not directory:
                continue
            for name in ('python3', 'python'):
                path = shutil.which(name, path=directory)
                if path:
                    candidates.append([path])
    if not explicit and sys.platform == 'win32' and shutil.which('py'):
        candidates.append([shutil.which('py'), '-3'])
    probe = ('import sys, tkinter; assert sys.version_info >= (3, 11); '
             'tkinter.Tcl(); print(sys.executable)')
    seen = set()
    for candidate in candidates:
        key = (str(Path(candidate[0]).resolve()), *candidate[1:])
        if key in seen:
            continue
        seen.add(key)
        try:
            result = subprocess.run([*candidate, '-c', probe], capture_output=True, text=True, timeout=10)
            if result.returncode == 0 and Path(result.stdout.strip()).is_file():
                return result.stdout.strip()
        except (OSError, subprocess.SubprocessError):
            continue
    return None


def alternate_runtime(args, standalone):
    if getattr(sys, 'frozen', False) or os.environ.get('UZ_CPLD_GUI_ALTERNATE_RUNTIME'):
        return None
    python = tk_python()
    if not python:
        return None
    directory = args.workspace or (settings.user_directory('data') / 'workspace' if standalone else repository_root())
    env = dict(os.environ, UZ_CPLD_GUI_ALTERNATE_RUNTIME='1',
               UZ_CPLD_GUI_WORKER_PYTHON=os.environ.get('UZ_CPLD_GUI_WORKER_PYTHON', sys.executable))
    env['PYTHONPATH'] = os.pathsep.join(filter(None, [str(Path(__file__).resolve().parent.parent), env.get('PYTHONPATH')]))
    command = [python, '-m', 'cpld_toolchain.programmer_gui', '--workspace', str(directory)]
    if args.check:
        command.append('--check')
    print(f'Using optional Tk runtime: {python}. Programming retains {env["UZ_CPLD_GUI_WORKER_PYTHON"]}.', flush=True)
    return subprocess.call(command, env=env)


def main(argv=None, *, standalone=False):
    parser = argparse.ArgumentParser(description='Open the optional UltraZohm programmer window.')
    parser.add_argument('--workspace', type=Path)
    parser.add_argument('--check', action='store_true', help='Check the optional Tk runtime without opening a window')
    args = parser.parse_args(argv)
    try:
        import tkinter as tk
    except ImportError as exc:
        code = alternate_runtime(args, standalone)
        if code is not None:
            return code
        print(f'Programmer GUI unavailable: {exc}. Install Python with Tk support. CLI programming remains available.', file=sys.stderr)
        return 2
    try:
        if args.check:
            tk.Tcl()  # Import alone does not establish that Tcl scripts are usable.
            print(f'Programmer GUI runtime available (Tk {tk.TkVersion}).')
            return 0
        directory = args.workspace or (settings.user_directory('data') / 'workspace' if standalone else repository_root())
        windows_dpi_awareness()
        root = tk.Tk()
        ProgrammerWindow(root, directory)
        root.mainloop()
        return 0
    except (ImportError, OSError, RuntimeError) as exc:
        print(f'Programmer GUI unavailable: {exc}. Install Python with Tk support (python3-tk on Ubuntu). '
              'All CLI programmer commands remain available.', file=sys.stderr)
        return 2
    except tk.TclError as exc:
        code = alternate_runtime(args, standalone)
        if code is not None:
            return code
        print(f'Cannot open programmer GUI: {exc}', file=sys.stderr)
        return 2


if __name__ == '__main__':
    raise SystemExit(main())
