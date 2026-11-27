/-
Parts of the reciprocal-rigidity argument are adapted from mathlib's
Mathlib/Algebra/Polynomial/UnitTrinomial.lean and
Mathlib/Algebra/Polynomial/Mirror.lean.
Copyright (c) 2022 Thomas Browning. Released under Apache 2.0.
-/
import Mathlib.Algebra.Polynomial.UnitTrinomial
import Mathlib.Tactic.Ring

namespace CriticalRigidity
open Polynomial Polynomial.IsUnitTrinomial

/-- A unit trinomial and its mirror determine its signed factor swaps. This
extracts the rigidity step in mathlib's proof of irreducibility for coprime
trinomials, so it can also be used when a cyclotomic factor is present. -/
private theorem signed_rigidity {p q : ℤ[X]} (hp : p.IsUnitTrinomial)
    (hpq : p * p.mirror = q * q.mirror) :
    q = p ∨ q = -p ∨ q = p.mirror ∨ q = -p.mirror := by
  have hq : IsUnitTrinomial q := (isUnitTrinomial_iff'' hpq).mp hp
  obtain ⟨k, m, n, hkm, hmn, u, v, w, hp⟩ := hp
  obtain ⟨k', m', n', hkm', hmn', x, y, z, hq⟩ := hq
  have hk : k = k' := by
    rw [← mul_right_inj' (show 2 ≠ 0 from two_ne_zero), ←
      trinomial_natTrailingDegree hkm hmn u.ne_zero, ← hp, ← natTrailingDegree_mul_mirror, hpq,
      natTrailingDegree_mul_mirror, hq, trinomial_natTrailingDegree hkm' hmn' x.ne_zero]
  have hn : n = n' := by
    rw [← mul_right_inj' (show 2 ≠ 0 from two_ne_zero), ← trinomial_natDegree hkm hmn w.ne_zero, ←
      hp, ← natDegree_mul_mirror, hpq, natDegree_mul_mirror, hq,
      trinomial_natDegree hkm' hmn' z.ne_zero]
  subst hk
  subst hn
  rcases eq_or_eq_neg_of_sq_eq_sq (y : ℤ) (v : ℤ)
      ((Int.isUnit_sq y.isUnit).trans (Int.isUnit_sq v.isUnit).symm) with
    (h1 | h1)
  · rw [h1] at hq
    rcases irreducible_aux3 hkm hmn hkm' hmn' u v w x z hp hq hpq with (h2 | h2)
    · exact Or.inl h2
    · exact Or.inr (Or.inr (Or.inl h2))
  · rw [h1] at hq
    rw [trinomial_def] at hp
    rw [← neg_inj, neg_add, neg_add, ← neg_mul, ← neg_mul, ← neg_mul, ← C_neg, ← C_neg, ← C_neg]
      at hp
    rw [← neg_mul_neg, ← mirror_neg] at hpq
    rcases irreducible_aux3 hkm hmn hkm' hmn' (-u) (-v) (-w) x z hp hq hpq with (rfl | rfl)
    · exact Or.inr (Or.inl rfl)
    · exact Or.inr (Or.inr (Or.inr p.mirror_neg))

/-- In every integral factorization of a unit trinomial, one factor divides
the mirror of the entire polynomial. -/
theorem factor_dvd_mirror {f p q : ℤ[X]} (hf : f.IsUnitTrinomial) (he : f = p*q) :
    p ∣ f.mirror ∨ q ∣ f.mirror := by
  let g := p * q.mirror
  have hprod : f * f.mirror = g * g.mirror := by
    dsimp [g]
    rw [he, mirror_mul_of_domain, mirror_mul_of_domain, mirror_mirror]
    ring
  have hp : p ∣ g := dvd_mul_right p q.mirror
  have hq : q ∣ g.mirror := by
    dsimp [g]
    rw [mirror_mul_of_domain, mirror_mirror]
    exact dvd_mul_left q p.mirror
  rcases signed_rigidity hf hprod with h | h | h | h
  · exact Or.inr (h ▸ hq)
  · rw [h, mirror_neg, dvd_neg] at hq
    exact Or.inr hq
  · exact Or.inl (h ▸ hp)
  · rw [h, dvd_neg] at hp
    exact Or.inl hp

/-- The factor dichotomy for the polynomial defining the critical radius. -/
theorem selmer_factor_dvd_mirror {s : ℕ} (hs : 1<s) {p q : ℤ[X]}
    (he : (X : ℤ[X])^s + X - 1 = p*q) :
    p ∣ ((X : ℤ[X])^s+X-1).mirror ∨ q ∣ ((X : ℤ[X])^s+X-1).mirror := by
  apply factor_dvd_mirror _ he
  refine ⟨0,1,s,zero_lt_one,hs,-1,1,1,?_⟩
  simp [trinomial]
  ring

#print axioms selmer_factor_dvd_mirror
end CriticalRigidity
