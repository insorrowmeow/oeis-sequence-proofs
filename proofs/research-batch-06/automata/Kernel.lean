import automata.PeriodBits
import Mathlib.Data.Nat.Choose.Lucas
import Mathlib.Algebra.MonoidAlgebra.Basic

namespace Rule150Digits

private theorem submask_halves (j m : ℕ) :
    Submask j m ↔ (j%2 = 1 → m%2 = 1) ∧ Submask (j/2) (m/2) := by
  constructor
  · intro h
    exact ⟨fun hj => by simpa using h 0 (by simpa using hj),
      fun i hi => by simpa [Nat.testBit_succ] using h (i+1) (by simpa [Nat.testBit_succ] using hi)⟩
  · rintro ⟨hbit,hh⟩ i hi
    cases i with
    | zero => simpa using hbit (by simpa using hi)
    | succ i => simpa [Nat.testBit_succ] using hh i (by simpa [Nat.testBit_succ] using hi)

/-- The binary form of Lucas's theorem, expressed as inclusion of bit positions. -/
theorem choose_odd_iff_submask (m j : ℕ) : m.choose j % 2 = 1 ↔ Submask j m := by
  induction j using Nat.strong_induction_on generalizing m with
  | h j ih =>
    by_cases hj : j = 0
    · subst j
      simp [Submask]
    have hrec : m.choose j % 2 = ((m%2).choose (j%2) * (m/2).choose (j/2))%2 :=
      Choose.choose_modEq_choose_mod_mul_choose_div_nat (p := 2)
    rw [submask_halves, ← ih (j/2) (by omega) (m/2), hrec]
    have hm := Nat.mod_lt m (by decide : 0 < 2)
    have hn := Nat.mod_lt j (by decide : 0 < 2)
    rcases (show m%2=0 ∨ m%2=1 by omega) with hm' | hm' <;>
      rcases (show j%2=0 ∨ j%2=1 by omega) with hj' | hj' <;> simp [hm',hj']

/-- Coefficient at residue j of (1+X^a)^m, after reducing exponents modulo m. -/
def folded (m a j : ℕ) : ZMod 2 :=
  ∑ k ∈ Finset.range (m+1), if a*k%m=j%m then (m.choose k : ZMod 2) else 0

def defect (m j : ℕ) : ZMod 2 := folded m 3 j + folded m 1 j

theorem folded_linear {m j : ℕ} (hj : 0 < j) (hm : j < m) :
    folded m 1 j = (m.choose j : ZMod 2) := by
  unfold folded
  simp_rw [one_mul, Nat.mod_eq_of_lt hm]
  rw [Finset.sum_eq_single j]
  · simp [Nat.mod_eq_of_lt hm]
  · intro k hk hne
    have hkm : k ≤ m := Nat.le_of_lt_succ (Finset.mem_range.mp hk)
    obtain He | Hl : k=m ∨ k<m := by omega
    · simp [He,show 0 ≠ j by omega]
    · simp [Nat.mod_eq_of_lt Hl,hne]
  · simp [Finset.mem_range, show j<m+1 by omega]

