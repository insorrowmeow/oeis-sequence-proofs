import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.RingTheory.PowerSeries.WellKnown

namespace CriticalPerimeter.Transfer

open Filter Topology
open scoped Polynomial
noncomputable section

abbrev Series := PowerSeries ℂ
def absSum (F : Series) : Prop := Summable fun n => ‖PowerSeries.coeff ℂ n F‖
def total (F : Series) : ℂ := ∑' n, PowerSeries.coeff ℂ n F

private theorem absSum_mul {F G : Series} (hF : absSum F) (hG : absSum G) :
    absSum (F * G) := by
  simpa only [absSum, PowerSeries.coeff_mul] using
    summable_norm_sum_mul_antidiagonal_of_summable_norm hF hG

private theorem total_mul {F G : Series} (hF : absSum F) (hG : absSum G) :
    total (F * G) = total F * total G := by
  simpa only [total, PowerSeries.coeff_mul] using
    (tsum_mul_tsum_eq_tsum_sum_antidiagonal_of_summable_norm hF hG).symm

private theorem polynomial_absSum (p : ℂ[X]) : absSum (p : Series) := by
  apply summable_of_ne_finset_zero (s := p.support)
  intro n hn
  simp [Polynomial.coeff_coe, Polynomial.not_mem_support_iff.mp hn]

private theorem polynomial_total (p : ℂ[X]) : total (p : Series) = p.eval 1 := by
  unfold total
  rw [tsum_eq_sum (s := p.support)]
  · simp [Polynomial.eval_eq_sum, Polynomial.sum]
  · intro n hn
    simpa [Polynomial.coeff_coe] using Polynomial.not_mem_support_iff.mp hn

def linear (q : ℂ) : Series := 1 - PowerSeries.C ℂ q * PowerSeries.X
def geometric (q : ℂ) : Series := PowerSeries.mk (fun n => q^n)

private theorem invert_linear (q : ℂ) : linear q * geometric q = 1 := by
  ext n
  cases n with
  | zero => simp [linear, geometric]
  | succ n =>
    simp [linear, geometric, sub_mul, mul_assoc, pow_succ', Nat.succ_ne_zero]

private theorem geometric_absSum {q : ℂ} (hq : ‖q‖ < 1) : absSum (geometric q) := by
  simpa only [absSum, geometric, PowerSeries.coeff_mk, norm_pow] using
    summable_geometric_of_lt_one (norm_nonneg q) hq

private theorem geometric_total {q : ℂ} (hq : ‖q‖ < 1) :
    total (geometric q) = (1-q)⁻¹ := by
  simpa only [total, geometric, PowerSeries.coeff_mk] using
    tsum_geometric_of_norm_lt_one hq

def factorProduct (l : List ℂ) : Series := (l.map linear).prod
private def inverseProduct (l : List ℂ) : Series := (l.map geometric).prod

private theorem invert_product (l : List ℂ) : factorProduct l * inverseProduct l = 1 := by
  induction l with
  | nil => simp [factorProduct, inverseProduct]
  | cons q l h =>
    change (linear q * factorProduct l) * (geometric q * inverseProduct l) = 1
    rw [mul_mul_mul_comm, invert_linear, h, mul_one]

private theorem stable_product (l : List ℂ) (h : ∀ q ∈ l, ‖q‖ < 1) :
    absSum (inverseProduct l) ∧ total (inverseProduct l) = (l.map (fun q => (1-q)⁻¹)).prod := by
  induction l with
  | nil =>
    have hu := polynomial_absSum (1 : ℂ[X])
    have hv := polynomial_total (1 : ℂ[X])
    simpa [inverseProduct] using And.intro hu hv
  | cons q l ih =>
    have hq := h q List.mem_cons_self
    obtain ⟨h₁,h₂⟩ := ih fun q' mq' => h q' (List.mem_cons_of_mem _ mq')
    change absSum (geometric q * inverseProduct l) ∧
      total (geometric q * inverseProduct l) = (1-q)⁻¹ * (l.map (fun w => (1-w)⁻¹)).prod
    exact ⟨absSum_mul (geometric_absSum hq) h₁,
      by rw [total_mul (geometric_absSum hq) h₁, geometric_total hq, h₂]⟩

/-- Transfer for a formal rational generating function after rescaling its dominant pole to 1.
    The other reciprocal roots may repeat. The identity is a formal power series identity. -/
theorem coefficient_limit (F : Series) (p : ℂ[X]) (l : List ℂ)
    (h : ∀ q ∈ l, ‖q‖ < 1)
    (gen : F * (1 - PowerSeries.X) * factorProduct l = (p : Series)) :
    Tendsto (fun n => PowerSeries.coeff ℂ n F) atTop
      (𝓝 (p.eval 1 * (l.map (fun q => (1-q)⁻¹)).prod)) := by
  obtain ⟨h₁,h₂⟩ := stable_product l h
  let J := (p : Series) * inverseProduct l
  have hu : absSum J := absSum_mul (polynomial_absSum p) h₁
  have hj : total J = p.eval 1 * (l.map (fun q => (1-q)⁻¹)).prod := by
    rw [show J = (p : Series) * inverseProduct l from rfl, total_mul (polynomial_absSum p) h₁,
      polynomial_total, h₂]
  have hF : F = J * PowerSeries.mk 1 := by
    change F = (p : Series) * inverseProduct l * PowerSeries.mk 1
    rw [← gen, mul_assoc (F * _) _ _, invert_product, mul_one, mul_assoc,
      mul_comm (1 - PowerSeries.X) _, PowerSeries.mk_one_mul_one_sub_eq_one, mul_one]
  rw [← hj]
  have hpart := hu.of_norm.hasSum.tendsto_sum_nat
  have hpart' := hpart.comp (tendsto_add_atTop_nat 1)
  refine hpart'.congr (fun n => ?_)
  simp only [Function.comp_apply, hF, PowerSeries.coeff_mul, PowerSeries.coeff_mk, Pi.one_apply,
    mul_one]
  exact (Finset.Nat.sum_antidiagonal_eq_sum_range_succ (fun k _ => PowerSeries.coeff ℂ k J) n).symm

end
end CriticalPerimeter.Transfer
