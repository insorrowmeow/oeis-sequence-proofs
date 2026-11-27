import Mathlib.RingTheory.PowerSeries.Inverse
import Mathlib.Algebra.Polynomial.Div
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

/-! Formal series lemmas for the catalytic-variable argument.
At each t-degree the coefficients may be arbitrary polynomials in the
catalytic variable, with no uniform bound on their degree. -/

namespace VoloshynSeries
open PowerSeries Finset

noncomputable section

variable {K : Type*} [Field K]
local notation "S" => PowerSeries K

/-- Each polynomial coefficient is evaluated at u(t), then shifted by its
original t-degree. Every output coefficient is a finite sum. -/
def subst (H : ℕ → Polynomial K) (u : S) : S := mk fun n =>
  ∑ i ∈ range (n+1), coeff K (n-i) (((H i).map (C K)).eval u)

def Agree (n : ℕ) (f g : S) : Prop := ∀ i, i<n → coeff K i f=coeff K i g

lemma agree_iff (n : ℕ) (f g : S) :
    Agree n f g ↔ (X : S)^n ∣ f-g := by
  simp [Agree, X_pow_dvd_iff, sub_eq_zero]

theorem subst_agree {H : ℕ → Polynomial K} {u v : S} {n : ℕ} (h : Agree n u v) :
    Agree n (subst H u) (subst H v) := by
  intro j hj
  simp only [subst, coeff_mk]
  apply sum_congr rfl
  intro i hi
  have he := ((agree_iff n u v).mp h).trans
    (Polynomial.sub_dvd_eval_sub u v ((H i).map (C K)))
  exact ((agree_iff _ _ _).mpr he) (j-i) (by omega)

private def step (H : ℕ → Polynomial K) (u : S) : S := 1 + X*subst H u

private theorem step_agree {H : ℕ → Polynomial K} {u v : S} {n : ℕ} (h : Agree n u v) :
    Agree (n+1) (step H u) (step H v) := by
  intro j hj
  cases j with
  | zero => simp [step]
  | succ j => simpa only [step, map_add, coeff_succ_X_mul, add_right_inj] using
      (subst_agree (H:=H) h) j (by omega)

private def iterRoot (H : ℕ → Polynomial K) : ℕ → S
  | 0 => 1
  | n+1 => step H (iterRoot H n)

private theorem stable_adjacent (H : ℕ → Polynomial K) (m : ℕ) :
    Agree m (iterRoot H m) (iterRoot H (m+1)) := by
  induction m with
  | zero => intro i hi; omega
  | succ m ih => exact step_agree ih

private theorem stable (H : ℕ → Polynomial K) {m n : ℕ} (hm : m ≤ n) :
    Agree m (iterRoot H m) (iterRoot H n) := by
  induction n,hm using Nat.le_induction with
  | base => intro i hi; rfl
  | succ n h ih => exact fun i hi => (ih i hi).trans ((stable_adjacent H n) i (by omega))

/-- An elementary t-adic implicit-function lemma for J=1-x+tH(t,x). -/
theorem existsUnique_kernel_root (H : ℕ → Polynomial K) :
    ∃! u : S, 1-u+X*subst H u=0 := by
  let r : S := mk fun i => coeff K i (iterRoot H (i+1))
  have hr (n : ℕ) : Agree n r (iterRoot H n) := by
    intro i hi
    simpa only [r, coeff_mk] using (stable H (m:=i+1) (n:=n) (by omega)) i (by omega)
  have fixed : r=step H r := by
    ext n
    exact ((hr (n+2)) n (by omega)).trans (((step_agree (H:=H) (hr (n+1))) n (by omega)).symm)
  have he : 1-r+X*subst H r=0 := by
    change r=1+X*subst H r at fixed
    linear_combination -fixed
  refine ⟨r,he,?_⟩
  intro y hy
  have fy : y=step H y := by unfold step; linear_combination -hy
  have hall (n : ℕ) : Agree n y r := by
    induction n with
    | zero => intro i hi; omega
    | succ n ih => simpa only [← fy, ← fixed] using step_agree (H:=H) ih
  ext n
  exact hall (n+1) n (by omega)

/-- Two branches of the same polynomial C(t,Y)=z(1-Y)+tP(t,Y)
coincide when z is invertible. Coefficients of P may themselves depend on t. -/
theorem unique_polynomial_branch (z : K) (hz : z≠0) (p : Polynomial S) (f g : S)
    (hf : C K z*(1-f)+X*p.eval f=0) (hg : C K z*(1-g)+X*p.eval g=0) : f=g := by
  obtain ⟨h,hh⟩ := Polynomial.sub_dvd_eval_sub f g p
  have factor : (f-g)*(C K z-X*h)=0 := by linear_combination -hf+hg+X*hh
  have hn : C K z-X*h ≠ 0 := by
    intro he
    have := congrArg (constantCoeff K) he
    simp [hz] at this
  exact sub_eq_zero.mp ((mul_eq_zero.mp factor).resolve_right hn)

#print axioms existsUnique_kernel_root
#print axioms unique_polynomial_branch
end
end VoloshynSeries
