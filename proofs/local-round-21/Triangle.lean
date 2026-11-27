import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.GCongr
import Mathlib.Tactic.Ring

/-! The exact harmonic weight of the upper half of an integer square. -/
namespace SizeTriangle
open Finset Filter
open scoped Topology
noncomputable section

def recip (i : ℕ) : ℝ := (i:ℝ)⁻¹

def pairSum (w : ℕ → ℝ) (b N : ℕ) : ℝ :=
  ∑ i ∈ range (N+1), ∑ j ∈ range (N+1),
    if b < i ∧ i < j ∧ N < i+j then w i*w j else 0

private def cell (N i j : ℕ) : ℝ := if N < i+j then recip i * recip j else 0

def ordered (N : ℕ) : ℝ :=
  ∑ i ∈ range (N+1), ∑ j ∈ range (N+1), cell N i j

private theorem cell_swap (N i j : ℕ) : cell N i j = cell N j i := by
  simp only [cell, Nat.add_comm i j, mul_comm (recip i)]

private theorem square_step (n i : ℕ) (hi : i ≤ n) :
    ∑ j ∈ range (n+1), cell n i j =
      (∑ j ∈ range (n+1), cell (n+1) i j) + recip i * recip (n+1-i) := by
  obtain rfl | hpos := Nat.eq_zero_or_pos i
  · simp [cell,recip]
  have hm : n+1-i ∈ range (n+1) := mem_range.mpr (by omega)
  have singled := sum_ite_eq' (range (n+1)) (n+1-i) (fun j => recip i*recip j)
  rw [if_pos hm] at singled
  rw [← singled,
    ← sum_add_distrib]
  apply sum_congr rfl
  intro j _
  unfold cell
  split_ifs <;> simp_all <;> omega

private theorem boundary_sum (n : ℕ) :
    ∑ i ∈ range (n+1), recip i * recip (n+1-i) =
      2 * recip (n+1) * ∑ i ∈ range (n+1), recip i := by
  rw [sum_range_succ',sum_range_succ' recip]
  simp only [recip, Nat.cast_zero, inv_zero, zero_mul, add_zero]
  have symm : ∑ j ∈ range n, (((n+1-(j+1):ℕ):ℝ))⁻¹ =
      ∑ j ∈ range n, ((j+1:ℕ):ℝ)⁻¹ := by
    rw [← sum_range_reflect (fun j : ℕ => ((j+1:ℕ):ℝ)⁻¹) n]
    apply sum_congr rfl
    intro j hj
    have := mem_range.mp hj
    rw [show n+1-(j+1)=n-1-j+1 by omega]
  have split : ∑ j ∈ range n, ((j+1:ℕ):ℝ)⁻¹ * ((n+1-(j+1):ℕ):ℝ)⁻¹ =
      ∑ j ∈ range n, ((n+1:ℕ):ℝ)⁻¹ * (((j+1:ℕ):ℝ)⁻¹ + ((n+1-(j+1):ℕ):ℝ)⁻¹) := by
    apply sum_congr rfl
    intro j hj
    have jlt := mem_range.mp hj
    have hk : 0 < (n+1-(j+1):ℕ) := by omega
    have he : ((n+1:ℕ):ℝ) = ((j+1:ℕ):ℝ) + ((n+1-(j+1):ℕ):ℝ) := by
      exact_mod_cast (show n+1 = (j+1)+(n+1-(j+1)) by omega)
    field_simp [ne_of_gt (show (0:ℝ) < ((n+1-(j+1):ℕ):ℝ) by exact_mod_cast hk)]
    simp only [Nat.add_sub_add_right]
    push_cast at he
    linarith
  rw [split, ← mul_sum, sum_add_distrib, symm]
  ring

