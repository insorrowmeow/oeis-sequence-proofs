import Std

namespace DoubleHalf

def Seen (a : Nat → Nat) (t x : Nat) : Prop := ∃ i, i ≤ t ∧ a i = x

/-- Index 0 is a sentinel. From index 2 onward, use half the preceding
value when it is fresh, or use twice the current index otherwise. -/
structure Rule (a : Nat → Nat) : Prop where
  zero : a 0 = 0
  one : a 1 = 1
  step (t : Nat) (ht : 1 ≤ t) :
    (Seen a t (a t / 2) ∧ a (t+1) = 2*(t+1)) ∨
    (¬ Seen a t (a t / 2) ∧ a (t+1) = a t / 2)

private theorem seen_mono {a : Nat → Nat} {t u x : Nat} (h : Seen a t x) (htu : t ≤ u) :
    Seen a u x := by
  obtain ⟨j,hj,he⟩ := h
  exact ⟨j,by omega,he⟩

private theorem bound {a : Nat → Nat} (h : Rule a) (t : Nat) : a t ≤ 2*t := by
  induction t with
  | zero => simp [h.zero]
  | succ t ih =>
    by_cases hz : t = 0
    · subst t; simp [h.one]
    rcases h.step t (by omega) with ⟨_,ht⟩ | ⟨_,ht⟩ <;> omega

private theorem fresh {a : Nat → Nat} (h : Rule a) (t : Nat) :
    ¬ Seen a t (a (t+1)) := by
  by_cases hz : t=0
  · subst t
    intro ⟨i,hi,he⟩
    have : i=0 := by omega
    subst i; simp [h.zero,h.one] at he
  rcases h.step t (by omega) with ⟨_,ht⟩ | ⟨hm,ht⟩
  · intro ⟨i,hi,he⟩
    have hb := bound h i
    omega
  · rwa [ht]

theorem injective {a : Nat → Nat} (h : Rule a) {i j : Nat} (he : a i = a j) : i=j := by
  have monotoneDistinct {s t : Nat} (hst : s < t) : a s ≠ a t := by
    cases t with
    | zero => omega
    | succ t => exact fun eq => fresh h t ⟨s,by omega,eq⟩
  by_cases hi : i < j
  · exact False.elim (monotoneDistinct hi he)
  by_cases hj : j < i
  · exact False.elim (monotoneDistinct hj he.symm)
  omega

/-- If a value has appeared, its integer half has appeared by the next step. -/
private theorem seen_half {a : Nat → Nat} (h : Rule a) {t x : Nat} (hx : Seen a t x) :
    Seen a (t+1) (x/2) := by
  obtain ⟨i,hi,rfl⟩ := hx
  by_cases hz : i = 0
  · subst i; exact ⟨0,by omega,by simp [h.zero]⟩
  rcases h.step i (by omega) with ⟨old,_⟩ | ⟨_,new⟩
  · exact seen_mono old (by omega)
  · exact ⟨i+1,by omega,new⟩

theorem seen_by {a : Nat → Nat} (h : Rule a) (n : Nat) : Seen a (4*n+5) n := by
  induction n using Nat.strongRecOn with
  | ind n ih =>
    by_cases hn0 : n=0
    · subst n; exact ⟨0,by decide,h.zero⟩
    by_cases hn1 : n=1
    · subst n; exact ⟨1,by decide,h.one⟩
    apply Classical.byContradiction
    intro hn
    have halve {i : Nat} (lo : 4*n ≤ i+1) (hi : i+1 ≤ 4*n+2) :
        a (i+1) = a i/2 := by
      rcases h.step i (by omega) with ⟨_,dbl⟩ | ⟨_,half⟩
      · have hs : Seen a (i+1) (2*(i+1)) := ⟨i+1,by omega,dbl⟩
        have s1 := seen_half h hs
        have s2 := seen_half h s1
        have s3 := seen_half h s2
        have e : 2*(i+1)/2/2/2=n := by omega
        rw [e] at s3
        exact False.elim (hn (seen_mono s3 (by omega)))
      · exact half
    let t := 4*n-1
    have ht : t+1 = 4*n := by dsimp [t]; omega
    have h1 := halve (i:=t) (by omega) (by omega)
    have h2 := halve (i:=t+1) (by omega) (by omega)
    have h3 := halve (i:=t+2) (by omega) (by omega)
    change a (t+2) = a (t+1)/2 at h2
    change a (t+3) = a (t+2)/2 at h3
    let m := a (t+3)
    have hb := bound h t
    have hm : m < n := by dsimp [m]; omega
    have hold := ih m (by omega)
    exact fresh h (t+2) (seen_mono hold (by omega))

