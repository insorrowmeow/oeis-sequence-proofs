import Mathlib.Algebra.Polynomial.Div
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

/-! Binary columns of the ordinary Fibonacci sequence, OEIS A036284. -/

namespace FibonacciBitMasks

open Nat Polynomial Finset

def fib : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | k+2 => fib k + fib (k+1)

private theorem fib_add_two {k : ℕ} : fib (k+2) = fib k + fib (k+1) := rfl

private theorem fib_six (k : ℕ) : fib (k + 6) = 5 * fib k + 8 * fib (k+1) := by
  have h (j : ℕ) := @fib_add_two (k+j)
  have h0 := h 0
  simp only [Nat.add_zero] at h0
  have h1 := h 1
  have h2 := h 2
  have h3 := h 3
  have h4 := h 4
  norm_num [Nat.add_assoc] at h1 h2 h3 h4
  omega

/-- A half-period shift is a scalar modulo the next power of two. -/
private theorem shift_coefficients (r : ℕ) : ∃ u v : ℕ, ∀ k : ℕ,
    fib (k + 6 * 2^r) =
      (1 + 4 * 2^r * (1 + 2*u)) * fib k + 8 * 2^r * v * fib (k+1) := by
  induction r with
  | zero =>
    exact ⟨0, 1, by simpa using fib_six⟩
  | succ r ih =>
    obtain ⟨u,v,H⟩ := ih
    refine ⟨u + 2^r * ((1+2*u)^2 + 4*v^2),
      (1 + 4*2^r*(1+2*u))*v + 4*2^r*v^2, ?_⟩
    intro k
    rw [show k+6*2^(r+1) = (k+6*2^r)+6*2^r by ring, H (k+6*2^r),
      show k+6*2^r+1 = (k+1)+6*2^r by omega, H (k+1), H k]
    rw [show k+1+1 = k+2 by omega, fib_add_two]
    ring

private theorem shift_bit (r k : ℕ) :
    (fib (k + 6 * 2^r) / (4*2^r)) % 2 =
      (fib k / (4*2^r) + fib k) % 2 := by
  obtain ⟨u,v,H⟩ := shift_coefficients r
  have e : fib (k+6*2^r) = fib k + (4*2^r) *
      (fib k + 2*(u*fib k + v*fib (k+1))) := by rw [H]; ring
  rw [e, Nat.add_mul_div_left _ _ (by positivity)]
  omega

abbrev P := Polynomial (ZMod 2)

/-- The bit at position n of the kth Fibonacci number. -/
def digit (n k : ℕ) : ZMod 2 := (fib k / 2^n : ℕ)

/-- A polynomial block of successive digits, with the first digit at degree zero. -/
noncomputable def block (n start m : ℕ) : P :=
  ∑ i ∈ range m, C (digit n (start+i)) * X^i

/-- The polynomial encoded by the nth integer in OEIS A036284. -/
noncomputable def mask (n : ℕ) : P := block n 0 (3*2^n)

private theorem digit_shift (r k : ℕ) :
    digit (r+2) (6*2^r+k) = digit (r+2) k + (fib k : ZMod 2) := by
  unfold digit
  rw [show 2^(r+2) = 4*2^r by ring, ← Nat.cast_add, ZMod.natCast_eq_natCast_iff']
  simpa [Nat.add_comm] using shift_bit r k

private theorem fib_three (k : ℕ) :
    (fib (k+3) : ZMod 2) = (fib k : ZMod 2) := by
  have h : fib (k+3) = fib k + 2*fib (k+1) := by
    have h1 : fib (k+3) = fib (k+1) + fib (k+2) := @fib_add_two (k+1)
    rw [h1, fib_add_two]
    omega
  rw [h, Nat.cast_add, Nat.cast_mul]
  simp [show (2 : ZMod 2) = 0 by decide]

private theorem fib_three_mul (s k : ℕ) :
    (fib (3*s+k) : ZMod 2) = (fib k : ZMod 2) := by
  induction s with
  | zero => simp
  | succ s ih =>
    rw [show 3*(s+1)+k = (3*s+k)+3 by omega, fib_three, ih]

private noncomputable def segment (f : ℕ → ZMod 2) (m : ℕ) : P :=
  ∑ i ∈ range m, C (f i) * X^i

private theorem segment_append (f : ℕ → ZMod 2) (m t : ℕ) :
    segment f (m+t) = segment f m + X^m * segment (fun i => f (m+i)) t := by
  simp only [segment, sum_range_add, mul_sum, pow_add]
  congr 1
  apply sum_congr rfl
  intro i _
  ring

private theorem segment_add (f g : ℕ → ZMod 2) (t : ℕ) :
    segment (fun i => f i + g i) t = segment f t + segment g t := by
  simp only [segment, map_add, add_mul, sum_add_distrib]

private theorem frobenius (r : ℕ) :
    ((1 : P) + X^3) ^ (2^r) = 1 + X^(3*2^r) := by
  rw [add_pow_char_pow _ _ 2, one_pow, ← pow_mul]

private theorem low_mask (r : ℕ) :
    segment (fun i => (fib i : ZMod 2)) (3*2^r) =
      (X+X^2) * ((1:P)+X^3)^(2^r-1) := by
  induction r with
  | zero =>
    simp [segment, sum_range_succ, fib]
  | succ r ih =>
    rw [show 3*2^(r+1) = 3*2^r+3*2^r by ring, segment_append]
    simp only [fib_three_mul, ih]
    rw [show 2^(r+1)-1 = (2^r-1)+2^r by have := Nat.two_pow_pos r; omega,
        pow_add, frobenius]
    ring

private theorem mask_factor (r : ℕ) : mask (r+2) =
    ((1:P)+X^3)^(2^(r+1)-1) *
      (((1:P)+X^3)*segment (digit (r+2)) (6*2^r) + X^(6*2^r)*(X+X^2)) := by
  have e : mask (r+2) = segment (digit (r+2)) (6*2^r+6*2^r) := by
    simp only [mask, block, segment, Nat.zero_add, show 3*2^(r+2) = 6*2^r+6*2^r by ring]
  have M : 6*2^r = 3*2^(r+1) := by ring
  have hh : (1:P)+X^(6*2^r) = ((1:P)+X^3)^(2^(r+1)-1)*(1+X^3) := by
    rw [← pow_succ, Nat.sub_add_cancel (Nat.two_pow_pos _), frobenius, M]
  have ll := low_mask (r+1)
  rw [← M] at ll
  rw [e, segment_append]
  simp only [digit_shift, segment_add, ll]
  rw [show (X : P)^(6*2^r) = (1+X^(6*2^r))-1 by ring]
  rw [hh]
  ring

theorem conjectures (n : ℕ) (hn : 0 < n) :
    (((1:P)+X^3)^(2^(n-1)-1) * (1+X)) ∣ mask n := by
  cases n with
  | zero => omega
  | succ n =>
    cases n with
    | zero =>
      use X^3
      norm_num [mask, block, digit, fib, sum_range_succ]
      ring_nf
      simp [show (2 : P) = 0 by exact CharP.cast_eq_zero P 2]
    | succ r =>
      rw [mask_factor r]
      refine ⟨(1-X+X^2)*segment (digit (r+2)) (6*2^r) + X^(6*2^r)*X, ?_⟩
      simp only [Nat.add_one_sub_one]
      ring

#print axioms conjectures

end FibonacciBitMasks
