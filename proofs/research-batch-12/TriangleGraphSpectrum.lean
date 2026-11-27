import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace TriangleGraphSpectrum

/-- For the nonisolated part of a tree let the degrees be dᵢ+1.  The tree
degree sum gives ∑ dᵢ + 1 = s. This is the corresponding rewrite of the
triangle deficit, in integers to retain the signs. -/
theorem tree_deficit {ι : Type*} (vertices : Finset ι) (d : ι → ℕ)
    (m s : ℕ) (hs : (∑ i ∈ vertices, d i) + 1 = s) :
    (s : ℤ) * ((m : ℤ) - 2) -
      (∑ i ∈ vertices, (((d i + 1).choose 2 : ℕ) : ℤ)) =
    (s : ℤ) * ((m : ℤ) - 3) + 1 -
      (∑ i ∈ vertices, (((d i).choose 2 : ℕ) : ℤ)) := by
  have hcast : (∑ i ∈ vertices, (d i : ℤ)) + 1 = (s : ℤ) := by exact_mod_cast hs
  simp only [Nat.choose_succ_succ' (k := 1), Nat.choose_one_right,
    Nat.cast_add, Finset.sum_add_distrib]
  linarith

/-- The intervals for successive values of s meet at their endpoints. -/
private theorem cover_blocks (c r n v : ℕ)
    (hlo : r*c+1 ≤ v) (hhi : v ≤ (r+n)*c+1) :
    ∃ s t : ℕ, r ≤ s ∧ s ≤ r+n ∧ t ≤ c ∧ v+t = s*c+1 := by
  induction n with
  | zero =>
    exact ⟨r, 0, le_rfl, by omega, by omega, by simpa using hlo.antisymm' hhi⟩
  | succ n ih =>
    by_cases h : v ≤ (r+n)*c+1
    · obtain ⟨s,t,h₁,h₂,h₃,h₄⟩ := ih h
      exact ⟨s,t,h₁,by omega,h₃,h₄⟩
    · have step : (r+(n+1))*c = (r+n)*c+c := by ring
      exact ⟨r+(n+1), (r+(n+1))*c+1-v, by omega, le_rfl, by omega, by omega⟩

/-- Every desired deficit between choose(m-1,2) and (m-2)^2 occurs in
the arithmetic family s(m-3)+1-t, with the stated parameter bounds. -/
theorem covered_deficits (m v : ℕ) (hm : 3 ≤ m)
    (hlo : (m-1).choose 2 ≤ v) (hhi : v ≤ (m-2)^2) :
    ∃ s t : ℕ, m/2 ≤ s ∧ s ≤ m-1 ∧ t ≤ m-3 ∧ v+t = s*(m-3)+1 := by
  obtain ⟨u, rfl⟩ : ∃ u, m = u+3 := ⟨m-3, by omega⟩
  simp only [show ∀ u : ℕ, u+3-1 = u+2 by omega,
    show ∀ u : ℕ, u+3-2 = u+1 by omega, Nat.add_sub_cancel] at *
  have bin := Nat.succ_mul_choose_eq (u+1) 1
  simp only [Nat.choose_one_right, Nat.succ_eq_add_one] at bin
  have half : 2*((u+3)/2) ≤ u+3 := by omega
  have low : (u+3)/2*u + 1 ≤ (u+2).choose 2 := by
    nlinarith [Nat.mul_le_mul_right u half]
  have high : (u+1)^2 = (u+2)*u+1 := by ring
  have len : (u+3)/2 + (u+2-(u+3)/2) = u+2 := by omega
  have hblocks := cover_blocks u ((u+3)/2) (u+2-(u+3)/2) v (low.trans hlo)
  rw [len] at hblocks
  exact hblocks (high ▸ hhi)

end TriangleGraphSpectrum
