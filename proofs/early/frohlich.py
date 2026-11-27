"""Search the modulus-c² question in Felix Fröhlich's OEIS A308482."""
import argparse
from math import isqrt

def find(bound):
    sieve=bytearray(b'\1')*(bound+1)
    sieve[:2]=b'\0\0'
    for p in range(2,isqrt(bound)+1):
        if sieve[p]:
            sieve[p*p::p]=bytes((bound-p*p)//p+1)
    prev,t=0,1
    for c in range(1,bound+1):
        if c>1 and not sieve[c]:
            symbol=(0,1,-1)[c%3]
            modulus=c*c
            rhs=(pow(3,c-1,modulus)*symbol)%modulus if symbol else 0
            if t%modulus==rhs:
                print(c, rhs, flush=True)
        prev,t=t,((2*c-1)*t+3*(c-1)*prev)//c

if __name__=='__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('limit',type=int)
    find(parser.parse_args().limit)
