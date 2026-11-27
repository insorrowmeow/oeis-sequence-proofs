import EventBounds

namespace SizeGeom
open Finset
noncomputable section
variable {ι Ω : Type*} [Fintype ι] [DecidableEq ι] [Fintype Ω]

theorem prob_or {w : Ω → ℝ} (hw : ∀ v, 0 ≤ w v) (A B : Ω → Prop) :
    prob w (fun v => A v ∨ B v) ≤ prob w A + prob w B := by
  classical
  unfold prob
  rw [← sum_add_distrib]
  exact sum_le_sum fun v _ => by by_cases a : A v <;> by_cases b : B v <;> simp [a,b,hw]

theorem prob_mono {w : Ω → ℝ} (hw : ∀ v, 0 ≤ w v) {A B : Ω → Prop} (h : ∀ v, A v → B v) :
    prob w A ≤ prob w B := by
  classical
  unfold prob
  exact sum_le_sum fun v _ => by by_cases a : A v <;> by_cases b : B v <;> simp_all

theorem markov {w : Ω → ℝ} (hw : ∀ v, 0 ≤ w v) (f : Ω → ℕ) {t : ℕ} (ht : 0 < t) :
    prob w (fun v => t < f v) ≤ (∑ v, w v * (f v : ℝ)) / t := by
  classical
  apply (le_div_iff₀ (Nat.cast_pos.mpr ht)).2
  unfold prob
  rw [sum_mul]
  apply sum_le_sum
  intro v _
  by_cases h : t < f v
  · rw [if_pos h]
    exact mul_le_mul_of_nonneg_left (by exact_mod_cast h.le) (hw v)
  · simp [h, mul_nonneg (hw v) (Nat.cast_nonneg (f v) : (0:ℝ) ≤ f v)]

theorem coordinate_mean {K : ℕ} {q : ι → ℝ} (h0 : ∀ i, 0 ≤ q i) (h1 : ∀ i, q i < 1)
    (i : ι) :
    (∑ v, mass q K v * (v i : ℕ)) ≤ q i / (1-q i) := by
  classical
  have count (d : Fin (K+1)) : (d:ℕ) = ∑ k ∈ range K, if k+1 ≤ (d:ℕ) then 1 else 0 := by
    rw [← sum_filter]
    have he : (range K).filter (fun k => k+1 ≤ (d:ℕ)) = range (d:ℕ) := by
      ext k
      have := d.isLt
      simp; omega
    simp [he]
  have splitMean (v : ι → Fin (K+1)) :
      mass q K v * (v i : ℕ) = ∑ k ∈ range K, if k+1 ≤ (v i:ℕ) then mass q K v else 0 := by
    conv_lhs => rhs; rw [count (v i)]
    simp only [Nat.cast_sum, Nat.cast_ite, Nat.cast_one, Nat.cast_zero, mul_sum, mul_ite, mul_one, mul_zero]
  calc
    _ = ∑ k ∈ range K, prob (mass q K) (fun v => k+1 ≤ (v i:ℕ)) := by
      simp_rw [splitMean]
      rw [sum_comm]
      apply sum_congr rfl
      intro k _
      unfold prob
      apply sum_congr rfl
      intro v _
      by_cases h : k+1 ≤ (v i:ℕ) <;> simp [h]
    _ = ∑ k ∈ range K, (q i)^(k+1) := sum_congr rfl fun k hk =>
      single_tail q i (k+1) (mem_range.mp hk)
    _ = (∑ k ∈ range K, (q i)^k) * q i := by simp only [sum_mul, pow_succ]
    _ ≤ (1-q i)⁻¹ * q i := by
      apply mul_le_mul_of_nonneg_right _ (h0 i)
      have hs := hasSum_geometric_of_lt_one (h0 i) (h1 i)
      rw [← hs.tsum_eq]
      exact hs.summable.sum_le_tsum _ fun k _ => pow_nonneg (h0 i) k
    _ = _ := by rw [mul_comm, div_eq_mul_inv]

