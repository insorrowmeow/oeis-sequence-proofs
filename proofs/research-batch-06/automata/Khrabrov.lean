import automata.PeriodNecessity
import Mathlib.Data.Nat.Factorization.Basic

namespace Rule150Digits

/-- The single seed is the multiplicative identity, so row J is T^J. -/
def EventualPeriod (n p : ℕ) : Prop :=
  0 < p ∧ ∃ J : ℕ, (rule n)^(J+p) = (rule n)^J

def ExactPeriod (n p : ℕ) : Prop :=
  EventualPeriod n p ∧ ∀ d, EventualPeriod n d → p ≤ d

/-- At a shifted Mersenne width, row 2^s repeats after one width. -/
theorem shifted_mersenne_row (s k : ℕ) (hk : 0 < k) :
    let n := 2^s*(2^k-1)
    (rule n)^(2^s+n) = (rule n)^(2^s) := by
  dsimp only
  let n := 2^s*(2^k-1)
  have hkpos : 1 < (2:ℕ)^k := Nat.one_lt_two_pow hk.ne'
  have he : 2^s + n = 2^(s+k) := by
    dsimp [n]
    rw [pow_add,Nat.mul_sub_left_distrib]
    have heq := Nat.mul_le_mul_left (2^s) hkpos.le
    simp only [mul_one] at heq ⊢
    omega
  change (rule n)^(2^s+n) = (rule n)^(2^s)
  rw [he,rule_frobenius,rule_frobenius]
  have he' : (2:ZMod n)^(s+k) = 2^s := by
    have hc := congrArg (fun a : ℕ => (a : ZMod n)) he
    simpa only [Nat.cast_add,Nat.cast_pow,Nat.cast_ofNat,ZMod.natCast_self,add_zero] using hc.symm
  rw [he']

theorem shifted_mersenne_period (s k : ℕ) (hk : 0 < k) :
    EventualPeriod (2^s*(2^k-1)) (2^s*(2^k-1)) := by
  have hkpos : 1 < (2:ℕ)^k := Nat.one_lt_two_pow hk.ne'
  exact ⟨Nat.mul_pos (Nat.two_pow_pos _) (by omega),2^s,shifted_mersenne_row s k hk⟩

private theorem power_width (s : ℕ) : EventualPeriod (2^(s+1)) (2^s) := by
  refine ⟨Nat.two_pow_pos _,0,?_⟩
  simp only [zero_add,pow_zero,rule_frobenius]
  let n := 2^(s+1)
  have he : (2:ZMod n)^(s+1) = 0 := by
    rw [← Nat.cast_ofNat (R := ZMod n) (n := 2), ← Nat.cast_pow]
    exact ZMod.natCast_self n
  have hc : -(2:ZMod n)^s = 2^s := by
    apply neg_eq_iff_add_eq_zero.mpr
    rwa [← two_mul,← pow_succ'] 
  change point n (-(2:ZMod n)^s) + 1 + point n (2^s) = 1
  rw [hc,add_right_comm]
  have hcancel (z : ZMod n) : point n z + point n z = 0 := by
    change Finsupp.single z 1 + Finsupp.single z 1 = (0 : ZMod n →₀ ZMod 2)
    rw [← Finsupp.single_add,show (1:ZMod 2)+1=0 by decide,Finsupp.single_zero]
  simp [hcancel]

private theorem triple_width (s : ℕ) : EventualPeriod (2^s*3) (2^s) := by
  let n := 2^s*3
  refine ⟨Nat.two_pow_pos _,2^s,?_⟩
  rw [show 2^s + 2^s = 2^(s+1) by rw [pow_succ]; omega, rule_frobenius,rule_frobenius]
  have he : (2:ZMod n)^s * 3 = 0 := by
    have h : ((2^s*3 : ℕ) : ZMod n) = 0 := ZMod.natCast_self n
    push_cast at h
    exact h
  have h : (2:ZMod n)^(s+1) = -(2^s) := by
    apply eq_neg_iff_add_eq_zero.mpr
    rw [pow_succ]
    linear_combination he
  change point n (-(2:ZMod n)^(s+1))+1+point n (2^(s+1)) = _
  rw [h,neg_neg]
  abel

/-- Binary run form forced by equality of the single-seed period and width. -/
theorem exact_width_shape {n : ℕ} (hn : 3 ≤ n) (h : ExactPeriod n n) :
    ∃ s k : ℕ, 3 ≤ k ∧ n = 2^s * (2^k-1) := by
  obtain ⟨s,m,hm,he⟩ := Nat.exists_eq_two_pow_mul_odd (by omega : n ≠ 0)
  obtain ⟨b,hb⟩ := hm
  have hm₁ : 1 < m := by
    by_contra! hsmall
    have hone : m=1 := by omega
    rw [hone,Nat.mul_one] at he
    subst n
    cases s with
    | zero => norm_num at hn
    | succ a =>
      have H := h.2 _ (power_width a)
      rw [pow_succ] at H
      have := Nat.two_pow_pos a
      omega
  have hm₃ : m ≠ 3 := by
    intro h3
    rw [h3] at he
    subst n
    have H := h.2 _ (triple_width s)
    have := Nat.two_pow_pos s
    omega
  obtain ⟨_,J,hJ⟩ := h.1
  subst n
  have hM := mersenne_of_eventual_repeat hm₁ (by omega) hJ
  refine ⟨s,m.log2+1,?_,congrArg (fun t : ℕ => 2^s*t) hM⟩
  by_contra! hlow
  have : m.log2=0 ∨ m.log2=1 := by omega
  obtain hlow|hlow := this <;> rw [hlow] at hM <;> norm_num at hM <;> omega

private theorem six_bits (i : ℕ) : Nat.testBit 6 i = decide (i=1 ∨ i=2) := by
  by_cases h : i ≤ 2
  · interval_cases i <;> decide
  · have hlo : (6:ℕ) < 2^i := lt_of_lt_of_le (by decide : 6 < 2^3)
        (Nat.pow_le_pow_right (by decide) (by omega))
    simp [Nat.testBit_lt_two_pow hlo,show i≠1 by omega,show i≠2 by omega]

private theorem mersenne_xor (k : ℕ) :
    let v := 2^(k+3)-1
    7*v = (v ^^^ (2*v) ^^^ (8*v)) := by
  dsimp only
  let low := 2^3*(2^k-1)+1
  have hp := Nat.two_pow_pos k
  have hsplit : 7*(2^(k+3)-1) = 2^(k+3)*6+low := by
    simp [low,pow_add]
    omega
  have hl : low < 2^(k+3) := by simp [low,pow_add]; omega
  apply Nat.eq_of_testBit_eq
  intro i
  rw [hsplit,Nat.testBit_two_pow_mul_add 6 hl]
  have hone : Nat.testBit 1 i = decide (i=0) := by
    simpa [eq_comm] using (Nat.testBit_two_pow (n:=0) (m:=i))
  have hmul (x : ℕ) : (2*x).testBit i = (decide (i≥1) && x.testBit (i-1)) :=
    Nat.testBit_two_pow_mul (i:=1)
  have h8 (x : ℕ) : (8*x).testBit i = (decide (i≥3) && x.testBit (i-3)) :=
    Nat.testBit_two_pow_mul (i:=3)
  simp only [low,Nat.testBit_two_pow_mul_add _ (by decide : (1:ℕ)<2^3),six_bits,
    Nat.testBit_xor,hmul,h8,Nat.testBit_two_pow_sub_one,hone]
  rcases (show i = 0 ∨ i = 1 ∨ i = 2 ∨ (3 ≤ i ∧ i < k + 3) ∨ i = k + 3 ∨
      i = k + 4 ∨ i = k + 5 ∨ k + 5 < i by omega) with h|h|h|h|h|h|h|h <;>
      simp (disch := omega) [*]
  · simp [show ¬ i < 3 by omega, show i - 3 < k by omega, show 1 ≤ i by omega,
      show i - 1 < k + 3 by omega, show i - 3 < k + 3 by omega]
  · simp [show ¬ i < k + 3 by omega, show i - (k+3) ≠ 1 by omega,
      show i - (k+3) ≠ 2 by omega, show ¬ i - 1 < k + 3 by omega,
      show ¬ i - 3 < k + 3 by omega]

private theorem shifted_xor (a b s : ℕ) : (2^s*a) ^^^ (2^s*b) = 2^s*(a ^^^ b) := by
  simpa [Nat.shiftLeft_eq, Nat.mul_comm] using (Nat.shiftLeft_xor_distrib (a:=a) (b:=b) (i:=s)).symm

/-- Khrabrov's implication in OEIS A085588, with A115770 stated by its original
    arithmetic/XOR definition. -/
theorem khrabrov {n : ℕ} (hn : 3 ≤ n) (h : ExactPeriod n n) :
    7*n = (n ^^^ (2*n) ^^^ (8*n)) := by
  obtain ⟨s,k,hk,he⟩ := exact_width_shape hn h
  obtain ⟨t,ht⟩ := Nat.exists_eq_add_of_le hk
  rw [show k=t+3 by omega] at he
  rw [he]
  let v := 2^(t+3)-1
  change 7*(2^s*v) = (2^s*v ^^^ (2*(2^s*v)) ^^^ (8*(2^s*v)))
  rw [Nat.mul_left_comm 2 (2^s), Nat.mul_left_comm 8 (2^s), shifted_xor,shifted_xor,
    Nat.mul_left_comm 7 (2^s),mersenne_xor t]

end Rule150Digits
