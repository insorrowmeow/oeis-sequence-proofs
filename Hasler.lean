import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.GeomSum
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

open Finset
namespace Hasler

def digits (b : ℕ) : ℕ := ∑ j ∈ range b, j*b^j
def A (n : ℕ) : ℕ := ∑ b ∈ range (n+2), digits b

private def W {R : Type*} [CommRing R] (x : R) (k : ℕ) : R :=
  ∑ j ∈ range k, (j : R)*x^j

private theorem weighted {R : Type*} [CommRing R] (x : R) (k : ℕ) :
    (x-1)^2 * W x k = x^k * ((k:R)*(x-1)-x) + x := by
  induction k with
  | zero => simp [W]
  | succ k ih =>
    rw [show W x (k+1) = W x k + (k:R)*x^k from sum_range_succ ..,
      mul_add, ih, pow_succ, Nat.cast_succ]
    ring

private theorem weighted_one {R : Type*} [CommRing R] (k : ℕ) :
    (2:R) * W (1:R) k = (k:R)*((k:R)-1) := by
  induction k with
  | zero => simp [W]
  | succ k ih =>
    rw [show W (1:R) (k+1) = W 1 k + (k:R)*1^k from sum_range_succ ..,
      mul_add, ih, Nat.cast_succ]
    ring

variable {p : ℕ} [Fact p.Prime]

private theorem cast_digits (hp : 5 ≤ p) (b : ℕ) :
    (digits b : ZMod p) =
    (b : ZMod p) / ((b : ZMod p) - 1)^2 * (((b : ZMod p)-2)*(b : ZMod p)^b+1) := by
  let a := (b : ZMod p)
  have hc : (digits b : ZMod p) = W a b := by simp [digits, W, a]
  rw [hc]
  change W a b = a/(a-1)^2*((a-2)*a^b+1)
  by_cases h1 : a=1
  · rw [h1]
    have h := weighted_one (R:=ZMod p) b
    change (2 : ZMod p)*W 1 b = a*(a-1) at h
    rw [h1] at h
    have two : (2 : ZMod p) ≠ 0 :=
      fun z => Nat.not_dvd_of_pos_of_lt (by decide) (by omega : 2 < p)
        ((ZMod.natCast_zmod_eq_zero_iff_dvd 2 p).mp z)
    simpa [two] using h
  · have h := weighted a b
    change (a-1)^2*W a b = a^b*(a*(a-1)-a)+a at h
    field_simp [sub_ne_zero.mpr h1]
    linear_combination h

private theorem dperiod (hp : 5 ≤ p) (b : ℕ) :
    (digits (b+p*(p-1)) : ZMod p) = digits b := by
  rw [cast_digits hp, cast_digits hp]
  simp only [Nat.cast_add, Nat.cast_mul, ZMod.natCast_self, zero_mul, add_zero]
  by_cases h : (b : ZMod p) = 0
  · simp [h]
  · rw [pow_add, Nat.mul_comm p (p-1), pow_mul, ZMod.pow_card_sub_one_eq_one h]
    simp

private theorem strip (hp : 5 ≤ p) (i : ℕ) :
    ∑ j ∈ range (p-1), (digits (p*j+i) : ZMod p) =
      -(i : ZMod p)/((i : ZMod p)-1)^2 := by
  let a := (i : ZMod p)
  let c := a/(a-1)^2
  have each (j : ℕ) : (digits (p*j+i) : ZMod p) =
      c*((a-2)*a^i)*a^j + c := by
    rw [cast_digits hp]
    simp only [Nat.cast_add,Nat.cast_mul,ZMod.natCast_self,zero_mul,zero_add,pow_add,pow_mul,ZMod.pow_card]
    dsimp [a,c]
    ring
  simp_rw [each]
  rw [sum_add_distrib, ← mul_sum, sum_const, card_range, nsmul_eq_mul]
  have pm : ((p-1:ℕ) : ZMod p) = -1 := by
    rw [Nat.cast_sub (by omega), ZMod.natCast_self, Nat.cast_one, zero_sub]
  rw [pm]
  change c*((a-2)*a^i) * _ + -1*c = -a/(a-1)^2
  by_cases h0 : a=0
  · simp [c,h0]
  by_cases h1 : a=1
  · simp [c,h1]
  have h := geom_sum_mul a (p-1)
  rw [ZMod.pow_card_sub_one_eq_one h0, sub_self] at h
  have hz := (mul_eq_zero.mp h).resolve_right (sub_ne_zero.mpr h1)
  simp [hz,c,neg_div]

