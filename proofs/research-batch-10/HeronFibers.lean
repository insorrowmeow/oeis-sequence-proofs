import Mathlib.Tactic.Ring
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace HeronFibers

theorem odd_fiber (p x y : ℕ) :
    let k := p*x^2
    let m := 16*(p+1)*y^2
    let q := k+m
    p*q*k*m*(p*q+k+m) = (4*p*(p+1)*x*y*q)^2 := by
  dsimp
  ring

theorem pell_fiber (p m X Y : ℤ)
    (hx : X = 3*p+2*m) (hn : X^2-2*Y^2=9*p^2) :
    2*p*p*m*(3*p+m)=(p*Y)^2 := by
  have h : 2*m*(3*p+m) = Y^2 := by rw [hx] at hn; nlinarith
  calc _ = p^2*(2*m*(3*p+m)) := by ring
       _ = _ := by rw [h]; ring

theorem angle_cone (x y : ℝ) :
    (5*y^2 ≤ 4*x^2 ∧ 4*x^2 ≤ 20*y^2) ↔
    ((2*x)^2 / 2 ≤ 10*y^2 ∧ 10*y^2 ≤ 2*(2*x)^2) := by
  constructor <;> rintro ⟨h₁,h₂⟩ <;> constructor <;> nlinarith

end HeronFibers
