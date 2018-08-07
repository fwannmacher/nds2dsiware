import struct
import sys


with open(sys.argv[1], 'rb') as file:
    if sys.argv[2] == 'title_id':
        file.seek(560)
        print '%x' % struct.unpack('<i', file.read(4))
    elif sys.argv[2] == 'save_size':
        file.seek(568)
        print struct.unpack('i', file.read(4))[0]
