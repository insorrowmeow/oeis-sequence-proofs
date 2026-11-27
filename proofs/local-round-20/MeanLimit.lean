import PerimeterFinite
import PerimeterLimit

/-! Mertens' product estimate already determines the normalized first length
moment. The difference between that moment and the logarithm of the product
lies between zero and one, uniformly in the truncation. -/

open Filter Topology Finset
namespace MeanLimit
open PerimeterFinite
noncomputable section

private theorem single_error {p a : ℝ} (ha : 0 ≤ a) (hp : a+2 ≤ p) :
    let q := 1/p
    0 ≤ q/(1-q) - Real.log (1-q)⁻¹ ∧
      q/(1-q) - Real.log (1-q)⁻¹ ≤ 1/(a+1) - 1/(a+2) := by
  dsimp only
  have pp : 0 < p := by linarith
  have pp' : 0 < p-1 := by linarith
  have hq : 0 < 1-1/p := sub_pos.mpr ((div_lt_one pp).mpr (by linarith))
  have hupper := Real.log_le_sub_one_of_pos (inv_pos.mpr hq)
  have hlow := Real.log_le_sub_one_of_pos hq
  have hid : (1-1/p)⁻¹ - 1 = (1/p)/(1-1/p) := by field_simp
  constructor
  · rw [hid] at hupper
    linarith
  · rw [Real.log_inv]
    calc
      _ ≤ (1/p)/(1-1/p) - 1/p := by linarith
      _ = 1/(p*(p-1)) := by field_simp; ring
      _ ≤ 1/((a+2)*(a+1)) := by
        apply one_div_le_one_div_of_le (by positivity)
        exact mul_le_mul hp (by linarith) (by linarith) pp.le
      _ = _ := by field_simp; ring

theorem mean_log_bounds (p : ℕ → ℝ) (hp : ∀ j : ℕ, (j:ℝ)+2 ≤ p (j+1)) (n : ℕ) :
    let q := fun j => 1/p (j+1)
    let B := ∑ j ∈ range n, q j/(1-q j)
    0 ≤ B - Real.log (euler q n) ∧ B - Real.log (euler q n) ≤ 1-1/((n:ℝ)+1) := by
  let q := fun j => 1/p (j+1)
  have hq (j : ℕ) : 0 < 1-q j := by
    have hh := hp j
    have ha : (0:ℝ) ≤ j := Nat.cast_nonneg j
    exact sub_pos.mpr ((div_lt_one (by linarith)).mpr (by linarith))
  have hprod (k : ℕ) : 0 < euler q k := prod_pos fun j _ => inv_pos.mpr (hq j)
  change 0 ≤ (∑ j ∈ range n, q j/(1-q j)) - Real.log (euler q n) ∧ _
  induction n with
  | zero => simp [euler]
  | succ n ih =>
    have term := single_error (Nat.cast_nonneg n : (0:ℝ) ≤ n) (hp n)
    change 0 ≤ q n/(1-q n) - Real.log (1-q n)⁻¹ ∧ _ at term
    change 0 ≤ (∑ j ∈ range (n+1), q j/(1-q j)) - Real.log (euler q (n+1)) ∧
      (∑ j ∈ range (n+1), q j/(1-q j)) - Real.log (euler q (n+1)) ≤ _
    rw [sum_range_succ, show euler q (n+1) = euler q n * (1-q n)⁻¹ by
      exact prod_range_succ _ _, Real.log_mul (ne_of_gt (hprod n)) (ne_of_gt (inv_pos.mpr (hq n)))]
    push_cast
    rw [show (n:ℝ)+1+1 = (n:ℝ)+2 by ring]
    constructor <;> linarith [ih.1, ih.2, term.1, term.2]

theorem mean_limit (p : ℕ → ℝ) (c : ℝ) (hc : 0 < c)
    (hp : ∀ j : ℕ, (j:ℝ)+2 ≤ p (j+1))
    (mertens : Tendsto (fun n : ℕ => euler (fun j => 1/p (j+1)) n / Real.log n)
      atTop (𝓝 c)) :
    Tendsto (fun n : ℕ => (∑ j ∈ range n, (1/p (j+1))/(1-1/p (j+1))) /
      Real.log (Real.log n)) atTop (𝓝 1) := by
  let q := fun j => 1/p (j+1)
  have hq (j : ℕ) : 0 < 1-q j := by
    have hh := hp j
    have ha : (0:ℝ) ≤ j := Nat.cast_nonneg j
    exact sub_pos.mpr ((div_lt_one (by linarith)).mpr (by linarith))
  have hprod (n : ℕ) : 0 < euler q n := prod_pos fun j _ => inv_pos.mpr (hq j)
  have logs : Tendsto (fun n : ℕ => Real.log (n:ℝ)) atTop atTop :=
    Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop
  have invll : Tendsto (fun n : ℕ => (Real.log (Real.log n))⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp (Real.tendsto_log_atTop.comp logs)
  have h := (tendsto_const_nhds (x := (1:ℝ))).add ((mertens.log hc.ne').mul invll)
  simp only [mul_zero, add_zero] at h
  have hlo : Tendsto (fun n : ℕ => Real.log (euler q n) / Real.log (Real.log n)) atTop (𝓝 1) := by
    apply h.congr'
    filter_upwards [logs.eventually_gt_atTop 1] with n hn
    change 1 + Real.log (euler q n / Real.log n) * (Real.log (Real.log n))⁻¹ = _
    rw [Real.log_div (hprod n).ne' (by linarith)]
    field_simp [(Real.log_pos hn).ne']
  have hhi := hlo.add invll
  simp only [add_zero] at hhi
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' hlo hhi
  · filter_upwards [logs.eventually_gt_atTop 1] with n hn
    exact div_le_div_of_nonneg_right (by linarith [(mean_log_bounds p hp n).1]) (Real.log_pos hn).le
  · filter_upwards [logs.eventually_gt_atTop 1] with n hn
    change _ ≤ _ / Real.log (Real.log n) + (Real.log (Real.log n))⁻¹
    rw [← one_div, ← add_div]
    apply div_le_div_of_nonneg_right _ (Real.log_pos hn).le
    have err := (mean_log_bounds p hp n).2
    have nn : 0 ≤ 1/((n:ℝ)+1) := by positivity
    linarith

#print axioms mean_limit
end
end MeanLimit
