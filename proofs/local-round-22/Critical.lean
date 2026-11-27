import Degree
import Rigidity
import Lifting
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.Linarith

/-! Converting the short-binomial obstruction into a classification of all admissible residues. -/

namespace CriticalResidues
open Polynomial

private theorem midpoint_impossible {r : ℝ} {s b c t : ℕ}
    (hr : 0 < r) (hr1 : r < 1) (hbc : b < c) (hgap : c - b < s)
    (hshort : ∀ {h k : ℕ}, 0 < h → h < k → k < s → 1 + r^k ≠ 2 * r^h) :
    r^b + r^c ≠ 2 * r^t := by
  intro heq
  have ha := pow_right_strictAnti₀ hr hr1
  have hvalues : r^c < r^b := ha hbc
  have hbt : b < t := by
    by_contra! h
    have := ha.antitone h
    linarith
  have htc : t < c := by
    by_contra! h
    have := ha.antitone h
    linarith
  apply hshort (h := t-b) (k := c-b) (by omega) (by omega) hgap
  apply mul_left_cancel₀ (ne_of_gt (pow_pos hr b))
  rw [mul_add, mul_one, ← pow_add, Nat.add_sub_of_le hbc.le,
    mul_left_comm, ← pow_add, Nat.add_sub_of_le hbt.le]
  exact heq

/-- J is zero precisely for the aligned residues. The algebraic input is the
    exclusion of a strict arithmetic midpoint among these short powers. -/
theorem residue_zero_iff {r : ℝ} {s a u v : ℕ}
    (hr : 0 < r) (hr1 : r < 1) (hu : 0 < u) (huv : u < v) (hv : v ≤ 2*s)
    (hshort : ∀ {h k : ℕ}, 0 < h → h < k → k < s → 1 + r^k ≠ 2 * r^h) :
    2*r^(a+s) - r^(u+s) - r^v = 0 ↔ u=a ∧ v=a+s := by
  constructor
  · intro h
    have hj : r^(u+s) + r^v = 2*r^(a+s) := by linarith
    rcases lt_trichotomy (u+s) v with hlt | he | hgt
    · exact False.elim (midpoint_impossible hr hr1 hlt (by omega) hshort hj)
    · rw [← he] at hj
      have heq : r^(u+s) = r^(a+s) := by linarith
      have hex := (pow_right_strictAnti₀ hr hr1).injective heq
      exact ⟨by omega, by omega⟩
    · rw [add_comm] at hj
      exact False.elim (midpoint_impossible hr hr1 hgt (by omega) hshort hj)
  · rintro ⟨rfl,rfl⟩
    ring

theorem midpoint_excluded {s k h : ℕ} {r : ℝ} (hs : 1<s) (hr : r^s+r=1)
    (hk : 0<k) (hks : k<s) : 1+r^k ≠ 2*r^h := by
  have hz : aeval r ((X : ℤ[X])^s+X-1)=0 := by simp [hr]
  obtain ⟨q,hq⟩ := minpoly.isIntegrallyClosed_dvd (PerimeterLift.integral_root hs hr) hz
  have hd := PerimeterDegree.degree_of_rigidity hs (minpoly.aeval ℤ r) hq
    (CriticalRigidity.selmer_factor_dvd_mirror hs hq)
  exact PerimeterLift.no_midpoint_of_degree hs hr hd hk hks h

/-- No unformalized irreducibility or factorization assumption. -/
theorem critical_zero_iff {r : ℝ} {s a u v : ℕ}
    (hs : 1 < s) (hr : 0 < r) (hr1 : r < 1) (he : r^s+r=1)
    (hu : 0 < u) (huv : u < v) (hv : v ≤ 2*s) :
    2*r^(a+s) - r^(u+s) - r^v = 0 ↔ u=a ∧ v=a+s := by
  apply residue_zero_iff hr hr1 hu huv hv
  intro h k hh hhk hks
  exact midpoint_excluded hs he (by omega) hks

#print axioms critical_zero_iff
end CriticalResidues
