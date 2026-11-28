'use strict';
const vscode = require('vscode');
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const {spawn} = require('node:child_process');

function activate(context) {
  const output = vscode.window.createOutputChannel('UltraZohm programmer preview');
  context.subscriptions.push(output);
  let panel, busy = false, workspace, demo = false;
  const post = message => panel?.webview.postMessage(message);
  const config = () => ({workspace, demo, busy, platform: process.platform, host: 'vscode'});
  const choose = async folder => {
    const result = await vscode.window.showOpenDialog({canSelectFiles: !folder, canSelectFolders: folder,
      canSelectMany: false, defaultUri: vscode.Uri.file(workspace || require('node:os').homedir()),
      ...(folder ? {} : {filters: {'Firmware ZIP': ['zip']}})});
    if (result?.[0]?.scheme !== 'file') return null;
    return result[0].fsPath;
  };

  async function run(request, id) {
    if (busy) throw new Error('Another programmer operation is still running.');
    if (!vscode.workspace.isTrusted) throw new Error('Trust this workspace before running the programmer.');
    busy = true;
    const python = vscode.workspace.getConfiguration('uzCpldPreview').get('pythonPath') ||
      (process.platform === 'win32' ? 'python' : 'python3');
    request = {...request, workspace};
    output.appendLine(`\n${demo ? '[DEMO] ' : ''}${request.action} · ${workspace}`);
    try {
      await vscode.window.withProgress({location: vscode.ProgressLocation.Window,
        title: `CPLD: ${request.action}`, cancellable: false}, () => new Promise((resolve, reject) => {
        const child = spawn(python, ['-u', path.join(context.extensionPath, 'bridge.py'), ...(demo ? ['--demo'] : [])],
          {cwd: context.extensionPath, windowsHide: true, stdio: ['pipe', 'pipe', 'pipe']});
        const operationId = crypto.randomUUID();
        let buffer = '', result, protocolError;
        child.stdout.setEncoding('utf8');
        child.stderr.setEncoding('utf8');
        child.stdout.on('data', chunk => {
          buffer += chunk;
          if (buffer.length > 1024 * 1024) { protocolError = 'Worker message exceeds size limit'; buffer = ''; }
          let end;
          while ((end = buffer.indexOf('\n')) >= 0) {
            const line = buffer.slice(0, end); buffer = buffer.slice(end + 1);
            try {
              const message = JSON.parse(line);
              if (message.version !== 1 || message.id !== operationId || result) throw new Error('Invalid worker protocol');
              if (message.type === 'result' && typeof message.ok === 'boolean') result = message;
              else if (message.type === 'event') {
                if (message.event.text) output.append(message.event.text);
                post({type: 'event', event: message.event});
              }
              else throw new Error('Invalid worker message');
            } catch (error) { protocolError = error.message; }
          }
        });
        child.stderr.on('data', text => {
          output.append(text); post({type: 'event', event: {phase: 'log', text}});
        });
        child.on('error', reject);
        child.stdin.on('error', reject);
        child.on('close', code => {
          if (protocolError || buffer.trim() || (result?.ok && code !== 0)) return reject(new Error('Worker outcome unknown: ' + (protocolError || 'inconsistent termination')));
          if (!result) return reject(new Error(`Worker exited (${code}). See the UltraZohm output channel.`));
          post({...result, type: 'response', id, action: request.action});
          if (!panel && request.action !== 'load') {
            const notify = result.ok ? vscode.window.showInformationMessage : vscode.window.showErrorMessage;
            notify(`CPLD ${request.action}: ${result.result?.message || result.message || 'complete'}`);
          }
          resolve();
        });
        child.stdin.end(JSON.stringify({version: 1, id: operationId, request}));
      }));
    } finally { busy = false; post({type: 'busy', busy: false}); }
  }

  async function open(useDemo) {
    if (panel) { panel.reveal(); return; }
    if (busy) { vscode.window.showInformationMessage('A programmer operation is still running. See the output channel.'); output.show(); return; }
    demo = useDemo;
    workspace ||= vscode.workspace.workspaceFolders?.find(f => f.uri.scheme === 'file')?.uri.fsPath;
    workspace ||= await choose(true);
    if (!workspace) return;
    panel = vscode.window.createWebviewPanel('uzCpldPreview', 'CPLD Programmer', vscode.ViewColumn.Active,
      {enableScripts: true, retainContextWhenHidden: true,
       localResourceRoots: [vscode.Uri.joinPath(context.extensionUri, 'web')]});
    const nonce = crypto.randomBytes(24).toString('hex');
    const asset = name => panel.webview.asWebviewUri(vscode.Uri.joinPath(context.extensionUri, 'web', name)).toString();
    panel.webview.html = fs.readFileSync(path.join(context.extensionPath, 'web/index.html'), 'utf8')
      .replaceAll('__STYLE__', asset('style.css')).replaceAll('__SCRIPT__', asset('app.js'))
      .replaceAll('__NONCE__', nonce)
      .replaceAll('__CSP__', `default-src 'none'; style-src ${panel.webview.cspSource}; script-src 'nonce-${nonce}';`)
      .replaceAll('__TOKEN__', '');
    panel.onDidDispose(() => { panel = undefined; });
    panel.webview.onDidReceiveMessage(async message => {
      const {id, type} = message;
      try {
        if (type === 'init') return post({type: 'response', id, ok: true, result: config()});
        if (type === 'logs') { output.show(); return post({type: 'response', id, ok: true, result: {}}); }
        if (type === 'pick') {
          if (busy) throw new Error('Wait for the active operation to finish.');
          const selected = await choose(message.kind === 'workspace');
          if (selected && message.kind === 'workspace') workspace = selected;
          return post({type: 'response', id, ok: true, result: {path: selected}});
        }
        if (type === 'request') return await run(message.request, id);
        throw new Error('Unknown host request.');
      } catch (error) { post({type: 'response', id, ok: false, message: error.message}); }
    });
  }
  context.subscriptions.push(
    vscode.commands.registerCommand('uzCpldPreview.open', () => open(false)),
    vscode.commands.registerCommand('uzCpldPreview.demo', () => open(true)));
}
module.exports = {activate};
