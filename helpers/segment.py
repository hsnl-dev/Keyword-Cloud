# -*- coding=utf-8 -*-
import jieba

jieba.set_dictionary('lib/dict/dict.txt.big')
jieba.load_userdict('lib/dict/dict.txt.big')


def seg_slides(slides):
    seg_list = jieba.cut(slides, cut_all=False)
    result = []
    for seg in seg_list:
        seg = ''.join(seg.split())
        if (seg != '' and seg != "\n" and seg != "\n\n"):
            result.append(seg)
    return result
