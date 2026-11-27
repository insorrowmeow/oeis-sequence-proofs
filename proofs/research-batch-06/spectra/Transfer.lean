import Mathlib.LinearAlgebra.Matrix.SpecialLinearGroup
import Mathlib.Data.Real.Basic
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Linarith

namespace FibonacciTransfer
noncomputable section

open Matrix
open scoped MatrixGroups
abbrev M := Matrix (Fin 2) (Fin 2) ℝ
abbrev G := SL(2,ℝ)
def tr (a : G) : ℝ := Matrix.trace (a : M)

private theorem tr_inverse (a : G) : tr a⁻¹ = tr a := by
  simp [tr, SpecialLinearGroup.coe_inv, Matrix.adjugate_fin_two, Matrix.trace,
    Fin.sum_univ_two, add_comm]

private theorem tr_comm (a b : G) : tr (a*b) = tr (b*a) := Matrix.trace_mul_comm _ _

private theorem cayley (a : G) :
    ((a*a : G) : M) = tr a • (a : M) - 1 := by
  have h := a.property
  rw [Matrix.det_fin_two] at h
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [tr,Matrix.trace, Fin.sum_univ_two, Matrix.mul_apply, Matrix.one_apply] at * <;>
    nlinarith only [h]

private theorem equal_squares {a b : G} (htr : tr a = tr b) (hn : tr a ≠ 0)
    (hs : a*a = b*b) : a = b := by
  have h := congrArg (fun g : G => (g : M)) hs
  change ((a*a : G) : M) = ((b*b : G) : M) at h
  rw [cayley, cayley, ← htr] at h
  have h' := sub_left_inj.mp h
  apply Subtype.ext
  ext i j
  exact mul_left_cancel₀ hn (congrFun (congrFun h' i) j)

private theorem comm_of_square {a b : G} (h : a*(b*b) = (b*b)*a)
    (hb : tr b ≠ 0) : a*b = b*a := by
  have h' := congrArg (fun g : G => (g : M)) h
  simp only [SpecialLinearGroup.coe_mul] at h'
  have hc : (b : M)*(b : M) = tr b • (b : M) - 1 := cayley b
  rw [hc, mul_sub, sub_mul, mul_one, one_mul, Matrix.mul_smul, Matrix.smul_mul] at h'
  have he := sub_left_inj.mp h'
  apply Subtype.ext
  ext i j
  exact mul_left_cancel₀ hb (congrFun (congrFun he i) j)

private theorem vanish {a : G} (ha : tr a = 0) : ((a*a : G) : M) = -1 := by
  rw [cayley, ha, zero_smul, zero_sub]

/-- Classification of the identity monodromy for an arbitrary block UV and its rotation VU. -/
theorem block_criterion (u v : G) (hnc : u*v ≠ v*u) (hz : ¬ (tr u=0 ∧ tr v=0)) :
    ((u*v)*(u*v))*((v*u)*(v*u)) = 1 ↔ tr (u*v)=0 := by
  let a := u*v
  let b := v*u
  have ht : tr a = tr b := tr_comm u v
  change (a*a)*(b*b) = 1 ↔ tr a = 0
  constructor
  · intro horb
    by_contra hna
    have he : a*a = b⁻¹*b⁻¹ := by
      calc a*a = (b*b)⁻¹ := eq_inv_of_mul_eq_one_left horb
           _ = b⁻¹*b⁻¹ := by simp
    have hab : a = b⁻¹ := equal_squares (ht.trans (tr_inverse b).symm) hna he
    have hvu : v*v = u⁻¹*u⁻¹ := by
      have hh : (u*v)*(v*u) = 1 := by change a*b = 1; rw [hab,inv_mul_cancel]
      calc v*v = u⁻¹*((u*v)*(v*u))*u⁻¹ := by simp [mul_assoc]
           _ = u⁻¹*u⁻¹ := by rw [hh,mul_one]
    have hvc : u*(v*v) = (v*v)*u := by rw [hvu]; simp [← mul_assoc]
    have hu : u*u = v⁻¹*v⁻¹ := by
      have hh := congrArg Inv.inv hvu
      simpa using hh.symm
    have huc : v*(u*u) = (u*u)*v := by rw [hu]; simp [← mul_assoc]
    apply hz
    constructor
    · by_contra h; exact hnc (comm_of_square huc h).symm
    · by_contra h; exact hnc (comm_of_square hvc h)
  · intro h
    apply Subtype.ext
    change ((a*a : G) : M) * ((b*b : G) : M) = 1
    rw [vanish h, vanish (ht ▸ h), neg_mul_neg, one_mul]

def letter (r x : ℝ) : G :=
  ⟨!![1-x*r,-x; r,1], by rw [Matrix.det_fin_two_of]; ring⟩

private theorem tr_letter (r x : ℝ) : tr (letter r x) = 2-x*r := by
  simp [letter,tr,Matrix.trace,Fin.sum_univ_two]; ring

private theorem tr_pair (r s x : ℝ) :
    tr (letter r x * letter s x) = 2-2*x*(r+s)+x^2*r*s := by
  simp [tr,letter, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two]; ring

theorem letters_commute_only_at_zero {r s x : ℝ} (hrs : r ≠ s)
    (h : letter r x * letter s x = letter s x * letter r x) : x=0 := by
  have hh := congrArg (fun a : G => a 0 0) h
  simp [letter, Matrix.mul_apply, Fin.sum_univ_two] at hh
  have hp : x*(r-s)=0 := by linarith
  exact (mul_eq_zero.mp hp).resolve_right (sub_ne_zero.mpr hrs)

def twoZeros (a b c : ℝ) := (a=0 ∧ b=0) ∨ (a=0 ∧ c=0) ∨ (b=0 ∧ c=0)

private theorem base_no_zeros {r s x : ℝ} (hrs : r ≠ s) :
    ¬ twoZeros (tr (letter r x)) (tr (letter s x)) (tr (letter r x * letter s x)) := by
  rw [tr_letter,tr_letter,tr_pair]
  rintro (⟨h,k⟩|⟨h,k⟩|⟨h,k⟩)
  · have h' : x*(r-s)=0 := by linarith
    have hx := (mul_eq_zero.mp h').resolve_right (sub_ne_zero.mpr hrs)
    simp [hx] at h
  · have contra : (2:ℝ)=0 := by linear_combination (2-x*s)*h - k
    norm_num at contra
  · have contra : (2:ℝ)=0 := by linear_combination (2-x*r)*h - k
    norm_num at contra

private theorem trace_update (p q : G) : tr ((p*q)*p) = tr p * tr (p*q) - tr q := by
  have he : tr ((p*q)*p) = tr ((p*p)*q) := by rw [tr_comm (p*q) p,mul_assoc]
  rw [he]
  change Matrix.trace (((p*p : G) : M) * (q : M)) = _
  rw [cayley, sub_mul, Matrix.smul_mul, one_mul, Matrix.trace_sub, Matrix.trace_smul]
  rfl

def subst : ℕ → G → G → G × G
  | 0,p,q => (p,q)
  | j+1,p,q => let z := subst j p q; (z.1*z.2,z.1)

private theorem invariants (p q : G) (hnc : p*q ≠ q*p)
    (hz : ¬ twoZeros (tr p) (tr q) (tr (p*q))) (j : ℕ) :
    let z := subst j p q
    z.1*z.2 ≠ z.2*z.1 ∧ ¬ twoZeros (tr z.1) (tr z.2) (tr (z.1*z.2)) := by
  induction j with
  | zero => exact ⟨hnc,hz⟩
  | succ j ih =>
    obtain ⟨hn,ht⟩ := ih
    let a := (subst j p q).1
    let b := (subst j p q).2
    change (a*b)*a ≠ a*(a*b) ∧ ¬ twoZeros (tr (a*b)) (tr a) (tr ((a*b)*a))
    constructor
    · intro h; exact hn (mul_left_cancel (by simpa [mul_assoc] using h.symm : a*(a*b)=a*(b*a)))
    · rw [trace_update]
      intro h
      apply ht
      change twoZeros (tr a) (tr b) (tr (a*b))
      rcases h with ⟨h,k⟩|⟨h,k⟩|⟨h,k⟩
      · exact Or.inr (Or.inl ⟨k,h⟩)
      · exact Or.inr (Or.inr ⟨by simpa [h] using k,h⟩)
      · exact Or.inl ⟨h,by simpa [h] using k⟩

/-- For distinct edge weights and a nonzero spectral parameter, the prefix
monodromy is identity exactly at zeros of the trace of the first block. -/
theorem transfer_iff {r s x : ℝ} (hrs : r ≠ s) (hx : x ≠ 0) (j : ℕ) :
    let z := subst j (letter r x) (letter s x)
    let u := z.1
    let v := z.2*z.1
    ((u*v)*(u*v))*((v*u)*(v*u)) = 1 ↔ tr (u*v)=0 := by
  let p := (subst j (letter r x) (letter s x)).1
  let q := (subst j (letter r x) (letter s x)).2
  have hh := invariants _ _ (fun h => hx (letters_commute_only_at_zero hrs h))
    (base_no_zeros hrs) j
  obtain ⟨hn,hz⟩ := hh
  apply block_criterion
  · change p*(q*p) ≠ (q*p)*p
    intro h; exact hn (mul_right_cancel (by simpa [mul_assoc] using h : (p*q)*p=(q*p)*p))
  · change ¬(tr p=0 ∧ tr (q*p)=0)
    rw [tr_comm q p]
    exact fun h => hz (Or.inr (Or.inl h))

#print axioms transfer_iff
end
end FibonacciTransfer
