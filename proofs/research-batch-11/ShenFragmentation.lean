import Mathlib.Data.List.Basic

namespace ShenFragmentation

variable {V : Type*} (rank : V → V → ℕ)

/-- All edges of the candidate's star precede all edges of the remainder. -/
def StarFirst (v : V) (rest : List V) : Prop :=
  ∀ x ∈ rest, ∀ y ∈ rest, ∀ z ∈ rest, y ≠ z → rank v x < rank y z

/-- The list gives a successful vertex removal order. -/
def Peels : List V → Prop
  | [] => True
  | v :: rest => StarFirst rank v rest ∧ Peels rest

/-- Restricting a successful removal order to any sublist preserves success. -/
theorem sublist_peels {l t : List V} (h : t.Sublist l) : Peels rank l → Peels rank t := by
  induction h with
  | slnil => exact id
  | cons _ _ ih => exact fun h => ih h.2
  | cons₂ _ h ih =>
    intro hfull
    refine ⟨?_, ih hfull.2⟩
    intro x hx y hy z hz hne
    exact hfull.1 x (h.subset hx) y (h.subset hy) z (h.subset hz) hne

/-- In particular, choosing any subset of the vertices gives a valid order. -/
theorem filter_peels {l : List V} (p : V → Bool) (h : Peels rank l) :
    Peels rank (l.filter p) := sublist_peels rank List.filter_sublist h

end ShenFragmentation
