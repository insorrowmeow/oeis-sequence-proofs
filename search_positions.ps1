$ErrorActionPreference = 'Stop'
Add-Type -TypeDefinition @'
using System;

public static class PositionAudit {
    public static void Run(int multiplier, int steps) {
        byte[] used = new byte[(multiplier * steps) / 8 + 1];
        used[0] = 3;
        int last = 1;
        long maxExcess = long.MinValue;
        int failures = 0;
        for (int i = 2; i <= steps; i++) {
            int half = last / 2;
            last = (used[half >> 3] & (1 << (half & 7))) != 0 ? multiplier * i : half;
            used[last >> 3] |= (byte)(1 << (last & 7));
            long excess = 3L * i - 16L * last;
            if (excess > maxExcess) maxExcess = excess;
            bool failure = multiplier == 2 ? i == 4L * last + 4 : excess > 21;
            if (failure && failures++ < 5) Console.WriteLine("exception M={0}, n={1}, T={2}", multiplier, last, i);
        }
        Console.WriteLine("M={0}, steps={1}, exceptions={2}, max 3T-16n={3}", multiplier, steps, failures, maxExcess);
    }
}
'@
[PositionAudit]::Run(2, 200000000)
[PositionAudit]::Run(3, 200000000)
