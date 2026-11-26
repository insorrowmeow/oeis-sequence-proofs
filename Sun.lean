import Mathlib.Data.Nat.ModEq
import Mathlib.Tactic.NormNum
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Tactic.ComputeDegree
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum.Prime

namespace SunTri
open Polynomial

/-- The generating polynomial used in OEIS A279821. -/
noncomputable def trinomial (R : Type*) [Semiring R] : Polynomial R :=
  X ^ 2 + X + 1

/-- The central trinomial coefficient, with its original coefficient definition. -/
noncomputable def central (n : ℕ) : ℕ := ((trinomial ℕ) ^ n).coeff n

private theorem central_mod (p n : ℕ) :
    (central n : ZMod p) = ((trinomial (ZMod p)) ^ n).coeff n := by
  change (Nat.castRingHom (ZMod p)) (((trinomial ℕ) ^ n).coeff n) = _
  rw [← Polynomial.coeff_map]
  simp [trinomial]

/-- The digit rule follows from Frobenius and the support bound [0, 2b]. -/
theorem digit (p a b : ℕ) [hp : Fact p.Prime] (hb : b < p) :
    (central (p*a+b) : ZMod p) = (central a : ZMod p) * (central b : ZMod p) := by
  let F := trinomial (ZMod p)
  have hd : F.natDegree ≤ 2 := by
    dsimp [F, trinomial]
    compute_degree
  have hbd : (F ^ b).natDegree ≤ 2*b := by
    rw [Polynomial.natDegree_pow, Nat.mul_comm 2 b]
    exact Nat.mul_le_mul_left b hd
  have hpow : F ^ (p*a+b) = (expand (ZMod p) p (F ^ a)) * F ^ b := by
    rw [ZMod.expand_card, ← pow_mul, Nat.mul_comm a p, pow_add]
  simp only [central_mod]
  change (F ^ (p*a+b)).coeff (p*a+b) = (F ^ a).coeff a * (F ^ b).coeff b
  rw [hpow, Polynomial.coeff_mul, Finset.sum_eq_single (p*a,b)]
  · exact congrArg (fun c => c * (F ^ b).coeff b)
      (Polynomial.coeff_expand_mul' hp.out.pos (F ^ a) a)
  · rintro ⟨i,j⟩ hij hne
    have hsum : i + j = p*a+b := by simpa using hij
    by_cases hi : p ∣ i
    · obtain ⟨k,rfl⟩ := hi
      have hka : k ≠ a := by
        rintro rfl
        have hj : j = b := by omega
        exact hne (by simp [hj])
      have hlarge : 2*b < j := by
        rcases lt_or_gt_of_ne hka with hk | hk
        · have h := Nat.mul_le_mul_left p (Nat.succ_le_of_lt hk)
          rw [Nat.mul_succ] at h
          omega
        · have h := Nat.mul_le_mul_left p (Nat.succ_le_of_lt hk)
          rw [Nat.mul_succ] at h
          omega
      change _ * (F ^ b).coeff j = 0
      rw [Polynomial.coeff_eq_zero_of_natDegree_lt (lt_of_le_of_lt hbd hlarge), mul_zero]
    · change (expand (ZMod p) p (F ^ a)).coeff i * _ = 0
      rw [Polynomial.coeff_expand hp.out.pos (F ^ a) i, if_neg hi, zero_mul]
  · intro h
    exact (h (by simp)).elim

/-- Addition of finite coefficient lists, padding by zero. -/
def addRows : List ℕ → List ℕ → List ℕ
  | [], ys => ys
  | x :: xs, [] => x :: xs
  | x :: xs, y :: ys => (x+y) :: addRows xs ys

def row : ℕ → List ℕ
  | 0 => [1]
  | n+1 => let r := row n; addRows r (0 :: addRows r (0 :: r))

private noncomputable def ofRow : List ℕ → Polynomial ℕ
  | [] => 0
  | x :: xs => C x + X * ofRow xs

private theorem ofRow_add (xs ys : List ℕ) :
    ofRow (addRows xs ys) = ofRow xs + ofRow ys := by
  induction xs generalizing ys with
  | nil => simp [addRows, ofRow]
  | cons x xs ih =>
    cases ys with
    | nil => simp [addRows, ofRow]
    | cons y ys =>
      simp only [addRows, ofRow, ih, map_add]
      ring

private theorem ofRow_row (n : ℕ) : ofRow (row n) = (trinomial ℕ)^n := by
  induction n with
  | zero => simp [row, ofRow]
  | succ n ih =>
    simp only [row, ofRow_add, ofRow, map_zero, zero_add, ih, pow_succ]
    unfold trinomial
    ring

private theorem ofRow_coeff (xs : List ℕ) (n : ℕ) :
    (ofRow xs).coeff n = (xs[n]?).getD 0 := by
  induction xs generalizing n with
  | nil => simp [ofRow]
  | cons x xs ih =>
    cases n with
    | zero => simp [ofRow, Polynomial.mul_coeff_zero]
    | succ k => simp [ofRow, Polynomial.coeff_C, ih]

/-- Kernel-computable evaluation for the finitely many small digits. -/
theorem central_eval (n : ℕ) : central n = ((row n)[n]?).getD 0 := by
  unfold central
  rw [← ofRow_row, ofRow_coeff]

end SunTri

-- Computations and the final counterexample for Sun's OEIS A279821.
namespace SunTri

set_option maxRecDepth 100000
set_option maxHeartbeats 0

theorem factor_42472009_prime : Nat.Prime 42472009 := by norm_num

private instance p31Prime : Fact (Nat.Prime 31) := ⟨by norm_num⟩
private instance qPrime : Fact (Nat.Prime 42472009) := ⟨factor_42472009_prime⟩

private theorem val0 : central 0 = 1 := by rw [central_eval]; decide
private theorem val1 : central 1 = 1 := by rw [central_eval]; decide
private theorem val14 : central 14 = 616227 := by rw [central_eval]; decide
private theorem val19 : central 19 = 128996853 := by rw [central_eval]; decide
private theorem val20 : central 20 = 377379369 := by rw [central_eval]; decide
private theorem val25 : central 25 = 82176836301 := by rw [central_eval]; decide
private theorem val30 : central 30 = 18252025766941 := by rw [central_eval]; decide
private theorem val31 : central 31 = 53876592856681 := by rw [central_eval]; decide

private theorem mod31 : (central 1316632279 : ZMod 31) = 1 := by
  have h0 : (central 1316632279 : ZMod 31) = central 42472009 * (central 0 : ZMod 31) :=
    digit 31 42472009 0 (by decide)
  have h1 : (central 42472009 : ZMod 31) = central 1370064 * (central 25 : ZMod 31) :=
    digit 31 1370064 25 (by decide)
  have h2 : (central 1370064 : ZMod 31) = central 44195 * (central 19 : ZMod 31) :=
    digit 31 44195 19 (by decide)
  have h3 : (central 44195 : ZMod 31) = central 1425 * (central 20 : ZMod 31) :=
    digit 31 1425 20 (by decide)
  have h4 : (central 1425 : ZMod 31) = central 45 * (central 30 : ZMod 31) :=
    digit 31 45 30 (by decide)
  have h5 : (central 45 : ZMod 31) = central 1 * (central 14 : ZMod 31) :=
    digit 31 1 14 (by decide)
  rw [h0,h1,h2,h3,h4,h5,val0,val25,val19,val20,val30,val1,val14]; decide

private theorem mod42472009 : (central 1316632279 : ZMod 42472009) = 1 := by
  have h : (central 1316632279 : ZMod 42472009) =
      central 31 * (central 0 : ZMod 42472009) := digit 42472009 31 0 (by decide)
  rw [h,val0,val31]; decide

theorem witness_trinomial_congruence : central 1316632279 ≡ 1 [MOD 1316632279] := by
  change central 1316632279 ≡ 1 [MOD 31 * 42472009]
  apply (Nat.modEq_and_modEq_iff_modEq_mul (by decide : Nat.Coprime 31 42472009)).mp
  exact ⟨(ZMod.natCast_eq_natCast_iff _ _ _).mp (by simpa using mod31),
         (ZMod.natCast_eq_natCast_iff _ _ _).mp (by simpa using mod42472009)⟩

theorem witness_not_square (k : ℕ) : k^2 ≠ 1316632279 := by
  intro h
  have hm : k^2 % 4 = 3 := by rw [h]
  rw [pow_two, Nat.mul_mod] at hm
  have hu : k%4 < 4 := Nat.mod_lt _ (by decide)
  have hc : k%4 = 0 ∨ k%4 = 1 ∨ k%4 = 2 ∨ k%4 = 3 := by omega
  rcases hc with hc|hc|hc|hc <;> simp [hc] at hm

theorem a279821_counterexample :
    1 < (1316632279 : ℕ) ∧ ¬ Nat.Prime 1316632279 ∧
    (∀ k : ℕ, k^2 ≠ 1316632279) ∧
    central 1316632279 ≡ 1 [MOD 1316632279] ∧
    (1316632279 : ℕ) ∉ [12,30,902,1360,2450,3730,21475,74945,82208,88282,254677] :=
  ⟨by decide, by norm_num, witness_not_square, witness_trinomial_congruence, by decide⟩

end SunTri

#print axioms SunTri.a279821_counterexample
