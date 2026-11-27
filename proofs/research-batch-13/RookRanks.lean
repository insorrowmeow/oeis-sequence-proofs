import Mathlib.Data.Finset.Powerset
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace RookRanks

open Finset

variable {α β : Type*} [DecidableEq α]

/-- A choice outside the distinguished independent set, paired with all its
compatible choices inside, with prescribed total cardinality. -/
def configurations (A : Finset α) (family : Finset (Finset β))
    (neighbors : β → Finset α) (k : ℕ) : Finset ((_ : Finset β) × Finset α) :=
  family.sigma fun S => if S.card ≤ k then
    (A \ S.biUnion neighbors).powersetCard (k-S.card) else ∅

private theorem choose_increasing (n i j : ℕ) (hij : i ≤ j) (hj : j ≤ n/2) :
    n.choose i ≤ n.choose j := by
  obtain ⟨p, rfl⟩ := Nat.exists_eq_add_of_le hij
  induction p with
  | zero => simp
  | succ p ih =>
    exact (ih (by omega) (by omega)).trans (Nat.choose_le_succ_of_lt_half_left (by omega))

private theorem choose_towards_middle (n i j : ℕ) (hij : i ≤ j) (hij' : i+j ≤ n) :
    n.choose i ≤ n.choose j := by
  by_cases h : j ≤ n/2
  · exact choose_increasing n i j hij h
  · rw [← Nat.choose_symm (show j ≤ n by omega)]
    exact choose_increasing n i (n-j) (by omega) (by omega)

/-- Every outside element excludes at most two distinguished elements. -/
theorem configuration_ranks (A : Finset α) (family : Finset (Finset β))
    (neighbors : β → Finset α) (h : ∀ b, (neighbors b).card ≤ 2)
    (k l : ℕ) (hkl : k ≤ l) (hsum : k+l ≤ A.card) :
    (configurations A family neighbors k).card ≤
      (configurations A family neighbors l).card := by
  classical
  simp only [configurations, Finset.card_sigma]
  apply Finset.sum_le_sum
  intro S _
  by_cases hk : S.card ≤ k
  · have hl : S.card ≤ l := hk.trans hkl
    simp only [if_pos hk, if_pos hl, Finset.card_powersetCard]
    have hcost : (S.biUnion neighbors).card ≤ S.card * 2 := by
      calc
        (S.biUnion neighbors).card ≤ ∑ b ∈ S, (neighbors b).card := Finset.card_biUnion_le
        _ ≤ ∑ _b ∈ S, (2 : ℕ) := Finset.sum_le_sum fun b _ => h b
        _ = S.card * 2 := by simp
    have hsurvive : A.card ≤ (A \ S.biUnion neighbors).card + (S.biUnion neighbors).card :=
      Finset.card_le_card_sdiff_add_card
    exact choose_towards_middle _ _ _ (by omega) (by omega)
  · simp [hk]

variable {V : Type*} [DecidableEq V]

structure SimpleGraph (V : Type*) where
  Adj : V → V → Prop
  symm : Symmetric Adj
  loopless : Irreflexive Adj

/-- The graph has no edge among the chosen vertices. -/
def independent (G : SimpleGraph V) (S : Finset V) : Prop :=
  ∀ x ∈ S, ∀ y ∈ S, ¬G.Adj x y

noncomputable def graphRank (G : SimpleGraph V) (U : Finset V) (k : ℕ) : ℕ := by
  classical
  exact ((U.powersetCard k).filter (independent G)).card

private noncomputable def outsideFamily (G : SimpleGraph V) (U A : Finset V) :
    Finset (Finset V) := by
  classical
  exact (U \ A).powerset.filter (independent G)

noncomputable def contact (G : SimpleGraph V) (A : Finset V) (v : V) :
    Finset V := by
  classical
  exact A.filter (G.Adj v)

private lemma mem_config (G : SimpleGraph V) (U A S T : Finset V) (k : ℕ) :
    Sigma.mk S T ∈ configurations A (outsideFamily G U A) (contact G A) k ↔
      S ⊆ U \ A ∧ independent G S ∧ T ⊆ A ∧
      (∀ x ∈ S, ∀ y ∈ T, ¬G.Adj x y) ∧ S.card+T.card=k := by
  classical
  simp only [configurations, Finset.mem_sigma, outsideFamily, Finset.mem_filter,
    Finset.mem_powerset, contact]
  by_cases h : S.card ≤ k
  · simp only [if_pos h, Finset.mem_powersetCard]
    constructor
    · rintro ⟨⟨hS,hI⟩,hT,hcard⟩
      refine ⟨hS,hI,fun _ hy => (Finset.mem_sdiff.mp (hT hy)).1, ?_,by omega⟩
      intro x hx y hy hxy
      exact (Finset.mem_sdiff.mp (hT hy)).2 (Finset.mem_biUnion.mpr
        ⟨x,hx,Finset.mem_filter.mpr ⟨(Finset.mem_sdiff.mp (hT hy)).1,hxy⟩⟩)
    · rintro ⟨hS,hI,hT,hcross,hcard⟩
      refine ⟨⟨hS,hI⟩,?_,by omega⟩
      intro y hy
      refine Finset.mem_sdiff.mpr ⟨hT hy,?_⟩
      rintro hblock
      obtain ⟨x,hx,hxy⟩ := Finset.mem_biUnion.mp hblock
      exact hcross x hx y hy (Finset.mem_filter.mp hxy).2
  · rw [if_neg h]
    constructor
    · rintro ⟨_,hempty⟩
      simp at hempty
    · rintro ⟨_,_,_,_,hs⟩
      omega

private theorem graphRank_eq (G : SimpleGraph V) (U A : Finset V) (hA : A ⊆ U)
    (hI : independent G A) (k : ℕ) :
    graphRank G U k = (configurations A (outsideFamily G U A) (contact G A) k).card := by
  classical
  unfold graphRank
  apply Finset.card_bij (fun F _ => Sigma.mk (F \ A) (F ∩ A))
  · intro F hF
    obtain ⟨⟨hU,hk⟩,hind⟩ := Finset.mem_filter.mp hF |>.imp_left Finset.mem_powersetCard.mp
    refine (mem_config _ _ _ _ _ _).mpr ⟨?_,?_,Finset.inter_subset_right,?_,?_⟩
    · intro x hx
      exact Finset.mem_sdiff.mpr ⟨hU (Finset.mem_sdiff.mp hx).1,(Finset.mem_sdiff.mp hx).2⟩
    · intro x hx y hy
      exact hind x (Finset.mem_sdiff.mp hx).1 y (Finset.mem_sdiff.mp hy).1
    · intro x hx y hy
      exact hind x (Finset.mem_sdiff.mp hx).1 y (Finset.mem_inter.mp hy).1
    · exact (Finset.card_sdiff_add_card_inter F A).trans hk
  · intro F _ F' _ he
    have he' := congrArg (fun p : (_ : Finset V) × Finset V => p.1 ∪ p.2) he
    simpa only [Finset.sdiff_union_inter] using he'
  · rintro ⟨S,T⟩ h
    obtain ⟨hS,hInd,hT,hcross,hcard⟩ := (mem_config _ _ _ _ _ _).mp h
    have hd : Disjoint S T := Finset.disjoint_left.mpr fun x hx hy =>
      (Finset.mem_sdiff.mp (hS hx)).2 (hT hy)
    refine ⟨S ∪ T,Finset.mem_filter.mpr ⟨Finset.mem_powersetCard.mpr ⟨?_,?_⟩,?_⟩,?_⟩
    · exact Finset.union_subset (fun x hx => (Finset.mem_sdiff.mp (hS hx)).1) (hT.trans hA)
    · exact (Finset.card_union_of_disjoint hd).trans hcard
    · intro x hx y hy
      rcases Finset.mem_union.mp hx with hx|hx <;> rcases Finset.mem_union.mp hy with hy|hy
      · exact hInd x hx y hy
      · exact hcross x hx y hy
      · exact fun hxy => hcross y hy x hx (G.symm hxy)
      · exact hI x (hT hx) y (hT hy)
    · have ex : (S ∪ T) \ A = S := by
        ext x
        simp only [Finset.mem_sdiff, Finset.mem_union]
        constructor
        · rintro ⟨hs|ht,hn⟩
          · exact hs
          · exact (hn (hT ht)).elim
        · intro hx
          exact ⟨Or.inl hx,(Finset.mem_sdiff.mp (hS hx)).2⟩
      have ey : (S ∪ T) ∩ A = T := by
        ext x
        simp only [Finset.mem_inter, Finset.mem_union]
        constructor
        · rintro ⟨hs|ht,ha⟩
          · exact ((Finset.mem_sdiff.mp (hS hs)).2 ha).elim
          · exact ht
        · intro hx
          exact ⟨Or.inr hx,hT hx⟩
      rw [ex,ey]

/-- Rank inequalities for graph independent sets relative to an independent
set whose members have at most two neighbours at each vertex. -/
theorem independent_ranks (G : SimpleGraph V) (U A : Finset V) (hA : A ⊆ U)
    (hI : independent G A) (h : ∀ v, (contact G A v).card ≤ 2)
    (k l : ℕ) (hkl : k ≤ l) (hsum : k+l ≤ A.card) :
    graphRank G U k ≤ graphRank G U l := by
  classical
  rw [graphRank_eq G U A hA hI k, graphRank_eq G U A hA hI l]
  exact configuration_ranks _ _ _ h k l hkl hsum

/-- No vertex has three pairwise nonadjacent neighbours. -/
def clawFree (G : SimpleGraph V) : Prop :=
  ∀ (v : V) (T : Finset V), T.card = 3 → independent G T → ¬∀ w ∈ T, G.Adj v w

theorem claw_free_ranks (G : SimpleGraph V) (hG : clawFree G) (U A : Finset V)
    (hA : A ⊆ U) (hI : independent G A) (k l : ℕ) (hkl : k ≤ l) (hsum : k+l ≤ A.card) :
    graphRank G U k ≤ graphRank G U l := by
  classical
  apply independent_ranks G U A hA hI _ k l hkl hsum
  intro v
  by_contra! h
  obtain ⟨T,hT,h3⟩ := Finset.exists_subset_card_eq (show 3 ≤ (contact G A v).card by omega)
  have hv : ∀ w ∈ T, w ∈ A ∧ G.Adj v w := fun w hw => Finset.mem_filter.mp (hT hw)
  exact hG v T h3 (fun x hx y hy => hI x (hv x hx).1 y (hv y hy).1)
    (fun w hw => (hv w hw).2)

/-- The two labels are the maximal horizontal and vertical runs of a rook
board. Two distinct cells attack exactly when one of their labels agrees. -/
def rookGraph {R C : Type*} (row : V → R) (col : V → C) : SimpleGraph V where
  Adj x y := x ≠ y ∧ (row x = row y ∨ col x = col y)
  symm _ _ h := ⟨h.1.symm, h.2.imp Eq.symm Eq.symm⟩
  loopless _ h := h.1 rfl

theorem rook_ranks {R C : Type*} (row : V → R) (col : V → C) (U A : Finset V)
    (hA : A ⊆ U) (hI : independent (rookGraph row col) A)
    (k l : ℕ) (hkl : k ≤ l) (hsum : k+l ≤ A.card) :
    graphRank (rookGraph row col) U k ≤ graphRank (rookGraph row col) U l := by
  classical
  apply independent_ranks _ U A hA hI _ k l hkl hsum
  intro v
  let rows := A.filter fun w => row w = row v
  let cols := A.filter fun w => col w = col v
  have hr : rows.card ≤ 1 := by
    apply Finset.card_le_one.mpr
    intro x hx y hy
    obtain ⟨hxa,hxv⟩ := Finset.mem_filter.mp hx
    obtain ⟨hya,hyv⟩ := Finset.mem_filter.mp hy
    by_contra hxy
    exact hI x hxa y hya ⟨hxy,Or.inl (hxv.trans hyv.symm)⟩
  have hc : cols.card ≤ 1 := by
    apply Finset.card_le_one.mpr
    intro x hx y hy
    obtain ⟨hxa,hxv⟩ := Finset.mem_filter.mp hx
    obtain ⟨hya,hyv⟩ := Finset.mem_filter.mp hy
    by_contra hxy
    exact hI x hxa y hya ⟨hxy,Or.inr (hxv.trans hyv.symm)⟩
  have hsub : contact (rookGraph row col) A v ⊆ rows ∪ cols := by
    intro w hw
    obtain ⟨ha,hvw⟩ := Finset.mem_filter.mp hw
    rcases hvw.2 with hr|hc
    · exact Finset.mem_union_left _ (Finset.mem_filter.mpr ⟨ha,hr.symm⟩)
    · exact Finset.mem_union_right _ (Finset.mem_filter.mpr ⟨ha,hc.symm⟩)
  exact (Finset.card_le_card hsub).trans ((Finset.card_union_le _ _).trans (by omega))

/-- Weber's mirror inequality. Any attained size d works, in particular the
largest exponent of the rook polynomial with nonzero coefficient. -/
theorem rook_mirror {R C : Type*} (row : V → R) (col : V → C) (U : Finset V)
    (d k : ℕ) (hd : 0 < graphRank (rookGraph row col) U d) (hk : 2*k ≤ d) :
    graphRank (rookGraph row col) U k ≤ graphRank (rookGraph row col) U (d-k) := by
  classical
  unfold graphRank at hd
  obtain ⟨A,hA⟩ := Finset.card_pos.mp hd
  obtain ⟨ha,hi⟩ := Finset.mem_filter.mp hA
  obtain ⟨hsub,hcard⟩ := Finset.mem_powersetCard.mp ha
  exact rook_ranks row col U A hsub hi k (d-k) (by omega) (by omega)

end RookRanks
