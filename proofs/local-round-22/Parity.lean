import Mathlib.Algebra.Polynomial.Degree.Domain
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.Algebra.Field.ZMod
import Mathlib.Tactic.Ring

/-! A large common factor of X^s + X + 1 and X^k + 1 cannot occur for
0 < k < s. Used after reducing the critical-perimeter equality modulo 2. -/

namespace PerimeterParity
open Polynomial

section General
variable {F : Type*} [Field F]

private theorem xp_add_one_degree (k : ℕ) :
    ((X : F[X])^k + 1).natDegree = k := by
  simpa using (natDegree_X_pow_add_C (R := F) (n := k) (r := 1))

private theorem xp_add_x_add_one_degree {s : ℕ} (hs : 1 < s) :
    ((X : F[X])^s + X + 1).natDegree = s := by
  have hX : ((X : F[X])+1).natDegree = 1 := by
    simpa using (xp_add_one_degree (F := F) 1)
  rw [add_assoc, natDegree_add_eq_left_of_natDegree_lt, natDegree_X_pow]
  simpa only [hX, natDegree_X_pow] using hs

/-- This obstruction holds over every field, independently of characteristic. -/
theorem no_short_binomial {s k : ℕ} (m : F[X]) (hm : m ∣ X^s+X+1)
    (hlarge : s < 2*m.natDegree)
    (hk : 0 < k) (hks : k < s) : ¬ m ∣ X^k+1 := by
  intro h
  have hn (e : ℕ) (he : 0 < e) : (X : F[X])^e + 1 ≠ 0 := by
    intro hz
    have := congrArg natDegree hz
    simp only [xp_add_one_degree, natDegree_zero] at this
    omega
  have hdk := natDegree_le_of_dvd h (hn k hk)
  rw [xp_add_one_degree] at hdk
  let r : F[X] := X + 1 - X^(s-k)
  have he : r = (X^s+X+1) - X^(s-k)*(X^k+1) := by
    rw [mul_add, ← pow_add, Nat.sub_add_cancel hks.le]
    dsimp [r]
    ring
  have hdr : m ∣ r := he ▸ dvd_sub hm (dvd_mul_of_dvd_right h _)
  have hpos : 0 < s-k := by omega
  have hr : r ≠ 0 := by
    intro hz
    have hz0 := congrArg (eval (0:F)) hz
    simp [r, hpos.ne'] at hz0
  have hlow := natDegree_le_of_dvd hdr hr
  have hX : ((X : F[X])+1).natDegree = 1 := by simpa using xp_add_one_degree (F:=F) 1
  have hu := natDegree_sub_le (X+1 : F[X]) (X^(s-k))
  change m.natDegree ≤ ((X+1 : F[X])-X^(s-k)).natDegree at hlow
  rw [hX, natDegree_X_pow] at hu
  omega

theorem full_factor {s k : ℕ} (hs : 1 < s) (hk : 0 < k) (hks : k<s) :
    ¬ ((X : F[X])^s+X+1) ∣ (X^k+1) := by
  apply no_short_binomial _ (dvd_refl _) _ hk hks
  rw [xp_add_x_add_one_degree hs]
  omega

/-- When the reciprocal cyclotomic quadratic was removed, the remaining degree
is s-2. For s≥5 it still exceeds half of s. -/
theorem quadratic_removed {s k : ℕ} (m : F[X]) (hs : 5 ≤ s)
    (hfactor : m*(X^2+X+1) = X^s+X+1)
    (hk : 0 < k) (hks : k<s) : ¬ m ∣ X^k+1 := by
  have hdeg := xp_add_x_add_one_degree (F:=F) (show 1<s by omega)
  have hquad := xp_add_x_add_one_degree (F:=F) (s:=2) (by decide)
  have hm : m ≠ 0 := by
    intro he
    rw [he, zero_mul] at hfactor
    rw [← hfactor, natDegree_zero] at hdeg
    omega
  have hq : (X^2+X+1 : F[X]) ≠ 0 := by
    intro he
    rw [he, natDegree_zero] at hquad
    omega
  have hd := congrArg natDegree hfactor
  rw [natDegree_mul hm hq, hquad, hdeg] at hd
  apply no_short_binomial m ⟨_, hfactor.symm⟩ _ hk hks
  omega

end General

/-- Either possible degree of the reduced minimal polynomial gives the
modulo-two obstruction. The quadratic branch only requires s≥5. -/
theorem mod_two {s k : ℕ} (m : (ZMod 2)[X]) (hs : 1<s) (hk : 0<k) (hks : k<s)
    (hfactor : m = X^s+X+1 ∨ (5≤s ∧ m*(X^2+X+1) = X^s+X+1)) :
    ¬ m ∣ X^k+1 := by
  rcases hfactor with rfl | ⟨h5,h⟩
  · exact full_factor (F:=ZMod 2) hs hk hks
  · exact quadratic_removed m h5 h hk hks

#print axioms mod_two
end PerimeterParity
