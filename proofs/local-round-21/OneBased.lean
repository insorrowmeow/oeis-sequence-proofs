import VectorPartitions
import SizeSharpLimit

namespace OneBased
open Finset VectorPartitions
noncomputable section

private theorem interval_sum (f : ℕ → ℝ) {a s n : ℕ} (hs : s≤n) :
    (∑ i ∈ (univ : Finset (Fin n)).filter (fun i => a<label i ∧ label i≤s), f (label i)) =
      ∑ j ∈ Ioc a s, f j := by
  refine sum_bij' (fun i _ => label i) (fun j hj => ⟨j-1, ?_⟩) ?_ ?_ ?_ ?_ ?_
  · have := mem_Ioc.mp hj
    omega
  · intro i hi
    exact mem_Ioc.mpr (mem_filter.mp hi).2
  · intro j hj
    have h := mem_Ioc.mp hj
    apply mem_filter.mpr
    refine ⟨mem_univ _,?_⟩
    change a<j-1+1 ∧ j-1+1≤s
    omega
  · intro i _
    apply Fin.ext
    dsimp [label]
  · intro j hj
    have := mem_Ioc.mp hj
    dsimp [label]
    omega
  · intro i _
    rfl

theorem big_mass (q : ℕ→ℝ) (n b : ℕ) :
    (∑ i ∈ (univ : Finset (Fin n)).filter (fun i => b<label i), q (label i)) = SizeLimit.mass q b n := by
  change _ = ∑ j ∈ Ioc b n, q j
  rw [← interval_sum (n:=n) q le_rfl]
  apply sum_congr _ (fun _ _ => rfl)
  ext i
  simp [label, show (i:ℕ)+1≤n by omega]

private theorem mean_one (q : ℕ→ℝ) (hbound : ∀ j, 0<j → q j ≤ 1/((j:ℝ)+1))
    {j : ℕ} (hj : 0<j) : (j:ℝ)*q j/(1-q j) ≤ 1 := by
  have hv : (0:ℝ)<j := by exact_mod_cast hj
  have h := (le_div_iff₀ (show (0:ℝ)<j+1 by positivity)).mp (hbound _ hj)
  have hh : q j < 1 := (hbound _ hj).trans_lt ((div_lt_one (by positivity)).mpr (by linarith))
  rw [div_le_one (sub_pos.mpr hh)]
  nlinarith

theorem small_mean (q : ℕ→ℝ) (hbound : ∀ j, 0<j → q j ≤ 1/((j:ℝ)+1))
    {b n : ℕ} (hbn : b≤n) :
    (∑ i ∈ (univ : Finset (Fin n)) \ univ.filter (fun i => b < label i),
      (label i:ℝ)*(q (label i)/(1-q (label i)))) ≤ b := by
  simp only [← mul_div_assoc]
  have he : (univ : Finset (Fin n)) \ univ.filter (fun i => b<label i) =
      univ.filter (fun i => 0<label i ∧ label i≤b) := by ext i; simp [label]
  rw [he,interval_sum (fun j => (j:ℝ)*q j/(1-q j)) hbn]
  calc
    _ ≤ ∑ _j ∈ Ioc 0 b, (1:ℝ) := sum_le_sum fun j hj => mean_one q hbound (mem_Ioc.mp hj).1
    _ = _ := by simp

theorem high_mass (q : ℕ→ℝ) (hbound : ∀ j, 0<j → q j ≤ 1/((j:ℝ)+1))
    {N n : ℕ} (hN : 0<N) (_hNn : N≤n) :
    (∑ i ∈ (univ : Finset (Fin n)).filter (fun i => N<label i), q (label i)) ≤
      ((n-N:ℕ):ℝ)/N := by
  rw [big_mass,SizeLimit.mass]
  calc
    _ ≤ ∑ _j ∈ Ioc N n, 1/(N:ℝ) := by
      apply sum_le_sum
      intro j hj
      have h := (mem_Ioc.mp hj).1
      apply (hbound _ (by omega)).trans
      apply one_div_le_one_div_of_le (by exact_mod_cast hN)
      exact_mod_cast (show N≤j+1 by omega)
    _ = _ := by simp [div_eq_mul_inv]

