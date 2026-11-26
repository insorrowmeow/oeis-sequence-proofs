import InverseBase

namespace Inverse

namespace Prefix

private abbrev size : Nat := 32
private abbrev last : Nat := 4 * size

/-- Literal candidate values at indices 0..128; all entries are kernel-checked below. -/
private def values : List Nat := [
  0, 1, 4, 2, 8, 10, 5, 14, 7, 3, 20, 22, 11, 26, 13,
  6, 32, 16, 36, 18, 9, 42, 21, 46, 23, 50, 25, 12, 56, 28,
  60, 30, 15, 66, 33, 70, 35, 17, 76, 38, 19, 82, 41, 86, 43,
  90, 45, 94, 47, 98, 49, 24, 104, 52, 108, 54, 27, 114, 57, 118,
  59, 29, 124, 62, 31, 130, 65, 134, 67, 138, 69, 34, 144, 72, 148,
  74, 37, 154, 77, 158, 79, 39, 164, 166, 83, 170, 85, 174, 87, 178,
  89, 44, 184, 92, 188, 190, 95, 194, 97, 48, 200, 100, 204, 102, 51,
  210, 105, 214, 107, 53, 220, 110, 55, 226, 113, 230, 115, 234, 117, 58,
  240, 120, 244, 122, 61, 250, 125, 254, 127]

/-- Inverse candidate. The default 129 places absent values beyond the finite prefix. -/
private def positions : List Nat := [
  0, 1, 3, 9, 2, 6, 15, 8, 4, 20, 5, 12, 27, 14, 7,
  32, 17, 37, 19, 40, 10, 22, 11, 24, 51, 26, 13, 56, 29, 61,
  31, 64, 16, 34, 71, 36, 18, 76, 39, 81, 129, 42, 21, 44, 91,
  46, 23, 48, 99, 50, 25, 104, 53, 109, 55, 112, 28, 58, 119, 60,
  30, 124, 63, 129, 129, 66, 33, 68, 129, 70, 35, 129, 73, 129, 75,
  129, 38, 78, 129, 80, 129, 129, 41, 84, 129, 86, 43, 88, 129, 90,
  45, 129, 93, 129, 47, 96, 129, 98, 49, 129, 101, 129, 103, 129, 52,
  106, 129, 108, 54, 129, 111, 129, 129, 114, 57, 116, 129, 118, 59, 129,
  121, 129, 123, 129, 62, 126, 129, 128, 129, 129, 65, 129, 129, 129, 67,
  129, 129, 129, 69, 129, 129, 129, 129, 129, 72, 129, 129, 129, 74, 129,
  129, 129, 129, 129, 77, 129, 129, 129, 79, 129, 129, 129, 129, 129, 82,
  129, 83, 129, 129, 129, 85, 129, 129, 129, 87, 129, 129, 129, 89, 129,
  129, 129, 129, 129, 92, 129, 129, 129, 94, 129, 95, 129, 129, 129, 97,
  129, 129, 129, 129, 129, 100, 129, 129, 129, 102, 129, 129, 129, 129, 129,
  105, 129, 129, 129, 107, 129, 129, 129, 129, 129, 110, 129, 129, 129, 129,
  129, 113, 129, 129, 129, 115, 129, 129, 129, 117, 129, 129, 129, 129, 129,
  120, 129, 129, 129, 122, 129, 129, 129, 129, 129, 125, 129, 129, 129, 127,
  129, 129]

private def atTime (i : Nat) := values[i]?.getD 0
private def atValue (v : Nat) := positions[v]?.getD (last+1)

private def checkAt (i : Nat) : Bool := decide (
  atValue (atTime i) = i ∧
  (1 ≤ i → i < last →
    let x := atTime i / 2
    if atValue x ≤ i then atTime (atValue x) = x ∧ atTime (i+1) = 2*(i+1)
    else atTime (i+1) = x))

set_option maxRecDepth 10000 in
set_option maxHeartbeats 4000000 in
/-- The checker validates both indices and the decision taken at every step.
It also verifies the proposed exclusion on the indicated range. -/
private theorem certificate :
    atTime 0 = 0 ∧ atTime 1 = 1 ∧
    (List.range (last+1)).all checkAt = true ∧
    (List.range size).all (fun v => decide (1<v → atTime (4*v+4) ≠ v)) = true := by
  decide +kernel

private theorem checked (i : Nat) (hi : i ≤ last) :
    atValue (atTime i) = i ∧
    (1 ≤ i → i < last →
      let x := atTime i / 2
      if atValue x ≤ i then atTime (atValue x) = x ∧ atTime (i+1) = 2*(i+1)
      else atTime (i+1) = x) := by
  have test := List.all_eq_true.mp certificate.2.2.1 i (List.mem_range.mpr (by omega))
  exact of_decide_eq_true test

private theorem agrees (i : Nat) (hi : i ≤ last) : atTime i = DoubleHalf.value i := by
  induction i using Nat.strongRecOn with
  | ind i ih =>
    cases i with
    | zero => exact certificate.1.trans DoubleHalf.value_rule.zero.symm
    | succ j =>
      by_cases zero : j = 0
      · subst j
        exact certificate.2.1.trans DoubleHalf.value_rule.one.symm
      have hj : 1 ≤ j := by omega
      have halfEq : atTime j / 2 = DoubleHalf.value j / 2 := by
        rw [ih j (by omega) (by omega)]
      have rule := (checked j (by omega)).2 hj (by omega)
      dsimp only at rule
      by_cases seen : atValue (atTime j / 2) ≤ j
      · rw [if_pos seen] at rule
        have earlier : DoubleHalf.Seen DoubleHalf.value j (DoubleHalf.value j / 2) := by
          refine ⟨atValue (atTime j / 2), seen, ?_⟩
          rw [← ih _ (by omega) (by omega)]
          exact rule.1.trans halfEq
        rcases DoubleHalf.value_rule.step j hj with ⟨_, doubled⟩ | ⟨fresh, _⟩
        · exact rule.2.trans doubled.symm
        · exact (fresh earlier).elim
      · rw [if_neg seen] at rule
        have fresh : ¬ DoubleHalf.Seen DoubleHalf.value j (DoubleHalf.value j / 2) := by
          rintro ⟨p, hp, he⟩
          have hp' : atTime p = atTime j / 2 := (ih p (by omega) (by omega)).trans (he.trans halfEq.symm)
          have hpos := (checked p (by omega)).1
          rw [hp'] at hpos
          exact seen (hpos ▸ hp)
        rcases DoubleHalf.value_rule.step j hj with ⟨old, _⟩ | ⟨_, halved⟩
        · exact (fresh old).elim
        · exact rule.trans (halfEq.trans halved.symm)

theorem good (v : Nat) (hv : 1 < v) (small : v < size) : ¬ Cell v (4*v+4) := by
  have test := List.all_eq_true.mp certificate.2.2.2 v (List.mem_range.mpr small)
  have excluded : 1 < v → atTime (4*v+4) ≠ v := of_decide_eq_true test
  intro h
  apply excluded hv
  exact (agrees _ (by dsimp [size, last] at small ⊢; omega)).trans h

end Prefix

theorem prefix_good : ∀ v, 1 < v → v < 32 → ¬ Cell v (4*v+4) := Prefix.good

end Inverse
