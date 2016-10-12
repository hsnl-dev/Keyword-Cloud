#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import json
import ast

if len(sys.argv) < 2:
    print('Usage: python3 [].py contents')
    sys.exit()
else:
    slide = sys.argv[1]
    delete_arr = sys.argv[2]

slide = json.loads(slide.replace("'", '"'))
delete_arr = ast.literal_eval(delete_arr)

for item in delete_arr:
    # print(item)
    slide.pop(item)
print(slide)
