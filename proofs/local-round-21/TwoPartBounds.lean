import Margins
import PairEvents

namespace SizePairs
open Finset SizeGeom
noncomputable section

def overflow {n : ℕ} (q : Fin n → ℝ) : ℝ :=
  prob (mass q (n+1)) (fun v => n < size part v)

theorem finite_lower {n : ℕ} (q : Fin n → ℝ) (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i ≤ 1)
    (b : ℕ) :
    (1-∑ i ∈ big n b, q i) * (∑ T ∈ cross n b n, ∏ i ∈ T, q i) ≤ overflow q := by
  let B := big n b
  let w := mass q (n+1)
  have hw := nonnegative_mass hq hq' (n+1)
  rw [mul_sum]
  calc
    _ ≤ ∑ T ∈ cross n b n, prob w (fun v => occupied B v = T) := by
      apply sum_le_sum
      intro T hT
      exact exactly_lower q hq hq' (by omega) B T (cross_mem.mp hT).1
    _ ≤ _ := disjoint_lower hw _ (occupied B) (fun _ h => cross_implies_large h)

theorem finite_upper {n s t : ℕ} (q : Fin n → ℝ) (hq : ∀ i, 0 ≤ q i) (hq' : ∀ i, q i < 1)
    (b : ℕ) (hcut : n=s+t) (ht : 0<t) :
    overflow q ≤ (∑ T ∈ cross n b s, ∏ i ∈ T, q i) +
    (∑ i ∈ univ \ big n b, (part i:ℝ)*(q i/(1-q i))) / t +
    (∑ i ∈ big n s, q i) + (∑ i ∈ big n b, (q i)^2) + (∑ i ∈ big n b, q i)^3 := by
  classical
  let B := big n b
  let w := mass q (n+1)
  have h1 := fun i => (hq' i).le
  have hw := nonnegative_mass hq h1 (n+1)
  let crossed := fun v : Fin n → Fin ((n+1)+1) => occupied B v ∈ cross n b s
  let small := fun v : Fin n → Fin ((n+1)+1) => t < smallSize b v
  let near := fun v : Fin n → Fin ((n+1)+1) => ∃ i ∈ big n s, 1 ≤ (v i:ℕ)
  let repeated := fun v : Fin n → Fin ((n+1)+1) => ∃ i ∈ B, 2 ≤ (v i:ℕ)
  let triple := fun v : Fin n → Fin ((n+1)+1) => 2 < (occupied B v).card
  have inc (v : Fin n → Fin ((n+1)+1)) (ho : n < size part v) :
      (((crossed v ∨ small v) ∨ near v) ∨ repeated v) ∨ triple v := by
    by_cases h : triple v
    · exact Or.inr h
    by_cases hr : repeated v
    · exact Or.inl (Or.inr hr)
    by_cases hx : near v
    · exact Or.inl (Or.inl (Or.inr hx))
    by_cases hm : small v
    · exact Or.inl (Or.inl (Or.inl (Or.inr hm)))
    have hcap : ∀ i ∈ occupied B v, part i ≤ s := by
      intro i hi
      by_contra hh
      exact hx ⟨i, mem_filter.mpr ⟨mem_univ _, Nat.lt_of_not_ge hh⟩, (mem_filter.mp hi).2⟩
    have hone : ∀ i ∈ B, (v i : ℕ) ≤ 1 := by
      intro i hi
      by_contra hh
      exact hr ⟨i, hi, by omega⟩
    exact Or.inl (Or.inl (Or.inl (Or.inl (classify hcut ho (Nat.le_of_not_gt hm) hcap hone
      (Nat.le_of_not_gt h)))))
  have reduction : overflow q ≤ prob w crossed + prob w small + prob w near + prob w repeated + prob w triple := by
    have h := prob_mono hw inc
    have h12 := prob_or hw crossed small
    have h3 := prob_or hw (fun v => crossed v ∨ small v) near
    have h4 := prob_or hw (fun v => (crossed v ∨ small v) ∨ near v) repeated
    have h5 := prob_or hw (fun v => ((crossed v ∨ small v) ∨ near v) ∨ repeated v) triple
    exact h.trans (h5.trans (add_le_add_right
      (h4.trans (add_le_add_right (h3.trans (add_le_add_right h12 _)) _)) _))
  have pCross : prob w crossed ≤ ∑ T ∈ cross n b s, ∏ i ∈ T, q i := by
    apply (cover hw (cross n b s) (fun T v => ∀ i ∈ T, 1 ≤ (v i:ℕ)) ?_).trans
    · apply sum_le_sum
      intro T _
      simpa [w] using (all_hit (K:=n+1) q T 1 (by omega)).le
    · intro v hv
      exact ⟨occupied B v, hv, fun i hi => (mem_filter.mp hi).2⟩
  have pSmall := small_markov (K:=n+1) ht q hq hq' part (univ \ B)
  have pNear := any_tail (K:=n+1) (by omega : 1 ≤ n+1) q hq h1 (big n s)
  have pRepeat := any_tail (K:=n+1) (by omega : 2 ≤ n+1) q hq h1 B
  have pTriple := triple_bound (K:=n+1) (by omega) q hq h1 B
  have pNear' : prob w near ≤ ∑ i ∈ big n s, q i := by simpa [w,near] using pNear
  exact reduction.trans (add_le_add (add_le_add (add_le_add (add_le_add pCross pSmall) pNear') pRepeat) pTriple)

end
end SizePairs
