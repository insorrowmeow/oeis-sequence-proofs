import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Fin
import Mathlib.Data.Finset.Powerset

namespace PowersetSingleDefect

variable {α : Type*} [DecidableEq α]

/-- Peeling off each chosen point produces a surviving point that has seen every label. -/
theorem allLabels (pick : Finset α → α) (hpick : ∀ s, s.Nonempty → pick s ∈ s)
    (s : Finset α) : s.Nonempty →
      ∃ j ∈ s, ∀ x ∈ s, ∃ t ⊆ s, j ∈ t ∧ pick t = x := by
  induction s using Finset.strongInductionOn with
  | _ s ih =>
    intro hs
    have hx := hpick s hs
    by_cases he : (s.erase (pick s)).Nonempty
    · obtain ⟨j, hj, hall⟩ := ih _ (Finset.erase_ssubset hx) he
      have hjs : j ∈ s := Finset.mem_of_mem_erase hj
      refine ⟨j, hjs, ?_⟩
      intro x hxs
      by_cases h : x = pick s
      · exact ⟨s, fun _ hy => hy, hjs, h.symm⟩
      · obtain ⟨t, ht, hjt, hx'⟩ := hall x (Finset.mem_erase.mpr ⟨h, hxs⟩)
        exact ⟨t, ht.trans (Finset.erase_subset _ _), hjt, hx'⟩
    · refine ⟨pick s, hx, ?_⟩
      intro x hxs
      by_cases h : x = pick s
      · exact ⟨s, fun _ hy => hy, hx, h.symm⟩
      · exact (he ⟨x, Finset.mem_erase.mpr ⟨h, hxs⟩⟩).elim

/-- If all nonempty sets of any one color meet pairwise, some point sees all colors. -/
theorem zeroDefects [Fintype α] [Nonempty α] (color : Finset α → α)
    (meet : ∀ s t, s.Nonempty → t.Nonempty → color s = color t →
      ∃ a, a ∈ s ∧ a ∈ t) :
    ∃ j : α, ∀ c : α, ∃ t : Finset α, j ∈ t ∧ color t = c := by
  classical
  let label (x : α) := color {x}
  have hinj : Function.Injective label := by
    intro a b hab
    obtain ⟨x, hx, hy⟩ :=
      meet {a} {b} (Finset.singleton_nonempty _) (Finset.singleton_nonempty _) hab
    exact (Finset.mem_singleton.mp hx).symm.trans (Finset.mem_singleton.mp hy)
  have hsur := Finite.surjective_of_injective hinj
  choose inv hinv using hsur
  let pick (s : Finset α) := inv (color s)
  have hmem (s : Finset α) (hs : s.Nonempty) : pick s ∈ s := by
    obtain ⟨a, ha, has⟩ := meet {pick s} s (Finset.singleton_nonempty _) hs (hinv _)
    rwa [Finset.mem_singleton.mp ha] at has
  obtain ⟨j, _, hall⟩ := allLabels pick hmem Finset.univ Finset.univ_nonempty
  refine ⟨j, fun c => ?_⟩
  obtain ⟨t, _, hjt, ht⟩ := hall (inv c) (Finset.mem_univ _)
  exact ⟨t, hjt, (hinv (color t)).symm.trans ((congrArg label ht).trans (hinv c))⟩

theorem atLeastOneDefect [Fintype α] [Nonempty α] (color : Finset α → α)
    (omits : ∀ j : α, ∃ c : α, ∀ s : Finset α, j ∈ s → color s ≠ c) :
    ∃ s t : Finset α, s.Nonempty ∧ t.Nonempty ∧ color s = color t ∧ Disjoint s t := by
  classical
  by_contra h
  obtain ⟨j, hj⟩ := zeroDefects color (fun s t hs ht he =>
    Finset.not_disjoint_iff.mp fun hd => h ⟨s, t, hs, ht, he, hd⟩)
  obtain ⟨c, hc⟩ := omits j
  obtain ⟨t, hjt, ht⟩ := hj c
  exact hc t hjt ht

abbrev Three := Fin 3

def baseColor (s : Finset Three) : Three :=
  if 2 ∉ s then 0 else if s = {2} then 1 else 2

theorem baseMissing :
    ∀ j : Three, ∃ c : Three, ∀ s ∈ (Finset.univ : Finset Three).powerset,
      j ∈ s → baseColor s ≠ c := by decide

theorem baseUniqueDefect :
    ∀ s ∈ (Finset.univ : Finset Three).powerset,
      ∀ t ∈ (Finset.univ : Finset Three).powerset, s.Nonempty → t.Nonempty →
        ((baseColor s = baseColor t ∧ Disjoint s t) ↔
          ((s = {0} ∧ t = {1}) ∨ (s = {1} ∧ t = {0}))) := by decide

theorem baseUsesAll :
    ∀ c : Three, ∃ s ∈ (Finset.univ : Finset Three).powerset,
      s.Nonempty ∧ baseColor s = c := by decide

section Extension

variable {β : Type*} [DecidableEq β]

private def core (s : Finset (Three ⊕ β)) : Finset Three :=
  Finset.univ.filter fun x => Sum.inl x ∈ s

