"""Exact certificates for Zanello's equal-area conjecture at fixed heights.

Requires python-flint. Run: python verify_equal_area.py
All polynomial arithmetic, including the interval tests, is rational.
"""
from collections import Counter
import argparse
from pathlib import Path
import re
from fractions import Fraction
from functools import cache
from math import comb, factorial, gcd

from flint import fmpq_poly as Q, fmpz_poly as Z, fmpq


X = Q([0, 1])
ONE = Q([1])
if not __debug__:
    raise RuntimeError("Run without -O so every certificate check executes.")


def rational(x):
    return fmpq(x.numerator, x.denominator)


def exact_div(p, d):
    q, r = divmod(p, d)
    assert not r
    return q


@cache
def waves(h, t):
    """Polynomial contribution at root 1 and coefficient bounds for all other roots."""
    denominator = ONE
    for i in range(1, h + 1):
        denominator *= 1 - X**i
    denominator = exact_div(denominator, (1 - X)**t)
    check = Q([])
    error = Q([])
    main = None
    for period in range(1, h + 1):
        order = h // period - (t if period == 1 else 0)
        divisor = Q(Z.cyclotomic(period))**order
        other = exact_div(denominator, divisor)
        gcd, inverse, _ = other.xgcd(divisor)
        assert gcd == 1
        numerator = inverse % divisor
        check += numerator * other
        lift = numerator * exact_div((1 - X**period)**order, divisor)
        assert lift.degree() < period * order
        by_residue = [Q([]) for _ in range(period)]
        for i, coefficient in enumerate(lift.coeffs()):
            if not coefficient:
                continue
            basis = ONE
            for j in range(1, order):
                basis *= (X - i) / period + j
            by_residue[i % period] += coefficient * basis / factorial(order - 1)
        if period == 1:
            main = by_residue[0]
        else:
            error += Q([max(abs(poly[k]) for poly in by_residue) for k in range(order)])
    assert check == 1
    return main, error


@cache
def offsets(h):
    """Counts subsets of 1..h by cardinality and sum."""
    rows = [Counter({0: 1})] + [Counter() for _ in range(h)]
    for i in range(1, h + 1):
        for j in range(i, 0, -1):
            rows[j].update({s+i: m for s, m in rows[j-1].items()})
    return rows


@cache
def component(h, t, scale, j):
    """Rows in c: main and absolute error for a size-j group, x=n/c."""
    main, wave_error = waves(h, t)
    counts = offsets(h)[j]
    # Once n >= j*width, extend the root-1 polynomial across short negative
    # arguments. Bound that extension exactly over each missing integer.
    extension = 0
    maximum = 0
    for k in range(1, max(counts)+1):
        maximum = max(maximum, abs(main(-k)))
        extension += maximum * counts.get(k, 0)
    signed = sum((mult * main(X-s) for s, mult in counts.items()), Q([])) * ((-1)**j)
    bound = comb(h, j) * wave_error + extension
    offset = X - rational(j * scale)
    return [(signed[i] * offset**i, bound[i] * offset**i) for i in range(main.degree()+1)]


def on_chamber(a, b, t, lo, sign, comparison_height=None):
    """Lower bound on sign times the t-th difference, polynomial in c and x."""
    cap = comparison_height or b
    rows = [Q([]) for _ in range(cap-t)]
    for h, scale, direction in ((cap, Fraction(1), sign), (a, Fraction(b, a), -sign)):
        for j in range(h+1):
            if j*scale > lo:
                break
            for i, (main, bound) in enumerate(component(h, t, scale, j)):
                rows[i] += direction * main - bound
    return rows


def positive_on_interval(poly, lo, hi, depth=8):
    """Positive Bernstein controls imply positivity on a closed interval."""
    if not poly:
        return True
    degree = poly.degree()
    p = poly(rational(lo) + rational(hi-lo) * X)
    controls = [sum(p[j] * comb(k, j) / comb(degree, j) for j in range(k+1))
                for k in range(degree+1)]
    if min(controls) > 0:
        return True
    if depth == 0 or min(controls[0], controls[-1]) <= 0:
        return False
    mid = (lo + hi) / 2
    return (positive_on_interval(poly, lo, mid, depth-1)
            and positive_on_interval(poly, mid, hi, depth-1))

