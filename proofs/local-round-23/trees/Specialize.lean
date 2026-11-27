import Series
import Mathlib.RingTheory.PowerSeries.Trunc
import Mathlib.Algebra.Polynomial.Derivative

namespace VoloshynSeries
open PowerSeries Finset
noncomputable section
variable {K : Type*} [Field K]
local notation "S" => PowerSeries K
local notation "B" => PowerSeries (Polynomial K)

private def spec (u : S) (f : B) := subst (fun i => coeff _ i f) u

private abbrev ce (u : S) : Polynomial K →+* S := Polynomial.eval₂RingHom (C K) u
private abbrev te (u : S) : Polynomial (Polynomial K) →+* S :=
  Polynomial.eval₂RingHom (ce u) X

private theorem approx (u : S) (f : B) {m n : ℕ} (hm : m<n) :
    coeff K m (spec u f) = coeff K m (te u (trunc n f)) := by
  change _ = coeff K m ((trunc n f).eval₂ (ce u) X)
  rw [eval₂_trunc_eq_sum_range, map_sum]
  simp only [spec, subst, coeff_mk, coeff_mul_X_pow']
  rw [← sum_subset (range_mono (by omega : m+1 ≤ n)) (fun i hi hmi => if_neg (by
    simp only [mem_range] at hmi
    omega : ¬ i≤m))]
  apply sum_congr rfl
  intro i hi
  rw [if_pos (by simpa only [mem_range, Nat.lt_succ_iff] using hi : i≤m)]
  simp [ce, Polynomial.eval_map]

private theorem eval_agree (u : S) {p q : Polynomial (Polynomial K)} {n : ℕ}
    (h : ∀ i, i<n → p.coeff i = q.coeff i) :
    Agree n (te u p) (te u q) := by
  apply (agree_iff ..).mpr
  have dvd : Polynomial.X^n ∣ p-q := Polynomial.X_pow_dvd_iff.mpr (by
    intro i hi
    simp [h i hi])
  have eX : te u Polynomial.X=X := by simp [te]
  simpa only [map_pow, eX, map_sub] using map_dvd (te u) dvd

private theorem spec_mul (u : S) (a b : B) : spec u (a*b) = spec u a * spec u b := by
  ext m
  let n := m+1
  have hm : m<n := by dsimp [n]; omega
  have h₁ := approx u (a*b) hm
  have he : Agree n (te u (trunc n (a*b))) (te u ((trunc n a)*(trunc n b))) := by
    apply eval_agree
    intro i hi
    rw [coeff_trunc, if_pos hi]
    simpa only [← Polynomial.coe_mul, Polynomial.coeff_coe] using coeff_mul_eq_coeff_trunc_mul_trunc a b hi
  rw [h₁, he m hm, map_mul, coeff_mul, coeff_mul]
  apply sum_congr rfl
  intro ij hij
  have hh := mem_antidiagonal.mp hij
  rw [approx u a (show ij.1<n by omega), approx u b (show ij.2<n by omega)]

/-- Coefficientwise finite substitution t ↦ t, x ↦ u(t). -/
def substHom (u : S) : B →+* S where
  toFun := spec u
  map_zero' := by ext m; rw [approx u 0 (Nat.lt_succ_self m)]; simp
  map_one' := by ext m; rw [approx u 1 (Nat.lt_succ_self m)]; simp
  map_add' f g := by
    ext m
    rw [approx u (f+g) (Nat.lt_succ_self m), trunc_add, map_add, map_add, map_add,
      approx u f (Nat.lt_succ_self m), approx u g (Nat.lt_succ_self m)]
  map_mul' := spec_mul u

@[simp] theorem substHom_C (u : S) (p : Polynomial K) :
    substHom u (C (Polynomial K) p) = p.eval₂ (C K) u := by
  ext m
  change coeff K m (spec _ _) = _
  rw [approx u _ (Nat.lt_succ_self m), trunc_C]
  simp [te,ce]

@[simp] theorem substHom_X (u : S) : substHom u X=X := by
  ext m
  change coeff K m (spec _ _) = _
  rw [approx u _ (by omega : m<m+2), trunc_X]
  simp [te]

/-- Coefficientwise formal differentiation in x, with t fixed. -/
def derivativeX (f : B) : B := mk fun i => (coeff (Polynomial K) i f).derivative

@[simp] theorem derivativeX_add (a b : B) :
    derivativeX (a+b)=derivativeX a+derivativeX b := by ext; simp [derivativeX]
@[simp] theorem derivativeX_sub (a b : B) :
    derivativeX (a-b)=derivativeX a-derivativeX b := by ext; simp [derivativeX]
@[simp] theorem derivativeX_C (p : Polynomial K) :
    derivativeX (C _ p)=C _ p.derivative := by
  ext n
  by_cases h : n=0 <;> simp [derivativeX, coeff_C, h]
@[simp] theorem derivativeX_X : derivativeX (X : B)=0 := by
  ext n
  by_cases h : n=1 <;> simp [derivativeX, coeff_X, h]
@[simp] theorem derivativeX_one : derivativeX (1 : B)=0 := by
  change derivativeX (C _ 1)=0
  rw [derivativeX_C, Polynomial.derivative_one, map_zero]

theorem derivativeX_mul (a b : B) :
    derivativeX (a*b)=derivativeX a*b+a*derivativeX b := by
  ext n
  simp only [derivativeX, coeff_mk, coeff_mul, map_sum, Polynomial.derivative_mul,
    sum_add_distrib, map_add]

/-- The kernel identity Δ=J² forces a genuine common root of Δ and its
catalytic derivative in the formal-series field's valuation ring. -/
theorem catalytic_square_double_root {J D : B}
    (h0 : coeff _ 0 J = 1-Polynomial.X) (hsq : D=J^2) :
    ∃ u : S, substHom u D=0 ∧ substHom u (derivativeX D)=0 := by
  have hz : constantCoeff _ (J-C _ (1-Polynomial.X))=0 := by
    rw [map_sub, constantCoeff_C, ← coeff_zero_eq_constantCoeff_apply, h0, sub_self]
  obtain ⟨H,hH⟩ := X_dvd_iff.mpr hz
  obtain ⟨u,hu,_⟩ := existsUnique_kernel_root (fun n => coeff _ n H)
  have hj : substHom u J=0 := by
    have he := congrArg (substHom u) hH
    simp only [map_sub, substHom_C, Polynomial.eval₂_sub, Polynomial.eval₂_one,
      Polynomial.eval₂_X, map_mul, substHom_X] at he
    change 1-u+X*substHom u H=0 at hu
    linear_combination he+hu
  use u
  rw [hsq,pow_two,derivativeX_mul,map_mul,hj,zero_mul,map_add,map_mul,map_mul,hj,zero_mul,mul_zero,add_zero]
  exact ⟨rfl,rfl⟩

#print axioms catalytic_square_double_root
end
end VoloshynSeries
