import BoundaryGap
import Moment
import PerimeterLimit

namespace PerimeterFinite
open Finset

noncomputable def meanLength (q : ℕ → ℝ) (m : ℕ) : ℝ :=
  ∑ j ∈ range m, q j / (1-q j)

/-- Prime-independent form of the sharp boundary sandwich at a square-root
cutoff. The hypotheses apply in particular to the increasing sequence of primes. -/
theorem sharp_finite {p : ℕ → ℝ} (hmono : Monotone p)
    (hp : ∀ i : ℕ, (i:ℝ)+2 ≤ p (i+1))
    (hprod : ∀ m : ℕ, euler (fun j => (3/2:ℝ) * (1 / p (j+1))) m ≤ ((m:ℝ)+1)^2)
    {n : ℕ} (hn : 2 ≤ n) :
    let q := fun j => 1 / p (j+1)
    let M := PerimeterLimit.leftIndex n
    let E := PerimeterLimit.error 3 2 n
    euler q M * meanLength q M / p n - E ≤ euler q n - cumulative q n ∧
      euler q n - cumulative q n ≤ euler q n * meanLength q n / p M + E := by
  let q := fun j => 1 / p (j+1)
  let M := PerimeterLimit.leftIndex n
  have hmdef : M = n - n.sqrt := rfl
  have hL : n.sqrt < n := Nat.sqrt_lt_self hn
  have hM : 0 < M := by omega
  have hp' (i : ℕ) : (3/2:ℝ)<p (i+1) := by linarith [hp i, Nat.cast_nonneg (α := ℝ) i]
  have pos (i : ℕ) : 0 < p (i+1) := by linarith [hp' i]
  have hq : ∀ i, 0 ≤ q i := fun i => div_nonneg zero_le_one (pos i).le
  have hq' : ∀ i, q i < 1 := fun i => (div_lt_one (pos i)).2 (by linarith [hp' i])
  have hqr (i : ℕ) : (3/2:ℝ)*q i < 1 := by
    dsimp only [q]
    rw [← mul_div_assoc, mul_one]
    exact (div_lt_one (pos i)).2 (hp' i)
  have hanti : Antitone q := by
    intro i j hij
    exact one_div_le_one_div_of_le (pos i) (hmono (Nat.succ_le_succ hij))
  have err (m : ℕ) (hm : m ≤ n) :
      3*euler (fun j => (3/2:ℝ)*q j) m / (3/2:ℝ)^n.sqrt ≤ PerimeterLimit.error 3 2 n := by
    apply div_le_div_of_nonneg_right _ (pow_nonneg (by norm_num) _)
    apply mul_le_mul_of_nonneg_left _ (by norm_num)
    apply (hprod m).trans
    have hmn : (m:ℝ) ≤ n := by exact_mod_cast hm
    gcongr
  obtain ⟨hlo, hhi⟩ := sharp_gap_bounds hanti hq hq' hqr hL.le
  simp only [fun m => (hasSum_tail hq hq' m).tsum_eq] at hlo hhi
  have w1 : q (n-1) = 1 / p n := by dsimp [q]; rw [show n-1+1=n by omega]
  have w2 : q (n-1-n.sqrt) = 1 / p M := by dsimp [q]; rw [show n-1-n.sqrt+1=M by omega]
  rw [w1, ← hmdef, one_div, ← div_eq_inv_mul] at hlo
  rw [w2, one_div, ← div_eq_inv_mul] at hhi
  exact ⟨le_trans (sub_le_sub_left (err M (hmdef ▸ Nat.sub_le ..)) _) hlo,
    le_trans hhi (add_le_add_left (err n le_rfl) _)⟩

#print axioms sharp_finite
end PerimeterFinite

