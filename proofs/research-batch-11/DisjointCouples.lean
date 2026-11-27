import Mathlib.Data.Finset.Powerset
import Mathlib.Data.Fintype.Fin
import Mathlib.Data.Nat.Choose.Basic

namespace DisjointCouples

abbrev Vertex := Fin 7
abbrev Edge := Finset Vertex

def leftPart : Finset Vertex := {0, 1}
def rightPart : Finset Vertex := {2, 3, 4, 5, 6}

def edges : Finset Edge :=
  leftPart.biUnion fun a => rightPart.image fun b => {a, b}

-- A two-element subfamily of edges is disjoint exactly when its union has size four.
def couples : Finset (Finset Edge) :=
  (edges.powersetCard 2).filter fun pair => (pair.biUnion id).card = 4

def compatible (s : Finset Vertex) : Prop :=
  ∀ p ∈ couples, ∀ a ∈ p, ∀ b ∈ p, (a ∩ s).Nonempty ↔ (b ∩ s).Nonempty

instance (s : Finset Vertex) : Decidable (compatible s) := by
  unfold compatible
  infer_instance

def witness (j : Vertex) : Finset Vertex := insert j leftPart

set_option maxRecDepth 20000
set_option maxHeartbeats 4000000

theorem numberOfCouples : couples.card = 20 := by decide

theorem inequalities :
    (7 + 1) / 2 = (4 : Nat) ∧ Nat.choose 5 2 * Nat.choose 3 2 / 2 = 15 ∧
      Nat.choose 5 2 * Nat.choose 3 2 / 2 ≤ couples.card := by decide

theorem allWitnesses :
    ∀ j : Vertex, j ∈ witness j ∧ compatible (witness j) ∧
      (witness j).card = (if j ∈ leftPart then 2 else 3) := by decide

-- There are only seven vertices. The sole tasks of the finite calculation below
-- are ruling out singletons and ruling out two-element sets at a right vertex.
private theorem smallSetLowerBound :
    ∀ s ∈ (Finset.univ : Finset Vertex).powerset, s.card ≤ 2 →
      ∀ j ∈ s, compatible s → (if j ∈ leftPart then 2 else 3) ≤ s.card := by
  decide

theorem exactMinimum (j : Vertex) :
    (∃ s : Finset Vertex, j ∈ s ∧ compatible s ∧
      s.card = (if j ∈ leftPart then 2 else 3)) ∧
    (∀ s : Finset Vertex, j ∈ s → compatible s →
      (if j ∈ leftPart then 2 else 3) ≤ s.card) := by
  refine ⟨⟨witness j, allWitnesses j⟩, ?_⟩
  intro s hj hs
  by_cases h : s.card ≤ 2
  · exact smallSetLowerBound s (Finset.mem_powerset.mpr (Finset.subset_univ s)) h j hj hs
  · split <;> omega

theorem counterexample :
    Nat.choose 5 2 * Nat.choose 3 2 / 2 ≤ couples.card ∧
      ∀ j : Vertex, ∃ s : Finset Vertex, j ∈ s ∧ compatible s ∧ s.card < 4 := by
  refine ⟨inequalities.2.2, ?_⟩
  intro j
  obtain ⟨hj, hc, hcard⟩ := allWitnesses j
  refine ⟨witness j, hj, hc, ?_⟩
  rw [hcard]
  split <;> decide

end DisjointCouples
