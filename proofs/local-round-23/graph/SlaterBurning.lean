import Mathlib.Combinatorics.SimpleGraph.Metric
import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Data.Nat.Lattice
import Mathlib.Data.Multiset.Sort
import Mathlib.Tactic.FinCases

/-! A connected graph of order 15 with Slater number 2 and burning number 4.
    The burning invariant uses closed balls in mathlib's graph distance.
    The Slater invariant uses the decreasing degree sequence. -/
namespace SlaterBurning

variable {V : Type*}

def CanBurn (G : SimpleGraph V) (k : ℕ) : Prop :=
  ∃ source : Fin k → V, ∀ v, ∃ i : Fin k, G.dist (source i) v ≤ k-1-i.val

noncomputable def burningNumber (G : SimpleGraph V) : ℕ := sInf {k | CanBurn G k}

def degreesDesc [Fintype V] (G : SimpleGraph V) [DecidableRel G.Adj] : List ℕ :=
  (Finset.univ.val.map (fun v => G.degree v)).sort (· ≥ ·)

noncomputable def slaterNumber [Fintype V] (G : SimpleGraph V) [DecidableRel G.Adj] : ℕ :=
  sInf {t | Fintype.card V ≤ t + ((degreesDesc G).take t).sum}

private theorem canBurn_mono [Inhabited V] {G : SimpleGraph V} {k l : ℕ}
    (h : CanBurn G k) (hkl : k ≤ l) : CanBurn G l := by
  obtain ⟨sources, hs⟩ := h
  let pad (i : Fin l) : V := if hi : i.val < k then sources ⟨i.val,hi⟩ else default
  refine ⟨pad, fun v => ?_⟩
  obtain ⟨i,hi⟩ := hs v
  let j : Fin l := ⟨i, by omega⟩
  refine ⟨j, ?_⟩
  have hj : pad j = sources i := by simp [pad,j,i.isLt]
  rw [hj]
  exact hi.trans (by dsimp [j]; omega)

abbrev Vertex := Fin 15

/-- Levels 0,...,9 form a path; five extra vertices are twins of level 1. -/
def level (v : Vertex) : ℕ := if v.val < 10 then v.val else 1

def graph : SimpleGraph Vertex where
  Adj u v := level u + 1 = level v ∨ level v + 1 = level u
  symm _ _ h := h.symm
  loopless _ h := by rcases h with h | h <;> omega

instance : DecidableRel graph.Adj := fun _ _ => instDecidableOr

/-- Distinct vertices on the same level are twins at distance two. -/
def distanceTable (u v : Vertex) : ℕ :=
  if u = v then 0 else if level u = level v then 2 else
    (level u - level v) + (level v - level u)

set_option maxRecDepth 100000 in
private theorem table_step : ∀ a b c : Vertex, graph.Adj a b →
    distanceTable a c ≤ distanceTable b c + 1 := by decide

set_option maxRecDepth 100000 in
private theorem closer : ∀ a b : Vertex, a ≠ b → ∃ c : Vertex,
    graph.Adj a c ∧ distanceTable c b < distanceTable a b := by decide

private theorem walk_witness (a b : Vertex) :
    ∃ p : graph.Walk a b, p.length ≤ distanceTable a b := by
  by_cases h : a = b
  · subst b
    exact ⟨.nil, Nat.zero_le _⟩
  · obtain ⟨c,hac,hd⟩ := closer a b h
    obtain ⟨p,hp⟩ := walk_witness c b
    exact ⟨.cons hac p, by simp; omega⟩
termination_by distanceTable a b

theorem connected : graph.Connected :=
  ⟨fun u v => (walk_witness u v).elim (fun p _ => ⟨p⟩)⟩

private theorem table_lower {u v : Vertex} (p : graph.Walk u v) :
    distanceTable u v ≤ p.length := by
  induction p with
  | nil => simp [distanceTable]
  | cons h p ih =>
    simp only [SimpleGraph.Walk.length_cons]
    exact (table_step _ _ _ h).trans (Nat.add_le_add_right ih 1)

theorem actual_distance (u v : Vertex) : graph.dist u v = distanceTable u v := by
  obtain ⟨p,hp⟩ := walk_witness u v
  obtain ⟨q,hq⟩ := connected.exists_walk_length_eq_dist u v
  exact le_antisymm ((SimpleGraph.dist_le p).trans hp) (hq ▸ table_lower q)

set_option maxRecDepth 100000 in
theorem degree_list : degreesDesc graph = [7,6,2,2,2,2,2,2,2,2,2,2,2,2,1] := by
  simp only [degreesDesc, SimpleGraph.degree, SimpleGraph.neighborFinset_eq_filter]
  rw [Finset.val_univ_fin, Multiset.map_coe, Multiset.coe_sort]
  rw [List.mergeSort_eq_insertionSort]
  decide

theorem slater_two : slaterNumber graph = 2 := by
  let P (t : ℕ) := Fintype.card Vertex ≤ t + ((degreesDesc graph).take t).sum
  have h2 : P 2 := by unfold P; rw [degree_list]; decide
  have hsmall : ∀ t < 2, ¬ P t := by
    intro t ht
    have hd : t = 0 ∨ t = 1 := by omega
    rcases hd with rfl | rfl <;> unfold P <;> rw [degree_list] <;> decide
  apply le_antisymm (Nat.sInf_le (s := {t | P t}) h2)
  have hm := Nat.sInf_mem (s := {t | P t}) ⟨2,h2⟩
  exact Nat.le_of_not_gt fun h => hsmall _ h hm

set_option maxRecDepth 100000 in
/-- A kernel check that some vertex lies outside every proposed three balls. -/
private theorem missed : ∀ a b c : Vertex, ∃ w : Vertex,
    2 < distanceTable a w ∧ 1 < distanceTable b w ∧ 0 < distanceTable c w := by decide

theorem no_three : ¬CanBurn graph 3 := by
  rintro ⟨src,hs⟩
  obtain ⟨v,ha,hb,hc⟩ := missed (src 0) (src 1) (src 2)
  obtain ⟨i,hi⟩ := hs v
  rw [actual_distance] at hi
  fin_cases i <;> simp_all <;> omega

private def sourceFour (i : Fin 4) : Vertex :=
  if i = 0 then 2 else if i = 1 then 7 else if i = 2 then 9 else 5

theorem four : CanBurn graph 4 := by
  refine ⟨sourceFour, ?_⟩
  simp only [actual_distance]
  decide

theorem burning_four : burningNumber graph = 4 := by
  have hm := Nat.sInf_mem (s := {k | CanBurn graph k}) ⟨4,four⟩
  apply le_antisymm (Nat.sInf_le (s := {k | CanBurn graph k}) four)
  by_contra! h
  exact no_three (canBurn_mono hm (by omega))

/-- The conjectured inequality fails on a nontrivial connected simple graph. -/
theorem counterexample : graph.Connected ∧ 1 < Fintype.card Vertex ∧
    ¬ burningNumber graph ≤ slaterNumber graph + 1 := by
  rw [burning_four, slater_two]
  exact ⟨connected, by decide, by decide⟩

#print axioms counterexample
end SlaterBurning