@cache
def affine_component(h, order, j, shift):
    """Wave bound for the whole size-j group at arguments y-s-shift, y>=0."""
    main, error = waves(h, order)
    counts = offsets(h)[j]
    offset_counts = {s + shift: mult for s, mult in counts.items()}
    bound = Q([])
    signed = Q([])
    for d, mult in offset_counts.items():
        signed += mult * main(X-d)
        bound += mult * error(X + max(0, -d))
    max_d = max(offset_counts)
    maximum = 0
    for k in range(1, max_d+1):
        maximum = max(maximum, abs(main(-k)))
        bound += maximum * offset_counts.get(k, 0)
    return signed*((-1)**j), bound


@cache
def inactive_bound(h, order, j, shift, distance):
    """If y<=-distance, bound the exact terms that may already be active."""
    main, error = waves(h, order)
    maximum = (-distance).__floor__() - shift
    if maximum < 0:
        return 0
    running = []
    value = 0
    for i in range(maximum+1):
        value = max(value, abs(main(i))+error(i))
        running.append(value)
    return sum(mult*running[maximum-s] for s, mult in offsets(h)[j].items() if s<=maximum)


def koh_chamber(a, b, t, lo, hi, threshold, sign, h, r):
    # lambda=((h+1)^r,1^(b-(h+1)*r)). After one finite difference the
    # line factor becomes a difference of two shifted Gaussian polynomials.
    length_slope = b-h*r
    start = h*(h+1)*r
    terms = [(h, t-1, Fraction(r), -2*h*r, 0, start, sign),
             (h, t-1, Fraction(r), -2*h*r, length_slope, start+1-2*h*r, -sign),
             (a, t, Fraction(b, a), 0, 0, 0, -sign)]
    rows = [Q([]) for _ in range(max(h-t+1, a-t))]
    for height, order, width, intercept, slope, constant, direction in terms:
        for j in range(height+1):
            knot = slope + j*width
            off = constant + j*intercept
            if knot > lo:
                assert hi <= knot
                rows[0] -= inactive_bound(height, order, j, off, threshold*(knot-hi))
                continue
            main, error = affine_component(height, order, j, off)
            piece = direction*main - error
            for i, p in enumerate(piece.coeffs()):
                rows[i] += p*(X-rational(knot))**i
    return rows


def certified_rows(rows, threshold, lo, hi, depth=8):
    for k in range(len(rows)):
        translated = sum((rows[i] * (comb(i, k) * threshold**(i-k))
                          for i in range(k, len(rows))), Q([]))
        if (not translated and k == 0) or not positive_on_interval(translated, lo, hi, depth):
            return False
    return True


