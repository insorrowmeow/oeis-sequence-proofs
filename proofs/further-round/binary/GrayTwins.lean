import Mathlib.Analysis.SpecialFunctions.Pow.Continuity
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Tactic.Linarith

open Filter
open scoped Topology

namespace GrayTwins

def gray (n : ℕ) := n ^^^ (n/2)

/-- A265385. The source starts at index 1. -/
def outer : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | 2 => 1
  | n+3 => gray (outer (n+2) + outer (n+1))

/-- A265387. The source starts at index 1. -/
def inner : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | 2 => 1
  | n+3 => gray (inner (n+2)) + gray (inner (n+1))

theorem linked (n : ℕ) : outer n = gray (inner n) := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    match n with
    | 0 | 1 | 2 => decide
    | n+3 =>
      change gray (outer (n+2) + outer (n+1)) = _
      rw [ih (n+2) (by omega), ih (n+1) (by omega)]
      rfl

private theorem shift (k x : ℕ) : gray x / 2^k = gray (x / 2^k) := by
  unfold gray
  rw [Nat.xor_div_two_pow, Nat.div_div_eq_div_mul, Nat.div_div_eq_div_mul, Nat.mul_comm 2]

private theorem next_sum (k : ℕ)
    (h : outer (k+2) / 2^k = 1 ∧ outer (k+3) / 2^k = 3) :
    (outer (k+3) + outer (k+2)) / 2^k = 4 ∨ (outer (k+3) + outer (k+2)) / 2^k = 5 := by
  rw [Nat.add_div (Nat.two_pow_pos k), h.1, h.2]
  split <;> decide

theorem leading (k : ℕ) : outer (k+2) / 2^k = 1 ∧ outer (k+3) / 2^k = 3 := by
  induction k with
  | zero => decide
  | succ k ih =>
    have drop (x : ℕ) : x / 2^(k+1) = x / 2^k / 2 := by
      rw [Nat.div_div_eq_div_mul, pow_succ]
    constructor
    · change outer (k+3) / 2^(k+1) = 1
      rw [drop,ih.2]
    · change gray (outer (k+3) + outer (k+2)) / 2^(k+1) = 3
      rw [drop, shift]
      rcases next_sum k ih with h|h <;> rw [h] <;> decide

theorem inner_leading (k : ℕ) : inner (k+3) / 2^k = 2 := by
  cases k with
  | zero => decide
  | succ k =>
    change (gray (inner (k+3)) + gray (inner (k+2))) / 2^(k+1) = 2
    rw [← linked, ← linked, pow_succ, ← Nat.div_div_eq_div_mul]
    rcases next_sum k (leading k) with h|h <;> rw [h]

private theorem root_ratio_of_leading (a : ℕ → ℕ)
    (h : ∀ k : ℕ, 2 ≤ a (k+3) / 2^k ∧ a (k+3) / 2^k < 4) :
    Tendsto (fun n : ℕ => ((a (2*n) : ℝ)/(a n : ℝ)) ^ (1 / (n : ℝ)))
      atTop (𝓝 2) := by
  let L := Real.log 2
  have log_bound (n : ℕ) (hn : 3 ≤ n) :
      0 < (a n : ℝ) ∧ ((n:ℝ)-2)*L ≤ Real.log (a n) ∧
        Real.log (a n) ≤ ((n:ℝ)-1)*L := by
    obtain ⟨k,rfl⟩ : ∃ k, n = k+3 := ⟨n-3, by omega⟩
    obtain ⟨lo,hi⟩ := h k
    rw [Nat.le_div_iff_mul_le (Nat.two_pow_pos k)] at lo
    rw [Nat.div_lt_iff_lt_mul (Nat.two_pow_pos k)] at hi
    have lo' : (2:ℝ)^(k+1) ≤ (a (k+3) : ℝ) := by
      rw [pow_succ, mul_comm]; exact_mod_cast lo
    have hi' : (a (k+3) : ℝ) ≤ (2:ℝ)^(k+2) := by
      rw [pow_add, mul_comm]; norm_num; exact_mod_cast hi.le
    have hp := lt_of_lt_of_le (by positivity : 0 < (2:ℝ)^(k+1)) lo'
    have l := Real.log_le_log (by positivity : 0 < (2:ℝ)^(k+1)) lo'
    have u := Real.log_le_log hp hi'
    rw [Real.log_pow] at l u
    push_cast at l u ⊢
    dsimp [L]
    exact ⟨hp, by linarith, by linarith⟩
  let f := fun n : ℕ => (Real.log (a (2*n)) - Real.log (a n))/(n:ℝ)
  have clos : ∀ᶠ n : ℕ in atTop, L-L/(n:ℝ) ≤ f n ∧ f n ≤ L+L/(n:ℝ) := by
    filter_upwards [eventually_ge_atTop 3] with n hn
    obtain ⟨_,lo,hi⟩ := log_bound n hn
    obtain ⟨_,lo',hi'⟩ := log_bound (2*n) (by omega)
    have hp : (0:ℝ) < n := by exact_mod_cast (by omega : 0 < n)
    push_cast at lo' hi'
    dsimp only [f]
    constructor
    · apply (le_div_iff₀ hp).mpr
      rw [sub_mul, div_mul_cancel₀ _ hp.ne']
      nlinarith
    · apply (div_le_iff₀ hp).mpr
      rw [add_mul, div_mul_cancel₀ _ hp.ne']
      nlinarith
  have z := tendsto_const_div_atTop_nhds_zero_nat L
  have c : Tendsto (fun _ : ℕ => L) atTop (𝓝 L) := tendsto_const_nhds
  have hf : Tendsto f atTop (𝓝 L) :=
    tendsto_of_tendsto_of_tendsto_of_le_of_le' (by simpa using c.sub z)
      (by simpa using c.add z) (clos.mono fun _ h => h.1) (clos.mono fun _ h => h.2)
  have hh := Real.continuous_exp.continuousAt.tendsto.comp hf
  have v : Real.exp L = 2 := Real.exp_log (by norm_num)
  rw [← v]
  apply hh.congr'
  filter_upwards [eventually_ge_atTop 3] with n hn
  have h1 := (log_bound n hn).1
  have h2 := (log_bound (2*n) (by omega)).1
  change Real.exp ((Real.log (a (2*n)) - Real.log (a n))/(n:ℝ)) =
    ((a (2*n) : ℝ)/(a n : ℝ)) ^ (1 / (n : ℝ))
  rw [Real.rpow_def_of_pos (div_pos h2 h1), Real.log_div h2.ne' h1.ne']
  congr 1
  ring

theorem a265385 : Tendsto (fun n : ℕ =>
    ((outer (2*n) : ℝ)/(outer n : ℝ)) ^ (1 / (n : ℝ))) atTop (𝓝 2) := by
  apply root_ratio_of_leading
  intro k; rw [(leading k).2]; decide

theorem a265387 : Tendsto (fun n : ℕ =>
    ((inner (2*n) : ℝ)/(inner n : ℝ)) ^ (1 / (n : ℝ))) atTop (𝓝 2) := by
  apply root_ratio_of_leading
  intro k; rw [inner_leading]; decide

#print axioms a265385
#print axioms a265387
end GrayTwins
