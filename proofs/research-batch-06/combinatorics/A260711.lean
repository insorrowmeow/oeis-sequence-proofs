import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Log
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace A260711

/-- A positive term of A080075 minus one. -/
def ProthPart (w : ℕ) : Prop :=
  ∃ m z : ℕ, 0 < m ∧ Odd z ∧ z < 2^m ∧ w = 2^m * z

/-- The conditions on the two squares in the positive part of A260711. -/
def Witness (x y : ℕ) : Prop :=
  0 < y ∧ y < x ∧ Odd x ∧ Odd y ∧ ∃ e : ℕ, x + y = 2^e

theorem witness_normal_form {x y : ℕ} (h : Witness x y) :
    ∃ m z : ℕ, 0 < m ∧ Odd z ∧ z < 2^m ∧
      x = 2^m + z ∧ y = 2^m - z ∧ x^2 - y^2 = 4 * (2^m * z) := by
  obtain ⟨hy, hxy, hxodd, ⟨b, hb⟩, e, he⟩ := h
  obtain _ | m := e
  · simp at he
    omega
  obtain _ | s := m
  · norm_num at he
    omega
  let t := 2^(s+1)
  have ht : t = 2*2^s := by simp [t, pow_succ, Nat.mul_comm]
  have hsum : x+y = 2*t := by simpa [t, pow_succ, Nat.mul_comm] using he
  have hyt : y < t := by omega
  have hodd : Odd (t-y) := by
    use 2^s-b-1
    omega
  refine ⟨s+1, t-y, by omega, hodd, ?_, ?_, ?_, ?_⟩
  · change t-y < t
    omega
  · change x = t + (t-y)
    omega
  · change y = t - (t-y)
    omega
  · change x^2 - y^2 = 4 * (t * (t-y))
    have hrem : t-y + y = t := Nat.sub_add_cancel hyt.le
    have hx : x = (t-y) + t := by omega
    have hpoly : x^2 = y^2 + 4*(t*(t-y)) := by
      rw [hx]
      nlinarith only [hrem, congrArg (fun a : ℕ => a^2) hrem]
    omega

theorem construct_witness {m z : ℕ} (hm : 0 < m) (hz : Odd z) (hzt : z < 2^m) :
    Witness (2^m + z) (2^m - z) ∧
      (2^m + z)^2 - (2^m - z)^2 = 4*(2^m*z) := by
  obtain ⟨b, hb⟩ := hz
  obtain _ | s := m
  · omega
  have ht : 2^(s+1) = 2*2^s := by rw [pow_succ, Nat.mul_comm]
  constructor
  · refine ⟨by omega, by omega, ⟨2^s+b, by omega⟩, ⟨2^s-b-1, by omega⟩,
      s+1+1, ?_⟩
    rw [pow_succ]
    omega
  · have hrem : 2^(s+1)-z + z = 2^(s+1) := Nat.sub_add_cancel hzt.le
    have hpoly : (2^(s+1)+z)^2 = (2^(s+1)-z)^2 + 4*(2^(s+1)*z) := by
      nlinarith only [hrem, congrArg (fun a : ℕ => a^2) hrem,
        congrArg (fun a : ℕ => a * z) hrem]
    omega

private theorem valuation {m z : ℕ} (h : Odd z) :
    (2^m*z).factorization 2 = m := by
  obtain ⟨q, hq⟩ := h
  have hz : z ≠ 0 := by omega
  have hn : ¬2 ∣ z := by omega
  simp [Nat.factorization_mul (pow_ne_zero m (by decide : (2:ℕ) ≠ 0)) hz,
    Nat.factorization_eq_zero_of_not_dvd hn, Nat.Prime.factorization_pow Nat.prime_two]

theorem unique_witness {x y X Y : ℕ} (h : Witness x y) (H : Witness X Y)
    (hs : x^2-y^2 = X^2-Y^2) : x = X ∧ y = Y := by
  obtain ⟨m,z,_,hz,_,hx,hy,he⟩ := witness_normal_form h
  obtain ⟨n,v,_,hv,_,hX,hY,hE⟩ := witness_normal_form H
  have hparts : 2^m*z = 2^n*v := by omega
  have heq : m = n := by
    rw [← valuation (m := m) hz, hparts, valuation hv]
  subst n
  have hzv : z = v := Nat.eq_of_mul_eq_mul_left (by positivity) hparts
  exact ⟨by simp [hx, hX, hzv], by simp [hy, hY, hzv]⟩

