import Mathlib.Data.Nat.Sqrt
import Mathlib.Tactic.Linarith

namespace DescendingBlocks

def seen (s v h k : Nat) : Prop := k ≤ s ∨ (v ≤ k ∧ k ≤ h)

noncomputable def next (x : Nat) (used : Nat → Prop) : Nat := by
  classical
  exact if used (x-1) then x + Nat.sqrt x else x-1

theorem launch (s m : Nat) (h : Nat.sqrt s = m) :
    next s (fun k => k ≤ s) = s+m := by
  simp [next, h]

theorem descend (s v h : Nat) (hv : s+1 < v) (vh : v ≤ h) :
    next v (seen s v h) = v-1 ∧
    ∀ k, (seen s v h k ∨ k = v-1) ↔ seen s (v-1) h k := by
  have hf : ¬seen s v h (v-1) := by unfold seen; omega
  simp only [next, if_neg hf, true_and]
  intro k
  unfold seen
  omega

theorem finish (s m : Nat) (hm : 1 ≤ m) (hs : Nat.sqrt (s+1) = m) :
    next (s+1) (seen s (s+1) (s+m)) = s+m+1 ∧
    ∀ k, (seen s (s+1) (s+m) k ∨ k = s+m+1) ↔ k ≤ s+m+1 := by
  have hv : seen s (s+1) (s+m) (s+1-1) := Or.inl (by omega)
  simp only [next, if_pos hv, hs]
  constructor
  · omega
  · intro k
    unfold seen
    omega

def boundary (m : Nat) := m*m+m-2

theorem stage (m : Nat) (hm : 2 ≤ m) :
    (∀ k, boundary m ≤ k → k ≤ boundary m+m+2 → Nat.sqrt k = m) ∧
    boundary m + 2*m + 2 = boundary (m+1) := by
  have hb : boundary m + 2 = m*m+m := by unfold boundary; omega
  constructor
  · intro k hk hl
    apply Eq.symm
    apply Nat.eq_sqrt.mpr
    constructor <;> nlinarith
  · unfold boundary
    have hh : (m+1)*(m+1) = m*m+2*m+1 := by nlinarith
    omega

end DescendingBlocks
