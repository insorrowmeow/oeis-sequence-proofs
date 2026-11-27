import Mathlib.Data.Nat.Choose.Sum
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp

/-! Soundness of the exact power-to-Bernstein coefficient test used in
`verify_equal_area.py`. Coefficients are arbitrary real numbers and the
degree parameter may exceed the actual degree. -/

namespace ZanelloBernstein

open Finset

noncomputable section

def basis (D k : ℕ) (u : ℝ) : ℝ := (D.choose k : ℝ) * u^k * (1-u)^(D-k)

def control (D : ℕ) (p : ℕ → ℝ) (k : ℕ) : ℝ :=
  ∑ j ∈ range (k+1), p j * ((k.choose j : ℝ) / D.choose j)

theorem partition_of_unity (D : ℕ) (u : ℝ) :
    ∑ k ∈ range (D+1), basis D k u = 1 := by
  simpa [basis, mul_comm, mul_left_comm, mul_assoc] using
    (add_pow u (1-u) D).symm

theorem monomial {D j : ℕ} (hj : j ≤ D) (u : ℝ) :
    ∑ k ∈ range (D+1), ((k.choose j : ℝ) / D.choose j) * basis D k u = u^j := by
  rw [show D+1 = j+(D-j+1) by omega, sum_range_add]
  have first : (∑ k ∈ range j, ((k.choose j : ℝ)/D.choose j) * basis D k u) = 0 := by
    apply sum_eq_zero
    intro k hk
    simp [Nat.choose_eq_zero_of_lt (mem_range.mp hk)]
  rw [first,zero_add]
  have tail : ∀ l ∈ range (D-j+1),
      (((j+l).choose j : ℝ)/D.choose j) * basis D (j+l) u =
      u^j * basis (D-j) l u := by
    intro l hl
    have hd : j+l ≤ D := by have := mem_range.mp hl; omega
    have den : (D.choose j : ℝ) ≠ 0 := by exact_mod_cast (Nat.choose_pos hj).ne'
    have C : ((j+l).choose j : ℝ) / D.choose j * D.choose (j+l) =
        ((D-j).choose l : ℝ) := by
      rw [div_mul_eq_mul_div, div_eq_iff den, mul_comm, mul_comm _ (D.choose j : ℝ)]
      exact_mod_cast (by simpa using (Nat.choose_mul hd (Nat.le_add_right j l)))
    simp only [basis]
    rw [show D-(j+l) = D-j-l by omega, pow_add]
    rw [← C]
    ring
  rw [sum_congr rfl tail, ← mul_sum, partition_of_unity, mul_one]

private theorem extend_control {D k : ℕ} (hk : k ≤ D) (p : ℕ → ℝ) :
    control D p k = ∑ j ∈ range (D+1), p j * ((k.choose j : ℝ)/D.choose j) := by
  apply sum_subset (range_mono (by omega))
  intro j _ hj
  have hkj : k < j := by simp at hj; omega
  simp [Nat.choose_eq_zero_of_lt hkj]

theorem conversion (D : ℕ) (p : ℕ → ℝ) (u : ℝ) :
    (∑ k ∈ range (D+1), control D p k * basis D k u) =
    ∑ j ∈ range (D+1), p j*u^j := by
  calc
    _ = ∑ k ∈ range (D+1), ∑ j ∈ range (D+1),
        p j * (((k.choose j : ℝ)/D.choose j) * basis D k u) := by
          apply sum_congr rfl
          intro k hk
          rw [extend_control (Nat.le_of_lt_succ (mem_range.mp hk)), sum_mul]
          simp only [mul_assoc]
    _ = ∑ j ∈ range (D+1), ∑ k ∈ range (D+1),
        p j * (((k.choose j : ℝ)/D.choose j) * basis D k u) := sum_comm
    _ = _ := by
      apply sum_congr rfl
      intro j hj
      rw [← mul_sum, monomial (Nat.le_of_lt_succ (mem_range.mp hj))]

theorem positive_if_controls_pos {D : ℕ} {p : ℕ → ℝ} {u : ℝ}
    (lo : 0 ≤ u) (hi : u ≤ 1) (controls : ∀ k ≤ D, 0 < control D p k) :
    0 < ∑ j ∈ range (D+1), p j*u^j := by
  rw [← conversion]
  have nonneg (k : ℕ) : 0 ≤ basis D k u :=
    mul_nonneg (mul_nonneg (Nat.cast_nonneg _) (pow_nonneg lo _)) (pow_nonneg (sub_nonneg.mpr hi) _)
  apply sum_pos' (fun k hk ↦ mul_nonneg (controls k (Nat.le_of_lt_succ (mem_range.mp hk))).le (nonneg k))
  rcases lt_or_eq_of_le hi with hu | rfl
  · refine ⟨0, by simp, mul_pos (controls _ (Nat.zero_le _)) ?_⟩
    simpa [basis] using pow_pos (sub_pos.mpr hu) D
  · exact ⟨D, by simp, by simpa [basis] using controls D le_rfl⟩

/-- Coefficients in the second variable after substituting width = C+z,
exactly as in the tail verifier. -/
def translated (D : ℕ) (p : ℕ → ℝ) (C : ℝ) (k : ℕ) : ℝ :=
  ∑ i ∈ range (D+1), p i * (C^(i-k) * i.choose k)

theorem translate_identity (D : ℕ) (p : ℕ → ℝ) (C z : ℝ) :
    (∑ k ∈ range (D+1), translated D p C k * z^k) =
      ∑ i ∈ range (D+1), p i*(C+z)^i := by
  calc
    _ = ∑ k ∈ range (D+1), ∑ i ∈ range (D+1), p i * (z^k*C^(i-k)*i.choose k) := by
      apply sum_congr rfl
      intro k _
      rw [translated, sum_mul]
      apply sum_congr rfl
      intro i _
      ring
    _ = ∑ i ∈ range (D+1), ∑ k ∈ range (D+1), p i * (z^k*C^(i-k)*i.choose k) := sum_comm
    _ = _ := by
      apply sum_congr rfl
      intro i hi
      rw [← mul_sum, add_comm C z, add_pow]
      congr 1
      symm
      apply sum_subset (range_mono (Nat.succ_le_succ (Nat.le_of_lt_succ (mem_range.mp hi))))
      intro k _ hk
      have hik : i < k := by simp at hk; omega
      simp [Nat.choose_eq_zero_of_lt hik]

/-- A strictly positive constant term and nonnegative remaining coefficients
after translation certify all widths at or above the cutoff C. -/
theorem positive_above_threshold {D : ℕ} {p : ℕ → ℝ} {C w : ℝ}
    (hw : C ≤ w) (constant : 0 < translated D p C 0)
    (others : ∀ k ≤ D, 0 ≤ translated D p C k) :
    0 < ∑ i ∈ range (D+1), p i * w^i := by
  have hz : 0 ≤ w-C := sub_nonneg.mpr hw
  rw [show w = C+(w-C) by ring, ← translate_identity]
  apply sum_pos' (fun k hk ↦ mul_nonneg (others k (Nat.le_of_lt_succ (mem_range.mp hk)))
                      (pow_nonneg hz k))
  exact ⟨0, by simp, by simpa using constant⟩

#print axioms positive_if_controls_pos
#print axioms positive_above_threshold

end
end ZanelloBernstein
