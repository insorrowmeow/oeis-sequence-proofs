import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic.Ring

/-! Elementary identities for the retained KOH summand. The coefficient
arrays here use integer indices so shifts and zero extensions cause no
truncated subtractions at the lower edge. -/

namespace ZanelloKoh

open Finset

/-- Coefficients of q^s A(q) (1+q+...+q^L). -/
def lineProduct (A : ℤ → ℤ) (s : ℤ) (L : ℕ) (i : ℤ) : ℤ :=
  ∑ j ∈ range (L+1), A (i-s-j)

def delta (A : ℤ → ℤ) (i : ℤ) := A i - A (i-1)

/-- The first difference of the line factor telescopes exactly, including
outside the support when A is a zero-extended coefficient sequence. -/
theorem delta_line (A : ℤ → ℤ) (s : ℤ) (L : ℕ) (i : ℤ) :
    delta (lineProduct A s L) i = A (i-s) - A (i-s-(L+1)) := by
  induction L with
  | zero =>
    simp [delta,lineProduct,show i-1-s=i-s-1 by omega]
  | succ L ih =>
    simp only [delta, lineProduct] at ih ⊢
    rw [sum_range_succ _ (L+1),sum_range_succ _ (L+1)]
    push_cast
    have h2 : i-1-s-((L:ℤ)+1) = i-s-(L+1+1) := by omega
    rw [h2]
    omega

/-- Convolution with a line has doubled center 2s+U+L if A has doubled
center U. Applied to a Gaussian polynomial, A is understood on all integers
by zero outside the rectangle's area. -/
theorem line_symmetric {A : ℤ → ℤ} {U : ℤ}
    (hA : ∀ k : ℤ, A (U-k) = A k) (s : ℤ) (L : ℕ) (i : ℤ) :
    lineProduct A s L ((2*s+U+L)-i) = lineProduct A s L i := by
  unfold lineProduct
  rw [← sum_range_reflect (fun j : ℕ ↦ A (i-s-j)) (L+1)]
  apply sum_congr rfl
  intro j hj
  have hjL : j ≤ L := Nat.le_of_lt_succ (mem_range.mp hj)
  simp only [Nat.add_sub_cancel, Int.natCast_sub hjL]
  rw [show 2*s+U+↑L-i-s-↑j = U-(i-s-(↑L-↑j)) by ring, hA]

/-- The retained KOH summand has the same center as the full rectangle. -/
theorem retained_doubled_center (h r b c : ℤ) :
    2*(h*(h+1)*r) + h*(r*(c-2*h)) + ((b-h*r)*c-2*h*r) = b*c := by ring

/-- Testing negative second differences through floor(N/2)+1 is enough
for positivity of every first difference on the left of the central
strip. This uses the symmetry of the same polynomial being differenced. -/
theorem central_delta_positive {A : ℤ → ℤ} {N L i : ℤ}
    (hs : ∀ k : ℤ, A (N-k) = A k) (hLi : L ≤ i) (hi : i ≤ N/2)
    (curvature : ∀ j : ℤ, L < j → j ≤ N/2+1 → delta (delta A) j < 0) :
    0 < delta A i := by
  let H := N/2
  have hstep (j : ℤ) (hl : L < j) (hu : j ≤ H+1) : delta A j < delta A (j-1) := by
    have := curvature j hl hu
    simpa only [delta,sub_neg] using this
  have mid : 0 < delta A H := by
    have h := hstep (H+1) (by dsimp [H]; omega) le_rfl
    simp only [add_sub_cancel_right] at h
    have parity : N = 2*H ∨ N=2*H+1 := by dsimp [H]; omega
    rcases parity with hN|hN
    · have r := hs (H+1)
      rw [show N-(H+1)=H-1 by omega] at r
      simp only [delta,add_sub_cancel_right] at h ⊢
      omega
    · have r := hs (H+1)
      rw [show N-(H+1)=H by omega] at r
      simp only [delta,add_sub_cancel_right] at h ⊢
      omega
  have back (k : ℕ) (hk : i + k ≤ H) : delta A (i+k) ≤ delta A i := by
    induction k with
    | zero => simp
    | succ k ih =>
      have step := hstep (i+(k+1:ℕ)) (by omega) (by omega)
      rw [show (i+((k+1:ℕ):ℤ))-1 = i+k by omega] at step
      exact step.le.trans (ih (by omega))
  have := back (H-i).toNat (by dsimp [H]; omega)
  rw [show i+(H-i).toNat=H by dsimp [H]; omega] at this
  exact mid.trans_le this

#print axioms delta_line
#print axioms line_symmetric
#print axioms central_delta_positive

end ZanelloKoh