theorem folded_support {m j : ℕ} (hj : 0 < j) (hm : j < m) :
    folded m 1 j = 1 ↔ Submask j m := by
  rw [folded_linear hj hm, ← Nat.cast_one (R := ZMod 2),
    ZMod.natCast_eq_natCast_iff', ← choose_odd_iff_submask]

theorem cube_zero {m j : ℕ} (hm : 3 ∣ m) (hj : j < m) (hn : j%3 ≠ 0) :
    folded m 3 j = 0 := by
  apply Finset.sum_eq_zero
  intro k _
  have h : 3*k%m ≠ j%m := by
    rw [Nat.mod_eq_of_lt hj]
    rintro rfl
    simp [Nat.mod_mod_of_dvd _ hm] at hn
  simp [h]

theorem cube_permutation {m : ℕ} (hm : m.Coprime 3) (j : ℕ) :
    folded m 3 (3*j) = folded m 1 j := by
  apply Finset.sum_congr rfl
  intro k _
  have h : 3*k%m = 3*j%m ↔ k%m=j%m :=
    ⟨fun h => Nat.ModEq.cancel_left_of_coprime hm h, fun h => Nat.ModEq.mul_left 3 h⟩
  simp [h]

private theorem defect_period (m j : ℕ) : defect m (j+m) = defect m j := by
  simp [defect,folded]

private theorem defect_zero {m : ℕ} (h3 : m%3 ≠ 0)
    (hkernel : ∀ j, defect m j + defect m (j+1) + defect m (j+2) = 0) (j : ℕ) :
    defect m j = 0 := by
  have hper := residue_value (kernel_period _ hkernel)
  have h0 := defect_period m 0
  have h1 := defect_period m 1
  rw [hper (0+m)] at h0
  rw [hper (1+m)] at h1
  have hlim := Nat.mod_lt m (by decide : 0<3)
  have ha := hkernel 0
  change defect m 0 + defect m 1 + defect m 2 = 0 at ha
  have he : defect m 0 = defect m 1 ∧ defect m 1 = defect m 2 := by
    rcases (show m%3=1 ∨ m%3=2 by omega) with hh | hh
    · simp [hh, show (1+m)%3=2 by omega] at h0 h1
      exact ⟨h0.symm, h1.symm⟩
    · simp [hh, show (1+m)%3=0 by omega] at h0 h1
      exact ⟨h1, h1.symm.trans h0.symm⟩
  have hz : defect m 2 = 0 := by
    rw [he.1, he.2] at ha
    simpa [← two_mul, show (2:ZMod 2)=0 by decide] using ha
  rw [hper j]
  have hres := Nat.mod_lt j (by decide : 0<3)
  rcases (show j%3=0 ∨ j%3=1 ∨ j%3=2 by omega) with h|h|h <;> simp [h,he.1,he.2,hz]

/-- The three-term kernel equation for the actual folded binomial coefficients
    forces every binary digit of the odd width to be set. -/
theorem mersenne_of_kernel {m : ℕ} (hm : 1 < m) (hodd : m%2=1)
    (hkernel : ∀ j, defect m j + defect m (j+1) + defect m (j+2) = 0) :
    m = 2^(m.log2+1)-1 := by
  by_cases h3 : 3 ∣ m
  · apply singular_support hm hodd (Nat.mod_eq_zero_of_dvd h3) _ hkernel
    intro j hj hres
    rw [defect, cube_zero h3 hj hres, zero_add]
    exact folded_support (by by_contra! h; simp [show j=0 by omega] at hres) hj
  · apply invariant_support hm hodd
    intro j hj hlt hmask
    have hc : m.Coprime 3 := (Nat.prime_three.coprime_iff_not_dvd.mpr h3).symm
    have hrem : (3*j)%m ≠ 0 := by
      intro h
      have H : 3*j ≡ 3*0 [MOD m] := by simpa [Nat.ModEq] using h
      have H' : j ≡ 0 [MOD m] := Nat.ModEq.cancel_left_of_coprime hc H
      simp [Nat.ModEq,Nat.mod_eq_of_lt hlt,show j ≠ 0 by omega] at H'
    apply (folded_support (Nat.pos_of_ne_zero hrem) (Nat.mod_lt _ (by omega))).mp
    have hD := defect_zero (fun h => h3 (Nat.dvd_of_mod_eq_zero h)) hkernel (3*j)
    rw [defect, cube_permutation hc, (folded_support hj hlt).mpr hmask] at hD
    have hsame : folded m 1 ((3*j)%m) = folded m 1 (3*j) := by simp [folded]
    rw [hsame]
    calc
      folded m 1 (3*j) = -1 := by linear_combination hD
      _ = 1 := by decide

/-- Cyclic polynomials over the binary field, with exponents indexed by Z/mZ. -/
abbrev Cyclic (m : ℕ) := AddMonoidAlgebra (ZMod 2) (ZMod m)

noncomputable def point (m : ℕ) (u : ZMod m) : Cyclic m := Finsupp.single u 1

noncomputable def rule (m : ℕ) : Cyclic m := point m (-1) + 1 + point m 1

noncomputable def binomial (m a : ℕ) : Cyclic m := (point m a + 1)^m

private def coefficient (m : ℕ) (j : ZMod m) : Cyclic m →+ ZMod 2 where
  toFun f := f j
  map_zero' := rfl
  map_add' _ _ := rfl

private theorem coeff_add {m : ℕ} (f g : Cyclic m) (j : ZMod m) :
    (f+g) j = f j + g j := rfl

theorem binomial_coeff (m a j : ℕ) : binomial m a (j : ZMod m) = folded m a j := by
  classical
  unfold binomial folded
  rw [add_pow]
  change coefficient m j (∑ k ∈ Finset.range (m+1),
    (point m a)^k * (1 : Cyclic m)^(m-k) * (m.choose k)) = _
  rw [map_sum]
  apply Finset.sum_congr rfl
  intro k _
  change (_ : Cyclic m) (j : ZMod m) = _
  unfold point
  rw [AddMonoidAlgebra.single_pow, AddMonoidAlgebra.natCast_def]
  simp only [one_pow, mul_one, AddMonoidAlgebra.single_mul_single, add_zero, one_mul,
    Finsupp.single_apply, nsmul_eq_mul]
  have h : (k:ZMod m)*a=j ↔ a*k%m=j%m := by
    rw [mul_comm, ← Nat.cast_mul, ZMod.natCast_eq_natCast_iff']
  simp [h]

theorem automaton_coeff (m : ℕ) (f : Cyclic m) (j : ℕ) :
    (rule m * f) ((j+1 : ℕ) : ZMod m) =
      f (j : ZMod m) + f ((j+1 : ℕ) : ZMod m) + f ((j+2 : ℕ) : ZMod m) := by
  unfold rule point
  simp only [add_mul, one_mul, coeff_add, AddMonoidAlgebra.single_mul_apply,
    neg_neg, Nat.cast_add, Nat.cast_one]
  have hhi : 1+((j:ZMod m)+1) = j+2 := by ring
  have hlo : -1+((j:ZMod m)+1) = j := by ring
  rw [hhi,hlo]
  norm_num
  abel

/-- The ring-level digit criterion. The state polynomial is the single-seed
    rule multiplier T; B(X^3) and B(X) are actual binomial powers in the ring. -/
theorem mersenne_of_ring_kernel {m : ℕ} (hm : 1 < m) (hodd : m%2=1)
    (h : rule m * (binomial m 3 + binomial m 1) = 0) :
    m = 2^(m.log2+1)-1 := by
  apply mersenne_of_kernel hm hodd
  intro j
  have hcoeff := congrArg (fun f : Cyclic m => f ((j+1 : ℕ) : ZMod m)) h
  change (rule m * (binomial m 3 + binomial m 1)) _ = 0 at hcoeff
  rw [automaton_coeff] at hcoeff
  simpa only [coeff_add,binomial_coeff,defect] using hcoeff

private theorem point_mul (m : ℕ) (a b : ZMod m) :
    point m a * point m b = point m (a+b) := by
  simp [point, AddMonoidAlgebra.single_mul_single]

private theorem point_zero (m : ℕ) : point m 0 = 1 := rfl

private theorem point_double (m : ℕ) (a : ZMod m) : point m a + point m a = 0 := by
  change Finsupp.single a 1 + Finsupp.single a 1 = (0 : ZMod m →₀ ZMod 2)
  rw [← Finsupp.single_add, show (1:ZMod 2)+1=0 by decide, Finsupp.single_zero]

private theorem point_order (m : ℕ) : (point m 1)^m=1 := by
  unfold point
  rw [AddMonoidAlgebra.single_pow]
  simp [nsmul_eq_mul,AddMonoidAlgebra.one_def]

private theorem cube_identity (m : ℕ) :
    point m 3 + 1 = ((point m 1 + 1) * point m 1) * rule m := by
  unfold rule
  simp only [add_mul,mul_add,mul_one,one_mul,point_mul]
  have h₁ : (1:ZMod m)+1 + -1=1 := by ring
  have h₃ : (1:ZMod m)+1 + 1=3 := by ring
  rw [h₁,h₃,add_neg_cancel,point_zero]
  have ha := point_double m 1
  have hb := point_double m ((1:ZMod m)+1)
  linear_combination -ha - hb

/-- Vanishing after a single transient step of T(T^m+1) forces the odd
    width m to be one less than a power of two. -/
theorem mersenne_of_rule_relation {m : ℕ} (hm : 1 < m) (hodd : m%2=1)
    (h : rule m * ((rule m)^m+1) = 0) :
    m = 2^(m.log2+1)-1 := by
  apply mersenne_of_ring_kernel hm hodd
  have hc : binomial m 3 = binomial m 1*(rule m)^m := by
    unfold binomial
    simp only [Nat.cast_ofNat,Nat.cast_one,cube_identity,mul_pow,point_order,mul_one]
  rw [hc, ← mul_add_one, mul_left_comm,h,mul_zero]

end Rule150Digits
