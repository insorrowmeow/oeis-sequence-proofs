import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Data.Rat.Defs

/-! Exact evaluation of the finite upper bound in equation (5) of PROOF.md.
The connection between this rational expression and probability is proved there. -/

namespace MakowskyRakita

/-- Sum f(0) + ... + f(k). -/
private def through {α : Type} [Add α] (f : Nat → α) : Nat → α
  | 0 => f 0
  | k + 1 => through f k + f (k + 1)

private def overlapNumerator (choose : Nat → Nat → Nat) (n r : Nat) : Nat :=
  through (fun j =>
    choose r j * choose (n - r) (r - j) * (2 ^ choose j 2 - 1)) r

/-- Chebyshev union bound for ranks 0 through K, plus the expected number
of ordered forbidden pairs. The contributions of ranks 0 and 1 vanish. -/
def failureBound (choose : Nat → Nat → Nat) (n k : Nat) : ℚ :=
  36 * through (fun r => (overlapNumerator choose n r : ℚ) / (choose n r : ℚ)) k +
    ((choose n k * choose (n - k) k : Nat) : ℚ) / ((2 : ℚ) ^ (choose k 2 + k ^ 2))

set_option maxRecDepth 10000 in
set_option maxHeartbeats 2000000 in
theorem failureBound_65536 : failureBound Nat.choose 65536 19 < 2075 / 1000000 := by
  rw [Nat.choose_eq_fast_choose]
  decide +kernel

#print axioms failureBound_65536

end MakowskyRakita
