import Mathlib.NumberTheory.ZetaValues
import Triangle

namespace SizeTriangle
open scoped Real

/-- The normalized reciprocal-square sum used by the discrete pair count. -/
theorem basel : HasSum (fun i : ℕ => recip i^2) (π^2/6) := by
  simpa only [recip,one_div,inv_pow] using hasSum_zeta_two

#print axioms basel
end SizeTriangle
