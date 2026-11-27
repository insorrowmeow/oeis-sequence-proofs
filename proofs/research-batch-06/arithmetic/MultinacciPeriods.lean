import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Algebra.Polynomial.Derivative
import Mathlib.Algebra.GeomSum
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.ComputeDegree
import Mathlib.Tactic.IntervalCases

namespace MultinacciPeriods

open Polynomial Finset

abbrev K := ZMod 9
abbrev Poly := Polynomial K

private instance : Fact (1 < 9) := ⟨by decide⟩

noncomputable def characteristic (n : ℕ) : Poly := X^n - ∑ i ∈ range n, X^i

private theorem telescopes (n : ℕ) :
    (X-1)*characteristic n = 1-X^n*(2-X) := by
  unfold characteristic
  rw [mul_sub, mul_geom_sum]
  ring

private theorem degree_lower (n : ℕ) : (∑ i ∈ range n, (X : Poly)^i).degree < n := by
  rw [degree_lt_iff_coeff_zero]
  intro m hm
  rw [finset_sum_coeff]
  apply sum_eq_zero
  intro i hi
  have h : i ≠ m := by have := mem_range.mp hi; omega
  simp [coeff_X_pow, h, Ne.symm h]

theorem characteristic_monic (n : ℕ) : (characteristic n).Monic :=
  monic_X_pow_sub (degree_lower n)

private theorem characteristic_degree (n : ℕ) : (characteristic n).degree = n := by
  rw [characteristic, degree_sub_eq_left_of_degree_lt, degree_X_pow]
  simpa using degree_lower n

private theorem singular_factor {R : Type*} [CommRing R] [Algebra K R]
    (y : R) (f g : Poly) (he : aeval y (f*g) = 0) (hs : (aeval y f)^2 = 0) :
    aeval y f * aeval y (derivative (f*g)) = 0 := by
  rw [map_mul] at he
  rw [derivative_mul, map_add, map_mul, map_mul]
  calc
    _ = (aeval y f * aeval y g)*aeval y (derivative f) +
        (aeval y f)^2 * aeval y (derivative g) := by ring
    _ = 0 := by rw [he, hs]; ring

private noncomputable def obstruction : Poly := 6*(X^3-1)*(X-1)^2

private theorem forces_obstruction (n T : ℕ) (ht : ¬ 3 ∣ T)
    (h : characteristic n ∣ X^T-1) : characteristic n ∣ obstruction := by
  let p := characteristic n
  let R := AdjoinRoot p
  let a : R := AdjoinRoot.root p
  let y : R := a^3
  let f : Poly := (X-1)*p
  obtain ⟨g, hg⟩ := h
  have hfg : f*g = (X-1)*(X^T-1) := by rw [hg]; dsimp [f,p]; ring
  have h9 : (9 : R)=0 := by
    simpa using congrArg (algebraMap K R) (show (9 : K)=0 by decide)
  have hp : a^n*(2-a)=1 := by
    have H := congrArg (AdjoinRoot.mk p) (telescopes n)
    change (AdjoinRoot.mk p) ((X-1)*p) = _ at H
    simp only [map_mul, AdjoinRoot.mk_self, mul_zero, map_sub, map_one, map_pow,
      AdjoinRoot.mk_X, map_ofNat] at H
    exact (sub_eq_zero.mp H.symm).symm
  have hT : a^T=1 := by
    have H : AdjoinRoot.mk p (X^T-1) = 0 := AdjoinRoot.mk_eq_zero.mpr ⟨g,hg⟩
    simpa [a, sub_eq_zero] using H
  have hy : y^T=1 := by dsimp [y]; rw [← pow_mul, Nat.mul_comm, pow_mul, hT, one_pow]
  have he : aeval y (f*g) = 0 := by simp [hfg,hy]
  have hv : aeval y f = 6*(a^n)^3*(a-1)^2 := by
    have hh := congrArg (fun z : R => z^3) hp
    rw [show f = (1-X^n*(2-X) : Poly) from telescopes n]
    simp only [map_sub, map_one, map_mul, map_pow, aeval_X, map_ofNat]
    dsimp [y]
    rw [← pow_mul, Nat.mul_comm, pow_mul]
    linear_combination -hh
  have hs : (aeval y f)^2=0 := by
    rw [hv]
    calc
      _ = (9:R)*(4*(a^n)^6*(a-1)^4) := by ring
      _ = 0 := by rw [h9, zero_mul]
  have H := singular_factor y f g he hs
  rw [hfg, derivative_mul, derivative_sub, derivative_X, derivative_one,
    derivative_sub, derivative_X_pow, derivative_one] at H
  simp only [map_add, map_mul, map_pow, map_one, map_sub, map_zero, aeval_X, aeval_C,
    map_natCast, hy, sub_self, mul_zero, zero_add, sub_zero] at H
  have ha : IsUnit a := IsUnit.of_pow_eq_one hT (by intro hz; subst T; simp at ht)
  have hTu : IsUnit (T : R) := by
    have hcop : T.Coprime 3 := ((Nat.Prime.coprime_iff_not_dvd (by decide : Nat.Prime 3)).mpr ht).symm
    have u : IsUnit (T : K) := (ZMod.isUnit_iff_coprime T 9).mpr (by simpa using hcop.pow_right 2)
    simpa using u.map (algebraMap K R)
  apply AdjoinRoot.mk_eq_zero.mp
  change AdjoinRoot.mk p obstruction = 0
  simp only [obstruction, map_mul, map_ofNat, map_pow, map_sub, map_one, AdjoinRoot.mk_X]
  change 6*(y-1)*(a-1)^2 = 0
  have hu := ((ha.pow n).pow 3).mul (hTu.mul ((ha.pow 3).pow (T-1)))
  apply hu.mul_right_injective
  dsimp only
  rw [mul_zero]
  rw [hv] at H
  convert H using 1
  dsimp [y]
  ring

