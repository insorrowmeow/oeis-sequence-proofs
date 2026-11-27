import KernelBridge
import TreeEnumeration

namespace Voloshyn
noncomputable section
open PowerSeries VoloshynTrees

/-- The actual tree series satisfies the published quartic, independently of
    existence or uniqueness of a candidate GWW row family. -/
theorem tree_satisfies_quartic {K : Type*} [Field K] [CharZero K] (z : K) :
    gww256 (-C K z+2*X*(1-C K z)^2*forestSeries z) (-C K z) (4*X*(1-C K z)^3)=0 := by
  obtain ⟨r,hr,hd⟩ := kernel_double_root z _ _ (forest_kernel z)
  rw [delta_as_quartic] at hr
  have hn := double_root_invariant _ _ _ _ _ r hr hd
  rw [tree_quartic_certificate] at hn
  have hnum : (6912 : PowerSeries K) ≠ 0 := by
    intro h
    have hc := congrArg (constantCoeff K) h
    simp only [map_ofNat, map_zero] at hc
    exact (Nat.cast_ne_zero.mpr (by decide : (6912:ℕ) ≠ 0)) hc
  have hne : (6912 : PowerSeries K)*X^3 ≠ 0 :=
    mul_ne_zero hnum (pow_ne_zero _ PowerSeries.X_ne_zero)
  rw [gww_certificate,(mul_eq_zero.mp hn).resolve_left hne,mul_zero]

#print axioms tree_satisfies_quartic
end
end Voloshyn
