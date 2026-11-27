import Mathlib.Tactic.Ring

namespace CarryFree

/-- States reachable by the loop, with the current state decomposed into
its power of two and its odd part at every executed step. -/
inductive Reach (n : ℕ) : ℕ → Prop
  | start : Reach n n
  | step {t m : ℕ} : Reach n (2^t*m) → 2^t*m < 2*n → m%2 = 1 →
      Reach n (2^t*m + min (2^t) m)

/-- The two nonzero rows of the binary long multiplication have disjoint bits. -/
theorem terminal {n k : ℕ} (hk : k = 2*n+1) (hr : Reach n k) :
    ∃ t m : ℕ, 0 < t ∧ 1 < m ∧ k = (2^t+1)*m ∧
      ∀ i, (2^t*m).testBit i = false ∨ m.testBit i = false := by
  cases hr with
  | start => omega
  | @step t m _ guard odd =>
    cases t with
    | zero =>
      simp only [pow_zero, one_mul] at *
      have hm : 1 ≤ m := by omega
      rw [min_eq_left hm] at hk
      omega
    | succ s =>
      have evenRow : 2^(s+1)*m = 2*(2^s*m) := by ring
      have evenPow : 2^(s+1) = 2*2^s := by ring
      have small : m < 2^(s+1) := by
        by_contra! h
        rw [min_eq_left h, evenRow, evenPow] at hk
        omega
      rw [min_eq_right small.le] at hk ⊢
      refine ⟨s+1, m, by omega, by omega, by ring, ?_⟩
      intro i
      by_cases h : i < s+1
      · left
        simp [Nat.testBit_two_pow_mul, Nat.not_le_of_lt h]
      · right
        apply Nat.testBit_lt_two_pow
        exact lt_of_lt_of_le small (Nat.pow_le_pow_right (by decide) (by omega))

end CarryFree
