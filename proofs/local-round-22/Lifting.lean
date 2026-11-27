import Parity
import Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed
import Mathlib.Algebra.GCDMonoid.IntegrallyClosed
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum

/-! Reducing an integer polynomial identity for the real algebraic root
modulo two. The sole algebraic input is the shape of its minimal polynomial. -/

namespace PerimeterLift
open Polynomial

noncomputable def SelmerShape (s : ℕ) (r : ℝ) : Prop :=
  minpoly ℤ r = X^s+X-1 ∨
    (5 ≤ s ∧ minpoly ℤ r * (X^2-X+1) = X^s+X-1)

theorem integral_root {s : ℕ} {r : ℝ} (hs : 1 < s) (hr : r^s+r = 1) :
    IsIntegral ℤ r := by
  refine ⟨X^s+(X-1), monic_X_pow_add ?_, ?_⟩
  · have hd : ((X : ℤ[X])-1).degree = 1 := by
      simpa using (degree_X_sub_C (1:ℤ))
    rw [hd]
    exact_mod_cast hs
  · change aeval r ((X:ℤ[X])^s+(X-1)) = 0
    simp only [map_add, map_pow, aeval_X, map_sub, map_one]
    linarith

private abbrev reduceTwo : ℤ →+* ZMod 2 := Int.castRingHom _

private theorem two_zero : (2 : (ZMod 2)[X])=0 := by
  change C (2:ZMod 2) = 0
  have hz : (2 : ZMod 2)=0 := rfl
  rw [hz, Polynomial.C_0]

private theorem neg_same (x : (ZMod 2)[X]) : -x=x := by
  apply neg_eq_iff_add_eq_zero.mpr
  rw [← two_mul, two_zero, zero_mul]

private theorem reduced_midpoint_dvd {r : ℝ} {k h : ℕ} (hint : IsIntegral ℤ r)
    (he : 1+r^k=2*r^h) : (minpoly ℤ r).map reduceTwo ∣ X^k+1 := by
  let p : ℤ[X] := X^k+1-2*X^h
  have ha : aeval r p = 0 := by
    simp only [p, map_sub, map_add, map_mul, map_pow, map_ofNat, aeval_X, map_one]
    linarith
  have hm := Polynomial.map_dvd reduceTwo (minpoly.isIntegrallyClosed_dvd hint ha)
  simpa [p, two_zero] using hm

/-- Only a lower bound on the degree of the integer minimal polynomial is
required for exclusion. Its degree is preserved by reduction since it is monic. -/
theorem no_midpoint_of_degree {s k : ℕ} {r : ℝ} (hs : 1<s) (hr : r^s+r=1)
    (hd : s < 2*(minpoly ℤ r).natDegree) (hk : 0<k) (hks : k<s) (h : ℕ) :
    1+r^k ≠ 2*r^h := by
  have hint := integral_root hs hr
  let m := (minpoly ℤ r).map reduceTwo
  have hmr : m.natDegree = (minpoly ℤ r).natDegree := (minpoly.monic hint).natDegree_map _
  have hroot : aeval r ((X : ℤ[X])^s + X - 1) = 0 := by
    simp [hr]
  have hdiv : m ∣ X^s+X+1 := by
    simpa [m, sub_eq_add_neg, neg_same] using
      Polynomial.map_dvd reduceTwo (minpoly.isIntegrallyClosed_dvd hint hroot)
  exact fun he => PerimeterParity.no_short_binomial m hdiv (hmr.symm ▸ hd)
    hk hks (reduced_midpoint_dvd hint he)

/-- If the minimal polynomial has its Selmer form, the powers of the positive
root have no midpoint of the form 1+r^k = 2*r^h at separations k<s. -/
theorem no_midpoint {s k : ℕ} {r : ℝ} (hs : 1<s) (hr : r^s+r=1)
    (shape : SelmerShape s r) (hk : 0<k) (hks : k<s) (h : ℕ) :
    1+r^k ≠ 2*r^h := by
  intro he
  apply (PerimeterParity.mod_two _ hs hk hks ?_) (reduced_midpoint_dvd (integral_root hs hr) he)
  rcases shape with hshape | ⟨h5, hshape⟩
  · left
    simpa [sub_eq_add_neg, neg_same] using congrArg (Polynomial.map reduceTwo) hshape
  · right
    refine ⟨h5, ?_⟩
    simpa [sub_eq_add_neg, neg_same] using congrArg (Polynomial.map reduceTwo) hshape

#print axioms no_midpoint
#print axioms no_midpoint_of_degree
end PerimeterLift
