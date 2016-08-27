import sys
from helpers import segment

if len(sys.argv) < 2:
    print('Usage: python [].py contents')
    sys.exit()
else:
    slides = sys.argv[1]

segment.seg_slides(slides)