private theorem block_partition {R : Type*} [AddCommMonoid R] (f : ℕ → R) (r k : ℕ) :
    ∑ b ∈ range (r*k), f b = ∑ j ∈ range k, ∑ i ∈ range r, f (r*j+i) := by
  induction k with
  | zero => simp
  | succ k ih => rw [Nat.mul_succ, sum_range_add, ih, sum_range_succ]

private theorem sum_residues (f : ZMod p → ZMod p) :
    ∑ i ∈ range p, f (i : ZMod p) = ∑ x : ZMod p, f x := by
  rw [← Fin.sum_univ_eq_sum_range]
  have conv (i : Fin p) : ((i:ℕ) : ZMod p) = (ZMod.finEquiv p) i := by
    cases p with
    | zero => exact Fin.elim0 i
    | succ k => exact Fin.ext (Nat.mod_eq_of_lt i.isLt)
  simpa [conv] using (ZMod.finEquiv p).toEquiv.sum_comp f

private theorem drift (hp : 5 ≤ p) :
    ∑ b ∈ range (p*(p-1)), (digits b : ZMod p) = 0 := by
  rw [block_partition _ p (p-1), sum_comm]
  simp_rw [strip hp]
  rw [sum_residues (fun x : ZMod p => -x/(x-1)^2)]
  let e : ZMod p ≃ ZMod p := (Equiv.addRight (-1)).trans (Equiv.inv (ZMod p))
  have piece (x : ZMod p) : -x/(x-1)^2 = -(e x + (e x)^2) := by
    change -x/(x-1)^2 = -((x+ -1)⁻¹ + ((x+ -1)⁻¹)^2)
    rw [← sub_eq_add_neg]
    by_cases h : x=1
    · simp [h]
    · field_simp [sub_ne_zero.mpr h]
      ring
  simp_rw [piece]
  rw [sum_neg_distrib, e.sum_comp (fun x => x+x^2), sum_add_distrib]
  have h1 := FiniteField.sum_pow_lt_card_sub_one (ZMod p) 1
    (by rw [ZMod.card]; omega)
  have h2 := FiniteField.sum_pow_lt_card_sub_one (ZMod p) 2
    (by rw [ZMod.card]; omega)
  simp only [pow_one] at h1
  rw [h1,h2,add_zero,neg_zero]

theorem hasler_period (hp : 5 ≤ p) (n : ℕ) :
    (A (n+p*(p-1)) : ZMod p) = (A n : ZMod p) := by
  simp only [A, Nat.cast_sum]
  rw [show n+p*(p-1)+2 = p*(p-1)+(n+2) by omega, sum_range_add, drift hp, zero_add]
  apply sum_congr rfl
  intro i _
  rw [Nat.add_comm]
  exact dperiod hp i

private theorem step_A (n : ℕ) : A (n+1) = A n + digits (n+2) := sum_range_succ ..

private theorem diff_shift {h : ℕ} (period : ∀ n, (A (n+h) : ZMod p) = A n)
    (b : ℕ) (hb : 2 ≤ b) : (digits (b+h) : ZMod p) = digits b := by
  let n := b-2
  have e : n+2=b := by dsimp [n]; omega
  have t := period (n+1)
  rw [show n+1+h = (n+h)+1 by omega, step_A, step_A, Nat.cast_add, Nat.cast_add,
      period n, add_right_inj] at t
  simpa [show n+h+2 = b+h by omega,e] using t

