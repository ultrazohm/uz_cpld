const $ = id => document.getElementById(id);
const vscode = typeof acquireVsCodeApi === 'function' ? acquireVsCodeApi() : null;
const pending = new Map();
let sequence = 0, logCount = 0;
let context, busy = false, firmware = '', sha256 = '', catalog = {}, assignments = {}, release = '';
let review = null, reviewRequest = null, published = [];

function log(text) {
  if (!text) return;
  const element = $('log');
  element.textContent = (element.textContent + text).slice(-150000);
  $('log-count').textContent = `${++logCount} entries`;
  element.scrollTop = element.scrollHeight;
}
function event(value) { if (value.text) log(value.text); }
function status(text, error = false) {
  $('status').textContent = text;
  $('status').parentElement.classList.toggle('error', error);
}
function setBusy(value) {
  busy = value;
  document.body.classList.toggle('busy', value);
  for (const control of document.querySelectorAll('main button, main input, main select')) control.disabled = value;
  $('execute').disabled = value || !$('physical-confirm').checked || !review;
  $('download').disabled = value || !$('published-release').value;
}

window.addEventListener('message', ({data}) => {
  if (data.type === 'event') event(data.event);
  if (data.type === 'response' && pending.has(data.id)) {
    const {resolve, reject} = pending.get(data.id); pending.delete(data.id);
    data.ok ? resolve(data.result) : reject(new Error(data.message));
  }
});

async function api(path, body) {
  const response = await fetch(path, {method: body === undefined ? 'GET' : 'POST',
    headers: {'Content-Type': 'application/json', 'X-Programmer-Token': document.querySelector('meta[name="programmer-token"]').content},
    ...(body === undefined ? {} : {body: JSON.stringify(body)})});
  const result = await response.json();
  if (!response.ok) throw new Error(result.message || `HTTP ${response.status}`);
  return result;
}
async function poll(id) {
  let cursor = 0;
  while (true) {
    const job = await api(`/api/job?id=${encodeURIComponent(id)}&cursor=${cursor}`);
    job.events.forEach(event); cursor = job.cursor;
    if (job.done) {
      if (!job.result.ok) throw new Error(job.result.message);
      return {action: job.action, result: job.result.result};
    }
    await new Promise(resolve => setTimeout(resolve, 250));
  }
}
async function host(type, data = {}) {
  if (vscode) return new Promise((resolve, reject) => {
    const id = ++sequence; pending.set(id, {resolve, reject}); vscode.postMessage({type, id, ...data});
  });
  if (type === 'init') return api('/api/context');
  if (type === 'request') return (await poll((await api('/api/request', data.request)).id)).result;
  if (type === 'pick') {
    const path = window.pywebview?.api ? await window.pywebview.api.pick(data.kind) :
      window.prompt(data.kind === 'workspace' ? 'Local workspace directory' : 'Local firmware ZIP path',
                    data.kind === 'workspace' ? context.workspace : $('firmware-path').value);
    if (path && data.kind === 'workspace') return api('/api/workspace', {path});
    return {path};
  }
  throw new Error('Unknown host operation.');
}

