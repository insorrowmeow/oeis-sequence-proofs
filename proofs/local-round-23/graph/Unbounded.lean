import Mathlib.Combinatorics.SimpleGraph.Path
import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.Ring

/-! A ball of radius i hits at most 2i+1 different integer levels.
    Blowing up the second vertex of a long path keeps its Slater number two. -/
namespace BurningFamily
open Finset SimpleGraph
noncomputable section

def Covered {V : Type*} (G : SimpleGraph V) (k : ℕ) : Prop :=
  ∃ c : Fin k → V, ∀ v, ∃ i, ∃ w : G.Walk (c i) v, w.length ≤ i.val

private theorem walk_level {V : Type*} {G : SimpleGraph V} {f : V → ℕ}
    (edge : ∀ {v w}, G.Adj v w → f v ≤ f w+1 ∧ f w ≤ f v+1)
    {v w} (p : G.Walk v w) :
    f v ≤ f w+p.length ∧ f w ≤ f v+p.length := by
  induction p with
  | nil => simp
  | cons h p ih => have h' := edge h; simp only [Walk.length_cons]; omega

/-- Any burning cover by k sources spans at most k² consecutive levels. -/
theorem cover_bound {V : Type*} {G : SimpleGraph V} (f : V → ℕ) {h k : ℕ}
    (edge : ∀ {v w}, G.Adj v w → f v ≤ f w+1 ∧ f w ≤ f v+1)
    (levels : ∀ j<h, ∃ v, f v=j) (hc : Covered G k) : h ≤ k^2 := by
  classical
  obtain ⟨c,hc⟩ := hc
  let I (i : Fin k) := Icc (f (c i)-i.val) (f (c i)+i.val)
  have contained : range h ⊆ univ.biUnion I := by
    intro j hj
    obtain ⟨v,rfl⟩ := levels j (mem_range.mp hj)
    obtain ⟨i,w,hw⟩ := hc v
    have hd := walk_level edge w
    exact mem_biUnion.mpr ⟨i, mem_univ _, mem_Icc.mpr ⟨by omega, by omega⟩⟩
  have cnt (i : Fin k) : (I i).card ≤ 2*i.val+1 := by
    simp only [I,Nat.card_Icc]; omega
  have total (n : ℕ) : (∑ j ∈ range n, (2*j+1))=n^2 := by
    induction n with
    | zero => simp
    | succ n ih => rw [sum_range_succ, ih]; ring
  calc h = (range h).card := (card_range h).symm
       _ ≤ (univ.biUnion I).card := card_le_card contained
       _ ≤ ∑ i, (I i).card := card_biUnion_le
       _ ≤ ∑ i : Fin k, (2*i.val+1) := sum_le_sum (fun i _ => cnt i)
       _ = k^2 := (Fin.sum_univ_eq_sum_range (fun i => 2*i+1) k).trans (total k)

/-- Vertices of the path have levels 0,...,n+4. The extra n vertices at
    level one have exactly the same two neighbors as the old one. -/
abbrev Vertex (n : ℕ) := Sum (Fin (n+5)) (Fin n)
def level {n : ℕ} : Vertex n → ℕ := Sum.elim Fin.val (fun _ => 1)
def graph (n : ℕ) : SimpleGraph (Vertex n) where
  Adj v w := level v+1=level w ∨ level w+1=level v
  symm _ _ := Or.symm
  loopless _ := by omega

def pathV {n : ℕ} (j : ℕ) (hj : j<n+5) : Vertex n := Sum.inl ⟨j,hj⟩
private theorem level_path {n j} (hj : j<n+5) : level (pathV j hj) = j := rfl

theorem family_lower (n k : ℕ) (h : Covered (graph n) k) : n+5 ≤ k^2 := by
  apply cover_bound level (h:=n+5) _ _ h
  · intro v w e
    change level v+1=level w ∨ level w+1=level v at e
    omega
  · exact fun j hj => ⟨pathV j hj,rfl⟩

theorem family_connected (n : ℕ) : (graph n).Connected := by
  refine (connected_iff_exists_forall_reachable _).mpr ⟨pathV 0 (by omega), ?_⟩
  have path (j : ℕ) (hj : j<n+5) :
      (graph n).Reachable (pathV 0 (by omega)) (pathV j hj) := by
    induction j with
    | zero => exact Reachable.rfl
    | succ j ih =>
      apply (ih (by omega)).trans
      exact (show (graph n).Adj (pathV j (by omega)) (pathV (j+1) hj) from Or.inl rfl).reachable
  rintro (i|i)
  · exact path i.val i.isLt
  · exact (show (graph n).Adj (pathV 0 (by omega)) (Sum.inr i) from Or.inl rfl).reachable

private noncomputable def nbr (n : ℕ) (x : Vertex n) : Finset (Vertex n) := by
  classical exact univ.filter ((graph n).Adj x)