private theorem small_remainder (n j : ℕ) (q r : Poly)
    (eqn : obstruction = characteristic n * q + r) (dr : r.degree = ↑j)
    (hj : j < n) : ¬characteristic n ∣ obstruction := by
  intro h
  rw [eqn] at h
  have hd := dvd_sub h (dvd_mul_right (characteristic n) q)
  rw [add_sub_cancel_left] at hd
  have h0 : r ≠ 0 := by intro hz; simp [hz] at dr
  exact (characteristic_monic n).not_dvd_of_degree_lt h0
    (by rw [dr, characteristic_degree]; exact_mod_cast hj) hd

private theorem obstruction_impossible (n : ℕ) (hn : 2 ≤ n) :
    ¬characteristic n ∣ obstruction := by
  by_cases h : 6 ≤ n
  · have d : obstruction.degree = 5 := by
      unfold obstruction
      compute_degree!
    have nz : obstruction ≠ 0 := by intro he; simp [he] at d
    exact (characteristic_monic n).not_dvd_of_degree_lt nz
      (by rw [d, characteristic_degree]; exact_mod_cast h)
  · have hh : n ≤ 5 := by omega
    interval_cases n
    · apply small_remainder 2 1 (-6+6*X-6*X^2+6*X^3) (-12+12*X)
      · simp [obstruction, characteristic, sum_range_succ]; ring
      · compute_degree!
        rw [show (12:Poly).coeff 1 = 0 from coeff_ofNat_succ 12 0]
        decide
      · decide
    · apply small_remainder 3 1 (6-6*X+6*X^2) (12*X)
      · simp [obstruction, characteristic, sum_range_succ]; ring
      · compute_degree!
      · decide
    · apply small_remainder 4 3 (-6+6*X) (-12+12*X-6*X^2+6*X^3)
      · simp [obstruction, characteristic, sum_range_succ]; ring
      · compute_degree!
        change ¬-((12:Poly).coeff 3) + 6 = 0
        rw [show (12:Poly).coeff 3 = 0 from coeff_ofNat_succ 12 2]
        decide
      · decide
    · apply small_remainder 5 4 6 (18*X+12*X^3-6*X^4)
      · simp [obstruction, characteristic, sum_range_succ]; ring
      · compute_degree!
      · decide

/-- Every polynomial period of the fundamental n-step Fibonacci recurrence mod 9
    is divisible by 3, for every order n ≥ 2. -/
theorem period_divisible_by_three (n T : ℕ) (hn : 2 ≤ n)
    (hp : characteristic n ∣ X^T-1) : 3 ∣ T := by
  by_contra ht
  exact obstruction_impossible n hn (forces_obstruction n T ht hp)

#print axioms period_divisible_by_three

private def advance : Module.End K (ℕ → K) where
  toFun s i := s (i+1)
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

