import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

/-! A uniform finite-difference criterion at the common center of two
symmetric polynomials. There is no restriction to even degrees. -/

namespace GaussianCenter

def symmetricThrough (a : ℕ → ℝ) (D : ℕ) : Prop :=
  ∀ i ≤ D, a (D-i) = a i

def gap (a : ℕ → ℝ) (i : ℕ) : ℝ := a (i+1) - a i

/-- The gap across the reflected pair of ranks has the opposite sign. -/
theorem reflected_gap {a : ℕ → ℝ} {D i : ℕ} (hs : symmetricThrough a D) (hi : i < D) :
    gap a (D-1-i) = -gap a i := by
  have he : D-1-i+1 = D-i := by omega
  have hf : D-1-i = D-(i+1) := by omega
  unfold gap
  rw [he, hs i (by omega), hf, hs (i+1) (by omega)]
  linarith

/-- Curvature at least H in magnitude, over the interval containing a gap
and its reflection, forces the gap on the left half to be at least H/2. -/
theorem gap_lower_bound {a : ℕ → ℝ} {D L i : ℕ} {H : ℝ}
    (hs : symmetricThrough a D) (hH : 0 ≤ H)
    (hi : L ≤ i) (hiD : i < D/2)
    (hc : ∀ j, L ≤ j → j < D-1-L → gap a (j+1) + H ≤ gap a j) :
    H / 2 ≤ gap a i := by
  have hind (j : ℕ) (hj : i+1 ≤ j) :
      j ≤ D-1-L → gap a j + H ≤ gap a i := by
    induction j, hj using Nat.le_induction with
    | base => intro h; exact hc i hi (by omega)
    | succ j hj ih =>
      intro h
      have hstep := hc j (by omega) (by omega)
      have hold := ih (by omega)
      linarith
  have h := hind (D-1-i) (by omega) (by omega)
  rw [reflected_gap hs (by omega)] at h
  linarith

/-- A first-difference error smaller than half the curvature margin preserves
strict growth on the left of the central peak. -/
theorem subtract_increases {a c : ℕ → ℝ} {D L i : ℕ} {H : ℝ}
    (hs : symmetricThrough a D) (hH : 0 ≤ H)
    (hi : L ≤ i) (hiD : i < D/2)
    (hc : ∀ j, L ≤ j → j < D-1-L → gap a (j+1) + H ≤ gap a j)
    (he : gap c i < H/2) :
    a i - c i < a (i+1) - c (i+1) := by
  have h := gap_lower_bound hs hH hi hiD hc
  unfold gap at he h
  linarith

/-- Nonnegative first coefficient and weak growth on the left half of a
symmetric array give nonnegativity and both monotone halves, including the
two equal middle coefficients when D is odd. -/
theorem mirror_conclusion {a : ℕ → ℝ} {D : ℕ} (hs : symmetricThrough a D)
    (h0 : 0 ≤ a 0) (hleft : ∀ j < D/2, a j ≤ a (j+1)) :
    (∀ j ≤ D, 0 ≤ a j) ∧ (∀ j, D/2 ≤ j → j < D → a (j+1) ≤ a j) := by
  have hpos (j : ℕ) : j ≤ D/2 → 0 ≤ a j := by
    induction j with
    | zero => exact fun _ => h0
    | succ j ih => exact fun hj => (ih (by omega)).trans (hleft j (by omega))
  constructor
  · intro j hj
    by_cases h : j ≤ D/2
    · exact hpos j h
    · rw [← hs j hj]
      exact hpos _ (by omega)
  · intro j hj hD
    by_cases h : D-1-j = j
    · have hmirror := hs (j+1) (by omega)
      rw [show D-(j+1) = j by omega] at hmirror
      exact hmirror.ge
    · have hleft' := hleft (D-1-j) (by omega)
      rw [show D-1-j+1 = D-j by omega, show D-1-j = D-(j+1) by omega,
        hs j (by omega), hs (j+1) (by omega)] at hleft'
      exact hleft'

/-- Coefficient array of q^s times a polynomial of degree at most d. The
second bound makes the zero padding at the right endpoint explicit. -/
def centeredShift (c : ℕ → ℝ) (d s i : ℕ) : ℝ :=
  if s ≤ i ∧ i ≤ s+d then c (i-s) else 0

theorem centeredShift_symmetric {c : ℕ → ℝ} {d s : ℕ}
    (hs : symmetricThrough c d) : symmetricThrough (centeredShift c d s) (d+2*s) := by
  intro i hi
  by_cases h : s ≤ i ∧ i ≤ s+d
  · have hr : s ≤ d+2*s-i ∧ d+2*s-i ≤ s+d := by omega
    simp only [centeredShift, if_pos h, if_pos hr]
    rw [show d+2*s-i-s = d-(i-s) by omega]
    exact hs _ (by omega)
  · have hr : ¬(s ≤ d+2*s-i ∧ d+2*s-i ≤ s+d) := by omega
    simp only [centeredShift, if_neg h, if_neg hr]

/-- Finite criterion for a centered difference. Uniform asymptotic bounds
from the manuscript give its head and curvature hypotheses for large W. -/
theorem centered_difference_shape {a c : ℕ → ℝ} {D d s L : ℕ} {H : ℝ}
    (hD : D = d+2*s) (ha : symmetricThrough a D) (hc : symmetricThrough c d)
    (h0 : 0 ≤ a 0 - centeredShift c d s 0)
    (hhead : ∀ j < L, gap (centeredShift c d s) j ≤ gap a j)
    (hH : 0 ≤ H)
    (hcurve : ∀ j, L ≤ j → j < D-1-L → gap a (j+1) + H ≤ gap a j)
    (herr : ∀ j, L ≤ j → j < D/2 → gap (centeredShift c d s) j < H/2) :
    let f := fun i => a i - centeredShift c d s i
    (∀ i ≤ D, 0 ≤ f i) ∧ (∀ j < D/2, f j ≤ f (j+1)) ∧
      (∀ j, D/2 ≤ j → j < D → f (j+1) ≤ f j) := by
  let f := fun i => a i - centeredShift c d s i
  have hsc : symmetricThrough (centeredShift c d s) D := hD ▸ centeredShift_symmetric hc
  have hf : symmetricThrough f D := fun i hi => by
    dsimp [f]
    rw [ha i hi, hsc i hi]
  have hleft (j : ℕ) (hj : j < D/2) : f j ≤ f (j+1) := by
    by_cases h : j < L
    · have hstep := hhead j h
      unfold gap at hstep
      dsimp [f]
      linarith
    · exact (subtract_increases ha hH (by omega) hj hcurve (herr _ (by omega) hj)).le
  have m := mirror_conclusion hf h0 hleft
  exact ⟨m.1, hleft, m.2⟩

#print axioms centered_difference_shape

end GaussianCenter
