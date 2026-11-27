import Mathlib.Data.Real.Basic
import Mathlib.Combinatorics.Enumerative.DoubleCounting
import Mathlib.Combinatorics.SimpleGraph.Clique
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Deterministic coefficient lemmas for the Makowsky–Rakita question. -/

namespace MakowskyRakita

/-- The coefficients at indices from zero through `N` rise to a peak and then fall. -/
def UnimodalThrough (a : ℕ → ℝ) (N : ℕ) : Prop :=
  ∃ m ≤ N, (∀ i < m, a i ≤ a (i + 1)) ∧
    (∀ i, m ≤ i → i < N → a (i + 1) ≤ a i)

/-- Positive, strictly log-concave coefficients through `K`, followed by a
nonincreasing tail, give a unimodal sequence on `[0,N]`. -/
theorem unimodal_of_initial_logConcavity {a : ℕ → ℝ} {K N : ℕ}
    (hKN : K ≤ N)
    (hpos : ∀ i ≤ K, 0 < a i)
    (hlc : ∀ i, i + 2 ≤ K → a i * a (i + 2) < a (i + 1) ^ 2)
    (htail : ∀ i, K ≤ i → i < N → a (i + 1) ≤ a i) :
    UnimodalThrough a N := by
  classical
  let P := fun i : ℕ => K ≤ i ∨ a (i + 1) ≤ a i
  have hex : ∃ i, P i := ⟨K, Or.inl le_rfl⟩
  let m := Nat.find hex
  have hmK : m ≤ K := Nat.find_min' hex (Or.inl le_rfl)
  refine ⟨m, hmK.trans hKN, ?_, ?_⟩
  · intro i hi
    have hp : ¬ P i := Nat.find_min hex hi
    exact (lt_of_not_ge (fun h => hp (Or.inr h))).le
  · intro i hi
    induction i, hi using Nat.le_induction with
    | base =>
        intro hmN
        rcases Nat.find_spec hex with hk | hfall
        · exact htail m hk hmN
        · exact hfall
    | succ i _ ih =>
        intro hiN
        by_cases hk : K ≤ i + 1
        · exact htail (i + 1) hk hiN
        · have hiK : i + 2 ≤ K := by omega
          have hp : 0 < a (i + 1) := hpos _ (by omega)
          have hnext : 0 ≤ a (i + 2) := (hpos _ hiK).le
          have hprod := mul_le_mul_of_nonneg_right (ih (by omega)) hnext
          apply le_of_lt
          apply lt_of_mul_lt_mul_left (a := a (i + 1)) (by nlinarith [hlc i hiK]) hp.le

/-- Uniform two-sided relative estimates transfer a strict log-concavity margin
from three model coefficients to the corresponding observed coefficients. -/
theorem strict_logConcavity_of_relative_bounds
    {a b c x y z l u q : ℝ}
    (hx : 0 ≤ x) (hy : 0 < y)
    (hc : 0 ≤ c) (hl : 0 ≤ l) (hu : 0 ≤ u)
    (hau : a ≤ u * x) (hcz : c ≤ u * z) (hbl : l * y ≤ b)
    (hmodel : x * z ≤ q * y ^ 2) (hmargin : u ^ 2 * q < l ^ 2) :
    a * c < b ^ 2 := by
  have hprod : a * c ≤ (u * x) * (u * z) :=
    mul_le_mul hau hcz hc (mul_nonneg hu hx)
  have hysq : 0 < y ^ 2 := sq_pos_of_pos hy
  have hbsq : (l * y) * (l * y) ≤ b * b :=
    mul_le_mul hbl hbl (mul_nonneg hl hy.le) ((mul_nonneg hl hy.le).trans hbl)
  calc
    a * c ≤ (u * x) * (u * z) := hprod
    _ = u ^ 2 * (x * z) := by ring
    _ ≤ u ^ 2 * (q * y ^ 2) := mul_le_mul_of_nonneg_left hmodel (sq_nonneg u)
    _ = (u ^ 2 * q) * y ^ 2 := by ring
    _ < l ^ 2 * y ^ 2 := mul_lt_mul_of_pos_right hmargin hysq
    _ = (l * y) * (l * y) := by ring
    _ ≤ b * b := hbsq
    _ = b ^ 2 := by ring

open Finset

/-- Double-count the inclusion incidences between successive levels of a
hereditary family. The lower shadow of each upper set must belong to `B`. -/
theorem count_successive_layers {V : Type*} [DecidableEq V]
    (A B : Finset (Finset V)) (r M : ℕ)
    (hcard : ∀ t ∈ A, t.card = r + 1)
    (hshadow : ∀ t ∈ A, t.powersetCard r ⊆ B)
    (hext : ∀ s ∈ B, (A.filter (fun t => s ⊆ t)).card ≤ M) :
    (r + 1) * A.card ≤ M * B.card := by
  let rel := fun t s : Finset V => s ⊆ t
  have hbelow (t : Finset V) (ht : t ∈ A) :
      r + 1 ≤ (B.bipartiteAbove rel t).card := by
    have hsub : t.powersetCard r ⊆ B.bipartiteAbove rel t := by
      intro s hs
      exact mem_filter.mpr ⟨hshadow t ht hs, (mem_powersetCard.mp hs).1⟩
    simpa [card_powersetCard, hcard t ht, Nat.choose_succ_self_right] using card_le_card hsub
  have h := card_nsmul_le_card_nsmul rel hbelow hext
  simpa [nsmul_eq_mul, Nat.mul_comm] using h