private theorem ordered_succ (n : ℕ) : ordered (n+1) = ordered n + recip (n+1)^2 := by
  have row (i : ℕ) : cell (n+1) i (n+1) = recip i * recip (n+1) := by
    cases i with
    | zero => simp [cell,recip]
    | succ i => simp [cell, show n+1 < i+1+(n+1) by omega]
  have decomp :
    ordered n = (∑ i ∈ range (n+1), ∑ j ∈ range (n+1), cell (n+1) i j) +
      2 * recip (n+1) * ∑ i ∈ range (n+1), recip i := by
    rw [← boundary_sum, ← sum_add_distrib]
    exact sum_congr rfl fun i hi => square_step n i (by have := mem_range.mp hi; omega)
  unfold ordered
  rw [sum_range_succ]
  simp only [sum_range_succ (fun j => cell (n+1) _ j) (n+1),row, sum_add_distrib]
  have col : (∑ j ∈ range (n+1), cell (n+1) (n+1) j) =
      ∑ j ∈ range (n+1), recip j * recip (n+1) :=
    sum_congr rfl fun j _ => (cell_swap ..).trans (row j)
  rw [col, ← sum_mul]
  change _ = ordered n + _
  rw [decomp]
  ring

theorem ordered_eq (n : ℕ) : ordered n = ∑ i ∈ range (n+1), recip i ^ 2 := by
  induction n with
  | zero => simp [ordered,cell,recip]
  | succ n ih => rw [ordered_succ, ih, sum_range_succ (fun i => recip i ^ 2) (n+1)]

private def upperCell (n i j : ℕ) := if i < j then cell n i j else 0
private def upperRow (n i : ℕ) := ∑ j ∈ range (n+1), upperCell n i j
private theorem upper_nonneg (n i j : ℕ) : 0 ≤ upperCell n i j := by
  unfold upperCell cell recip
  split_ifs <;> positivity

private theorem split_ordered (n : ℕ) :
    ordered n = 2 * (∑ i ∈ range (n+1), upperRow n i) +
      ∑ i ∈ range (n+1), cell n i i := by
  have per (i j : ℕ) : cell n i j = upperCell n i j + upperCell n j i +
      (if j=i then cell n i i else 0) := by
    rcases lt_trichotomy i j with h | h | h
    · simp [upperCell,h,not_lt_of_ge h.le,ne_of_gt h]
    · subst j; simp [upperCell]
    · simp [upperCell,h,not_lt_of_ge h.le,ne_of_lt h,cell_swap n i j]
  have diag : (∑ i ∈ range (n+1), ∑ j ∈ range (n+1), if j=i then cell n i i else 0) =
      ∑ i ∈ range (n+1), cell n i i := by
    apply sum_congr rfl
    intro i hi
    simp [hi]
  unfold ordered upperRow
  calc
    _ = ∑ i ∈ range (n+1), ∑ j ∈ range (n+1),
        (upperCell n i j + upperCell n j i + if j=i then cell n i i else 0) :=
      sum_congr rfl fun i _ => sum_congr rfl fun j _ => per i j
    _ = _ := by
      simp only [sum_add_distrib, diag]
      rw [sum_comm (f := fun i j => upperCell n j i)]
      ring

private theorem pairRows (b n : ℕ) : pairSum recip b n =
    ∑ i ∈ range (n+1), (if b < i then upperRow n i else 0) := by
  apply sum_congr rfl
  intro i _
  by_cases hb : b < i
  · rw [if_pos hb]
    apply sum_congr rfl
    intro j _
    simp only [upperCell,cell]
    split_ifs <;> simp_all
  · simp [hb]

