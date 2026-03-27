#!/usr/bin/env python3
import sys, email, tempfile, subprocess, base64

data = sys.stdin.buffer.read()
msg = email.message_from_bytes(data)

# Collect inline parts (Content-ID -> data URI)
cid_map = {}
for part in msg.walk():
    content_id = part.get('Content-ID')
    if content_id:
        cid = content_id.strip('<>')
        content_type = part.get_content_type()
        payload = part.get_payload(decode=True)
        if payload:
            b64 = base64.b64encode(payload).decode()
            cid_map[cid] = f'data:{content_type};base64,{b64}'

# Find HTML part
html = None
for part in msg.walk():
    if part.get_content_type() == 'text/html':
        charset = part.get_content_charset() or 'utf-8'
        html = part.get_payload(decode=True).decode(charset, errors='replace')
        break

if html:
    for cid, data_uri in cid_map.items():
        html = html.replace(f'cid:{cid}', data_uri)
    with tempfile.NamedTemporaryFile(suffix='.html', delete=False, mode='w', encoding='utf-8') as f:
        f.write(html)
        subprocess.run(['open', f.name])
