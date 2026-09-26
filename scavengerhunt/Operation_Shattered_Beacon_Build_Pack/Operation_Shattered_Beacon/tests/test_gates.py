"""Portable C gameplay tests. Requires Python 3 and GCC; does not provision Windows."""
from pathlib import Path
import json
import subprocess
import tempfile

root=Path(__file__).resolve().parents[1]
rows=json.loads((root/'organizer/manifest.json').read_text())
checks=0
with tempfile.TemporaryDirectory(prefix='shattered-beacon-test-') as tmp:
    for i,row in enumerate(rows):
        binary=Path(tmp)/Path(row['source']).stem
        subprocess.run(['gcc','-std=c11','-Wall','-Wextra','-Werror','-I',str(root/'include'),
            '-DHUNT_DNS_SERVER="192.0.2.53"','-DHUNT_DOMAIN="clone.wars"',
            str(root/row['source']),'-o',str(binary)],check=True,capture_output=True,text=True)
        def run(data,args=()):
            return subprocess.run([str(binary),*args],input=data,text=True,capture_output=True,check=True).stdout
        def denied_before_briefing(output):
            assert 'Mission briefing follows.' not in output
            assert 'Evidence accepted.' not in output
            assert 'Scoring flag:' not in output
            assert 'Next entry password:' not in output
        for value in ('wrong-entry\n',row['answer']+'\n','x'*400+'\n',''):
            denied_before_briefing(run(value));checks+=1
        output=run(row['entry']+'\n')
        assert 'Mission briefing follows.' in output and 'Scoring flag:' not in output
        checks+=1
        output=run(row['entry']+'\nwrong-answer\n')
        assert 'Mission briefing follows.' in output
        assert 'Evidence accepted.' not in output and 'Next entry password:' not in output
        checks+=1
        output=run(row['entry']+'\n'+row['answer']+'\n\n')
        assert 'Evidence accepted.' in output and row['flag'] in output
        if i+1<len(rows):
            nxt=rows[i+1]
            assert 'Next entry password: '+nxt['entry'] in output.splitlines()
            assert 'Next terminal: C:\\Republic\\Hunt\\'+nxt['path'] in output.splitlines()
            assert row['host']!=nxt['host']
        else:
            assert 'NO BROTHER LEFT BEHIND' in output
            assert 'Next entry password:' not in output
            droid=run(row['entry']+'\n'+row['answer']+'\n\n',('--droid',))
            assert 'ROGER, ROGER' in droid and row['flag'] in droid
            checks+=1
        checks+=1
        denied_before_briefing(run('wrong-after-restart\n'));checks+=1
        # CRLF pasted from Windows should preserve password semantics.
        output=run(row['entry']+'\r\n'+row['answer']+'\r\n\r\n')
        assert row['flag'] in output;checks+=1
        print('PASS',row['host'],Path(row['source']).name)
assert len(rows)==21
assert len({r['flag'] for r in rows})==21
assert sum(r['blue_points'] for r in rows)==520
assert sum(r['red_points'] for r in rows)==260
print(f'{len(rows)} C programs compiled; {checks} runtime scenarios passed; all 20 next-stage handoffs matched.')
