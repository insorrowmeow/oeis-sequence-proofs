import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Tactic.Ring

namespace TriangularDensity

def latticeCount (i j : Nat) := (i*j+i+j-Nat.gcd i j)/2

-- Here p=i+1, n+1=p*(u+1), and the second side is 2u+1.
theorem coprime_representation (i u : Nat)
    (h : Nat.Coprime i (2*(i*u+i+u)+1)) :
    Nat.Coprime i (2*u+1) ∧ latticeCount i (2*u+1) = i*u+i+u := by
  rw [show 2*(i*u+i+u)+1 = (2*u+1)+(2*u+2)*i by ring,
    Nat.coprime_add_mul_right_right] at h
  refine ⟨h, ?_⟩
  unfold latticeCount
  rw [h.gcd_eq_one, show i*(2*u+1)+i+(2*u+1) = 2*(i*u+i+u)+1 by ring]
  omega

end TriangularDensity
