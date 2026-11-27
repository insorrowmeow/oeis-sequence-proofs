import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

namespace KleinTwist

-- At index m this is (U_m,U_{m+1}), for U_0=0, U_1=1.
def pair : Nat → Int × Int
  | 0 => (0, 1)
  | m+1 => let p := pair m; (p.2, 5*p.2-p.1)

theorem cone (m : Nat) :
    1 ≤ (pair m).2 ∧ 0 ≤ (pair m).1 ∧ 110*(pair m).1 ≤ 23*(pair m).2 := by
  induction m with
  | zero => decide
  | succ m ih =>
    rcases ih with ⟨h1,h2,h3⟩
    simp only [pair]
    exact ⟨by omega, by omega, by omega⟩

-- This integer is three times c1-c2 when m=n-1.
def gap (m : Nat) : Int :=
  let v := (pair m).1
  let u := (pair m).2
  9*(m:Int)*u^2 - 12*((m:Int)-1)*u*(u-v) - 4*((u-v)^2-1)

private theorem negative (z u d : Int) (hz : 15 ≤ z) (hu : 5 ≤ u)
    (hd : 87*u ≤ 110*d) :
    9*z*u^2-12*(z-1)*u*d-4*(d^2-1) < 0 := by
  have hu0 : 0 ≤ u := by omega
  have he : 0 ≤ 110*d-87*u := by omega
  have hp : 0 ≤ 110*d+87*u := by omega
  have h1 := mul_nonneg hu0 he
  have h2 := mul_nonneg he hp
  have hs : 9*u^2-12*u*d ≤ 0 := by nlinarith [sq_nonneg u]
  have h3 := mul_nonpos_of_nonneg_of_nonpos (show 0 ≤ z-15 by omega) hs
  have h4 := mul_nonneg (show 0 ≤ u-5 by omega) (show 0 ≤ u+5 by omega)
  nlinarith

theorem crossover (m : Nat) :
    (m < 15 → 0 < gap m) ∧ (15 ≤ m → gap m < 0) := by
  constructor
  · intro hm
    have h : ∀ i : Fin 15, 0 < gap i.val := by decide
    exact h ⟨m, hm⟩
  · intro hm
    rcases m with _ | i
    · omega
    have hi := cone i
    have hc := cone (i+1)
    have hu : 5 ≤ (pair (i+1)).2 := by
      simp only [pair]
      omega
    exact negative (i+1 : Nat) _ _ (by exact_mod_cast hm) hu (by omega)

theorem eight :
    let u := (pair 7).2
    let d := u-(pair 7).1
    3*7*u^2+4*u*d = 88757780045 ∧
      3*7*4*u*d+4*(d^2-1) = 3*84444825220 := by decide

end KleinTwist
