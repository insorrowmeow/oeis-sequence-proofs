import Mathlib.Algebra.Polynomial.UnitTrinomial
import Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed
import Mathlib.RingTheory.UniqueFactorizationDomain.GCDMonoid
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace PerimeterDegree
open Polynomial

private lemma tri_id (s : ℕ) : (X^s+X-1 : ℤ[X]) = trinomial 0 1 s (-1) 1 1 := by
  simp [trinomial]
  ring

private lemma mirror_combination {s : ℕ} (hs : 1<s) :
    (X-1)*(X^s+X-1) + X*(X^s+X-1 : ℤ[X]).mirror = X^2-X+1 := by
  rw [show (X^s+X-1 : ℤ[X]).mirror = 1 + X^(s-1) - X^s by
    rw [tri_id, trinomial_mirror Nat.zero_lt_one hs (by decide) (by decide)]
    simp [trinomial]
    ring]
  have he : (X : ℤ[X])*X^(s-1) = X^s := by
    rw [← pow_succ', Nat.sub_add_cancel hs.le]
  linear_combination he

private lemma quartic_cases {s : ℕ} {q : ℤ[X]} (hs : 1<s)
    (hf : q ∣ (X^s+X-1)) (hq : q ∣ X^2-X+1) : s < 2*(s-q.natDegree) := by
  have const_degree {n : ℤ} (hn : n ≠ 0) (hnq : q ∣ C n) : q.natDegree = 0 := by
    have h := natDegree_le_of_dvd hnq (C_ne_zero.mpr hn)
    simpa using h
  have hquad : (X^2-X+1 : ℤ[X]) = trinomial 0 1 2 1 (-1) 1 := by simp [trinomial]; ring
  have hdQ : (X^2-X+1 : ℤ[X]).natDegree = 2 := by
    rw [hquad, trinomial_natDegree (by decide) (by decide) one_ne_zero]
  have hQnz : (X^2-X+1 : ℤ[X]) ≠ 0 := fun h => by simp [h] at hdQ
  have hdeg := natDegree_le_of_dvd hq hQnz
  rw [hdQ] at hdeg
  by_cases h5 : 5 ≤ s
  · omega
  interval_cases s
  · have he : (4 : ℤ[X]) = (4+2*X)*(X^2-X+1) - (2*X)*(X^2+X-1) := by ring
    have h4 : q ∣ C (4 : ℤ) := by
      rw [show C (4 : ℤ) = (4 : ℤ[X]) by norm_num, he]
      exact dvd_sub (dvd_mul_of_dvd_right hq _) (dvd_mul_of_dvd_right hf _)
    have := const_degree (n := 4) (by decide) h4
    omega
  · have he : (X-2 : ℤ[X]) = (X^3+X-1)-(X+1)*(X^2-X+1) := by ring
    have hd : (X-2 : ℤ[X]).natDegree = 1 := by
      simpa using (natDegree_X_sub_C (R := ℤ) 2)
    have hz : (X-2 : ℤ[X]) ≠ 0 := fun h => by simp [h] at hd
    have h1 : q ∣ X-2 := he ▸ dvd_sub hf (dvd_mul_of_dvd_right hq _)
    have hbound := natDegree_le_of_dvd h1 hz
    omega
  · have he : (-1 : ℤ[X]) = (X^4+X-1) - (X^2+X)*(X^2-X+1) := by ring
    have h1 : q ∣ C (-1 : ℤ) := by
      rw [map_neg, map_one, he]
      exact dvd_sub hf (dvd_mul_of_dvd_right hq _)
    have := const_degree (n := -1) (by decide) h1
    omega

/-- Reciprocal-factor rigidity gives a lower bound for the degree of any
    factor containing the positive root. No classification of its factors is required. -/
theorem degree_of_rigidity {s : ℕ} {r : ℝ} {p q : ℤ[X]}
    (hs : 1<s) (hz : aeval r p = 0)
    (hprod : (X^s+X-1 : ℤ[X]) = p*q)
    (hrig : p ∣ (X^s+X-1 : ℤ[X]).mirror ∨ q ∣ (X^s+X-1 : ℤ[X]).mirror) :
    s < 2*p.natDegree := by
  let f : ℤ[X] := X^s+X-1
  have hdf : f.natDegree = s := by
    rw [show f = trinomial 0 1 s (-1) 1 1 from tri_id _, trinomial_natDegree Nat.zero_lt_one hs one_ne_zero]
  have hf0 : f ≠ 0 := fun h => by simp [h] at hdf; omega
  have hpq : p*q ≠ 0 := hprod ▸ hf0
  have hdegrees := natDegree_mul (left_ne_zero_of_mul hpq) (right_ne_zero_of_mul hpq)
  have hsum : p.natDegree + q.natDegree = s := hdegrees.symm.trans (hprod ▸ hdf)
  have common (b : ℤ[X]) (hb : b ∣ f) (hm : b ∣ f.mirror) : b ∣ X^2-X+1 := by
    rw [← mirror_combination hs]
    exact dvd_add (dvd_mul_of_dvd_right hb _) (dvd_mul_of_dvd_right hm _)
  have hp : p ∣ f := ⟨_, hprod⟩
  have hq : q ∣ f := ⟨_, hprod.trans (mul_comm _ _)⟩
  rcases hrig with hm | hm
  · obtain ⟨g,hg⟩ := common p hp hm
    have hzero := congrArg (aeval r) hg
    simp [hz] at hzero
    nlinarith [sq_nonneg (2*r-1)]
  · have := quartic_cases hs hq (common q hq hm)
    omega

end PerimeterDegree