function selection(targetOnly = false) {
  const result = {release};
  const target = $('target').value;
  if ((!targetOnly || target === 's3c') && assignments.s3c) result.s3c = assignments.s3c;
  if ((!targetOnly || target === 'dslot') && [1, 2, 3, 4, 5].some(i => assignments[i])) {
    result.slots = Object.fromEntries([1, 2, 3, 4, 5].map(i => [String(i), assignments[i] || '']));
  }
  return result;
}
function request(action, extra = {}) {
  const backend = $('backend').value;
  return {action, backend, firmware, expected_sha256: sha256, target: $('target').value,
    selection: selection(action === 'prepare'), serial: backend === 'foss' ? $('serial').value.trim() : null,
    cable: backend === 'foss' ? $('cable').value.trim() : null,
    probe_index: $('probe-index').value === '' ? null : Number($('probe-index').value),
    device_id: $('device-id').value.trim(), ...extra};
}
function persist() {
  vscode?.setState({workspace: context.workspace, release, assignments,
    backend: $('backend').value, target: $('target').value});
}
function invalidate() { review = null; reviewRequest = null; $('physical-confirm').checked = false; }
function options(select, values, selected, placeholder) {
  select.replaceChildren();
  if (placeholder) select.add(new Option(placeholder, ''));
  for (const value of values) select.add(new Option(value, value));
  select.value = values.includes(selected) ? selected : '';
}
function renderAssignments() {
  const target = $('target').value;
  $('target-label').textContent = target === 's3c' ? 'S3C controller' : 'D1–D5 slots';
  const keys = target === 's3c' ? ['s3c'] : ['1', '2', '3', '4', '5'];
  $('assignments').replaceChildren();
  for (const key of keys) {
    const field = document.createElement('div');
    if (target === 's3c') field.className = 'single';
    const label = document.createElement('label'); label.htmlFor = `program-${key}`;
    label.textContent = key === 's3c' ? 'S3C program' : `D${key} program`;
    const select = document.createElement('select'); select.id = label.htmlFor;
    options(select, catalog[release]?.[target] || [], assignments[key], 'Choose a program');
    select.onchange = () => { assignments[key] = select.value; invalidate(); persist(); };
    field.append(label, select); $('assignments').append(field);
  }
}
function emptyDevices() {
  $('devices').replaceChildren();
  const row = $('devices').insertRow(); const cell = row.insertCell();
  cell.colSpan = 5; cell.className = 'empty'; cell.textContent = 'Scan or read identities to inspect the connected devices.';
}
function showDevices(devices) {
  $('devices').replaceChildren();
  if (!devices.length) return emptyDevices();
  for (const device of devices) {
    const row = $('devices').insertRow();
    const identity = device.identity;
    const values = [device.label.replace('slot', 'D').replace('s3c', 'S3C'), device.idcode,
      identity?.program || ('usercode' in device ? 'Unknown firmware' : '—'),
      identity ? `${identity.revision ?? '—'}${identity.known_build ? '' : ' (unknown build)'}` : '—', device.usercode || '—'];
    for (const value of values) row.insertCell().textContent = value;
  }
}
function apply(action, result) {
  if (['load', 'select', 'download'].includes(action)) {
    invalidate();
    firmware = result.firmware || ''; sha256 = result.sha256 || ''; catalog = result.cycles || {};
    $('firmware-path').value = firmware;
    $('firmware-detail').textContent = firmware ? `Commit ${(result.commit || 'unknown').slice(0, 12)} · SHA256 ${sha256.slice(0, 16)}…` : 'No firmware selected.';
    if (action === 'load') {
      const saved = result.selection || {};
      release = saved.release || Object.keys(catalog)[0] || '';
      assignments = {...(saved.slots || {}), s3c: saved.s3c || ''};
    }
    if (!(release in catalog)) release = Object.keys(catalog)[0] || '';
    for (const key of Object.keys(assignments)) {
      if (!catalog[release]?.[key === 's3c' ? 's3c' : 'dslot']?.includes(assignments[key])) assignments[key] = '';
    }
    options($('release'), Object.keys(catalog), release, 'Choose a release');
    renderAssignments(); persist();
  }
  if (result.devices) showDevices(result.devices);
  if (result.message) status(result.message, result.chain_matches === false);
}
async function run(action, extra = {}, snapshot = null) {
  if (busy) throw new Error('Wait for the active operation to finish.');
  setBusy(true); status(`${context.demo ? 'Demo · ' : ''}${({load: 'Loading workspace', scan: 'Scanning chain', identify: 'Reading identities',
    prepare: 'Preparing programming review', execute: 'Programming and verifying Flash', download: 'Downloading firmware'})[action] || 'Working'}…`);
  try {
    const result = await host('request', {request: snapshot || request(action, extra)});
    apply(action, result); return result;
  } catch (error) { status(error.message, true); log(`ERROR: ${error.message}\n`); $('log-panel').open = true; throw error; }
  finally { setBusy(false); }
}
function confirmAction(text, title = 'Confirm action') {
  return new Promise(resolve => {
    const dialog = $('confirm-dialog'); $('confirm-text').textContent = text; $('confirm-title').textContent = title;
    $('confirm-yes').onclick = () => { dialog.close(); resolve(true); };
    $('confirm-no').onclick = () => { dialog.close(); resolve(false); };
    dialog.oncancel = () => resolve(false); dialog.showModal(); $('confirm-no').focus();
  });
}
function bind(id, callback) {
  $(id).addEventListener('click', () => Promise.resolve().then(callback).catch(error => status(error.message, true)));
}