private theorem diff_mult {h : ℕ} (period : ∀ n, (A (n+h) : ZMod p) = A n)
    (b : ℕ) (hb : 2 ≤ b) (k : ℕ) : (digits (b+h*k) : ZMod p) = digits b := by
  induction k with
  | zero => simp
  | succ k ih => rw [Nat.mul_succ,←Nat.add_assoc,diff_shift period _ (by omega),ih]

private theorem char_nonzero {a : ℕ} (hz : 0<a) (hlt : a<p) : (a : ZMod p) ≠ 0 :=
  fun he => Nat.not_dvd_of_pos_of_lt hz hlt ((ZMod.natCast_zmod_eq_zero_iff_dvd a p).mp he)

private theorem dvd_shift (hp : 5 ≤ p) {h : ℕ}
    (period : ∀ n, (A (n+h) : ZMod p) = A n) : p ∣ h := by
  by_contra hn
  have hh : (h : ZMod p) ≠ 0 := fun z => hn ((ZMod.natCast_zmod_eq_zero_iff_dvd h p).mp z)
  let k := ((h : ZMod p)⁻¹).val
  let b := p*(p-1)
  let b' := b+h*((p-1)*k)
  have bp : 2 ≤ b := by dsimp [b]; nlinarith [Nat.sub_add_cancel (by omega : 1≤p)]
  have bc : (b:ZMod p) = 0 := by simp [b]
  have pm : ((p-1:ℕ) : ZMod p) = -1 := by
    simp [Nat.cast_sub (by omega : 1 ≤ p), ZMod.natCast_self]
  have b'c : (b':ZMod p) = -1 := by
    dsimp [b']
    rw [Nat.cast_add,bc,zero_add,Nat.cast_mul,Nat.cast_mul,pm]
    dsimp [k]
    rw [ZMod.natCast_zmod_val]
    simp [hh]
  have form : b'=(p-1)*(p+h*k) := by dsimp [b',b]; ring
  have exp : (-1 : ZMod p)^b' = 1 := by
    rw [form,pow_mul,ZMod.pow_card_sub_one_eq_one (neg_ne_zero.mpr one_ne_zero),one_pow]
  have eqn : (digits b' : ZMod p) = digits b := diff_mult period b bp _
  rw [cast_digits hp,cast_digits hp,b'c,bc,exp] at eqn
  have two : (2 : ZMod p) ≠ 0 := char_nonzero (a:=2) (p:=p) (by decide) (by omega)
  have u : (-1:ZMod p)-1 ≠ 0 := fun he => two (by linear_combination -he)
  field_simp [u] at eqn
  exact two (by linear_combination eqn)

private theorem power_shift (hp : 5 ≤ p) {h : ℕ}
    (period : ∀ n, (A (n+h) : ZMod p) = A n)
    (a : ZMod p) (a0 : a≠0) (a1 : a≠1) (a2 : a≠2) : a^h=1 := by
  have hc := (ZMod.natCast_zmod_eq_zero_iff_dvd h p).mpr (dvd_shift hp period)
  let b := a.val+p
  have castb : (b : ZMod p) = a := by simp [b,ZMod.natCast_zmod_val]
  have d := diff_shift period b (by dsimp [b]; omega)
  rw [cast_digits hp,cast_digits hp,Nat.cast_add,hc,add_zero,castb,pow_add] at d
  field_simp [sub_ne_zero.mpr a1] at d
  exact ((d.resolve_right a0).resolve_right (sub_ne_zero.mpr a2))

theorem least_period_divides (hp : 5 ≤ p) {h : ℕ}
    (period : ∀ n, (A (n+h) : ZMod p) = A n) : p*(p-1) ∣ h := by
  have nz2 : (2 : ZMod p) ≠ 0 := char_nonzero (a:=2) (p:=p) (by decide) (by omega)
  have nz3 : (3 : ZMod p) ≠ 0 := char_nonzero (a:=3) (p:=p) (by decide) (by omega)
  have nz4 : (4 : ZMod p) ≠ 0 := char_nonzero (a:=4) (p:=p) (by decide) (by omega)
  have neg1 := power_shift hp period (-1) (neg_ne_zero.mpr one_ne_zero)
    (fun he => nz2 (by linear_combination -he)) (fun he => nz3 (by linear_combination -he))
  have neg2 := power_shift hp period (-2) (neg_ne_zero.mpr nz2)
    (fun he => nz3 (by linear_combination -he)) (fun he => nz4 (by linear_combination -he))
  rw [show (-2:ZMod p) = (-1)*2 by ring, mul_pow,neg1,one_mul] at neg2
  have units (x : (ZMod p)ˣ) : x^h=1 := by
    apply Units.ext
    change (x : ZMod p)^h=1
    by_cases x1 : (x : ZMod p)=1
    · simp [x1]
    by_cases x2 : (x : ZMod p)=2
    · simpa [x2] using neg2
    exact power_shift hp period _ x.ne_zero x1 x2
  have ph := (FiniteField.forall_pow_eq_one_iff (ZMod p) h).mp units
  rw [ZMod.card] at ph
  have cop : Nat.Coprime p (p-1) := by
    cases p with
    | zero => omega
    | succ k => simp [Nat.coprime_self_add_left]
  exact cop.mul_dvd_of_dvd_of_dvd (dvd_shift hp period) ph

private theorem end_digits (hp : 5≤p) : let P := p*(p-1)
    (digits (P+1) : ZMod p) = 0 ∧ (digits P : ZMod p) = 0 ∧
    (digits (P-1) : ZMod p) = -1 ∧ (digits (P-2) : ZMod p) = 0 := by
  let P := p*(p-1)
  have big : 4 ≤ P := by dsimp [P]; nlinarith [Nat.sub_add_cancel (by omega : 1 ≤ p)]
  have pc : (P : ZMod p) = 0 := by simp [P]
  have c1 : ((P-1:ℕ):ZMod p) = -1 := by rw [Nat.cast_sub (by omega),pc]; simp
  have c2 : ((P-2:ℕ):ZMod p) = -2 := by rw [Nat.cast_sub (by omega),pc]; simp
  have n2 : (2:ZMod p) ≠ 0 := char_nonzero (a:=2) (p:=p) (by decide) (by omega)
  have n3 : (3:ZMod p) ≠ 0 := char_nonzero (a:=3) (p:=p) (by decide) (by omega)
  have hpow (x : ZMod p) (h : x≠0) : x^P=1 := by
    dsimp [P]; rw [Nat.mul_comm, pow_mul, ZMod.pow_card_sub_one_eq_one h,one_pow]
  have m1 : (-1:ZMod p)^(P-1) * (-1) = 1 := by
    rw [←pow_succ, Nat.sub_add_cancel (by omega)]
    exact hpow _ (neg_ne_zero.mpr one_ne_zero)
  have m2 : (-2:ZMod p)^(P-2) * (-2)^2 = 1 := by
    rw [←pow_add, Nat.sub_add_cancel (by omega)]
    exact hpow _ (neg_ne_zero.mpr n2)
  change (digits (P+1) : ZMod p) = 0 ∧ (digits P : ZMod p) = 0 ∧
    (digits (P-1) : ZMod p) = -1 ∧ (digits (P-2) : ZMod p) = 0
  simp only [cast_digits hp, c1, c2, Nat.cast_add, pc, Nat.cast_one, zero_add]
  constructor
  · simp
  constructor
  · simp
  constructor
  · have denom : (-1:ZMod p)-1 ≠ 0 := fun he => n2 (by linear_combination -he)
    field_simp [denom]
    linear_combination -3*m1
  · have denom : (-2:ZMod p)-1 ≠ 0 := fun he => n3 (by linear_combination -he)
    field_simp [denom]
    linear_combination -2*m2

theorem period_end (hp : 5 ≤ p) : let P := p*(p-1)
    (A (P-4):ZMod p)=1 ∧ (A (P-3):ZMod p)=1 ∧
    (A (P-2):ZMod p)=0 ∧ (A (P-1):ZMod p)=0 ∧ (A P:ZMod p)=0 := by
  let P := p*(p-1)
  have big : 4 ≤ P := by dsimp [P]; nlinarith [Nat.sub_add_cancel (by omega : 1 ≤ p)]
  have hP : (A P:ZMod p)=0 := by
    have initial : A 0 = 0 := by decide
    have orig := hasler_period hp 0
    rw [Nat.zero_add, initial, Nat.cast_zero] at orig
    exact orig
  obtain ⟨d1,d2,d3,d4⟩ := end_digits hp
  change (digits (P+1):ZMod p)=0 at d1
  change (digits P:ZMod p)=0 at d2
  change (digits (P-1):ZMod p)=-1 at d3
  change (digits (P-2):ZMod p)=0 at d4
  have step (j : ℕ) : (A (j+1):ZMod p) = (A j:ZMod p)+(digits (j+2):ZMod p) := by
    rw [step_A,Nat.cast_add]
  have s1 := step (P-1)
  have s2 := step (P-2)
  have s3 := step (P-3)
  have s4 := step (P-4)
  rw [show P-1+1=P by omega,show P-1+2=P+1 by omega,hP,d1,add_zero] at s1
  rw [show P-2+1=P-1 by omega,show P-2+2=P by omega,←s1,d2,add_zero] at s2
  rw [show P-3+1=P-2 by omega,show P-3+2=P-1 by omega,←s2,d3] at s3
  have x3 : (A (P-3):ZMod p)=1 := by linear_combination -s3
  rw [show P-4+1=P-3 by omega,show P-4+2=P-2 by omega,x3,d4,add_zero] at s4
  exact ⟨s4.symm,x3,s2.symm,s1.symm,hP⟩

#print axioms hasler_period
#print axioms least_period_divides
#print axioms period_end

private theorem short_period {m : ℕ} (zero : (m : ZMod p)=0)
    (shift : ∀ x : ZMod p, ∑ j ∈ range m, (x+(j:ZMod p))*x^j = 0)
    (init : (A m : ZMod p)=A 0) (n : ℕ) : (A (n+m):ZMod p)=A n := by
  have per (b : ℕ) : (digits (b+m):ZMod p) = digits b := by
    simp only [digits, Nat.cast_sum, Nat.cast_mul, Nat.cast_pow, Nat.cast_add, zero, add_zero]
    rw [sum_range_add]
    apply add_eq_left.mpr
    have factor := congrArg (fun z : ZMod p => (b : ZMod p)^b*z) (shift b)
    simpa only [mul_sum, mul_zero, Nat.cast_add, pow_add, mul_left_comm, mul_assoc] using factor
  induction n with
  | zero => simpa using init
  | succ n ih =>
    rw [show n+1+m=n+m+1 by omega, step_A, step_A, Nat.cast_add, Nat.cast_add, ih,
      show n+m+2=n+2+m by omega, per]

theorem period_two (n : ℕ) : (A (n+8):ZMod 2)=A n :=
  short_period (by decide) (by decide) (by decide) n

theorem period_three (n : ℕ) : (A (n+9):ZMod 3)=A n :=
  short_period (by decide) (by decide) (by decide) n

private theorem finite_lower_bound {m h : ℕ}
    (test : ∀ r : Fin m, r.val ≠ 0 → ∃ j : Fin m, (A (j.val+r.val):ZMod p)≠A j.val)
    (hp : 0<h) (period : ∀ n, (A (n+h):ZMod p)=A n) : m≤h := by
  by_contra! lt
  obtain ⟨j,hj⟩ := test ⟨h,lt⟩ (Nat.ne_of_gt hp)
  exact hj (period j.val)

theorem minimal_two {h : ℕ} (hp : 0<h) (period : ∀ n, (A (n+h):ZMod 2)=A n) : 8≤h :=
  finite_lower_bound (by decide) hp period

theorem minimal_three {h : ℕ} (hp : 0<h) (period : ∀ n, (A (n+h):ZMod 3)=A n) : 9≤h :=
  finite_lower_bound (by decide) hp period

theorem tail_two : (A 4:ZMod 2)=1 ∧ (A 5:ZMod 2)=1 ∧ (A 6:ZMod 2)=0 ∧
    (A 7:ZMod 2)=0 ∧ (A 8:ZMod 2)=0 := by decide

theorem tail_three : (A 5:ZMod 3)=1 ∧ (A 6:ZMod 3)=1 ∧ (A 7:ZMod 3)=0 ∧
    (A 8:ZMod 3)=0 ∧ (A 9:ZMod 3)=0 := by decide

#print axioms period_two
#print axioms period_three
#print axioms minimal_two
#print axioms minimal_three
#print axioms tail_two
#print axioms tail_three

private def cycle (q : ℕ) : ℕ := if q=2 then 8 else if q=3 then 9 else q*(q-1)

private theorem cycle_properties (q : ℕ) (prime : q.Prime) :
    4 ≤ cycle q ∧ (∀ n, (A (n+cycle q):ZMod q)=A n) ∧ (A (cycle q-3):ZMod q)=1 := by
  by_cases two : q=2
  · subst q
    exact ⟨by decide, period_two, tail_two.2.1⟩
  by_cases three : q=3
  · subst q
    exact ⟨by decide, period_three, tail_three.2.1⟩
  have notfour : q ≠ 4 := fun eqn => (by decide : ¬Nat.Prime 4) (eqn ▸ prime)
  have ge := prime.two_le
  have large : 5 ≤ q := by omega
  letI : Fact q.Prime := ⟨prime⟩
  simp only [cycle, if_neg two, if_neg three]
  exact ⟨by nlinarith [Nat.sub_add_cancel (by omega : 1≤q)], hasler_period large,
    (period_end large).2.1⟩

theorem avoids_finite_prime_sets (S : Finset ℕ) (primes : ∀ q ∈ S, q.Prime) (B : ℕ) :
    ∃ n, B ≤ n ∧ ∀ q ∈ S, (A n : ZMod q) = 1 := by
  let M := (B+5)*(∏ q ∈ S, cycle q)
  have pos : 0 < ∏ q ∈ S, cycle q := by
    apply Finset.prod_pos
    intro q hq
    have big := (cycle_properties q (primes q hq)).1
    omega
  have large : B+5 ≤ M := Nat.le_mul_of_pos_right (B+5) pos
  refine ⟨M-3, by omega, ?_⟩
  intro q hq
  obtain ⟨qc,period,one⟩ := cycle_properties q (primes q hq)
  have hd : cycle q ∣ M := dvd_trans (Finset.dvd_prod_of_mem cycle hq) (dvd_mul_left _ _)
  obtain ⟨k,hk⟩ := hd
  cases k with
  | zero => simp at hk; omega
  | succ k =>
    have step (j : ℕ) : (A (cycle q-3+cycle q*j):ZMod q) = A (cycle q-3) := by
      induction j with
      | zero => simp
      | succ j ih => rw [Nat.mul_succ,←Nat.add_assoc,period,ih]
    rw [Nat.mul_succ] at hk
    rw [show M-3=cycle q-3+cycle q*k by omega, step, one]

#print axioms avoids_finite_prime_sets
end Hasler
