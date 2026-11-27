import Mathlib.Data.Int.Basic
import Mathlib.Tactic.NormNum

namespace SingleSeed67

abbrev Config := ℤ → Prop

/-- The three live neighbourhoods of Wolfram rule 67 are 000, 001 and 110. -/
def step (c : Config) (i : ℤ) : Prop :=
  (¬ c (i-1) ∧ ¬ c i) ∨ (c (i-1) ∧ c i ∧ ¬ c (i+1))

def cell : ℕ → Config
  | 0 => fun i => i = 0
  | n+1 => step (cell n)

def first (i : ℤ) : Prop := i ≠ 0 ∧ i ≠ 1
def second (i : ℤ) : Prop := i = -1 ∨ i = 1
def third (i : ℤ) : Prop := i < -1 ∨ 2 < i
def evenShape (i : ℤ) : Prop := i = -2 ∨ i = 0 ∨ i = 1 ∨ i = 2
def oddShape (i : ℤ) : Prop := i < -2 ∨ i = 2 ∨ 3 < i
def shift (m : ℕ) (c : Config) (i : ℤ) : Prop := c (i + m)

private theorem row1 : cell 1 = first := by
  funext i; apply propext
  simp only [cell, step, first]
  omega

private theorem row2 : cell 2 = second := by
  change step (cell 1) = second
  rw [row1]
  funext i; apply propext
  simp only [step, first, second]
  omega

theorem row3 : cell 3 = third := by
  change step (cell 2) = third
  rw [row2]
  funext i; apply propext
  simp only [step, second, third]
  omega

private theorem row4 : cell 4 = evenShape := by
  change step (cell 3) = evenShape
  rw [row3]
  funext i; apply propext
  simp only [step, third, evenShape]
  omega

private theorem even_step : step evenShape = oddShape := by
  funext i; apply propext
  simp only [step, evenShape, oddShape]
  omega

private theorem odd_step : step oddShape = shift 1 evenShape := by
  funext i; apply propext
  simp only [step, shift, evenShape, oddShape]
  omega

private theorem commute (m : ℕ) (c : Config) : step (shift m c) = shift m (step c) := by
  funext i
  simp only [step, shift]
  rw [show i - 1 + (m : ℤ) = i + m - 1 by omega,
      show i + 1 + (m : ℤ) = i + m + 1 by omega]

/-- Equality of entire infinite configurations, including the uniform outside background. -/
theorem all_rows (m : ℕ) :
    cell (4+2*m) = shift m evenShape ∧ cell (5+2*m) = shift m oddShape := by
  induction m with
  | zero =>
    simp only [Nat.mul_zero, Nat.add_zero]
    have hz (c : Config) : shift 0 c = c := by funext i; simp [shift]
    rw [hz, hz, row4]
    exact ⟨rfl, show step (cell 4) = oddShape by rw [row4, even_step]⟩
  | succ m ih =>
    obtain ⟨_, ho⟩ := ih
    have he : cell (4+2*(m+1)) = shift (m+1) evenShape := by
      rw [show 4+2*(m+1) = (5+2*m)+1 by omega]
      change step (cell (5+2*m)) = _
      rw [ho, commute, odd_step]
      funext i
      simp [shift, add_assoc]
    refine ⟨he, ?_⟩
    rw [show 5+2*(m+1) = (4+2*(m+1))+1 by omega]
    change step (cell (4+2*(m+1))) = _
    rw [he, commute, even_step]

noncomputable def digit (c : Config) (i : ℤ) : ℕ := by
  classical
  exact if c i then 1 else 0

/-- Read consecutive cells from left to right, giving the leftmost one greatest weight. -/
noncomputable def word (b : ℕ) (c : Config) (i : ℤ) : ℕ → ℕ
  | 0 => 0
  | len+1 => digit c i * b^len + word b c (i+1) len

theorem keller_counterexample :
    word 2 (cell 3) (-3) 7 = 97 ∧
    16 * word 2 (cell 3) (-3) 7 + 61 * 8^(3/2) + 16 ≠ 16 * (2 * 4^3) := by
  rw [row3]
  norm_num [word, digit, third]

#print axioms all_rows
#print axioms keller_counterexample
end SingleSeed67
