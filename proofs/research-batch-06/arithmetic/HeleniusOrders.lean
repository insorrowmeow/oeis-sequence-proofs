import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Algebra.Field.ZMod
import Mathlib.Algebra.CharP.Algebra
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-! Orders of the two reciprocal trinomials occurring in Helenius's period formulas. -/
namespace HeleniusOrders
open Polynomial

abbrev K := ZMod 3
abbrev P := Polynomial K

noncomputable def trinomial (n : ℕ) : P := X^n + (X+1)

private theorem mono (n : ℕ) (h : 1<n) : (trinomial n).Monic := by
  apply monic_X_pow_add
  rw [show (X+1 : P).degree = 1 by simpa using degree_X_add_C (1:K)]
  exact_mod_cast h

private theorem deg (n : ℕ) (h : 1<n) : (trinomial n).natDegree = n := by
  unfold trinomial
  rw [natDegree_add_eq_left_of_natDegree_lt, natDegree_X_pow]
  simpa [show (X+1:P).natDegree = 1 by simpa using natDegree_X_add_C (1:K)] using h

private theorem nt (n : ℕ) (h : 1<n) : Nontrivial (AdjoinRoot (trinomial n)) := by
  apply AdjoinRoot.nontrivial
  rw [degree_eq_natDegree (mono n h).ne_zero, deg n h]
  exact_mod_cast (by omega : n≠0)

private theorem root_rel (n : ℕ) : (AdjoinRoot.root (trinomial n))^n =
    -(AdjoinRoot.root (trinomial n)+1) := by
  apply eq_neg_of_add_eq_zero_left
  have h := AdjoinRoot.mk_self (f := trinomial n)
  change AdjoinRoot.mk (trinomial n) (X^n+(X+1)) = 0 at h
  simpa only [map_add, map_pow, map_one, AdjoinRoot.mk_X] using h

private theorem small_polynomial (n : ℕ) (hn : 1 < n) (g : P) (hg : g ≠ 0)
    (hd : g.natDegree < n) : AdjoinRoot.mk (trinomial n) g ≠ 0 :=
  AdjoinRoot.mk_ne_zero_of_natDegree_lt (mono n hn) hg (by rwa [deg n hn])

private theorem weighted_degree (a b : ℕ) :
    ((-(X+1) : P)^a * X^b).natDegree = a+b := by
  rw [natDegree_mul, natDegree_pow, natDegree_neg, natDegree_X_pow]
  · simp [show (X+1:P).natDegree = 1 by simpa using natDegree_X_add_C (1:K)]
  · exact pow_ne_zero _ (neg_ne_zero.mpr (by simpa using X_add_C_ne_zero (1:K)))
  · exact pow_ne_zero _ X_ne_zero

private theorem no_weighted_one (n a b : ℕ) (hn : 1<n) (hp : 0<a+b) (hd : a+b<n) :
    (-(AdjoinRoot.root (trinomial n)+1))^a * (AdjoinRoot.root (trinomial n))^b ≠ 1 := by
  let g : P := (-(X+1))^a * X^b - 1
  have D : g.natDegree = a+b := by
    change (_ - C (1:K)).natDegree = _
    rw [natDegree_sub_C, weighted_degree]
  have H := small_polynomial n hn g (ne_zero_of_natDegree_gt (D ▸ hp)) (D ▸ hd)
  simpa [g, sub_eq_zero] using H

