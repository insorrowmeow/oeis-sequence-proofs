import arithmetic.HeleniusOrders
import arithmetic.MultinacciPeriods
import Mathlib.Algebra.Polynomial.Reverse
import Mathlib.Tactic.FinCases

namespace HeleniusPeriods

open Polynomial Finset MultinacciPeriods

abbrev F := ZMod 3
abbrev P := Polynomial F

private def red : (ZMod 9) →+* F := ZMod.castHom (by decide : 3 ∣ 9) F
private noncomputable def ch (n : ℕ) : P := (characteristic n).map red

private theorem ch_eq (n : ℕ) : ch n = X^n - ∑ i ∈ range n, X^i := by
  simp [ch, characteristic, Polynomial.map_sum]

private theorem zero_coeff (z : ZMod 9) (h : red z = 0) :
    (3 : ZMod 9) * ((z.val / 3 : ℕ) : ZMod 9) = z := by
  revert h
  fin_cases z <;> decide

private theorem kernel (r : Polynomial (ZMod 9)) (h : r.map red = 0) :
    ∃ s : Polynomial (ZMod 9), r = 3*s := by
  let s : Polynomial (ZMod 9) := ∑ i ∈ r.support, C (((r.coeff i).val/3 : ℕ) : ZMod 9) * X^i
  refine ⟨s, ?_⟩
  conv_lhs => rw [r.as_sum_support_C_mul_X_pow]
  simp only [s, mul_sum]
  apply sum_congr rfl
  intro i _
  have H := congrArg (fun p : P => p.coeff i) h
  have H' : red (r.coeff i) = 0 := by simpa using H
  have A := congrArg (C : ZMod 9 →+* Polynomial (ZMod 9)) (zero_coeff _ H')
  rw [map_mul, map_ofNat] at A
  rw [← A]
  ring

private theorem lift_period (n t : ℕ) (h : ch n ∣ X^t-1) :
    characteristic n ∣ X^(3*t)-1 := by
  let f : Polynomial (ZMod 9) := X^t-1
  let p := characteristic n
  let r := f %ₘ p
  have hm := characteristic_monic n
  have H : r.map red = 0 := by
    change (f %ₘ p).map red = 0
    rw [map_modByMonic red hm]
    apply (modByMonic_eq_zero_iff_dvd (hm.map red)).mpr
    simpa [ch,p,f] using h
  obtain ⟨s, hs⟩ := kernel r H
  let R := AdjoinRoot p
  let a : R := AdjoinRoot.root p
  let b : R := AdjoinRoot.mk p s
  have hf := congrArg (AdjoinRoot.mk p) (modByMonic_add_div f hm)
  change AdjoinRoot.mk p (r + p * (f /ₘ p)) = AdjoinRoot.mk p (X^t-1) at hf
  simp only [hs, map_add, map_mul, map_ofNat, AdjoinRoot.mk_self, zero_mul, add_zero,
    map_sub, map_pow, AdjoinRoot.mk_X, map_one] at hf
  have eqn : a^t = 1+3*b := by
    change 3*b = a^t-1 at hf
    linear_combination -hf
  have h9 : (9:R)=0 := by simpa using congrArg (algebraMap (ZMod 9) R) (show (9:ZMod 9)=0 by decide)
  apply AdjoinRoot.mk_eq_zero.mp
  change AdjoinRoot.mk p (X^(3*t)-1) = 0
  simp only [map_sub, map_pow, AdjoinRoot.mk_X, map_one]
  change a^(3*t)-1=0
  rw [Nat.mul_comm, pow_mul, eqn]
  linear_combination (b+3*b^2+3*b^3)*h9

private theorem refl_power (t : ℕ) : (X^t-1 : P).reverse = -(X^t-1) := by
  rw [reverse, show (X^t-1:P).natDegree=t by simpa using natDegree_X_pow_sub_C (r := (1:F)) (n:=t)]
  simp [reflect_sub, revAt_le]

private theorem reverse_dvd {f : P} {t : ℕ} (h : f ∣ X^t-1) :
    f.reverse ∣ X^t-1 := by
  obtain ⟨g,hg⟩ := h
  have H := congrArg Polynomial.reverse hg
  rw [refl_power, reverse_mul_of_domain] at H
  exact ⟨-g.reverse, by linear_combination -H⟩

private noncomputable def enlarged (n : ℕ) : P := X^(n+1)+(X^n+1)

private theorem enlarged_eq (n : ℕ) : enlarged n = (X-1)*ch n := by
  rw [ch_eq, mul_sub, mul_geom_sum, enlarged]
  have h3 : (3:P)=0 := CharP.cast_eq_zero P 3
  linear_combination X^n*h3

private theorem reverse_enlarged (n : ℕ) : (enlarged n).reverse = HeleniusOrders.trinomial (n+1) := by
  have dn : (enlarged n).natDegree=n+1 := by
    rw [enlarged, natDegree_add_eq_left_of_natDegree_lt, natDegree_X_pow]
    rw [show (X^n+1:P).natDegree=n by simpa using natDegree_add_C (p:=(X:P)^n) (a:=(1:F)), natDegree_X_pow]
    omega
  rw [reverse, dn, enlarged, HeleniusOrders.trinomial]
  simp only [reflect_add, reflect_monomial, reflect_one, revAt_le (Nat.le_refl _),
    revAt_le (Nat.le_succ _), Nat.sub_self, pow_zero, show n+1-n=1 by omega, pow_one]
  ring

private theorem reverse_tri (n : ℕ) (hn : 0<n) :
    (HeleniusOrders.trinomial (n+1)).reverse=enlarged n := by
  have d : (HeleniusOrders.trinomial (n+1)).natDegree=n+1 := by
    rw [HeleniusOrders.trinomial, natDegree_add_eq_left_of_natDegree_lt, natDegree_X_pow]
    simpa [show (X+1:P).natDegree = 1 by simpa using natDegree_X_add_C (1:F)] using hn
  rw [reverse, d, HeleniusOrders.trinomial, enlarged]
  rw [show X+(1:P) = X^1+1 by simp]
  simp only [reflect_add, reflect_monomial, reflect_one, revAt_le (Nat.le_refl _),
    revAt_le (show 1≤n+1 by omega), Nat.sub_self, pow_zero, Nat.add_one_sub_one]
  ring

private theorem same_period (n t : ℕ) (hn : 0<n) (h : (n:F) ≠ 1) :
    ch n ∣ X^t-1 ↔ HeleniusOrders.trinomial (n+1) ∣ X^t-1 := by
  have he : (ch n).eval 1 ≠ 0 := by
    simp [ch_eq, eval_finset_sum, sub_eq_zero, Ne.symm h]
  constructor
  · rintro ⟨g,hg⟩
    have H := congrArg (eval (1:F)) hg
    have hg0 : g.eval 1=0 := by simpa [he] using H.symm
    obtain ⟨u,hu⟩ := (dvd_iff_isRoot (p:=g) (a:=(1:F))).mpr hg0
    rw [← reverse_enlarged]
    apply reverse_dvd
    use u
    rw [hg, hu, enlarged_eq, map_one]
    ring
  · intro hf
    have H := reverse_dvd hf
    rw [reverse_tri n hn, enlarged_eq] at H
    exact dvd_trans (dvd_mul_left _ _) H

def Fundamental (n : ℕ) (s : ℕ → ℕ) : Prop :=
  (∀ i, i < n-1 → s i = 0) ∧ s (n-1)=1 ∧
  ∀ k, s (k+n) = digitalRoot (∑ i ∈ range n, s (k+i))

def IsEventualPeriod (s : ℕ → ℕ) (T : ℕ) : Prop := ∃ m, ∀ k, m ≤ k → s (k+T)=s k

private theorem bridge (n w T : ℕ) (hn : 2≤n) (h1 : (n:F)≠1) (hw : Nat.Coprime 3 w)
    (ord : orderOf (AdjoinRoot.root (HeleniusOrders.trinomial (n+1))) = w)
    (s : ℕ → ℕ) (hs : Fundamental n s) : IsEventualPeriod s T ↔ 3*w ∣ T := by
  obtain ⟨hz,ho,rec⟩ := hs
  rw [IsEventualPeriod, digital_period_iff n T hn s hz ho rec]
  have base (t : ℕ) : ch n ∣ X^t-1 ↔ w ∣ t := by
    rw [same_period n t (by omega) h1, ← AdjoinRoot.mk_eq_zero, ← ord, orderOf_dvd_iff_pow_eq_one]
    simp [sub_eq_zero]
  constructor
  · intro H
    apply hw.mul_dvd_of_dvd_of_dvd (period_divisible_by_three n T hn H)
    apply (base T).mp
    obtain ⟨g,hg⟩ := H
    use g.map red
    simpa [ch] using congrArg (Polynomial.map red) hg
  · rintro ⟨b,rfl⟩
    exact (lift_period n w ((base w).mpr dvd_rfl)).trans
      (pow_one_sub_dvd_pow_mul_sub_one X (3*w) b)

private theorem pow_props (k : ℕ) (hk : 0<k) : 3 ≤ 3^k ∧ 3 ∣ 3^k := by
  obtain ⟨j,rfl⟩ := Nat.exists_eq_succ_of_ne_zero hk.ne'
  rw [pow_succ]
  have h : 0 < 3^j := Nat.pow_pos (by decide)
  exact ⟨by omega, dvd_mul_left _ _⟩

/-- Every eventual period for order 3^k-1 is a multiple of 3((3^k)^2-1),
    and every such multiple is an eventual period. -/
theorem quadratic_period (k T : ℕ) (hk : 0<k) (s : ℕ → ℕ)
    (hs : Fundamental (3^k-1) s) :
    IsEventualPeriod s T ↔ 3*((3^k)*(3^k)-1) ∣ T := by
  let q := 3^k
  obtain ⟨hq,h3⟩ := pow_props k hk
  change 3≤q at hq
  change 3∣q at h3
  have hq0 : (q : F)=0 := (CharP.cast_eq_zero_iff F 3 q).mpr h3
  apply bridge (q-1) (q*q-1) T (by omega) _ _ _ s hs
  · rw [Nat.cast_sub (by omega), Nat.cast_one, hq0]
    decide
  · apply (Nat.Prime.coprime_iff_not_dvd (by decide : Nat.Prime 3)).mpr
    have H := dvd_mul_of_dvd_left h3 q
    have Q : 0<q*q := Nat.mul_pos (by omega) (by omega)
    omega
  · rw [Nat.sub_add_cancel (by omega : 1≤q)]
    exact HeleniusOrders.quadratic_order k hk

/-- Every eventual period for order 3^k is a multiple of 3((3^k)^2+3^k+1),
    and every such multiple is an eventual period. -/
theorem cubic_period (k T : ℕ) (hk : 0<k) (s : ℕ → ℕ)
    (hs : Fundamental (3^k) s) :
    IsEventualPeriod s T ↔ 3*((3^k)*(3^k)+3^k+1) ∣ T := by
  let q := 3^k
  obtain ⟨hq,h3⟩ := pow_props k hk
  change 3≤q at hq
  change 3∣q at h3
  have hq0 : (q:F)=0 := (CharP.cast_eq_zero_iff F 3 q).mpr h3
  apply bridge q (q*q+q+1) T (by omega) (by rw [hq0]; decide) _ (HeleniusOrders.cubic_order k hk) s hs
  apply (Nat.Prime.coprime_iff_not_dvd (by decide : Nat.Prime 3)).mpr
  have H := dvd_mul_of_dvd_left h3 q
  omega

#print axioms quadratic_period
#print axioms cubic_period

end HeleniusPeriods
