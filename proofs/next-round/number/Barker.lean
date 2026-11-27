import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace Barker

/-- The greatest integer strictly below y²/x when x is a positive integer. -/
def strictStep (x y : ℤ) : ℤ := (y^2-1)/x

def strictPisot (x y : ℤ) : ℕ → ℤ
  | 0 => x
  | 1 => y
  | n+2 => strictStep (strictPisot x y n) (strictPisot x y (n+1))

private def linear (k : ℤ) : ℕ → ℤ
  | 0 => 2
  | 1 => 4*k
  | 2 => 8*k^2-1
  | n+3 => 2*k*linear k (n+2) - k*linear k n

private def gap (k : ℤ) (n : ℕ) : ℤ :=
  linear k (n+1)^2-linear k n*linear k (n+2)

private theorem gap_step (k : ℤ) (n : ℕ) :
    gap k (n+3) = 2*k^2*gap k (n+1)+k^2*gap k n := by
  let u := linear k n
  let v := linear k (n+1)
  let w := linear k (n+2)
  let s := 2*k*w-k*u
  let t := 2*k*s-k*v
  change t^2-s*(2*k*t-k*w) = 2*k^2*(w^2-v*s)+k^2*(v^2-u*w)
  dsimp only [s,t]
  ring

private theorem grows {k : ℤ} (hk : k=4 ∨ k=8) (n : ℕ) :
    0 < linear k n ∧ (2*k-1)*linear k n ≤ linear k (n+1) := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    match n with
    | 0 | 1 => rcases hk with rfl | rfl <;> decide
    | n+2 =>
      have h0 := ih n (by omega)
      have h1 := ih (n+1) (by omega)
      change 0 < linear k (n+1) ∧ (2*k-1)*linear k (n+1) ≤ linear k (n+2) at h1
      change 0 < linear k (n+2) ∧
        (2*k-1)*linear k (n+2) ≤ 2*k*linear k (n+2)-k*linear k n
      rcases hk with rfl | rfl <;> constructor <;> omega

private theorem gap_ok {k : ℤ} (hk : k=4 ∨ k=8) (n : ℕ) :
    0 < gap k n ∧ gap k n ≤ linear k n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    match n with
    | 0 | 1 | 2 => rcases hk with rfl | rfl <;> decide
    | n+3 =>
      have h0 := ih n (by omega)
      have h1 := ih (n+1) (by omega)
      have g0 := grows hk n
      have g1 := grows hk (n+1)
      have g2 := grows hk (n+2)
      change 0 < linear k (n+1) ∧ (2*k-1)*linear k (n+1) ≤ linear k (n+2) at g1
      change 0 < linear k (n+2) ∧ (2*k-1)*linear k (n+2) ≤ linear k (n+3) at g2
      rw [gap_step]
      rcases hk with rfl | rfl <;> constructor <;> omega

private theorem matches_linear {k : ℤ} (hk : k=4 ∨ k=8) (n : ℕ) :
    strictPisot 2 (4*k) n = linear k n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    match n with
    | 0 | 1 => rfl
    | n+2 =>
      have d := gap_ok hk n
      unfold gap at d
      have p := (grows hk n).1
      change strictStep (strictPisot 2 (4*k) n) (strictPisot 2 (4*k) (n+1)) = _
      rw [ih n (by omega), ih (n+1) (by omega)]
      unfold strictStep
      rw [Int.ediv_eq_iff_of_pos p]
      constructor <;> nlinarith [d.1,d.2]

/-- Colin Barker's recurrence for OEIS A022027. -/
theorem a022027 (n : ℕ) :
    strictPisot 2 16 (n+3) = 8*strictPisot 2 16 (n+2)-4*strictPisot 2 16 n := by
  have h := matches_linear (k := 4) (Or.inl rfl)
  change strictPisot 2 (4*4) (n+3) = 8*strictPisot 2 (4*4) (n+2)-4*strictPisot 2 (4*4) n
  rw [h,h,h]
  rfl

/-- Colin Barker's recurrence for OEIS A022028. -/
theorem a022028 (n : ℕ) :
    strictPisot 2 32 (n+3) = 16*strictPisot 2 32 (n+2)-8*strictPisot 2 32 n := by
  have h := matches_linear (k := 8) (Or.inr rfl)
  change strictPisot 2 (4*8) (n+3) = 16*strictPisot 2 (4*8) (n+2)-8*strictPisot 2 (4*8) n
  rw [h,h,h]
  rfl

end Barker

#print axioms Barker.a022027
#print axioms Barker.a022028
