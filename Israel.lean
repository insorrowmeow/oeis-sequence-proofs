import InversePrefix
import P4R0
import P4R2
import P8R1
import P8R5
import P8R7
import P16R3
import P16R11

namespace Inverse

/-- The one position left open by the seven-position bound never occurs. -/
theorem never_extra (n : Nat) : 1 < n → ¬ Cell n (4*n+4) := by
  induction n using Nat.strongRecOn with
  | ind n ih =>
    intro hn bad
    by_cases small : n < 32
    · exact prefix_good n hn small bad
    have g : GoodBelow n := fun v hv hlt => ih v hlt hv
    have fire (m r : Nat) (hm : 0 < m) (h : n = m*((n-32)/m)+(32+r))
        (f : ∀ k, GoodBelow (m*k+(32+r)) →
          Cell (m*k+(32+r)) (4*(m*k+(32+r))+4) → False) : False := by
      exact f ((n-32)/m) (h ▸ g) (h ▸ bad)
    have cases : (n-32)%4=0 ∨ (n-32)%4=2 ∨ (n-32)%8=1 ∨
        (n-32)%8=5 ∨ (n-32)%8=7 ∨ (n-32)%16=3 ∨ (n-32)%16=11 := by omega
    rcases cases with h|h|h|h|h|h|h
    · exact fire 4 0 (by decide) (by omega) P4R0.exclude
    · exact fire 4 2 (by decide) (by omega) P4R2.exclude
    · exact fire 8 1 (by decide) (by omega) P8R1.exclude
    · exact fire 8 5 (by decide) (by omega) P8R5.exclude
    · exact fire 8 7 (by decide) (by omega) P8R7.exclude
    · exact fire 16 3 (by decide) (by omega) P16R3.exclude
    · exact fire 16 11 (by decide) (by omega) P16R11.exclude

def IsraelPositions (v t : Nat) : Prop :=
  2*t=v ∨ t=v+1 ∨ t=2*v+2 ∨ t=2*v+3 ∨ t=4*v+3 ∨ t=4*v+5

/-- Every positive v greater than 1 occurs at exactly one index. This index
satisfies Robert Israel's six-position conjecture from OEIS A050129. -/
theorem israel_A050129 (v : Nat) (hv : 1 < v) :
    ∃ t, Cell v t ∧ IsraelPositions v t ∧ ∀ j, Cell v j → j=t := by
  obtain ⟨t, _, _, h, hu⟩ := DoubleHalf.a050128 v (by omega)
  have p := DoubleHalf.seven_positions t v hv h
  have ex : t ≠ 4*v+4 := fun ht => never_extra v hv (ht ▸ h)
  exact ⟨t,h,by unfold IsraelPositions; omega,hu⟩

#print axioms israel_A050129

end Inverse
