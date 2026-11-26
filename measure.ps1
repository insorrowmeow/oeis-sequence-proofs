param([int]$Count = 10010000)
$ErrorActionPreference = 'Stop'
Add-Type -TypeDefinition @'
using System;
using System.Collections;
public static class RopeExperiment {
  public static void Run(int count) {
    var used = new BitArray(count + count/8 + 10000);
    var next = new int[10];
    var masks = new int[10000];
    var padded = new int[10000];
    for (int i=1; i<10000; i++) masks[i] = masks[i/10] | 1<<(i%10);
    for (int i=0; i<10000; i++) padded[i] = masks[i] | (i<1000 ? 1 : 0);
    var powers = new System.Collections.Generic.HashSet<int>();
    for (long p=10; p<count*2L && p<=int.MaxValue; p*=10) powers.Add((int)p);
    used[0]=true;
    int last=0, prev=-1, streak=0, longest=0;
    for (int n=2; n<=count; n++) {
      int d= last==0 ? 0 : (last-1)%9+1;
      streak = d==prev ? streak+1 : 1;
      if(streak>longest) {
        longest=streak;
        Console.WriteLine("root run {0} digit {1} ending at term index {2}",longest,d,n-1);
      }
      prev=d;
      int x=next[d];
      for (;;x++) {
        if(x>=used.Length) used.Length=checked(used.Length+used.Length/4);
        if(used[x]) continue;
        int h=x, mask=0;
        while(h>=10000) {mask |= padded[h%10000]; h/=10000;}
        mask |= masks[h];
        if ((mask & (1<<d)) != 0) break;
      }
      used[x]=true;
      next[d]=x+1;
      last=x;
      if(powers.Contains(x)) Console.WriteLine("power {0} index {1}",x,n);
    }
  }
}
'@ -CompilerOptions '/optimize'
[RopeExperiment]::Run($Count)
