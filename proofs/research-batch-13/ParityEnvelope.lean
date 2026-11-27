import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.SplitIfs

namespace ParityEnvelope

/-- One step to index n+1 starting with the value at n. -/
def step (n a : ℕ) : ℕ :=
  if (a + (n+1)) % 2 = 1 then a + (n+1) else (a + (n+1)) / 2

/-- Coefficient for the upper bound on three times a term. -/
def cap (n a : ℕ) : ℕ :=
  if n % 2 = 0 then (if a % 2 = 0 then 5 else 11)
  else (if a % 2 = 0 then 7 else 8)

theorem step_envelope (n a extra : ℕ) (h : 3*a ≤ cap n a*n + extra) :
    3 * step n a ≤ cap (n+1) (step n a) * (n+1) + (extra-1) := by
  unfold cap at *
  unfold step
  split_ifs at * <;> omega

theorem step_lower (n a : ℕ) (h : n ≤ a) : n+1 ≤ step n a := by
  unfold step
  split <;> omega

/-- Index k represents the term at position k+1. -/
def orbit (seed : ℕ) : ℕ → ℕ
  | 0 => seed
  | k+1 => step (k+1) (orbit seed k)

theorem envelope (seed k : ℕ) :
    3*orbit seed k ≤ cap (k+1) (orbit seed k) * (k+1) + (3*seed - cap 1 seed - k) := by
  induction k with
  | zero => simp [orbit]; omega
  | succ k ih =>
    have h := step_envelope (k+1) (orbit seed k) (3*seed-cap 1 seed-k) ih
    simpa only [orbit, Nat.sub_sub, Nat.add_assoc] using h

theorem lower (seed k : ℕ) (hs : 1 ≤ seed) : k+1 ≤ orbit seed k := by
  induction k with
  | zero => exact hs
  | succ k ih => exact step_lower (k+1) (orbit seed k) ih

theorem cap_le (n a : ℕ) : cap n a ≤ 11 := by unfold cap; split_ifs <;> decide

theorem universal_bounds (seed k : ℕ) (hs : 1 ≤ seed) (hk : 3*seed-cap 1 seed ≤ k) :
    k+1 ≤ orbit seed k ∧ 3*orbit seed k ≤ 11*(k+1) := by
  refine ⟨lower seed k hs, ?_⟩
  have h := envelope seed k
  rw [Nat.sub_eq_zero_of_le hk, Nat.add_zero] at h
  exact Nat.le_trans h (Nat.mul_le_mul_right _ (cap_le _ _))

theorem original_bounds (k : ℕ) :
    k+1 ≤ orbit 1 k ∧ 3*orbit 1 k ≤ 11*(k+1) :=
  universal_bounds 1 k (by decide) (by simp [cap])

end ParityEnvelope