/-- A witness consists of disjoint sets of size `K`, the first independent,
with all cross-edges absent. No restriction is imposed within the second set. -/
def HasWitness {V : Type*} (G : SimpleGraph V) (K : ℕ) : Prop :=
  ∃ S T : Finset V, S.card = K ∧ T.card = K ∧ Disjoint S T ∧
    G.IsIndepSet S ∧ ∀ x ∈ S, ∀ y ∈ T, ¬ G.Adj x y

/-- In the absence of a witness, all levels of the independence polynomial
from `K` onwards satisfy the quantitative tail bound. -/
theorem tail_count_of_no_witness {V : Type*} [Fintype V] [DecidableEq V]
    (G : SimpleGraph V) [DecidableRel G.Adj] {K r : ℕ}
    (hKr : K ≤ r) (hw : ¬ HasWitness G K) :
    (r + 1) * (G.indepSetFinset (r + 1)).card ≤
      (K - 1) * (G.indepSetFinset r).card := by
  apply count_successive_layers
  · intro t ht
    exact (SimpleGraph.mem_indepSetFinset_iff.mp ht).card_eq
  · intro t ht s hs
    obtain ⟨hsub, hcard⟩ := mem_powersetCard.mp hs
    have hind := (SimpleGraph.mem_indepSetFinset_iff.mp ht).isIndepSet
    exact SimpleGraph.mem_indepSetFinset_iff.mpr ⟨hind.mono hsub, hcard⟩
  · intro s hs
    have hi := SimpleGraph.mem_indepSetFinset_iff.mp hs
    let C := univ.filter (fun v : V => v ∉ s ∧ ∀ x ∈ s, ¬ G.Adj x v)
    have hc : C.card < K := by
      by_contra! h
      obtain ⟨S, hSs, hS⟩ := exists_subset_card_eq (n := K) (s := s) (hi.card_eq ▸ hKr)
      obtain ⟨T, hTC, hT⟩ := exists_subset_card_eq h
      apply hw
      refine ⟨S, T, hS, hT, disjoint_left.mpr ?_, hi.isIndepSet.mono hSs, ?_⟩
      · intro v hvS hvT
        exact (mem_filter.mp (hTC hvT)).2.1 (hSs hvS)
      · intro x hx y hy
        exact (mem_filter.mp (hTC hy)).2.2 x (hSs hx)
    have hsub : (G.indepSetFinset (r+1)).filter (fun t => s ⊆ t) ⊆
        C.image (fun v => insert v s) := by
      intro t ht
      obtain ⟨ht, hst⟩ := mem_filter.mp ht
      have hit := SimpleGraph.mem_indepSetFinset_iff.mp ht
      obtain ⟨v, hv, heq⟩ := exists_eq_insert_iff.mpr
        ⟨hst, by rw [hi.card_eq, hit.card_eq]⟩
      have hvt : v ∈ t := heq ▸ mem_insert_self v s
      refine mem_image.mpr ⟨v, mem_filter.mpr ⟨mem_univ _, hv, ?_⟩, heq⟩
      intro x hx
      exact hit.isIndepSet (hst hx) hvt (fun h => hv (h ▸ hx))
    exact (card_le_card hsub).trans (card_image_le.trans (by omega))

/-- The two events used in the probability argument imply unimodality of the
actual independence polynomial of a finite graph. Here `μ` denotes the model
coefficients on the initial segment. -/
theorem unimodality_on_good_events {V : Type*} [Fintype V] [DecidableEq V]
    (G : SimpleGraph V) [DecidableRel G.Adj] (μ : ℕ → ℝ) {q l u : ℝ} {K : ℕ}
    (hKN : K ≤ Fintype.card V) (hl : 0 < l) (hu : 0 ≤ u)
    (hmodelPos : ∀ i ≤ K, 0 < μ i)
    (hmodel : ∀ i, i + 2 ≤ K → μ i * μ (i + 2) ≤ q * μ (i + 1) ^ 2)
    (hmargin : u ^ 2 * q < l ^ 2)
    (hcoeff : ∀ i ≤ K, l * μ i ≤ ((G.indepSetFinset i).card : ℝ) ∧
      ((G.indepSetFinset i).card : ℝ) ≤ u * μ i)
    (hw : ¬ HasWitness G K) :
    UnimodalThrough (fun i => ((G.indepSetFinset i).card : ℝ)) (Fintype.card V) := by
  apply unimodal_of_initial_logConcavity hKN
  · intro i hi
    exact (mul_pos hl (hmodelPos i hi)).trans_le (hcoeff i hi).1
  · intro i hi
    have hi0 : i ≤ K := by omega
    have hi1 : i + 1 ≤ K := by omega
    exact strict_logConcavity_of_relative_bounds (hmodelPos _ hi0).le (hmodelPos _ hi1)
      (Nat.cast_nonneg _) hl.le hu (hcoeff _ hi0).2 (hcoeff _ hi).2 (hcoeff _ hi1).1
      (hmodel i hi) hmargin
  · intro r hKr _
    have hcount := tail_count_of_no_witness G hKr hw
    have hmul := hcount.trans <| Nat.mul_le_mul_right (G.indepSetFinset r).card
      (show K-1 ≤ r+1 by omega)
    exact_mod_cast (Nat.le_of_mul_le_mul_left hmul (by omega))

end MakowskyRakita