private theorem square_estimate (q : ℕ→ℝ) (h₀ : ∀ j,0≤q j)
    (hbound : ∀ j, 0<j → q j ≤ 1/((j:ℝ)+1)) {j : ℕ} (hj : 0<j) :
    (q j)^2 ≤ 1/(j:ℝ)-1/((j:ℝ)+1) := by
  have hp : (0:ℝ)<j := by exact_mod_cast hj
  have h' : (0:ℝ)<j+1 := by positivity
  calc
    _ ≤ (1/((j:ℝ)+1))*(1/(j:ℝ)) := by
      rw [sq]
      exact mul_le_mul (hbound _ hj) ((hbound _ hj).trans (one_div_le_one_div_of_le hp (by linarith)))
        (h₀ _) (by positivity)
    _ = _ := by field_simp; ring

theorem big_squares (q : ℕ→ℝ) (h₀ : ∀ j,0≤q j)
    (hbound : ∀ j, 0<j → q j ≤ 1/((j:ℝ)+1)) {b n : ℕ} (hb : 0<b) (hbn : b≤n) :
    (∑ i ∈ (univ : Finset (Fin n)).filter (fun i => b<label i), (q (label i))^2) ≤ 1/(b:ℝ) := by
  rw [big_mass (fun j => (q j)^2),SizeLimit.mass]
  have htel : (∑ j ∈ Ioc b n, (q j)^2) ≤ 1/((b:ℝ)+1)-1/((n:ℝ)+1) := by
    induction n,hbn using Nat.le_induction with
    | base => simp
    | succ n hbn ih =>
      have eq : Ioc b (n+1) = insert (n+1) (Ioc b n) := by ext j; simp; omega
      rw [eq,sum_insert (by simp)]
      have hs := square_estimate q h₀ hbound (Nat.zero_lt_succ n)
      push_cast at hs ⊢
      linarith
  exact htel.trans ((sub_le_self _ (by positivity)).trans (one_div_le_one_div_of_le (by exact_mod_cast hb) (by linarith)))

#print axioms big_squares


def primeQ (j : ℕ) := 1/SizeEnsemble.primeAt j

theorem primeQ_nonneg (j : ℕ) : 0 ≤ primeQ j := by
  cases j with
  | zero => norm_num [primeQ,SizeEnsemble.primeAt]
  | succ j => exact div_nonneg zero_le_one (zero_le_one.trans (SizeEnsemble.prime_gt_one j).le)

theorem primeQ_bound (j : ℕ) (hj : 0<j) : primeQ j ≤ 1/((j:ℝ)+1) := by
  have lower (i : ℕ) : i+2 ≤ Nat.nth Nat.Prime i := by
    induction i with
    | zero => simp
    | succ i ih =>
      have h : Nat.nth Nat.Prime i < Nat.nth Nat.Prime (i+1) :=
        Nat.nth_strictMono (p := Nat.Prime) Nat.infinite_setOf_prime (Nat.lt_succ_self i)
      omega
  obtain ⟨i,rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hj)
  apply one_div_le_one_div_of_le (by positivity)
  convert (show (i:ℝ)+2 ≤ (Nat.nth Nat.Prime i : ℝ) by exact_mod_cast lower i) using 1
  · push_cast; ring


open Filter Topology in
theorem weighted_pnt
    (pnt : Tendsto (fun n : ℕ => SizeEnsemble.primeAt n / ((n:ℝ)*Real.log n)) atTop (𝓝 1)) :
    Tendsto (fun n : ℕ => (n:ℝ)*Real.log n*primeQ n) atTop (𝓝 1) := by
  have h := pnt.inv₀ (by norm_num)
  simpa [primeQ,div_eq_mul_inv,mul_comm,mul_left_comm,mul_assoc] using h

end
end OneBased
