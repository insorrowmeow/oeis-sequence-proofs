import Mathlib.RingTheory.PowerSeries.Derivative
import Mathlib.Data.Nat.Factorial.Basic
import Mathlib.Tactic.Ring

namespace SchroederRows
open PowerSeries
abbrev Series := PowerSeries ℚ

noncomputable def scaled (s : Series) (n : ℕ) : ℚ := (n.factorial : ℚ) * coeff ℚ n s

theorem slope {v : Series} (h : v = 1 + X * v * (2*v-1)) :
    v * (1-2*X*v) = 1-X*v := by
  calc
    _ = v-X*v*(2*v-1)-X*v := by ring
    _ = _ := by rw [show v-X*v*(2*v-1)=1 from sub_eq_iff_eq_add.mpr h]

theorem boundary {A B W : Series} (h : B = A + X*(B*W))
    (hd : B = derivativeFun A) (n : ℕ) :
    scaled B (n+1) = scaled B n + (n+1 : ℕ)*scaled (B*W) n := by
  have hb := congrArg (coeff ℚ (n+1)) h
  simp only [map_add, coeff_succ_X_mul] at hb
  have ha := congrArg (coeff ℚ n) hd
  rw [coeff_derivativeFun] at ha
  unfold scaled
  rw [hb, ha, Nat.factorial_succ, Nat.cast_mul, Nat.cast_add_one]
  ring

theorem interior {B W : Series} (h : W = 1+X*(W+W^2)) (n q : ℕ) :
    scaled (B*W^(q+1)) (n+1) = scaled (B*W^q) (n+1) +
      (n+1 : ℕ)*(scaled (B*W^(q+1)) n + scaled (B*W^(q+2)) n) := by
  have eqn : B*W^(q+1) = B*W^q + X*(B*W^(q+1)+B*W^(q+2)) := by
    calc
      _ = (B*W^q)*W := by ring
      _ = (B*W^q)*(1+X*(W+W^2)) := congrArg _ h
      _ = _ := by ring
  have hc := congrArg (coeff ℚ (n+1)) eqn
  simp only [map_add, coeff_succ_X_mul] at hc
  unfold scaled
  rw [hc, Nat.factorial_succ, Nat.cast_mul, Nat.cast_add_one]
  ring

theorem identifies (r : ℕ → ℕ → ℚ) (A B W : Series)
    (hw : W = 1+X*(W+W^2)) (hb : B = A+X*(B*W)) (hd : B = derivativeFun A)
    (h0 : ∀ q, scaled (B*W^q) 0 = 1) (r0 : ∀ q, r 0 q = 1)
    (rb : ∀ n, r (n+1) 0 = r n 0 + (n+1 : ℕ)*r n 1)
    (ri : ∀ n q, r (n+1) (q+1) = r (n+1) q +
      (n+1 : ℕ)*(r n (q+1)+r n (q+2))) :
    ∀ n q, r n q = scaled (B*W^q) n := by
  intro n
  induction n with
  | zero => intro q; rw [r0, h0]
  | succ n ih =>
    intro q
    induction q with
    | zero => simpa [rb, ih] using (boundary hb hd n).symm
    | succ q iq => rw [ri, iq, ih, ih, interior hw]

end SchroederRows
