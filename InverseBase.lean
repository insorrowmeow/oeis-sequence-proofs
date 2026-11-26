import DoubleHalf

namespace Inverse

abbrev Cell (v t : Nat) : Prop := DoubleHalf.value t = v

def Allowed (n v t : Nat) : Prop :=
  2*t = v ∨ t = v+1 ∨ t = 2*v+2 ∨ t = 2*v+3 ∨ t = 4*v+3 ∨
  t = 4*v+5 ∨ (n ≤ v ∧ t = 4*v+4)

def GoodBelow (n : Nat) : Prop := ∀ v, 1 < v → v < n → ¬ Cell v (4*v+4)

theorem allowed_of_cell {n v t : Nat} (g : GoodBelow n) (hv : 1 < v) (h : Cell v t) :
    Allowed n v t := by
  have seven := DoubleHalf.seven_positions t v hv h
  have exceptional (ht : t = 4*v+4) : n ≤ v := by
    apply Nat.le_of_not_gt
    intro small
    exact g v hv small (ht ▸ h)
  unfold Allowed
  omega

theorem row (n v : Nat) (g : GoodBelow n) (hv : 1 < v) :
    ∃ t, Cell v t ∧ Allowed n v t := by
  obtain ⟨t, _, _, h, _⟩ := DoubleHalf.a050128 v (by omega)
  exact ⟨t, h, allowed_of_cell g hv h⟩

theorem row_eq {v s t : Nat} (hs : Cell v s) (ht : Cell v t) : s = t :=
  DoubleHalf.injective DoubleHalf.value_rule (hs.trans ht.symm)

theorem col_eq {v w t : Nat} (hv : Cell v t) (hw : Cell w t) : v = w :=
  hv.symm.trans hw

theorem col (n t : Nat) (g : GoodBelow n) (ht : 1 < t) :
    ∃ v, Cell v t ∧ 1 < v ∧ Allowed n v t := by
  let v := DoubleHalf.value t
  have h : Cell v t := rfl
  have hv : 1 < v := by
    have nz : v ≠ 0 := by
      intro h0
      have := row_eq (h0 ▸ h) DoubleHalf.value_rule.zero
      omega
    have no : v ≠ 1 := by
      intro h1
      have := row_eq (h1 ▸ h) DoubleHalf.value_rule.one
      omega
    omega
  exact ⟨v, h, hv, allowed_of_cell g hv h⟩

theorem half_time {v t ch u : Nat} (h : Cell v t) (hc : Cell ch u) (hu : 1 ≤ u)
    (hch : ch = 2*v ∨ ch = 2*v+1) : t ≤ u+1 := by
  have halved : DoubleHalf.value u / 2 = v := by
    change DoubleHalf.value u = ch at hc
    rw [hc]
    omega
  rcases DoubleHalf.value_rule.step u hu with ⟨⟨i, hi, he⟩, _⟩ | ⟨_, he⟩
  · have it := row_eq (he.trans halved) h
    omega
  · have it := row_eq (he.trans halved) h
    omega

theorem parent {v t : Nat} (h : Cell v t) (ht : 1 < t) (hd : 2*t ≠ v) :
    Cell (2*v) (t-1) ∨ Cell (2*v+1) (t-1) := by
  have step := DoubleHalf.value_rule.step (t-1) (by omega)
  rw [show t-1+1=t by omega] at step
  change DoubleHalf.value t = v at h
  unfold Cell
  rcases step with ⟨_, doubled⟩ | ⟨_, halved⟩ <;> omega

end Inverse
