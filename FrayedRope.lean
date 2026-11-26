import Mathlib.Data.Nat.Digits
import Mathlib.Data.Fintype.EquivFin
import Mathlib.Data.Finset.Lattice.Fold
import Mathlib.Data.Nat.Find

/-! Bijection for OEIS A340138. Zero-based indices: term 0 = 0.
The primary description is Michael De Vlieger, The Frayed Rope Sequence. -/
namespace FrayedRope

def digitalRoot (x : ℕ) : ℕ :=
  if x = 0 then 0 else (x - 1) % 9 + 1

private theorem root_lt (x : ℕ) : digitalRoot x < 10 := by
  unfold digitalRoot
  split <;> omega

-- The suffix 1234567890 makes a marker eligible for any request.
def marker (d k : ℕ) : ℕ := 1234567890 + 10000000000 * (d + 9*k)

private theorem marker_digit {r : ℕ} (hr : r < 10) (d k : ℕ) :
    r ∈ Nat.digits 10 (marker d k) := by
  let suffix : List ℕ := [0,9,8,7,6,5,4,3,2,1]
  have digitsSuffix : Nat.digits 10 1234567890 = suffix := by
    change Nat.digits 10 (Nat.ofDigits 10 suffix) = suffix
    apply Nat.digits_ofDigits _ (by decide)
    · simp [suffix]
    · intro h
      exact Nat.one_ne_zero
  have allDigits : ∀ i : Fin 10, i.val ∈ Nat.digits 10 1234567890 := by
    rw [digitsSuffix]; decide
  have lengthSuffix : (Nat.digits 10 1234567890).length = 10 := by rw [digitsSuffix]; rfl
  have h := Nat.digits_append_digits (b := 10) (n := 1234567890) (m := d + 9*k) (by decide)
  rw [lengthSuffix] at h
  change r ∈ Nat.digits 10 (1234567890 + 10^10 * (d + 9*k))
  rw [← h]
  exact List.mem_append_left _ (allDigits ⟨r, hr⟩)

private theorem marker_root {d : ℕ} (hd : 0 < d) (hd' : d < 10) (k : ℕ) :
    digitalRoot (marker d k) = d := by
  simp only [digitalRoot, marker]
  split <;> omega

private def Eligible (last : ℕ) (seen : Finset ℕ) (y : ℕ) : Prop :=
  y ∉ seen ∧ digitalRoot last ∈ Nat.digits 10 y

private theorem next_exists (last : ℕ) (seen : Finset ℕ) :
    ∃ y, Eligible last seen y := by
  let bound := seen.sup id
  refine ⟨marker 1 bound, ?_, marker_digit (root_lt last) _ _⟩
  intro h
  have hle : marker 1 bound ≤ bound := Finset.le_sup (f := id) h
  unfold marker at hle
  omega

private noncomputable def next (last : ℕ) (seen : Finset ℕ) : ℕ := by
  classical
  exact Nat.find (next_exists last seen)

private theorem next_ok (last : ℕ) (seen : Finset ℕ) :
    Eligible last seen (next last seen) := by
  classical
  exact Nat.find_spec (next_exists last seen)

private theorem next_le {last y : ℕ} {seen : Finset ℕ} (hy : Eligible last seen y) :
    next last seen ≤ y := by
  classical
  exact Nat.find_min' (next_exists last seen) hy

private noncomputable def state : ℕ → ℕ × Finset ℕ
  | 0 => (0, {0})
  | n+1 => let (last, seen) := state n
           let y := next last seen
           (y, insert y seen)

noncomputable def term (n : ℕ) : ℕ := (state n).1

private theorem seen_iff (n y : ℕ) :
    y ∈ (state n).2 ↔ ∃ i ≤ n, term i = y := by
  induction n with
  | zero => simp [state, term, eq_comm]
  | succ n ih =>
    change y ∈ insert (term (n+1)) (state n).2 ↔ _
    rw [Finset.mem_insert, ih]
    constructor
    · rintro (h | ⟨i, hi, he⟩)
      · exact ⟨_, le_rfl, h.symm⟩
      · exact ⟨i, by omega, he⟩
    · rintro ⟨i, hi, he⟩
      by_cases h : i = n+1
      · exact Or.inl (h ▸ he).symm
      · exact Or.inr ⟨i, by omega, he⟩

theorem term_injective : Function.Injective term := by
  have distinct {i j : ℕ} (lt : i < j) : term i ≠ term j := by
    obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : j ≠ 0)
    intro e
    exact (next_ok (term n) (state n).2).1 ((seen_iff n _).2 ⟨i, by omega, e⟩)
  intro i j h
  rcases lt_trichotomy i j with hlt | he | hgt
  · exact False.elim (distinct hlt h)
  · exact he
  · exact False.elim (distinct hgt h.symm)

private theorem not_bounded {f : ℕ → ℕ} (hf : Function.Injective f) (y : ℕ) :
    ¬ ∀ i, f i ≤ y := by
  intro h
  let g (i : ℕ) : Fin (y+1) := ⟨f i, Nat.lt_succ_of_le (h i)⟩
  exact not_injective_infinite_finite g (fun _ _ e => hf (congrArg Fin.val e))

private theorem le_if_absent {y : ℕ} (absent : ¬ ∃ i, term i = y)
    (n : ℕ) (hd : digitalRoot (term n) ∈ Nat.digits 10 y) : term (n+1) ≤ y := by
  apply next_le (last := term n) (seen := (state n).2)
  refine ⟨?_, hd⟩
  intro mem
  obtain ⟨i, _, eq⟩ := (seen_iff n y).1 mem
  exact absent ⟨i, eq⟩

private theorem marker_occurs (d k : ℕ) : ∃ n, term n = marker d k := by
  by_contra absent
  apply not_bounded (f := fun n => term (n+1)) (fun _ _ e => Nat.succ.inj (term_injective e))
      (marker d k)
  exact fun n => le_if_absent absent n (marker_digit (root_lt _) d k)

theorem term_surjective : Function.Surjective term := by
  intro y
  by_cases hy : y = 0
  · exact ⟨0, hy.symm⟩
  let digits := Nat.digits 10 y
  have hn : digits ≠ [] := Nat.digits_ne_nil_iff_ne_zero.mpr hy
  let d := digits.getLast hn
  have hmem : d ∈ digits := List.getLast_mem hn
  have hdpos : 0 < d := Nat.pos_of_ne_zero (Nat.getLast_digit_ne_zero 10 hy)
  have hdlt : d < 10 := Nat.digits_lt_base (by decide) hmem
  choose index hindex using marker_occurs d
  have hinj : Function.Injective index := by
    intro j k e
    have same := (hindex j).symm.trans ((congrArg term e).trans (hindex k))
    unfold marker at same
    omega
  by_contra absent
  apply not_bounded (f := fun k => term (index k + 1))
      (fun _ _ e => hinj (Nat.succ.inj (term_injective e))) y
  intro k
  apply le_if_absent absent
  rwa [hindex, marker_root hdpos hdlt]

theorem A340138_permutation : Function.Bijective term := ⟨term_injective, term_surjective⟩

#print axioms A340138_permutation
end FrayedRope