/-- Inside each interval between successive powers of four, precisely the
    multiples of the prescribed power of two occur. This certifies the sorted blocks. -/
theorem block {s w : ℕ} (hl : (2^s)^2 ≤ w) (hu : w < (2^(s+1))^2) :
    ProthPart w ↔ 2^(s+1) ∣ w := by
  constructor
  · rintro ⟨m,z,_,_,hz,rfl⟩
    have hm : s+1 ≤ m := by
      by_contra! h
      have hle : (2:ℕ)^m ≤ 2^s := Nat.pow_le_pow_right (by decide) (by omega)
      have hlt : 2^m*z < (2^m)^2 := by simpa [pow_two] using Nat.mul_lt_mul_of_pos_left hz (by positivity : 0 < (2:ℕ)^m)
      exact (not_lt_of_ge hl) (lt_of_lt_of_le hlt (Nat.pow_le_pow_left hle 2))
    exact dvd_mul_of_dvd_left (pow_dvd_pow 2 hm) _
  · rintro ⟨u, rfl⟩
    have hp : 0 < (2:ℕ)^(s+1) := by positivity
    have hu0 : u ≠ 0 := by
      rintro rfl
      simp at hl
    obtain ⟨d,z,hz,hdecomp⟩ := Nat.exists_eq_two_pow_mul_odd hu0
    have hbound : u < 2^(s+1) := by
      rw [pow_two] at hu
      exact (Nat.mul_lt_mul_left hp).mp hu
    have hzu : z ≤ u := by
      rw [hdecomp]
      exact Nat.le_mul_of_pos_left _ (by positivity)
    have hstep : (2:ℕ)^(s+1) ≤ 2^(s+1+d) := Nat.pow_le_pow_right (by decide) (by omega)
    exact ⟨s+1+d,z,by omega,hz,lt_of_le_of_lt hzu (lt_of_lt_of_le hbound hstep),
      by rw [pow_add 2 (s+1) d,hdecomp,Nat.mul_assoc]⟩

/-- The formulas for the odd factor, the exponent and the two witnesses in
    both halves of every indexed block, with L = s + 1. -/
theorem indexed_parameters (s j r : ℕ) (hr : r < 2^s) :
    let c := 2^s+r
    let v := c.factorization 2
    let b₁ := c/2^v
    let b₂ := s+1+j+v
    let x := 2^b₂ + b₁
    let y := 2^b₂ - b₁
    Odd b₁ ∧ b₁ < 2^b₂ ∧ Witness x y ∧
      x^2-y^2 = 4*(2^(s+1+j)*c) := by
  dsimp only
  have hc : 2^s + r ≠ 0 := by positivity
  obtain ⟨d,z,hz,he⟩ := Nat.exists_eq_two_pow_mul_odd hc
  have hv : (2^s+r).factorization 2 = d := by rw [he, valuation hz]
  have hd : (2^s+r) / 2^d = z := by rw [he, Nat.mul_div_cancel_left _ (by positivity)]
  have hzc : z ≤ 2^s+r := by rw [he]; exact Nat.le_mul_of_pos_left _ (by positivity)
  have hbound : z < 2^(s+1+j+d) := by
    have hlow : z < 2^(s+1) := by rw [pow_succ]; omega
    exact lt_of_lt_of_le hlow (Nat.pow_le_pow_right (by decide) (by omega))
  rw [hv,hd]
  obtain ⟨hw,hv'⟩ := construct_witness (m := s+1+j+d) (by omega) hz hbound
  refine ⟨hz,hbound,hw,?_⟩
  rw [hv',he,pow_add 2 (s+1+j) d,Nat.mul_assoc]

/-- The floor-log term in the question, including the integer division by three. -/
theorem index_logarithms (s j r : ℕ) (hj : j ≤ 1) (hr : r < 2^s) :
    let N := (2+j)*2^s+r
    Nat.log 2 N = s+1 ∧ Nat.log 2 (2*N/3) = s+j := by
  dsimp only
  have hp : 0 < (2:ℕ)^s := by positivity
  obtain h | h : j = 0 ∨ j = 1 := by omega
  all_goals subst j
  all_goals constructor
  all_goals apply Nat.log_eq_of_pow_le_of_lt_pow <;> simp [pow_succ] <;> omega

end A260711
