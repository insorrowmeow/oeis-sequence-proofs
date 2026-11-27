import KernelBridge
import TreeEnumeration
import TreeSemantics
import TreeQuartic
import Rows
import Mathlib.Algebra.CharZero.Infinite

/-! Main comparison. The hypothesis characterizing the GWW rows is the pair of
identities (3.10) and (3.56) in Voloshyn, in integral normalization. -/
namespace Voloshyn
open PowerSeries VoloshynTrees

noncomputable section
variable {K : Type*} [Field K] [CharZero K]

/-- Equations (3.10), (3.56) with u = -z, h² = 4t(1-z)³. -/
def GwwRowEquations (rows : ℕ → Polynomial K) : Prop :=
  ∀ z : K, z≠0 → z≠1 →
    gww256 (-C K z+2*X*(1-C K z)^2*rowBranch rows z) (-C K z) (4*X*(1-C K z)^3)=0

theorem forestSeries_eq_gww (rows : ℕ → Polynomial K) (hr : GwwRowEquations rows)
    (z : K) (hz : z≠0) (h1 : z≠1) : forestSeries z=rowBranch rows z :=
  forest_eq_gww_of_kernel z hz h1 (forestSeries z) (rowBranch rows z) (catalyticSeries z)
    (forest_kernel z) (hr z hz h1)

theorem weighted_rows (rows : ℕ → Polynomial K) (hr : GwwRowEquations rows)
    (z : K) (hz : z≠0) (h1 : z≠1) (n : ℕ) : Wrow z 1 (n+1)=z*(rows (n+1)).eval z := by
  have he := congrArg (coeff K (n+1)) (forestSeries_eq_gww rows hr z hz h1)
  simpa only [forestSeries, coeff_mk, rowBranch_succ] using he

#print axioms forestSeries_eq_gww

omit [CharZero K] in
private theorem eval_weighted_tree (z : K) {s : ℕ} (hs : 0<s) :
    Wrow z 1 s=z*(treeRow (Polynomial.X : Polynomial K) s).eval z := by
  have he := congrArg (Polynomial.evalRingHom z)
    (Wrow_eq_z_mul_treeRow (Polynomial.X : Polynomial K) hs)
  rw [row_map, map_one, map_mul] at he
  simpa [Polynomial.coe_evalRingHom] using he

/-- Voloshyn (3.55) for every row family with the GWW characterization. The
right side sums over exactly the distinct labelled trees of the specified size,
using the number of leaves plus maximal internal vertices minus two. -/
theorem description_tree_refinement (rows : ℕ → Polynomial K) (hr : GwwRowEquations rows)
    {s : ℕ} (hs : 0<s) : rows s = treeRow (Polynomial.X : Polynomial K) s := by
  obtain ⟨n,rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hs)
  apply row_polynomial_eq
  intro z hz h1
  exact (weighted_rows rows hr z hz h1 n).symm.trans (eval_weighted_tree z hs)

/-- The GWW equation determines exactly the tree statistic in all positive rows. -/
theorem gww_iff_description_trees (rows : ℕ → Polynomial K) :
    GwwRowEquations rows ↔ ∀ s, 0<s → rows s=treeRow (Polynomial.X : Polynomial K) s := by
  constructor
  · exact fun h s hs => description_tree_refinement rows h hs
  · intro h z _ _
    have he : rowBranch rows z=forestSeries z := by
      ext n
      cases n with
      | zero =>
        simp only [rowBranch,forestSeries,coeff_mk]
        change 1=((forests 0).map (wt z (1:K))).sum
        rw [forests]
        simp [wt,marks,labels]
      | succ n =>
        rw [rowBranch_succ,h (n+1) (by omega)]
        simpa [forestSeries] using (eval_weighted_tree z (Nat.succ_pos n)).symm
    rw [he]
    exact tree_satisfies_quartic z

#print axioms description_tree_refinement
#print axioms gww_iff_description_trees

/-- Literal source notation of (3.55), with ν computed on every labelled tree. -/
theorem voloshyn_3_55 (rows : ℕ → Polynomial K) (hr : GwwRowEquations rows)
    {s : ℕ} (hs : 0<s) :
    rows s=∑ t : DescriptionTree s, (Polynomial.X : Polynomial K)^(nu t-2) :=
  (description_tree_refinement rows hr hs).trans (treeRow_eq_sum _ _)

#print axioms voloshyn_3_55

end
end Voloshyn
