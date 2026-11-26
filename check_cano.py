"""Test indices 5..5000 of A300326 for compositeness with the GMP library."""
import ctypes as C
from ctypes.util import find_library
from math import isqrt, prod
from pathlib import Path
import sys


class Mpz(C.Structure):
    _fields_ = [('alloc', C.c_int), ('size', C.c_int), ('limbs', C.c_void_p)]


def main():
    # Optionally pass the library location on the command line.
    location = sys.argv[1] if len(sys.argv) > 1 else find_library('gmp')
    if not location:
        location = Path('C:/Program Files/Git/mingw64/bin/libgmp-10.dll')
    lib = C.CDLL(str(location))
    ptr = C.POINTER(Mpz)
    ui = C.c_ulong

    def bind(name, arguments, result=None):
        fun = getattr(lib, '__gmpz_' + name)
        fun.argtypes = arguments
        fun.restype = result
        return fun

    init = bind('init', [ptr])
    clear = bind('clear', [ptr])
    power = bind('ui_pow_ui', [ptr, ui, ui])
    multiply = bind('mul_ui', [ptr, ptr, ui])
    add_ui = bind('add_ui', [ptr, ptr, ui])
    divide = bind('divexact_ui', [ptr, ptr, ui])
    add = bind('add', [ptr, ptr, ptr])
    parse = bind('set_str', [ptr, C.c_char_p, C.c_int], C.c_int)
    gcd = bind('gcd', [ptr, ptr, ptr])
    compare_ui = bind('cmp_ui', [ptr, ui], C.c_int)
    primality = bind('probab_prime_p', [ptr, C.c_int], C.c_int)

    sieve_limit = 100000
    sieve = bytearray([1]) * (sieve_limit + 1)
    for p in range(2, isqrt(sieve_limit) + 1):
        if sieve[p]:
            sieve[p*p::p] = bytes(len(sieve[p*p::p]))
    primes_product = prod(p for p in range(2, sieve_limit+1) if sieve[p])
    variables = [Mpz() for _ in range(5)]
    total, power_term, increment, pool, common = variables
    for v in variables:
        init(v)
    try:
        assert parse(pool, hex(primes_product).encode(), 0) == 0
        primality_calls = 0
        for n in range(1, 5001):
            b = n+1
            power(power_term, b, b)
            # (b-1)^2 D(b) = b*(b-2)*b^b + b.
            multiply(increment, power_term, b*(b-2))
            add_ui(increment, increment, b)
            divide(increment, increment, (b-1)**2)
            add(total, total, increment)
            if n < 5:
                continue
            if n == 5:
                assert compare_ui(total, 47971) == 0 and 47971 % 7 == 0
            else:
                assert compare_ui(total, sieve_limit) > 0
            gcd(common, total, pool)
            if compare_ui(common, 1) == 0:
                primality_calls += 1
                # GMP returns 0 only if it has established compositeness.
                assert primality(total, 25) == 0, f"Inspect candidate at index {n}"
        print(f"Indices 5 through 5000 are composite ({primality_calls} GMP tests after sieving).")
    finally:
        for v in variables:
            clear(v)


if __name__ == '__main__':
    main()
