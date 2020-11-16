#!/usr/bin/python3

import json
import sys

f = open(sys.argv[1], 'r')
parsed = json.load(f)
print(parsed)
f.close()

with open(sys.argv[1], 'w') as outfile:
    out = json.dumps(parsed, sort_keys=True, indent=4, ensure_ascii=False)
    outfile.write(out)