bind('reload', () => run('load'));
bind('workspace-pick', async () => {
  const {path} = await host('pick', {kind: 'workspace'});
  if (path) { context.workspace = path; $('workspace').textContent = path; invalidate(); emptyDevices(); await run('load'); }
});
bind('browse', async () => { const {path} = await host('pick', {kind: 'firmware'}); if (path) await run('select', {firmware: path}); });
bind('select', () => {
  if (!$('firmware-path').value.trim()) throw new Error('Choose a firmware ZIP first.');
  return run('select', {firmware: $('firmware-path').value.trim()});
});
bind('scan', () => run('scan'));
bind('identify', () => run('identify'));
bind('save', async () => {
  if (await confirmAction('Save the displayed assignments to selection.toml? This replaces the saved assignments.', 'Save assignments')) await run('save', {override: true});
});
bind('prepare', async () => {
  if (!firmware) throw new Error('Choose firmware before reviewing programming.');
  if ($('firmware-path').value.trim() !== firmware) throw new Error('Click Use ZIP to validate the changed firmware path first.');
  const snapshot = request('prepare');
  const prepared = await run('prepare', {}, snapshot);
  review = prepared; reviewRequest = snapshot;
  $('review-meta').textContent = `${prepared.summary.target.toUpperCase()} · ${prepared.summary.release} · ${prepared.summary.backend.toUpperCase()}${context.demo ? ' · DEMO' : ''}`;
  $('review-assignments').replaceChildren();
  for (const item of prepared.summary.assignments) {
    const row = document.createElement('div'); row.className = 'review-row';
    const label = document.createElement('strong'); label.textContent = item.position;
    const name = document.createElement('span'); name.textContent = item.program;
    row.append(label, name); $('review-assignments').append(row);
  }
  $('review-hashes').textContent = JSON.stringify(prepared.firmware, null, 2);
  status('Review ready. Hardware has not been accessed.');
  $('physical-confirm').checked = false; $('execute').disabled = true;
  $('review-dialog').showModal(); $('review-cancel').focus();
});
bind('review-cancel', () => { $('review-dialog').close(); invalidate(); status('Review canceled. Hardware has not been accessed.'); });
$('review-dialog').addEventListener('cancel', invalidate);
$('physical-confirm').onchange = () => { $('execute').disabled = !$('physical-confirm').checked || busy || !review; };
bind('execute', async () => {
  if (!review || !$('physical-confirm').checked || busy) return;
  const snapshot = {...reviewRequest, action: 'execute', plan_id: review.plan_id, review_sha256: review.review_sha256};
  $('review-dialog').close(); invalidate(); await run('execute', {}, snapshot);
});
function filterPublished() {
  const select = $('published-release'); select.replaceChildren();
  for (const [index, item] of published.entries()) {
    if (item.prerelease && !$('testing').checked) continue;
    select.add(new Option(`${item.published_at.slice(0, 10)} · ${item.name || item.tag}${item.prerelease ? ' · testing' : ''}`, String(index)));
  }
  if (!select.options.length) select.add(new Option('No matching releases available', ''));
  $('download').disabled = !select.value;
}
bind('releases', async () => { published = (await run('releases')).releases; filterPublished(); $('release-dialog').showModal(); });
$('testing').onchange = filterPublished;
bind('download-cancel', () => $('release-dialog').close());
bind('download', async () => {
  if (!$('published-release').value) return;
  const item = published[Number($('published-release').value)]; $('release-dialog').close();
  await run('download', {release_id: item.id, release_commit: item.commit});
});
bind('drivers', async () => {
  if (context.platform === 'linux' && !context.demo) {
    await confirmAction('Run ultrazohm-cpld-user setup_drivers in a terminal with your toolchain environment activated, then reconnect the probe. Administrator authentication happens in that terminal.', 'Linux USB permissions'); return;
  }
  if (await confirmAction('Configure the selected programmer driver? Close other programmer applications. Windows may request administrator approval.', 'Driver setup')) await run('drivers');
});
$('release').onchange = () => {
  release = $('release').value; invalidate();
  for (const key of Object.keys(assignments)) if (!catalog[release]?.[key === 's3c' ? 's3c' : 'dslot']?.includes(assignments[key])) assignments[key] = '';
  renderAssignments(); persist();
};
$('firmware-path').addEventListener('input', invalidate);
for (const id of ['target', 'backend', 'serial', 'cable', 'probe-index', 'device-id']) $(id).addEventListener('change', () => {
  invalidate(); emptyDevices(); renderAssignments(); persist(); status('Connection changed. Scan to inspect this chain.');
});

function themeLabel() {
  $('theme-label').textContent = vscode ? `VS Code theme · ${document.body.dataset.vscodeThemeId || 'active theme'}` : 'Standalone · system theme';
}
new MutationObserver(themeLabel).observe(document.body, {attributes: true, attributeFilter: ['data-vscode-theme-id', 'class']});
async function initialize() {
  context = await host('init'); $('workspace').textContent = context.workspace; $('demo').hidden = !context.demo;
  $('host-label').textContent = vscode ? 'VS Code · shared programmer API' : 'Standalone · shared programmer API';
  themeLabel();
  const saved = vscode?.getState();
  if (saved?.workspace === context.workspace) {
    $('backend').value = saved.backend || 'foss'; $('target').value = saved.target || 's3c';
  }
  if (context.busy && context.active_job) {
    setBusy(true); status('Reconnected to the running operation…');
    try { const outcome = await poll(context.active_job); apply(outcome.action, outcome.result); }
    finally { setBusy(false); }
  }
  await run('load');
}
initialize().catch(error => { status(error.message, true); log(error.stack + '\n'); });
