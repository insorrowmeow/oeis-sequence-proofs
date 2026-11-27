"""Cross-check the OEIS square-lattice sum against the Lean parameter model."""

from math import gcd, isqrt


def from_legs(n):
    total = 0
    for x in range(1, n+1):
        for y in range(x+1, n+1):
            z2 = x*x+y*y
            z = isqrt(z2)
            if z*z == z2 and gcd(x,y) == 1:
                total += (n//y+n//z)**2
    return total


def from_parameters(n):
    total = 0
    for u in range(1, n+1):
        for i in range(u//2):
            v = 2*i+(1 if u%2 == 0 else 2)
            if gcd(u,v) == 1:
                y = max(u*u-v*v, 2*u*v)
                z = u*u+v*v
                total += (n//y+n//z)**2
    return total


if __name__ == "__main__":
    prefix = [0,0,0,1,4,4,4,9,9,16,16,26,29,29,41,54,57,57,57,89]
    assert [from_parameters(n) for n in range(1,21)] == prefix
    for n in range(201):
        assert from_legs(n) == from_parameters(n)
    print("The Euclid-parameter and leg counts agree for 0 <= n <= 200.")