private theorem small_row {i b n : ℕ} (hi : i ≤ b) (hb : b < n) :
    upperRow n i ≤ recip (n-b) := by
  let f := upperCell n i
  have hs := sum_range_add f (n-i+1) i
  rw [show n-i+1+i=n+1 by omega] at hs
  change (∑ j ∈ range (n+1), f j) ≤ _
  rw [hs]
  have hz : (∑ j ∈ range (n-i+1), f j) = 0 := by
    apply sum_eq_zero
    intro j hj
    have hj' := mem_range.mp hj
    simp [f,upperCell,cell,show ¬ n < i+j by omega]
  rw [hz,zero_add]
  calc
    _ ≤ ∑ j ∈ range i, recip i * recip (n-b) := by
      apply sum_le_sum
      intro j _
      dsimp [f,upperCell,cell]
      split_ifs
      · apply mul_le_mul_of_nonneg_left _ (by unfold recip; positivity)
        unfold recip
        apply inv_anti₀ (by exact_mod_cast (show 0 < n-b by omega))
        exact_mod_cast (show n-b ≤ n-i+1+j by omega)
      all_goals unfold recip; positivity
    _ ≤ _ := by
      rw [sum_const,card_range,nsmul_eq_mul]
      obtain rfl | hpos := Nat.eq_zero_or_pos i
      · simp [recip]
      · unfold recip
        rw [← mul_assoc, mul_inv_cancel₀ (by exact_mod_cast hpos.ne'),one_mul]

private theorem upper_rows_loss {b n : ℕ} (hb : b < n) :
    0 ≤ (∑ i ∈ range (n+1), upperRow n i) - pairSum recip b n ∧
    (∑ i ∈ range (n+1), upperRow n i) - pairSum recip b n ≤ (b+1:ℕ) * recip (n-b) := by
  rw [pairRows, ← sum_sub_distrib]
  have hnn (i : ℕ) : 0 ≤ upperRow n i := sum_nonneg fun j _ => upper_nonneg n i j
  constructor
  · exact sum_nonneg fun i _ => by split_ifs <;> simp [hnn]
  · have hs := sum_range_add (fun i => upperRow n i - (if b < i then upperRow n i else 0))
        (b+1) (n-b)
    rw [show b+1+(n-b)=n+1 by omega] at hs
    rw [hs]
    have hz : (∑ j ∈ range (n-b), (upperRow n (b+1+j) -
        (if b < b+1+j then upperRow n (b+1+j) else 0))) = 0 := by
      apply sum_eq_zero
      intro j _
      simp [show b < b+1+j by omega]
    rw [hz, add_zero]
    calc
      _ ≤ ∑ _i ∈ range (b+1), recip (n-b) := by
        apply sum_le_sum
        intro i hi
        have hi' := mem_range.mp hi
        simpa [show ¬ b < i by omega] using small_row (show i ≤ b by omega) hb
      _ = _ := by simp

private theorem diagonal_bounds {n : ℕ} (hn : 0 < n) :
    0 ≤ (∑ i ∈ range (n+1), cell n i i) ∧
    (∑ i ∈ range (n+1), cell n i i) ≤ ((n+1:ℕ):ℝ) * (2/(n:ℝ))^2 := by
  constructor
  · exact sum_nonneg fun i _ => by unfold cell recip; split_ifs <;> positivity
  · calc
      _ ≤ ∑ _i ∈ range (n+1), (2/(n:ℝ))^2 := by
        apply sum_le_sum
        intro i _
        dsimp only [cell]
        split_ifs with h
        · have hi : 0 < (i:ℝ) := by exact_mod_cast (show 0 < i by omega)
          have hn' : 0 < (n:ℝ) := by exact_mod_cast hn
          have hw : recip i ≤ 2/(n:ℝ) := by
            rw [recip,←one_div,div_le_div_iff₀ hi hn']
            have : (n:ℝ) ≤ (i:ℝ)+(i:ℝ) := by exact_mod_cast h.le
            linarith
          rw [←sq]
          exact pow_le_pow_left₀ (by unfold recip; positivity) hw _
        · positivity
      _ = _ := by simp

/-- Quantitative control of the strip erased by a lower cutoff and of
the diagonal erased when passing to distinct unordered pairs. -/
theorem triangle_bounds {b n : ℕ} (hb : b < n) :
    0 ≤ (∑ i ∈ range (n+1), recip i^2) - 2 * pairSum recip b n ∧
    (∑ i ∈ range (n+1), recip i^2) - 2 * pairSum recip b n ≤
      2*((b+1:ℕ):ℝ)*recip (n-b) + ((n+1:ℕ):ℝ) * (2/(n:ℝ))^2 := by
  rw [← ordered_eq,split_ordered]
  have h := upper_rows_loss hb
  have hd := diagonal_bounds (show 0 < n by omega)
  constructor <;> nlinarith [h.1,h.2,hd.1,hd.2]

/-- A moving lower cutoff o(N) has no effect on the triangular harmonic
mass. The input series is the classical Basel sum when S = π²/6. -/
theorem pair_limit (b N : ℕ → ℕ) (S : ℝ)
    (hN : Tendsto N atTop atTop)
    (hb : Tendsto (fun n => (b n:ℝ)/(N n:ℝ)) atTop (𝓝 0))
    (hs : HasSum (fun i => recip i^2) S) :
    Tendsto (fun n => pairSum recip (b n) (N n)) atTop (𝓝 (S/2)) := by
  have hNr : Tendsto (fun n => (N n:ℝ)) atTop atTop := tendsto_natCast_atTop_atTop.comp hN
  have hz : Tendsto (fun n => (N n:ℝ)⁻¹) atTop (𝓝 0) := tendsto_inv_atTop_zero.comp hNr
  have safe : ∀ᶠ n in atTop, b n < N n := by
    filter_upwards [hN.eventually (eventually_ge_atTop 1), hb.eventually_lt_const zero_lt_one]
      with n hn hr
    have hpos : 0 < (N n:ℝ) := by exact_mod_cast (show 0 < N n by omega)
    exact_mod_cast (div_lt_one hpos).mp hr
  have herr1 : Tendsto (fun n => ((b n+1:ℕ):ℝ)*recip (N n-b n)) atTop (𝓝 0) := by
    have h := (hb.add hz).div (tendsto_const_nhds.sub hb) (by norm_num : (1:ℝ)-0 ≠ 0)
    simp only [zero_add,sub_zero,zero_div] at h
    apply h.congr'
    filter_upwards [safe] with n hn
    have lt' : (b n:ℝ) < (N n:ℝ) := by exact_mod_cast hn
    have Np : 0 < (N n:ℝ) := lt_of_le_of_lt (Nat.cast_nonneg _) lt'
    have hne : 1-(b n:ℝ)/(N n:ℝ) ≠ 0 := ne_of_gt (sub_pos.mpr ((div_lt_one Np).mpr lt'))
    dsimp [recip]
    rw [Nat.cast_sub hn.le, Nat.cast_add, Nat.cast_one]
    field_simp [Np.ne', hne, ne_of_gt (sub_pos.mpr lt')]
  have herr2 : Tendsto (fun n => ((N n+1:ℕ):ℝ)*(2/(N n:ℝ))^2) atTop (𝓝 0) := by
    have h := (hz.add (hz.pow 2)).const_mul 4
    norm_num at h
    apply h.congr'
    filter_upwards [safe] with n hn
    push_cast
    field_simp [show (N n:ℝ) ≠ 0 by exact_mod_cast (show N n ≠ 0 by omega)]
    ring
  have hplus : Tendsto (fun n => N n+1) atTop atTop :=
    tendsto_atTop_mono' atTop (.of_forall fun n => Nat.le_succ _) hN
  have hm := hs.tendsto_sum_nat.comp hplus
  have e := (herr1.const_mul 2).add herr2
  simp only [mul_zero, zero_add] at e
  have hd : Tendsto (fun n => (∑ i ∈ range (N n+1), recip i^2) - 2 * pairSum recip (b n) (N n))
      atTop (𝓝 0) := by
    apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds e
    · exact safe.mono fun _ h => (triangle_bounds h).1
    · exact safe.mono fun _ h => by simpa [mul_assoc] using (triangle_bounds h).2
  have h := (hm.sub hd).div_const 2
  simpa [Function.comp_def] using h

#print axioms pair_limit
end
end SizeTriangle



