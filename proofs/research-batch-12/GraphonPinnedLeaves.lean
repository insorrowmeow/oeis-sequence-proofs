import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace GraphonPinnedLeaves

/-- Each block has measure one half. Blocks of the same type have weight p+e. -/
def weight (p e : ℝ) (i j : Bool) : ℝ := if i = j then p+e else p-e

noncomputable def degree (p e : ℝ) (i : Bool) : ℝ := (weight p e i true + weight p e i false) / 2

noncomputable def twoLeaves (p e : ℝ) (i j : Bool) : ℝ :=
  (weight p e i true * weight p e j true + weight p e i false * weight p e j false) / 2

theorem bounds {p e : ℝ} (he : 0 ≤ e) (h₁ : e ≤ p) (h₂ : e ≤ 1-p) (i j : Bool) :
    0 ≤ weight p e i j ∧ weight p e i j ≤ 1 := by
  unfold weight
  split <;> constructor <;> linarith

theorem regular (p e : ℝ) (i : Bool) : degree p e i = p := by
  cases i <;> simp [degree,weight]

theorem minimizesValue (p e : ℝ) :
    ((degree p e true)^2 + (degree p e false)^2)/2 = p^2 := by
  rw [regular, regular]
  ring

theorem conditional_values (p e : ℝ) :
    twoLeaves p e true true = p^2+e^2 ∧ twoLeaves p e true false = p^2-e^2 := by
  constructor <;> simp [twoLeaves,weight] <;> ring

theorem conditional_unequal {p e : ℝ} (he : 0 < e) :
    twoLeaves p e true false < twoLeaves p e true true := by
  rw [(conditional_values p e).1, (conditional_values p e).2]
  nlinarith [sq_pos_of_pos he]

/-- For any finite weighted distribution of degrees, the P3 density is at least p². -/
theorem minimum_weighted {α : Type*} (s : Finset α) (w d : α → ℝ) (p : ℝ)
    (hn : ∀ i ∈ s, 0 ≤ w i) (hw : ∑ i ∈ s, w i = 1) (hd : ∑ i ∈ s, w i * d i = p) :
    p^2 ≤ ∑ i ∈ s, w i * (d i)^2 := by
  have h : 0 ≤ ∑ i ∈ s, w i * (d i-p)^2 :=
    Finset.sum_nonneg (fun i hi => mul_nonneg (hn i hi) (sq_nonneg _))
  have eqn : ∀ i, w i * (d i-p)^2 = w i * (d i)^2 - (w i*d i)*(2*p) + w i*p^2 := by
    intro i
    ring
  simp_rw [eqn] at h
  rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.sum_mul, ← Finset.sum_mul, hd, hw] at h
  nlinarith

end GraphonPinnedLeaves