private def embed (s : Finset Three) : Finset (Three ⊕ β) :=
  s.image Sum.inl

@[simp] private theorem inl_embed (x : Three) (s : Finset Three) :
    (Sum.inl x : Three ⊕ β) ∈ embed s ↔ x ∈ s := by simp [embed]

@[simp] private theorem inr_embed (x : β) (s : Finset Three) :
    (Sum.inr x : Three ⊕ β) ∉ embed s := by simp [embed]

private theorem pure (s : Finset (Three ⊕ β)) (h : ¬ ∃ x : β, Sum.inr x ∈ s) :
    s = embed (core s) := by
  ext a
  cases a with
  | inl x => simp [core]
  | inr x => simp [not_exists.mp h x]

noncomputable def construction (s : Finset (Three ⊕ β)) : Three ⊕ β := by
  classical
  exact if h : ∃ x : β, Sum.inr x ∈ s then Sum.inr h.choose else Sum.inl (baseColor (core s))

@[simp] private theorem onEmbed (s : Finset Three) :
    construction (embed s : Finset (Three ⊕ β)) = Sum.inl (baseColor s) := by
  classical
  have hx : core (embed s : Finset (Three ⊕ β)) = s := by ext x; simp [core]
  simp [construction, hx]

private theorem inr_color {s : Finset (Three ⊕ β)} {c : β}
    (hc : construction s = Sum.inr c) : Sum.inr c ∈ s := by
  classical
  unfold construction at hc
  split at hc
  next h => exact (Sum.inr.inj hc) ▸ h.choose_spec
  next => contradiction

private theorem inl_color {s : Finset (Three ⊕ β)} {c : Three}
    (hc : construction s = Sum.inl c) : s = embed (core s) := by
  classical
  unfold construction at hc
  split at hc
  next => contradiction
  next h => exact pure s h

theorem constructionOmits (j : Three ⊕ β) :
    ∃ c : Three ⊕ β, ∀ s : Finset (Three ⊕ β), j ∈ s → construction s ≠ c := by
  cases j with
  | inl j =>
    obtain ⟨c, hc⟩ := baseMissing j
    refine ⟨Sum.inl c, ?_⟩
    intro s hj hs
    obtain ⟨t, rfl⟩ : ∃ t : Finset Three, s = embed t := ⟨_, inl_color hs⟩
    exact hc t (Finset.mem_powerset.mpr (Finset.subset_univ _)) (inl_embed _ _ |>.mp hj)
      (Sum.inl.inj ((onEmbed t).symm.trans hs))
  | inr j =>
    refine ⟨Sum.inl 0, ?_⟩
    intro s hj hs
    rw [inl_color hs] at hj
    exact inr_embed _ _ hj

theorem constructionUsesAll (c : Three ⊕ β) :
    ∃ s : Finset (Three ⊕ β), s.Nonempty ∧ construction s = c := by
  classical
  cases c with
  | inl c =>
    obtain ⟨t, _, ⟨a, ha⟩, ht⟩ := baseUsesAll c
    exact ⟨embed t, ⟨Sum.inl a, (inl_embed a t).mpr ha⟩, by simp [ht]⟩
  | inr c =>
    have h : ∃ x : β, Sum.inr x ∈ ({Sum.inr c} : Finset (Three ⊕ β)) :=
      ⟨c, Finset.mem_singleton_self _⟩
    exact ⟨{Sum.inr c}, Finset.singleton_nonempty _, by
      simp [construction, h]⟩

theorem constructionDefects (s t : Finset (Three ⊕ β)) (hs : s.Nonempty) (ht : t.Nonempty) :
    (construction s = construction t ∧ Disjoint s t) ↔
      ((s = {Sum.inl 0} ∧ t = {Sum.inl 1}) ∨ (s = {Sum.inl 1} ∧ t = {Sum.inl 0})) := by
  constructor
  · rintro ⟨he, hd⟩
    cases hc : construction t with
    | inr c =>
      exact (Finset.disjoint_left.mp hd (inr_color (he.trans hc)) (inr_color hc)).elim
    | inl c =>
      obtain ⟨a, rfl⟩ : ∃ a : Finset Three, s = embed a := ⟨_, inl_color (he.trans hc)⟩
      obtain ⟨b, rfl⟩ : ∃ b : Finset Three, t = embed b := ⟨_, inl_color hc⟩
      have ha : a.Nonempty := by simpa [embed] using hs
      have hb : b.Nonempty := by simpa [embed] using ht
      have hab : Disjoint a b := Finset.disjoint_left.mpr fun x hx hy =>
        Finset.disjoint_left.mp hd ((inl_embed x a).mpr hx) ((inl_embed x b).mpr hy)
      have heq : baseColor a = baseColor b := by simpa using he
      have hu := (baseUniqueDefect a (by simp) b (by simp) ha hb).mp ⟨heq, hab⟩
      rcases hu with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> simp [embed]
  · rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩) <;>
      simp [construction, core, baseColor, Finset.disjoint_singleton_left]

end Extension

end PowersetSingleDefect