private theorem no_weighted_power (n a b : ℕ) (hn : 1<n) (hb : 0 < b)
    (hab : b ≤ a) (ha : a < n) :
    (-(AdjoinRoot.root (trinomial n)+1))^a ≠ (AdjoinRoot.root (trinomial n))^b := by
  let g : P := (-(X+1))^a - X^b
  have hg : g ≠ 0 := by
    intro H
    have H' := congrArg (eval (0:K)) H
    simp [g, zero_pow hb.ne'] at H'
  have D : g.natDegree ≤ a := by
    apply (natDegree_sub_le _ _).trans
    rw [natDegree_pow, natDegree_neg, natDegree_X_pow,
      show (X+1:P).natDegree = 1 by simpa using natDegree_X_add_C (1:K), mul_one]
    exact max_le (le_refl _) hab
  have H := small_polynomial n hn g hg (D.trans_lt ha)
  simpa [g, sub_eq_zero] using H

private theorem plus_no_short_period (q m : ℕ) (hq : 2 ≤ q) (hm : 0 < m)
    (hbound : m < q*q) : (AdjoinRoot.root (trinomial (q+1)))^m ≠ 1 := by
  let y := AdjoinRoot.root (trinomial (q+1))
  let a := m/q
  let b := m%q
  have eqn : m = (q+1)*a+b-a := by
    have H := Nat.div_add_mod m q
    dsimp [a,b]
    rw [Nat.add_mul, one_mul]; omega
  have ha : a < q := (Nat.div_lt_iff_lt_mul (by omega)).mpr hbound
  have hb : b < q := Nat.mod_lt _ (by omega)
  have rel : y^(q+1) = -(y+1) := root_rel _
  change y^m ≠ 1
  intro done
  by_cases h : a ≤ b
  · have E : m = (q+1)*a+(b-a) := by omega
    rw [E, pow_add, pow_mul, rel] at done
    have hpos : 0 < a+(b-a) := by
      by_cases az : a=0
      · have mb : m=b := by simpa only [az, mul_zero, Nat.sub_zero, zero_add] using E
        simpa only [az, Nat.sub_zero, zero_add, ← mb] using hm
      · exact Nat.add_pos_left (Nat.pos_of_ne_zero az) _
    exact no_weighted_one (q+1) a (b-a) (by omega) hpos (by omega) done
  · have E : m+(a-b)=(q+1)*a := by
      have H := Nat.div_add_mod m q
      change q*a+b=m at H
      rw [Nat.add_mul, one_mul]; omega
    exact no_weighted_power (q+1) a (a-b) (by omega) (by omega) (by omega) (by omega)
      (by rw [← rel, ← pow_mul, ← E, pow_add, done, one_mul])

theorem cubic_order (k : ℕ) (hk : 0 < k) :
    let q := 3^k
    orderOf (AdjoinRoot.root (trinomial (q+1))) = q*q+q+1 := by
  let q := 3^k
  have hq : 3 ≤ q := by
    obtain ⟨k, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hk.ne'
    dsimp [q]
    rw [pow_succ]
    have : 0 < 3^k := Nat.pow_pos (by decide)
    omega
  let R := AdjoinRoot (trinomial (q+1))
  letI : Nontrivial R := nt _ (by omega)
  letI : CharP R 3 := charP_of_injective_algebraMap' K R 3
  let y : R := AdjoinRoot.root (trinomial (q+1))
  have rel : y^(q+1) + (y+1) = 0 := by rw [show y^(q+1) = -(y+1) from root_rel _]; ring
  have fr := congrArg (fun z : R => z^(3^k)) rel
  simp only [add_pow_char_pow, one_pow] at fr
  change (y^(q+1))^q + (y^q+1) = 0^q at fr
  rw [zero_pow (by omega : q ≠ 0)] at fr
  change orderOf y = q*q+q+1
  apply orderOf_eq_of_pow_and_pow_div_prime (by omega)
  · rw [show q*q+q+1 = (q+1)*q+1 by ring, pow_add, pow_one, pow_mul]
    have H : y^q*y = -(y+1) := by rw [← pow_succ, root_rel]
    linear_combination y*fr - H
  · intro p hp hpd
    apply plus_no_short_period q _ (by omega)
    · exact Nat.div_pos (Nat.le_of_dvd (by omega) hpd) hp.pos
    · have hp2 := hp.two_le
      apply (Nat.div_lt_iff_lt_mul hp.pos).mpr
      nlinarith [Nat.mul_le_mul_left (q*q) hp2, Nat.mul_le_mul (by omega : 2 ≤ q) hq]

theorem quadratic_order (k : ℕ) (hk : 0 < k) :
    let q := 3^k
    orderOf (AdjoinRoot.root (trinomial q)) = q*q-1 := by
  let q := 3^k
  have hq : 3 ≤ q := by
    obtain ⟨k, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hk.ne'
    dsimp [q]
    rw [pow_succ]
    have : 0 < 3^k := Nat.pow_pos (by decide)
    omega
  let R := AdjoinRoot (trinomial q)
  letI : Nontrivial R := nt _ (by omega)
  letI : CharP R 3 := charP_of_injective_algebraMap' K R 3
  let y : R := AdjoinRoot.root (trinomial q)
  have rel : y^q = -(y+1) := root_rel q
  have rel' : y^q+(y+1)=0 := by rw [rel]; ring
  have fr := congrArg (fun z : R => z^(3^k)) rel'
  simp only [add_pow_char_pow, one_pow] at fr
  change (y^q)^q+(y^q+1)=0^q at fr
  rw [zero_pow (by omega : q ≠ 0)] at fr
  have hu : IsUnit y := by
    apply isUnit_iff_exists_inv.mpr
    refine ⟨-(y^(q-1)+1), ?_⟩
    have H : y*y^(q-1)=y^q := by rw [← pow_succ', Nat.sub_add_cancel (by omega)]
    rw [mul_neg, mul_add, H, rel]; ring
  have Q : 0 < q*q := Nat.mul_pos (by omega) (by omega)
  have factor : q*q-1=(q-1)*(q+1) := by
    have H : q-1+1=q := by omega
    have H' : q*q-1+1=q*q := by omega
    nlinarith [congrArg (fun z : ℕ => z*q) H]
  change orderOf y = q*q-1
  apply orderOf_eq_of_pow_and_pow_div_prime (by rw [factor]; exact Nat.mul_pos (by omega) (by omega))
  · apply hu.mul_right_injective
    change y*y^(q*q-1)=y*1
    rw [← pow_succ', Nat.sub_add_cancel Q, pow_mul, mul_one]
    linear_combination fr-rel'
  · intro p hp hd
    have hp2 := hp.two_le
    rw [factor] at hd ⊢
    rcases hp.dvd_mul.mp hd with hm | hm
    · let u := (q-1)/p
      have H : p*u=q-1 := Nat.mul_div_cancel' hm
      have uPos : 0<u := Nat.div_pos (Nat.le_of_dvd (by omega) hm) hp.pos
      have small : u+u<q := by
        have hh : 2*u ≤ p*u := Nat.mul_le_mul_right u hp2
        omega
      rw [Nat.mul_comm (q-1), Nat.mul_div_assoc _ hm]
      change y^((q+1)*u) ≠ 1
      rw [Nat.add_mul, one_mul, pow_add, pow_mul, rel]
      exact no_weighted_one q u u (by omega) (Nat.add_pos_left uPos _) small
    · let v := (q+1)/p
      have H : p*v=q+1 := Nat.mul_div_cancel' hm
      have vPos : 0<v := Nat.div_pos (Nat.le_of_dvd (by omega) hm) hp.pos
      have vq : v≤q := by nlinarith [Nat.mul_le_mul_right v hp2]
      have V : v-1+1=v := by omega
      have W : q-v+v=q := by omega
      have Q' : q-1+1=q := by omega
      have E : (q-1)*v = q*(v-1)+(q-v) := by
        nlinarith [congrArg (fun z : ℕ => q*z) V, congrArg (fun z : ℕ => z*v) Q']
      rw [Nat.mul_div_assoc _ hm]
      change y^((q-1)*v) ≠ 1
      rw [E, pow_add, pow_mul, rel]
      exact no_weighted_one q (v-1) (q-v) (by omega) (by omega) (by omega)

#print axioms cubic_order
#print axioms quadratic_order

end HeleniusOrders
