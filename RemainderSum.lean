import Mathlib.Data.Nat.Log
import Mathlib.Tactic.Ring

namespace RemainderSum

/-- Add the remainders modulo b, b², …, b^k. -/
def sumThrough (b n : ℕ) : ℕ → ℕ
  | 0 => 0
  | k+1 => sumThrough b n k + n % b^(k+1)

/-- The sum from the original definition, truncated at the largest power ≤ n. -/
def s (b n : ℕ) : ℕ := sumThrough b n (Nat.log b n)

private theorem shift {b r : ℕ} (hr : r < b) (n j : ℕ) :
    (b*n+r) % b^(j+1) = b*(n % b^j)+r := by
  rw [pow_succ', Nat.mod_mul, Nat.mul_add_mod, Nat.mod_eq_of_lt hr,
      Nat.mul_add_div (by omega), Nat.div_eq_of_lt hr, Nat.add_zero, Nat.add_comm]

private theorem sum_shift {b r : ℕ} (hr : r < b) (n k : ℕ) :
    sumThrough b (b*n+r) (k+1) = b * sumThrough b n k + r*(k+1) := by
  induction k with
  | zero => simp [sumThrough, Nat.mul_add_mod, Nat.mod_eq_of_lt hr]
  | succ k ih =>
    change sumThrough b (b*n+r) (k+1) + (b*n+r) % b^(k+1+1) =
      b * (sumThrough b n k + n % b^(k+1)) + r*(k+1+1)
    rw [ih, shift hr]
    ring

/-- Petros Hadjicostas' conjecture in OEIS A049804, for every base b ≥ 2. -/
theorem hadjicostas {b n r : ℕ} (hb : 2 ≤ b) (hn : 1 ≤ n) (hr : r < b) :
    s b (b*n+r) = b*s b n + r*(Nat.log b n+1) := by
  have lower : b ≤ b*n+r := by
    have h := Nat.mul_le_mul_left b hn
    simp only [Nat.mul_one] at h
    omega
  have digits : Nat.log b (b*n+r) = Nat.log b n + 1 := by
    rw [Nat.log_of_one_lt_of_le hb lower, Nat.mul_add_div (by omega),
        Nat.div_eq_of_lt hr]
    simp
  unfold s
  rw [digits]
  exact sum_shift hr n _

end RemainderSum

#print axioms RemainderSum.hadjicostas