theorem small_markov {K t : ℕ} (ht : 0<t) (q : ι→ℝ) (h0 : ∀ i, 0≤q i) (h1 : ∀ i, q i<1)
    (part : ι→ℕ) (s : Finset ι) :
    prob (mass q K) (fun v => t < ∑ i ∈ s, part i * (v i:ℕ)) ≤
      (∑ i ∈ s, (part i : ℝ)*(q i/(1-q i))) / t := by
  have h := markov (nonnegative_mass h0 (fun i => (h1 i).le) K)
    (fun v => ∑ i ∈ s, part i * (v i:ℕ)) ht
  refine h.trans (div_le_div_of_nonneg_right ?_ (Nat.cast_nonneg t))
  simp only [Nat.cast_sum, Nat.cast_mul, mul_sum]
  rw [sum_comm]
  apply sum_le_sum
  intro i _
  have he (v : ι → Fin (K+1)) :
      mass q K v * ((part i:ℝ)*(v i:ℕ)) = (part i:ℝ)*(mass q K v*(v i:ℕ)) := by ring
  simp_rw [he, ← mul_sum]
  exact mul_le_mul_of_nonneg_left (coordinate_mean h0 h1 i) (Nat.cast_nonneg _)

theorem any_tail {K k : ℕ} (hk : k ≤ K) (q : ι→ℝ) (h0 : ∀ i, 0≤q i) (h1 : ∀ i, q i≤1)
    (s : Finset ι) :
    prob (mass q K) (fun v => ∃ i ∈ s, k ≤ (v i:ℕ)) ≤ ∑ i ∈ s, (q i)^k := by
  apply (cover (nonnegative_mass h0 h1 K) s (fun i v => k ≤ (v i:ℕ)) (fun _ h => h)).trans
  exact sum_le_sum fun i _ => (single_tail q i k hk).le

theorem triple_bound {K : ℕ} (hK : 1≤K) (q : ι→ℝ) (h0 : ∀ i, 0≤q i) (h1 : ∀ i, q i≤1)
    (s : Finset ι) :
    prob (mass q K) (fun v => 2 < (occupied s v).card) ≤ (∑ i ∈ s, q i)^3 := by
  classical
  let T := (s ×ˢ (s ×ˢ s)).filter fun x => x.1 ≠ x.2.1 ∧ x.1 ≠ x.2.2 ∧ x.2.1 ≠ x.2.2
  let event (x : ι × ι × ι) (v : ι → Fin (K+1)) := ∀ i ∈ ({x.1,x.2.1,x.2.2} : Finset ι), 1 ≤ (v i:ℕ)
  apply (cover (nonnegative_mass h0 h1 K) T event ?_).trans
  · calc
      _ = ∑ x ∈ T, q x.1 * (q x.2.1 * q x.2.2) := by
        apply sum_congr rfl
        rintro ⟨a,b,c⟩ hx
        obtain ⟨h, h', h''⟩ := (mem_filter.mp hx).2
        simpa [event, h, h', h''] using all_hit q {a,b,c} 1 hK
      _ ≤ ∑ x ∈ s ×ˢ (s ×ˢ s), q x.1 * (q x.2.1 * q x.2.2) :=
        sum_le_sum_of_subset_of_nonneg (filter_subset _ _) (fun x _ _ =>
          mul_nonneg (h0 _) (mul_nonneg (h0 _) (h0 _)))
      _ = _ := by simp only [sum_product, ← mul_sum, ← sum_mul]; ring
  · intro v hv
    obtain ⟨a,b,c,ha,hb,hc,hab,hac,hbc⟩ := two_lt_card_iff.mp hv
    refine ⟨(a,b,c), mem_filter.mpr ⟨mem_product.mpr ⟨(mem_filter.mp ha).1,
      mem_product.mpr ⟨(mem_filter.mp hb).1, (mem_filter.mp hc).1⟩⟩, hab, hac, hbc⟩, ?_⟩
    dsimp only [event]
    simp only [mem_insert, mem_singleton]
    rintro i (rfl|rfl|rfl)
    · exact (mem_filter.mp ha).2
    · exact (mem_filter.mp hb).2
    · exact (mem_filter.mp hc).2

end
end SizeGeom
