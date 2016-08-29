#!/usr/bin/env python
# -*- coding: utf-8 -*-
import jieba
import sys

if len(sys.argv) < 2:
    print('Usage: python [].py contents')
    sys.exit()
else:
    slides = sys.argv[1]

jieba.set_dictionary('lib/dict/dict.txt.big')
jieba.load_userdict('lib/dict/dict.txt.big')


seg_list = jieba.cut(slides, cut_all=False)
for seg in seg_list:
    seg = ''.join(seg.split())
    if (seg != '' and seg != "\n" and seg != "\n\n"):
        print(seg)
