"""Exhaustive two-ended digit search for the even-product case of OEIS A401895."""

import argparse


def search(depth):
    # A state fixes prefixes p,q of n,rev(n), and their length-k reversals u,v.
    # They simultaneously determine the suffixes of rev(n),n.
    states = [(0, 0, 0, 0, d) for d in range(1, 10)]
    power = 1
    matches = set()
    widths = []
    for k in range(1, depth+1):
        new = []
        z = power*10
        for p, q, u, v, digit in states:
            # (9uv+d) is a multiple of power for every old state.
            carry = (9*u*v+digit)//power
            for i in range(int(k == 1), 10):
                a = 10*p+i
                for j in range(int(k == 1), 10):
                    if k == 1 and i > j:
                        continue
                    # For k=1 the cross term still enters the lowest position.
                    if (carry + 9*(i*v+j*u+power*i*j)) % 10:
                        continue
                    b = 10*q+j
                    if not (9*a*b < digit*z*z <= 9*(a+1)*(b+1)):
                        continue
                    s, t = u+power*i, v+power*j
                    new.append((a,b,s,t,digit))
                    even_n, even_rev = a*z+t, b*z+s
                    if 9*even_n*even_rev == digit*(z**4-1):
                        matches.update((even_n, even_rev))
                    if i == j:
                        odd_n, odd_rev = (a//10)*z+t, (b//10)*z+s
                        if 9*odd_n*odd_rev == digit*((z*z//10)**2-1):
                            matches.update((odd_n, odd_rev))
        states = new
        power = z
        widths.append((k,len(states),tuple(sorted({s[-1] for s in states}))))
    return matches, widths


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("depth", nargs="?", type=int, default=100)
    d = parser.parse_args().depth
    matches, widths = search(d)
    for k,num,digits in widths:
        if k in (1,2,3,14,d) or k%25 == 0:
            print(f"{k} digits at each end: {num} prefixes, surviving product digits {digits}")
    print(f"Even-length repdigit products for inputs of up to {2*d} digits: {sorted(matches)}")
