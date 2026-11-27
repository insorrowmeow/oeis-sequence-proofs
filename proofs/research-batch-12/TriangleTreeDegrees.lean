import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Algebra.BigOperators.Group.List.Basic

namespace TriangleTreeDegrees

/-- The remainder is smaller than the next gap between triangular numbers. -/
theorem greedy_decomposition (t : ℕ) :
    ∃ a u : ℕ, 0 < a ∧ u < a ∧ a.choose 2 + u = t := by
  induction t with
  | zero => exact ⟨1, 0, by decide, by decide, by decide⟩
  | succ t ih =>
    obtain ⟨a, u, ha, hu, ht⟩ := ih
    by_cases h : u + 1 < a
    · exact ⟨a, u + 1, ha, h, by omega⟩
    · have step : (a + 1).choose 2 = a + a.choose 2 := by
        simp only [Nat.choose_succ_succ' (k := 1), Nat.choose_one_right]
      exact ⟨a + 1, 0, by omega, by omega, by omega⟩

/-- The list consisting of a followed by u copies of 2 has enough room for padding. -/
theorem greedy_budget (m t a u : ℕ) (hm : 75 ≤ m) (ht : t ≤ m - 3)
    (hu : u < a) (he : a.choose 2 + u = t) :
    a + 2 * u + 1 ≤ m / 2 := by
  by_cases hs : a ≤ 12
  · omega
  · have bound : 12 * a ≤ a * (a - 1) := by
      rw [Nat.mul_comm 12 a]
      exact Nat.mul_le_mul_left a (by omega)
    rw [Nat.choose_two_right] at he
    omega

/-- For a tree with s edges, these are the degrees minus one of its s+1 vertices.
Padding by ones changes the sum without changing the sum of triangular numbers.
Padding by zeros supplies the remaining vertices. -/
theorem tree_degree_parameters (m t s : ℕ) (hm : 75 ≤ m) (ht : t ≤ m - 3)
    (hs : m / 2 ≤ s) :
    ∃ d : List ℕ, d.length = s + 1 ∧ d.sum = s - 1 ∧
      (d.map fun x => x.choose 2).sum = t := by
  obtain ⟨a, u, ha, hu, he⟩ := greedy_decomposition t
  have budget := greedy_budget m t a u hm ht hu he
  let ones := s - 1 - (a + 2 * u)
  let zeros := s + 1 - (1 + u + ones)
  have hsum : a + 2 * u + ones = s - 1 := by dsimp [ones]; omega
  have hlength : 1 + u + ones + zeros = s + 1 := by dsimp [zeros, ones]; omega
  refine ⟨a :: (List.replicate u 2 ++ List.replicate ones 1 ++ List.replicate zeros 0),
    ?_, ?_, ?_⟩
  · simp only [List.length_cons, List.length_append, List.length_replicate]
    omega
  · simp only [List.sum_cons, List.sum_append, List.sum_replicate_nat, Nat.mul_one,
      Nat.mul_zero, Nat.add_zero]
    omega
  · simp only [List.map_cons, List.map_append, List.map_replicate, List.sum_cons,
      List.sum_append, List.sum_replicate_nat, show Nat.choose 2 2 = 1 by decide,
      show Nat.choose 1 2 = 0 by decide, show Nat.choose 0 2 = 0 by decide,
      Nat.mul_one, Nat.mul_zero, Nat.add_zero]
    exact he

end TriangleTreeDegrees
