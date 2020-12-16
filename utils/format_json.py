#!/usr/bin/python3

import json
import sys

f = open(sys.argv[1], 'r')
try:
    parsed = json.load(f)
    f.close()
except Exception as e:
    print(e)
    print("json not properly formatted!")
    exit(1)
print("json valid!")

with open(sys.argv[1], 'w') as outfile:
    out = json.dumps(parsed, sort_keys=True, indent=4, ensure_ascii=False)
    outfile.write(out)