private theorem advance_pow (s : ℕ → K) (i j : ℕ) :
    (advance^j) s i = s (i+j) := by
  induction j generalizing i with
  | zero => rfl
  | succ j ih =>
    rw [pow_succ', Module.End.mul_apply]
    change (advance^j) s (i+1) = _
    rw [ih]
    congr 1
    omega

private theorem annihilation (n T : ℕ) (hn : 2 ≤ n) (s : ℕ → K)
    (hz : ∀ i, i < n-1 → s i = 0) (ho : s (n-1)=1)
    (rec : ∀ k, s (k+n) = ∑ i ∈ range n, s (k+i))
    (hp : ∀ k, s (k+T)=s k) : characteristic n ∣ X^T-1 := by
  let f : Poly := X^T-1
  let p := characteristic n
  let r := f %ₘ p
  have hf : (aeval advance f) s = 0 := by
    funext k
    simp [f, advance_pow, hp]
  have hc : (aeval advance p) s = 0 := by
    funext k
    simp [p, characteristic, advance_pow, rec, LinearMap.sum_apply, sum_apply]
  have hm : p.Monic := characteristic_monic n
  have hr : (aeval advance r) s = 0 := by
    have H := congrArg (fun z : Poly => (aeval advance z) s) (modByMonic_add_div f hm)
    rw [mul_comm p] at H
    change (aeval advance (r + (f /ₘ p)*p)) s = _ at H
    simpa [Module.End.mul_apply, hc, hf] using H
  apply (modByMonic_eq_zero_iff_dvd hm).mp
  change r = 0
  by_contra hne
  have hd : r.natDegree < n := by
    have HH : r.degree < (n : WithBot ℕ) := (characteristic_degree n) ▸ degree_modByMonic_lt f hm
    simpa [degree_eq_natDegree hne] using HH
  let k := n-1-r.natDegree
  have hk : k+r.natDegree=n-1 := by dsimp [k]; omega
  have H := congrFun hr k
  rw [aeval_eq_sum_range] at H
  simp only [LinearMap.sum_apply, sum_apply, LinearMap.smul_apply, Pi.smul_apply,
    smul_eq_mul, advance_pow, Pi.zero_apply] at H
  rw [sum_range_succ, hk, ho, mul_one] at H
  have vanished : ∑ i ∈ range r.natDegree, r.coeff i * s (k+i) = 0 := by
    apply sum_eq_zero
    intro i hi
    have hi' := mem_range.mp hi
    rw [hz (k+i) (by omega), mul_zero]
  rw [vanished, zero_add] at H
  exact (leadingCoeff_ne_zero.mpr hne) H

/-- Statement on the actual impulse sequence with its initial values and recurrence. -/
theorem fundamental_period (n T : ℕ) (hn : 2 ≤ n) (s : ℕ → K)
    (hz : ∀ i, i < n-1 → s i = 0) (ho : s (n-1)=1)
    (rec : ∀ k, s (k+n) = ∑ i ∈ range n, s (k+i))
    (hp : ∀ k, s (k+T)=s k) : 3 ∣ T :=
  period_divisible_by_three n T hn (annihilation n T hn s hz ho rec hp)

#print axioms fundamental_period

private theorem extend_period (n T : ℕ) (hn : 2 ≤ n) (s : ℕ → K)
    (rec : ∀ k, s (k+n) = ∑ i ∈ range n, s (k+i)) (m : ℕ)
    (hp : ∀ k, m ≤ k → s (k+T) = s k) : ∀ k, s (k+T) = s k := by
  induction m with
  | zero => exact fun k => hp k (Nat.zero_le k)
  | succ m ih =>
    apply ih
    intro k hk
    by_cases hk' : m+1 ≤ k
    · exact hp k hk'
    have h : k=m := by omega
    subst k
    have H : ∑ i ∈ range n, s (m+T+i) = ∑ i ∈ range n, s (m+i) := by
      rw [← rec, ← rec, show m+T+n = m+n+T by omega]
      exact hp (m+n) (by omega)
    rw [show n = (n-1)+1 by omega, sum_range_succ', sum_range_succ'] at H
    have tail : (∑ i ∈ range (n-1), s (m+T+(i+1))) =
        ∑ i ∈ range (n-1), s (m+(i+1)) := by
      apply sum_congr rfl
      intro i _
      rw [show m+T+(i+1) = m+(i+1)+T by omega]
      exact hp _ (by omega)
    simpa only [tail, Nat.add_zero, add_right_inj] using H

/-- Every eventual period of the digit-root residues is a multiple of three. -/
theorem eventual_fundamental_period (n T : ℕ) (hn : 2 ≤ n) (s : ℕ → K)
    (hz : ∀ i, i < n-1 → s i = 0) (ho : s (n-1)=1)
    (rec : ∀ k, s (k+n) = ∑ i ∈ range n, s (k+i))
    (hp : ∃ m, ∀ k, m ≤ k → s (k+T)=s k) : 3 ∣ T := by
  obtain ⟨m, hm⟩ := hp
  exact fundamental_period n T hn s hz ho rec (extend_period n T hn s rec m hm)

#print axioms eventual_fundamental_period

/-- Standard decimal digital root, including the value at zero. -/
def digitalRoot : ℕ → ℕ
  | 0 => 0
  | k+1 => k%9+1

private theorem digitalRoot_cast (k : ℕ) : (digitalRoot k : K) = (k : K) := by
  rw [ZMod.natCast_eq_natCast_iff']
  cases k with
  | zero => rfl
  | succ k => simp only [digitalRoot]; omega

/-- The digital-root recurrence and initial values as given in OEIS A210456. -/
theorem digital_root_period (n T : ℕ) (hn : 2 ≤ n) (s : ℕ → ℕ)
    (hz : ∀ i, i < n-1 → s i = 0) (ho : s (n-1)=1)
    (rec : ∀ k, s (k+n) = digitalRoot (∑ i ∈ range n, s (k+i)))
    (hp : ∃ m, ∀ k, m ≤ k → s (k+T)=s k) : 3 ∣ T := by
  obtain ⟨m, hm⟩ := hp
  apply eventual_fundamental_period n T hn (fun i => (s i : K))
  · intro i hi; simp [hz i hi]
  · simp [ho]
  · intro k
    rw [rec k, digitalRoot_cast, Nat.cast_sum]
  · exact ⟨m, fun k hk => congrArg (fun t : ℕ => (t : K)) (hm k hk)⟩

#print axioms digital_root_period

private theorem positive_tail (n : ℕ) (hn : 2 ≤ n) (s : ℕ → ℕ)
    (ho : s (n-1)=1) (rec : ∀ k, s (k+n) = digitalRoot (∑ i ∈ range n, s (k+i)))
    (k : ℕ) (hk : n-1 ≤ k) : 0 < s k ∧ s k ≤ 9 := by
  obtain ⟨j, rfl⟩ := Nat.exists_eq_add_of_le hk
  induction j with
  | zero => simp [ho]
  | succ j ih =>
    have hp : 0 < ∑ i ∈ range n, s (j+i) := by
      apply lt_of_lt_of_le _ (single_le_sum (f := fun i => s (j+i)) (fun _ _ => Nat.zero_le _)
        (show n-1 ∈ range n from mem_range.mpr (by omega)))
      simpa [Nat.add_comm] using (ih (by omega)).1
    rw [show n-1+(j+1)=j+n by omega, rec]
    rcases he : ∑ i ∈ range n, s (j+i) with _ | t
    · omega
    · simp only [digitalRoot]; omega

/-- Polynomial divisibility characterizes all eventual periods of the digit sequence. -/
theorem digital_period_iff (n T : ℕ) (hn : 2 ≤ n) (s : ℕ → ℕ)
    (hz : ∀ i, i < n-1 → s i = 0) (ho : s (n-1)=1)
    (rec : ∀ k, s (k+n) = digitalRoot (∑ i ∈ range n, s (k+i))) :
    (∃ m, ∀ k, m ≤ k → s (k+T)=s k) ↔ characteristic n ∣ X^T-1 := by
  let u (k : ℕ) : K := s k
  have HU : ∀ k, u (k+n) = ∑ i ∈ range n, u (k+i) := by
    intro k
    dsimp [u]
    rw [rec, digitalRoot_cast, Nat.cast_sum]
  constructor
  · rintro ⟨m, hp⟩
    apply annihilation n T hn u (fun i hi => by simp [u, hz i hi]) (by simp [u, ho]) HU
    exact extend_period n T hn u HU m (fun k hk => congrArg (fun t : ℕ => (t : K)) (hp k hk))
  · rintro ⟨g, hg⟩
    have hc : (aeval advance (characteristic n)) u = 0 := by
      funext k
      simp [characteristic, advance_pow, HU, LinearMap.sum_apply, sum_apply]
    have H : (aeval advance (X^T-1 : Poly)) u = 0 := by
      rw [hg, mul_comm, map_mul, Module.End.mul_apply, hc, map_zero]
    refine ⟨n-1, ?_⟩
    intro k hk
    have he := congrFun H k
    simp [advance_pow, u, sub_eq_zero, ZMod.natCast_eq_natCast_iff'] at he
    have h1 := positive_tail n hn s ho rec k hk
    have h2 := positive_tail n hn s ho rec (k+T) (by omega)
    omega

end MultinacciPeriods