/-- A t-element set reaches the degree-sum threshold if and only if the
    sum of the t largest degrees reaches it for at least one such set. -/
def slaterTest (n t : ℕ) : Prop :=
  ∃ S : Finset (Vertex n), S.card=t ∧ Fintype.card (Vertex n) ≤ t+∑ v ∈ S, (nbr n v).card

private theorem order (n : ℕ) : Fintype.card (Vertex n) = n+5+n := by simp [Vertex]

private theorem nonneighbor (n : ℕ) (v : Vertex n) :
    ∃ w : Vertex n, w≠v ∧ ¬(graph n).Adj v w := by
  by_cases h : level v ≥ 2
  · refine ⟨pathV 0 (by omega),fun he => ?_, ?_⟩
    · have := congrArg level he; rw [level_path] at this; omega
    · change ¬ (level v+1=0 ∨ 0+1=level v)
      omega
  · refine ⟨pathV (n+4) (by omega),fun he => ?_, ?_⟩
    · have := congrArg level he; rw [level_path] at this; omega
    · change ¬ (level v+1=n+4 ∨ (n+4)+1=level v)
      omega

private theorem degree_lt (n : ℕ) (v : Vertex n) : 1+(nbr n v).card < Fintype.card (Vertex n) := by
  classical
  obtain ⟨w,hw,ha⟩ := nonneighbor n v
  have hv : v ∉ nbr n v := by simp [nbr]
  have hwm : w ∉ insert v (nbr n v) := by simp [nbr, hw, ha]
  have hn := (insert w (insert v (nbr n v))).card_le_univ
  rw [card_insert_of_not_mem hwm, card_insert_of_not_mem hv] at hn
  omega

private theorem two_hubs (n : ℕ) : slaterTest n 2 := by
  classical
  let a : Vertex n := pathV 0 (by omega)
  let b : Vertex n := pathV 2 (by omega)
  let x : Vertex n := pathV 1 (by omega)
  let y : Vertex n := pathV 3 (by omega)
  let twins : Finset (Vertex n) := univ.image (Sum.inr : Fin n → Vertex n)
  have ct : twins.card=n := by simp [twins, card_image_of_injective _ Sum.inr_injective]
  have hx : x ∉ twins := by simp [twins, x, pathV]
  have hy : y ∉ insert x twins := by simp [twins,x,y,pathV]
  have nt (v : Vertex n) (hv : v ∈ twins) : level v=1 := by
    have ⟨i,_,hi⟩ := mem_image.mp hv
    exact hi ▸ rfl
  have ha : insert x twins ⊆ nbr n a := by
    intro v h
    apply mem_filter.mpr
    refine ⟨mem_univ _,Or.inl ?_⟩
    have : level v=1 := (mem_insert.mp h).elim (fun e => e ▸ rfl) (nt v)
    exact this.symm
  have hb : insert y (insert x twins) ⊆ nbr n b := by
    intro v h
    apply mem_filter.mpr
    refine ⟨mem_univ _,?_⟩
    rcases mem_insert.mp h with rfl | h
    · exact Or.inl rfl
    · have : level v=1 := (mem_insert.mp h).elim (fun e => e ▸ rfl) (nt v)
      exact Or.inr (show level v+1=2 by omega)
  have ca := card_le_card ha
  have cb := card_le_card hb
  rw [card_insert_of_not_mem hx, ct] at ca
  rw [card_insert_of_not_mem hy, card_insert_of_not_mem hx, ct] at cb
  have hab : a ≠ b := by simp [a,b,pathV]
  refine ⟨{a,b}, by simp [hab], ?_⟩
  simp [hab,order]
  omega

theorem exact_slater (n : ℕ) :
    slaterTest n 2 ∧ (∀ t<2, ¬ slaterTest n t) := by
  refine ⟨two_hubs n, ?_⟩
  rintro t ht ⟨S,hs,h⟩
  rcases (show t=0 ∨ t=1 by omega) with rfl | rfl
  · obtain rfl := card_eq_zero.mp hs
    simp [order] at h
  · obtain ⟨v,rfl⟩ := card_eq_one.mp hs
    simp at h
    exact (not_le_of_gt (degree_lt n v)) (by simpa [order] using h)

/-- An infinite family at fixed Slater number defeats every proposed
    uniform bound on burning time. -/
theorem unbounded_at_two (k : ℕ) :
    ∃ n, (graph n).Connected ∧ (slaterTest n 2 ∧ ∀ t<2, ¬ slaterTest n t) ∧
      (∀ j≤k, ¬ Covered (graph n) j) := by
  refine ⟨k^2, family_connected _, exact_slater _, ?_⟩
  intro j hj cov
  have h := family_lower _ _ cov
  have := Nat.pow_le_pow_left hj 2
  omega

#print axioms unbounded_at_two
end
end BurningFamily


