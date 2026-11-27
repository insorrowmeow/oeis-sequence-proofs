import Init.Data.Nat.Bitwise.Lemmas
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.LinearCombination

namespace Rule150Digits

/-- Every bit set in the column is also set in the row. -/
def Submask (j m : ℕ) : Prop :=
  ∀ i, j.testBit i = true → m.testBit i = true

private theorem singleton_mask (m i : ℕ) :
    Submask (2^i) m ↔ m.testBit i = true := by
  constructor
  · intro h
    exact h i Nat.testBit_two_pow_self
  · intro h k hk
    simp [Nat.testBit_two_pow] at hk
    simpa [← hk] using h

private theorem top_bit {m : ℕ} (hm : m ≠ 0) : m.testBit m.log2 = true := by
  have h₁ := Nat.log2_self_le hm
  have h₂ := Nat.lt_log2_self (n := m)
  rw [pow_succ] at h₂
  have hl : m - 2^m.log2 < 2^m.log2 := by omega
  have h := Nat.testBit_two_pow_add_eq (m - 2^m.log2) m.log2
  rw [Nat.testBit_lt_two_pow hl] at h
  simpa [Nat.add_sub_of_le h₁] using h

private theorem from_bits {m : ℕ} (h : ∀ i ≤ m.log2, m.testBit i = true) :
    m = 2^(m.log2+1)-1 := by
  apply Nat.eq_of_testBit_eq
  intro i
  rw [Nat.testBit_two_pow_sub_one]
  by_cases hi : i ≤ m.log2
  · simpa [show i < m.log2+1 by omega] using h i hi
  · have hlo : m < 2^i := lt_of_lt_of_le Nat.lt_log2_self
        (Nat.pow_le_pow_right (by decide) (by omega))
    simp [Nat.testBit_lt_two_pow hlo, show ¬i < m.log2+1 by omega]

/-- If multiplication by three on residues preserves the submask support,
    the low bit propagates upwards. This is the unit case for Rule 150. -/
theorem invariant_support {m : ℕ} (hm : 1 < m) (hodd : m%2 = 1)
    (hinv : ∀ j, 0 < j → j < m → Submask j m → Submask ((3*j)%m) m) :
    m = 2^(m.log2+1)-1 := by
  apply from_bits
  intro i hi
  induction i with
  | zero => simpa using hodd
  | succ i ih =>
    obtain htop | hlow : i+1 = m.log2 ∨ i+1 < m.log2 := by omega
    · rw [htop]
      exact top_bit (by omega)
    have hpow : (2:ℕ)^(i+2) ≤ m := le_trans
      (Nat.pow_le_pow_right (by decide) (by omega)) (Nat.log2_self_le (by omega))
    have hpos : 0 < (2:ℕ)^i := Nat.two_pow_pos i
    have h3 : 3*2^i < m := by simp [pow_succ] at hpow; omega
    have hmask := hinv (2^i) hpos (by omega) ((singleton_mask m i).mpr (ih (by omega)))
    rw [Nat.mod_eq_of_lt h3] at hmask
    apply hmask
    rw [Nat.mul_comm, Nat.testBit_two_pow_mul]
    simpa using (by decide : Nat.testBit 3 1 = true)

private theorem preceding_mask {m : ℕ} (hodd : m%2 = 1) : Submask (m-1) m := by
  intro i hi
  cases i with
  | zero => simpa using hodd
  | succ i =>
    rw [Nat.testBit_succ] at hi ⊢
    rwa [show (m-1)/2 = m/2 by omega] at hi

private theorem nonzero_power_mod_three (i : ℕ) : 2^i % 3 ≠ 0 := by
  induction i with
  | zero => decide
  | succ i ih =>
    rw [pow_succ, Nat.mul_mod]
    have := Nat.mod_lt (2^i) (by decide : 0 < 3)
    omega

/-- The coefficient recurrence from annihilation by Rule 150 forces period 3. -/
theorem kernel_period (D : ℕ → ZMod 2)
    (h : ∀ j, D j + D (j+1) + D (j+2) = 0) (i : ℕ) : D (i+3) = D i := by
  linear_combination h (i+1) - h i

theorem residue_value {D : ℕ → ZMod 2} (h : ∀ i, D (i+3) = D i) (j : ℕ) :
    D j = D (j%3) := by
  induction j using Nat.strong_induction_on with
  | h j ih =>
    by_cases hj : j < 3
    · rw [Nat.mod_eq_of_lt hj]
    · have he : j = j-3+3 := by omega
      calc
        D j = D (j-3) := by simpa [← he] using h (j-3)
        _ = D ((j-3)%3) := ih (j-3) (by omega)
        _ = D (j%3) := by congr 1; omega

/-- For a multiple of three, outside the zero residue class D equals the
    submask coefficient. The recurrence alone then forces a Mersenne width. -/
theorem singular_support {m : ℕ} (hm : 1 < m) (hodd : m%2 = 1) (hthree : m%3 = 0)
    (D : ℕ → ZMod 2) (hkernel : ∀ j, D j + D (j+1) + D (j+2) = 0)
    (hcoeff : ∀ j, j < m → j%3 ≠ 0 → (D j = 1 ↔ Submask j m)) :
    m = 2^(m.log2+1)-1 := by
  have hperiod := residue_value (kernel_period D hkernel)
  have h₁ : D 1 = 1 := (hcoeff 1 hm (by decide)).mpr (by
    simpa using (singleton_mask m 0).mpr (by simpa using hodd))
  have hpred : D (m-1) = 1 :=
    (hcoeff (m-1) (by omega) (by omega)).mpr (preceding_mask hodd)
  have h₂ : D 2 = 1 := by
    rw [hperiod,show (m-1)%3 = 2 by omega] at hpred
    exact hpred
  apply from_bits
  intro i hi
  obtain hlt | htop : i < m.log2 ∨ i = m.log2 := by omega
  · have hpow : (2:ℕ)^i < m := lt_of_lt_of_le
      (Nat.pow_lt_pow_right (by decide) hlt) (Nat.log2_self_le (by omega))
    have hn := nonzero_power_mod_three i
    have hres := Nat.mod_lt (2^i) (by decide : 0 < 3)
    apply (singleton_mask m i).mp
    apply (hcoeff (2^i) hpow hn).mp
    rw [hperiod]
    rcases (show 2^i%3 = 1 ∨ 2^i%3 = 2 by omega) with h | h <;> simp [h, h₁, h₂]
  · rw [htop]
    exact top_bit (by omega)

end Rule150Digits
