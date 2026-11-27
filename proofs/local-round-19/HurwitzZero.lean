import Mathlib.Data.Complex.Basic
import Mathlib.Tactic.NormNum

/-! An upper-half-plane zero for the full five-variable Hurwitz polynomial
of profile (3,3), genus zero. The underlying counts use the bit order
t₂, t₃, t₄, t₅, from least to most significant. -/

namespace HurwitzZero

def counts : List ℕ :=
  [360,120,312,72,696,200,520,120,1752,520,1352,312,2856,696,1752,360]

noncomputable def row (c : List ℕ) (j : ℕ) (x y : ℂ) : ℂ :=
  (c[j]! + (c[j+1]! : ℂ) * x) + (c[j+2]! + (c[j+3]! : ℂ) * x) * y

/-- Counts of transitive tuples, including the common factor t₆ and
the normalization 1/360 = 2!/6! for this profile. -/
noncomputable def evalCounts (c : List ℕ) (x y z w u : ℂ) : ℂ :=
  u * (row c 0 x y + row c 4 x y * z +
    (row c 8 x y + row c 12 x y * z) * w) / 360

def Stable (p : ℂ → ℂ → ℂ → ℂ → ℂ → ℂ) : Prop :=
  ∀ x y z w u, 0 < x.im → 0 < y.im → 0 < z.im → 0 < w.im → 0 < u.im →
    p x y z w u ≠ 0

noncomputable def x : ℂ := ⟨-5,2⟩
noncomputable def y : ℂ := ⟨-2,1/8⟩
noncomputable def z : ℂ := ⟨-167/223,10/223⟩
noncomputable def w : ℂ := ⟨0,1/8⟩
noncomputable def u : ℂ := ⟨0,1⟩

theorem open_half_planes :
    0 < x.im ∧ 0 < y.im ∧ 0 < z.im ∧ 0 < w.im ∧ 0 < u.im := by
  norm_num [x,y,z,w,u]

theorem exact_zero : evalCounts counts x y z w u = 0 := by
  unfold evalCounts
  apply (div_eq_zero_iff).mpr
  left
  apply mul_eq_zero_of_right
  apply Complex.ext <;> norm_num [row, counts, x, y, z, w,
    Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im]

theorem not_stable : ¬ Stable (evalCounts counts) := by
  obtain ⟨a,b,c,d,e⟩ := open_half_planes
  intro h
  exact h x y z w u a b c d e exact_zero

#print axioms exact_zero
#print axioms not_stable

end HurwitzZero
