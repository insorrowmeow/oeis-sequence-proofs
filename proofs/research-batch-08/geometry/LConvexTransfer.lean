import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace LConvexTransfer
noncomputable section

/-- The pair after the matrices indexed 0 through k have acted on (1,0). -/
def state (s : ℕ → ℝ) : ℕ → ℝ × ℝ
  | 0 => (1, (s 0)^2)
  | k+1 => ((state s k).1 + (state s k).2,
    (s (k+1))^2*(state s k).1+(state s k).2)

def growth (s : ℕ → ℝ) : ℕ → ℝ
  | 0 => 1+s 0
  | k+1 => growth s k * (1+s (k+1))

theorem growth_nonnegative (s : ℕ → ℝ) (hs : ∀ j, 0 ≤ s j) (k : ℕ) :
    0 ≤ growth s k := by
  induction k with
  | zero => simp [growth]; linarith [hs 0]
  | succ k ih => exact mul_nonneg ih (by linarith [hs (k+1)])

theorem state_nonnegative (s : ℕ → ℝ) (k : ℕ) :
    0 ≤ (state s k).1 ∧ 0 ≤ (state s k).2 := by
  induction k with
  | zero => exact ⟨by norm_num [state],sq_nonneg _⟩
  | succ k ih =>
    exact ⟨add_nonneg ih.1 ih.2, add_nonneg (mul_nonneg (sq_nonneg _) ih.1) ih.2⟩

/-- Lower and upper estimates simultaneously for the two coordinates. -/
theorem coordinate_bounds (s : ℕ → ℝ) (hs : ∀ j, 0 ≤ s j) (hmax : s 0 ≤ 1)
    (hdec : ∀ j, s (j+1) ≤ s j) (k : ℕ) :
    growth s k*s 0 ≤ (1+s 0)*(state s k).1 ∧
    growth s k*s 0*s k ≤ (1+s 0)*(state s k).2 ∧
    s k*(state s k).1 ≤ growth s k ∧ (state s k).2 ≤ growth s k := by
  induction k with
  | zero =>
    simp only [growth, state, mul_one]
    constructor
    · nlinarith [mul_nonneg (by linarith [hs 0] : 0 ≤ 1+s 0) (sub_nonneg.mpr hmax)]
    constructor
    · apply le_of_eq; ring
    constructor
    · linarith
    · nlinarith [mul_nonneg (hs 0) (sub_nonneg.mpr hmax)]
  | succ k ih =>
    obtain ⟨h1,h2,h3,h4⟩ := ih
    have s' := hs (k+1)
    have lower : growth s k * s 0 * s (k+1) ≤ (1+s 0)*(state s k).2 :=
      (mul_le_mul_of_nonneg_left (hdec k) (mul_nonneg (growth_nonnegative s hs k) (hs 0))).trans h2
    have upper : s (k+1) * (state s k).1 ≤ growth s k :=
      (mul_le_mul_of_nonneg_right (hdec k) (state_nonnegative s k).1).trans h3
    simp only [growth, state]
    constructor
    · nlinarith only [h1,lower]
    constructor
    · nlinarith only [lower,mul_le_mul_of_nonneg_left h1 (sq_nonneg (s (k+1)))]
    constructor
    · nlinarith only [upper,mul_le_mul_of_nonneg_left h4 s']
    · nlinarith only [h4,mul_le_mul_of_nonneg_left upper s']

/-- The scalar transfer expression f is the sum of the coordinates. -/
theorem scalar_bounds (s : ℕ → ℝ) (hs : ∀ j, 0 < s j) (hmax : s 0 ≤ 1)
    (hdec : ∀ j, s (j+1) ≤ s j) (k : ℕ) :
    let f := (state s k).1 + (state s k).2
    growth s k*s 0/(1+s 0) ≤ f ∧ f ≤ 2*growth s k/s k := by
  dsimp only
  have hk : s k ≤ 1 := by
    induction k with
    | zero => exact hmax
    | succ k ih => exact (hdec k).trans ih
  obtain ⟨h1,_,h3,h4⟩ := coordinate_bounds s (fun j => (hs j).le) hmax hdec k
  constructor
  · apply (div_le_iff₀ (by linarith [hs 0] : 0 < 1+s 0)).mpr
    nlinarith only [h1,mul_nonneg (by linarith [hs 0] : 0 ≤ 1+s 0) (state_nonnegative s k).2]
  · apply (le_div_iff₀ (hs k)).mpr
    nlinarith only [h3,h4,mul_le_mul_of_nonneg_right hk (state_nonnegative s k).2]

#print axioms scalar_bounds

end
end LConvexTransfer