def tail(a, b, threshold, koh=None, depth=8):
    center = Fraction(b, 2)
    regions = ((1, 1, Fraction(1), center - Fraction(1, 4)),
               (2, -1, center - Fraction(1, 4), center + Fraction(1, 4)))
    for t, sign, start, end in regions:
        knots = {Fraction(j*b,a) for j in range(a+1)}
        if koh:
            h, r = koh
            cap = min(b, a+6)
            switch = Fraction(cap, 2) - Fraction(1, 4)
            assert r>0 and b>(h+1)*r and threshold>=2*h and threshold*(b-h*r)>=2*h*r
            knots.update(Fraction(j*r+i) for j in range(h+1) for i in (0,b-h*r))
            knots.add(switch)
            if t == 1:
                knots.update(Fraction(j) for j in range(b+1))
        else:
            knots.update(Fraction(j) for j in range(b+1))
        knots = sorted({start, end} | {v for v in knots if start<v<end})
        for lo, hi in zip(knots, knots[1:]):
            if koh and t == 1 and hi <= switch:
                rows = on_chamber(a,b,t,lo,sign,cap)
            elif koh and t == 1:
                # Each summand and its complement are centered and unimodal.
                # A different summand may supply the lower bound on each strip.
                choices = sorted(range(1, (b-1)//(h+1)+1),
                                 key=lambda u: abs((lo+hi)/2-u*(Fraction(h,2)+Fraction(h*(h+1),threshold))))
                if any(certified_rows(koh_chamber(a,b,t,lo,hi,threshold,sign,h,u),threshold,lo,hi,depth)
                       for u in choices):
                    continue
                return False, (t, lo, hi)
            elif koh:
                rows = koh_chamber(a,b,t,lo,hi,threshold,sign,*koh)
            else:
                rows = on_chamber(a,b,t,lo,sign)
            if not certified_rows(rows, threshold, lo, hi, depth):
                return False, (t, lo, hi)
    return True, None


def rectangles(h, last):
    """Use P(h,w)(1-q^w)=P(h,w-1)(1-q^(w+h)) and a geometric sum."""
    value = Z([1])
    yield value
    for w in range(1, last+1):
        degree = h*w
        value -= value.left_shift(w+h)
        step = w
        while step <= degree:
            value = (value + value.truncate(degree-step+1).left_shift(step)).truncate(degree+1)
            step *= 2
        yield value


def finite_widths(a, b, threshold):
    if threshold <= b:
        return
    outer = enumerate(rectangles(a, (b * (threshold-1)) // a))
    for c, p in enumerate(rectangles(b, threshold-1)):
        if c < b or (b*c) % a:
            continue
        d = b*c // a
        for w, q in outer:
            if w == d:
                break
        assert w == d
        coeff = [int(x) for x in (p - q).coeffs()]
        coeff.extend([0] * (b*c+1-len(coeff)))
        assert coeff == coeff[::-1] and coeff[0] == 0
        drop = next((j for j in range(1, b*c//2+1) if coeff[j] < coeff[j-1]), None)
        yield c, d, drop


def finite(a, b, threshold):
    count = 0
    for c, d, drop in finite_widths(a, b, threshold):
        if drop is not None:
            raise ArithmeticError((a, b, c, d, drop))
        count += 1
    return count


def primitive_heights(a):
    return [b for b in range(a+1, a*a)
            if b % a and 1 < gcd(a,b) and b//gcd(a,b) < a
            and all(b % t for t in range(a, b))]


def verify_pair(a, b):
    if b <= 48:
        for T in (64,128,256,512):
            if tail(a,b,T)[0]:
                return T, "full", finite(a,b,T)
    for h in (a+3, a+5, a, a+8, a+11):
        r = (b-1)//(h+1)
        if r == 0 or b >= 2*h*r:
            continue
        for T in sorted({max(b,2*h),max(128,b),max(192,b),max(256,b),max(384,b),max(512,b)}):
            if T >= 2*h and tail(a,b,T,(h,r))[0]:
                return T, f"KOH({h},{r})", finite(a,b,T)
    for T in (128,256,512,1024):
        if tail(a,b,T)[0]:
            return T, "full", finite(a,b,T)
    raise ArithmeticError(f"No tail certificate at heights {a},{b}")


def exceptions(a):
    """Unrestricted decision procedure. Output includes the first offending rank."""
    if a < 1:
        raise ValueError("The smallest side must be positive.")
    if a <= 3:
        return  # Zanello's theorem
    for b in range(a+1, a*a):
        g = gcd(a,b)
        if b % a == 0 or g == 1 or b//g >= a:
            continue  # unconditional divisibility or the intermediate rectangle
        # Try every width cutoff and every subdivision depth in a diagonal
        # order. The fixed-height theorem guarantees a successful pair.
        budget = 0
        found = False
        while not found:
            for exponent in range(budget+1):
                threshold = 8 * 2**exponent
                depth = budget - exponent
                if tail(a, b, threshold, depth=depth)[0]:
                    found = True
                    break
            budget += 1
        for c, d, drop in finite_widths(a,b,threshold):
            if drop is not None:
                yield a, b, c, d, drop


def replay(ledger):
    """Check the recorded width bounds for all primitive pairs through 24."""
    from packed_head import finite as independent_head

    lines = Path(ledger).read_text(encoding="utf-8").splitlines()
    expected = [(a, b) for a in range(4, 25) for b in primitive_heights(a)]
    assert len(lines) == len(expected)
    direct = 0
    widths = 0
    for (a, b), line in zip(expected, lines):
        first, second, threshold, method, count = line.split()
        assert (a, b) == (int(first), int(second))
        T = int(threshold)
        assert T >= 4
        koh = None
        if method != "full":
            parameters = re.fullmatch(r"KOH\((\d+),(\d+)\)", method)
            assert parameters is not None
            koh = tuple(map(int, parameters.groups()))
        assert tail(a,b,T,koh)[0]
        covered, expanded = independent_head(a,b,T)
        assert covered == int(count)
        direct += expanded
        widths += covered
    print(f"{len(expected)} pairs, {widths} finite widths, {direct} packed expansions")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--first", type=int, default=4)
    parser.add_argument("--last", type=int, default=24)
    parser.add_argument("--exceptions", type=int, help="decide one fixed smallest side")
    parser.add_argument("--replay", type=Path, help="recompute the full run ledger")
    args = parser.parse_args()
    if args.replay is not None:
        replay(args.replay)
    elif args.exceptions is not None:
        print(list(exceptions(args.exceptions)))
    else:
        for a in range(args.first,args.last+1):
            for b in primitive_heights(a):
                T, method, instances = verify_pair(a,b)
                print(a,b,T,method,instances,flush=True)
