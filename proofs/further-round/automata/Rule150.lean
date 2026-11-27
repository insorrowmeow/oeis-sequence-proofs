import Mathlib.Data.Nat.Basic

namespace Rule150

def step {w : Nat} (x : BitVec w) := x.rotateLeft 1 ^^^ x ^^^ x.rotateRight 1

/-- Numerator update for min(2x,2−2x) with x=j/w. -/
def tent (w j : Nat) := min (2*j) (2*w-2*j)

theorem width_four :
    step (1 : BitVec 4) = 11 ∧ step (11 : BitVec 4) = 1 ∧
    (1 : BitVec 4) ≠ 11 ∧
    tent 4 1 = 2 ∧ tent 4 2 = 4 ∧ tent 4 4 = 0 ∧ tent 4 0 = 0 ∧
    ¬ (2^2*(2^1-1) : Nat) ∣ 2 := by decide

#print axioms width_four
end Rule150
