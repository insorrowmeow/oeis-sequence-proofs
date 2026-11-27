import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

/-! Algebraic certificates for the description-tree refinement of Voloshyn (3.55).
The identities are integral and valid in every commutative ring. -/
namespace Voloshyn

variable {R : Type*} [CommRing R]

def kernelA (t z x : R) := t*x^2*(1-z+z*x)
def kernelB (t f x : R) := 1-x-t*x^2*f
def delta (t z f x : R) := (kernelB t f x)^2+4*kernelA t z x*(1-x)

theorem square_of_forest (t z f x w : R)
    (h : kernelA t z x*w^2 + kernelB t f x*w - (1-x) = 0) :
    (2*kernelA t z x*w + kernelB t f x)^2 = delta t z f x := by
  unfold delta
  linear_combination 4 * kernelA t z x * h

def quartic (a b c d e x : R) := a*x^4+b*x^3+c*x^2+d*x+e
def dQuartic (a b c d x : R) := 4*a*x^3+3*b*x^2+2*c*x+d
def fourth (t z f : R) := t^2*f^2-4*t*z
def third (t z f : R) := 2*t*f+4*t*(2*z-1)
def second (t z f : R) := 1-2*t*f+4*t*(1-z)

theorem delta_as_quartic (t z f x : R) :
    delta t z f x = quartic (fourth t z f) (third t z f) (second t z f) (-2) 1 x := by
  unfold delta kernelA kernelB quartic fourth third second
  ring

/-- Twenty-seven times the usual discriminant, expressed via the binary quartic invariants. -/
def quarticInvariant (a b c d e : R) :=
  4*(12*a*e-3*b*d+c^2)^3 -
  (72*a*c*e+9*b*c*d-27*a*d^2-27*b^2*e-2*c^3)^2

theorem double_root_invariant (a b c d e r : R)
    (h : quartic a b c d e r = 0) (hd : dQuartic a b c d r = 0) :
    quarticInvariant a b c d e = 0 := by
  unfold quartic at h
  unfold dQuartic at hd
  have dval : d = -(4*a*r^3+3*b*r^2+2*c*r) := by linear_combination hd
  have eval : e = 3*a*r^4+2*b*r^3+c*r^2 := by linear_combination h - r*hd
  rw [dval, eval]
  unfold quarticInvariant
  ring

/-- Positive-order part of the normalized relation after extracting one t. -/
def correction (t z f : R) : R :=
  let w := f-1
  let c1 := (z^2-10*z+1)*w^2 + 10*z*(z+1)*w + z^2
  let c2 := -8*((-z^2+4*z-1)*w^3+(z^3+2*z^2+2*z+1)*w^2+
    (4*z^3-2*z^2+4*z)*w+z^3+z^2)
  let c3 := 16*f^2*(z-1)^2*(z+w)^2
  c1+t*(c2+t*c3)

/-- Common polynomial after removing the powers of t in the two certificates. -/
def normalized (t z f : R) : R := z*(1-f)+t*correction t z f

theorem normalized_at_zero (z f : R) : normalized 0 z f = z*(1-f) := by
  simp [normalized]

set_option maxHeartbeats 0 in
theorem tree_quartic_certificate (t z f : R) :
    quarticInvariant (fourth t z f) (third t z f) (second t z f) (-2) 1 =
      6912*t^3*normalized t z f := by
  unfold quarticInvariant fourth third second normalized correction
  ring

/-- 256 times Voloshyn's equation (3.10), where y = 2g and h2 = h². -/
def gww256 (y u h2 : R) :=
  16*y^4+16*(1+u^2-h2)*y^3+
    4*((1-u^2)^2+2*(u^2-4)*h2+h2^2)*y^2+
    4*(-4*u^2*(1+u^2)+(u^2-1)*h2+5*h2^2)*y-
    4*u^2*(1+u^2)^2-4*u^2*(3*u^2-5)*h2+(1-12*u^2)*h2^2-4*h2^3

set_option maxHeartbeats 0 in
theorem gww_certificate (t z f : R) :
    gww256 (-z+2*t*(1-z)^2*f) (-z) (4*t*(1-z)^3) =
      16*t*(1-z)^6*normalized t z f := by
  unfold gww256 normalized correction
  ring

#print axioms double_root_invariant
#print axioms tree_quartic_certificate
#print axioms gww_certificate

end Voloshyn
