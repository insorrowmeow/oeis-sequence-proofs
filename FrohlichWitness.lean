import TrinomialRecurrence
import Mathlib.Data.Int.ModEq
import Mathlib.Tactic.NormNum.Prime

namespace Frohlich

/-- The Kronecker symbol (c/3), tabulated on the three residue classes. -/
def symbolModThree (c : ℕ) : ℤ :=
  if c % 3 = 0 then 0 else if c % 3 = 1 then 1 else -1

/-- The original congruence of A308482 with the question's stronger modulus. -/
def question (c : ℕ) : Prop :=
  1 < c ∧ ¬Nat.Prime c ∧ c ≠ 189 ∧
    (central (c-1) : ℤ) ≡ symbolModThree c * 3^(c-1) [ZMOD (c : ℤ)^2]

theorem witness_of_remainder (h : central 413342 % (413343^2) = 0) :
    question 413343 := by
  refine ⟨by decide, by norm_num, by decide, ?_⟩
  have j : symbolModThree 413343 = 0 := by decide
  rw [j, zero_mul]
  have hh := (Int.natCast_modEq_iff (a := central 413342) (b := 0) (n := 413343^2)).mpr h
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Nat.cast_zero] using hh

end Frohlich