/- The recurrence itself, using its original indices. -/
open Classical in
noncomputable def value (n : Nat) : Nat :=
  if hz : n=0 then 0 else if n=1 then 1 else
    let half := value (n-1) / 2
    if ∃ i : Fin n, value i.val = half then 2*n else half
termination_by n
decreasing_by
  all_goals first | omega | exact Fin.isLt _

theorem value_rule : Rule value := by
  constructor
  · rw [value]; simp
  · rw [value]; simp
  · intro t ht
    rw [value.eq_def (t+1)]
    simp only [show ¬ t+1=0 by omega, ↓reduceDIte, Nat.add_sub_cancel,
      show ¬ t+1=1 by omega, ↓reduceIte]
    have seen : (∃ i : Fin (t+1), value i.val = value t/2) ↔ Seen value t (value t/2) :=
      ⟨fun ⟨i,e⟩ => ⟨i.val,by have := i.isLt; omega,e⟩,
       fun ⟨i,hi,e⟩ => ⟨⟨i,by omega⟩,e⟩⟩
    by_cases existsVal : ∃ i : Fin (t+1), value i.val = value t/2
    · exact Or.inl ⟨seen.mp existsVal,by simp [existsVal]⟩
    · exact Or.inr ⟨fun hx => existsVal (seen.mpr hx),by simp [existsVal]⟩

/-- Every positive integer occurs at exactly one positive index, bounded by 4n+5. -/
theorem a050128 (n : Nat) (hn : 0<n) :
    ∃ i, 0<i ∧ i≤4*n+5 ∧ value i=n ∧ ∀ j, value j=n → j=i := by
  obtain ⟨i,hi,he⟩ := seen_by value_rule n
  have hpos : 0<i := by
    by_cases hz : i=0
    · subst i; rw [value_rule.zero] at he; omega
    · omega
  exact ⟨i,hpos,hi,he,fun j hj => injective value_rule (hj.trans he.symm)⟩

/-- Partial result towards Israel's inverse conjecture A050129: the single
additional position not in the conjectured six-element list is 4n+4. -/
theorem seven_positions (i n : Nat) (hn : 1<n) (he : value i=n) :
    2*i=n ∨ i=n+1 ∨ i=2*n+2 ∨ i=2*n+3 ∨
    i=4*n+3 ∨ i=4*n+4 ∨ i=4*n+5 := by
  obtain ⟨j,_,hb,hj,_⟩ := a050128 n (by omega)
  have ji := injective value_rule (hj.trans he.symm)
  have step_or (t : Nat) (ht : 1<t) : value t = 2*t ∨ value t = value (t-1)/2 := by
    have h := value_rule.step (t-1) (by omega)
    rw [show t-1+1=t by omega] at h
    exact h.elim (fun h => Or.inl h.2) (fun h => Or.inr h.2)
  have first : value 0=0 := value_rule.zero
  have second : value 1=1 := value_rule.one
  have hi : 1<i := by
    by_cases hz : i=0
    · rw [hz,first] at he; omega
    by_cases ho : i=1
    · rw [ho,second] at he; omega
    omega
  rcases step_or i hi with hi0|h1
  · omega
  have hprev : 1<i-1 := by
    by_cases hz : i-1=1
    · rw [hz,second] at h1; omega
    omega
  rcases step_or (i-1) hprev with hi1|h2
  · omega
  have hh : 1<i-1-1 := by
    by_cases hz : i-1-1=1
    · rw [hz,second] at h2; omega
    omega
  rcases step_or (i-1-1) hh with hi2|h3
  · omega
  have hhh : 1<i-1-1-1 := by
    by_cases hz : i-1-1-1=1
    · rw [hz,second] at h3; omega
    omega
  rcases step_or (i-1-1-1) hhh with hi3|h4
  · omega
  · have hbound := bound value_rule (i-1-1-1-1)
    omega

end DoubleHalf
