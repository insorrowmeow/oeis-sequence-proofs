import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Fin

/-! A criterion for finite coefficient sequences and an exact shifted-shape example. -/

namespace ShiftedUnimodality

/-- The coefficients on [0,N] weakly increase to some index and weakly decrease after it. -/
def UnimodalThrough (a : ℕ → ℝ) (N : ℕ) : Prop :=
  ∃ m ≤ N, (∀ i < m, a i ≤ a (i+1)) ∧ (∀ i, m ≤ i → i < N → a (i+1) ≤ a i)

/-- The center uses every second difference whose three indices belong to [L,R].
The first and last differences at the interfaces are covered even when L=R or R=N. -/
theorem of_increasing_concave_decreasing {a : ℕ → ℝ} {L R N : ℕ}
    (hLR : L ≤ R) (hRN : R ≤ N)
    (hleft : ∀ i < L, a i ≤ a (i+1))
    (hcenter : ∀ i, L ≤ i → i+2 ≤ R → a (i+2) - 2*a (i+1) + a i ≤ 0)
    (hright : ∀ i, R ≤ i → i < N → a (i+1) ≤ a i) :
    UnimodalThrough a N := by
  classical
  let P := fun i : ℕ => R ≤ i ∨ (L ≤ i ∧ a (i + 1) ≤ a i)
  have hex : ∃ i, P i := ⟨R, Or.inl le_rfl⟩
  let m := Nat.find hex
  have hmR : m ≤ R := Nat.find_min' hex (Or.inl le_rfl)
  have hm : P m := Nat.find_spec hex
  have hLm : L ≤ m := hm.elim (fun h => hLR.trans h) And.left
  refine ⟨m, hmR.trans hRN, ?_, ?_⟩
  · intro i hi
    by_cases h : i < L
    · exact hleft i h
    · have hn : ¬ P i := Nat.find_min hex hi
      exact (lt_of_not_ge (fun hdec => hn (Or.inr ⟨Nat.le_of_not_gt h, hdec⟩))).le
  · intro i hmi
    induction i, hmi using Nat.le_induction with
    | base => exact fun h => hm.elim (fun hR => hright m hR h) And.right
    | succ i hi ih =>
      intro hiN
      by_cases h : R ≤ i + 1
      · exact hright (i+1) h hiN
      · have hprev := ih (by omega)
        have hsecond := hcenter i (hLm.trans hi) (by omega)
        linarith

/-- Each positive row length (j+1) uses one branch and limits the next row to j.
Zero ends the partition and contributes one empty continuation. -/
def sizes : List ℕ → ℕ → List ℕ
  | [], _ => [0]
  | bound :: rows, cap =>
    0 :: ((List.range (min bound cap)).flatMap fun j =>
      (sizes rows j).map fun k => (j + 1) + k)

/-- Coefficients through the area of the bounding shape. -/
def coefficients (shape : List ℕ) : List ℕ :=
  let weights := sizes shape (shape.headD 0)
  (List.range (shape.sum + 1)).map fun k => weights.count k

def exampleShape : List ℕ := [14,13,11,10,9]

def exampleCounts : List ℕ := [1,1,1,2,2,3,4,5,6,8,10,12,15,18,22,26,30,35,41,47,
  54,61,69,77,86,94,103,111,119,125,133,137,142,144,146,145,144,139,135,127,
  120,110,101,90,80,69,59,49,40,31,24,18,13,9,6,4,2,1]

set_option maxRecDepth 12000 in
set_option maxHeartbeats 2000000 in
theorem example_coefficients : coefficients exampleShape = exampleCounts := by decide +kernel

/-- The coefficient at rank 34 is the unique global maximum, attained by 146 partitions. -/
theorem example_unique_peak :
    (coefficients exampleShape)[34]? = some 146 ∧
    ∀ i : Fin 58, i.val ≠ 34 → (coefficients exampleShape)[i.val]! < 146 := by
  rw [example_coefficients]
  decide +kernel

#print axioms of_increasing_concave_decreasing
#print axioms example_unique_peak

section UpperTail

variable {b : ℕ}

/-- Zeros pad out the shorter partitions; only positive successive parts
have to be strictly smaller. -/
def Fits (cap a : Fin (b+1) → ℕ) : Prop :=
  (∀ i, a i ≤ cap i) ∧ (∀ i j, i < j → 0 < a j → a j < a i)

def area (a : Fin (b+1) → ℕ) : ℕ := ∑ i, a i

def lowerLast (a : Fin (b+1) → ℕ) (i : Fin (b+1)) : ℕ :=
  if i = Fin.last b then a i - 1 else a i

private theorem last_pos_of_area {cap a : Fin (b+1) → ℕ} (hf : Fits cap a)
    (harea : area cap < area a + cap (Fin.last b)) : 0 < a (Fin.last b) := by
  have hsum : (∑ i, (cap i - a i)) + area a = area cap := by
    unfold area
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl (fun i _ => Nat.sub_add_cancel (hf.1 i))
  have hle : cap (Fin.last b) - a (Fin.last b) ≤ ∑ i, (cap i - a i) :=
    Finset.single_le_sum (f := fun i => cap i - a i)
      (fun _ _ => Nat.zero_le _) (Finset.mem_univ (Fin.last b))
  omega

private theorem lowerLast_fits {cap a : Fin (b+1) → ℕ} (hf : Fits cap a) :
    Fits cap (lowerLast a) := by
  constructor
  · intro i
    by_cases h : i = Fin.last b
    · simpa [lowerLast, h] using (Nat.sub_le (a (Fin.last b)) 1).trans (hf.1 _)
    · simpa [lowerLast, h] using hf.1 i
  · intro i j hij hj
    have hi : i ≠ Fin.last b := by
      intro h
      subst i
      exact (not_lt_of_ge (Fin.le_last j)) hij
    by_cases hjl : j = Fin.last b
    · simp only [lowerLast, if_pos hjl] at hj
      have h0 : 0 < a j := by omega
      have hlt := hf.2 i j hij h0
      simp only [lowerLast, if_pos hjl, if_neg hi]
      omega
    · simpa [lowerLast, hi, hjl] using
        hf.2 i j hij (by simpa [lowerLast, hjl] using hj)

private theorem lowerLast_area {a : Fin (b+1) → ℕ} (hp : 0 < a (Fin.last b)) :
    area (lowerLast a) + 1 = area a := by
  simp only [area, Fin.sum_univ_castSucc]
  have hprefix : (∑ i : Fin b, lowerLast a i.castSucc) = ∑ i : Fin b, a i.castSucc := by
    apply Finset.sum_congr rfl
    intro i _
    simp [lowerLast, i.castSucc_ne_last]
  rw [hprefix]
  simp [lowerLast]
  omega

/-- Removing the bottom cell injects rank k+1 into rank k throughout the
upper boundary layer. The source/target include strict partitions of every
length up to b+1 through zero padding. -/
theorem upper_tail_injection (cap : Fin (b+1) → ℕ) (k : ℕ)
    (harea : area cap < k + 1 + cap (Fin.last b)) :
    ∃ f : {a // Fits cap a ∧ area a = k + 1} → {a // Fits cap a ∧ area a = k},
      Function.Injective f := by
  let f : {a // Fits cap a ∧ area a = k + 1} → {a // Fits cap a ∧ area a = k} :=
    fun x => ⟨lowerLast x.1, lowerLast_fits x.2.1, by
      have hp := last_pos_of_area x.2.1 (by simpa [x.2.2] using harea)
      have h := lowerLast_area hp
      exact Nat.add_right_cancel (h.trans x.2.2)⟩
  refine ⟨f, ?_⟩
  intro x y hxy
  have hfun : lowerLast x.1 = lowerLast y.1 := congrArg Subtype.val hxy
  apply Subtype.ext
  funext i
  have h := congrFun hfun i
  by_cases heq : i = Fin.last b
  · subst i
    have hx := last_pos_of_area x.2.1 (by simpa [x.2.2] using harea)
    have hy := last_pos_of_area y.2.1 (by simpa [y.2.2] using harea)
    simp [lowerLast] at h
    omega
  · simpa [lowerLast, heq] using h

end UpperTail

#print axioms upper_tail_injection

section LowerTail

variable {b : ℕ}

def raiseFirst (a : Fin (b+1) → ℕ) (i : Fin (b+1)) : ℕ :=
  if i = 0 then a i + 1 else a i

private theorem raiseFirst_fits {cap a : Fin (b+1) → ℕ} (hf : Fits cap a)
    (ha : area a < cap 0) : Fits cap (raiseFirst a) := by
  have ha0 : a 0 ≤ area a :=
    Finset.single_le_sum (f := a) (fun _ _ => Nat.zero_le _) (Finset.mem_univ 0)
  constructor
  · intro i
    by_cases h : i = 0
    · subst i
      simpa [raiseFirst] using Nat.succ_le_of_lt (ha0.trans_lt ha)
    · simpa [raiseFirst,h] using hf.1 i
  · intro i j hij hj
    have hj0 : j ≠ 0 := by
      intro h
      subst j
      exact (not_lt_of_ge (Fin.zero_le i)) hij
    have hlt := hf.2 i j hij (by simpa [raiseFirst,hj0] using hj)
    by_cases hi0 : i = 0
    · simpa [raiseFirst,hi0,hj0] using hlt.trans_le (Nat.le_succ (a i))
    · simpa [raiseFirst,hi0,hj0] using hlt

private theorem raiseFirst_area (a : Fin (b+1) → ℕ) :
    area (raiseFirst a) = area a + 1 := by
  simp only [area, Fin.sum_univ_succ]
  have htail : (∑ i : Fin b, raiseFirst a i.succ) = ∑ i : Fin b, a i.succ := by
    apply Finset.sum_congr rfl
    intro i _
    simp [raiseFirst]
  rw [htail]
  simp [raiseFirst]
  omega

/-- Below the longest row, adding a cell to the first row injects
rank k into rank k+1, including the empty partition. -/
theorem lower_tail_injection (cap : Fin (b+1) → ℕ) (k : ℕ) (hk : k < cap 0) :
    ∃ f : {a // Fits cap a ∧ area a = k} → {a // Fits cap a ∧ area a = k+1},
      Function.Injective f := by
  let f : {a // Fits cap a ∧ area a = k} → {a // Fits cap a ∧ area a = k+1} :=
    fun x => ⟨raiseFirst x.1, raiseFirst_fits x.2.1 (by simpa [x.2.2] using hk),
      by rw [raiseFirst_area, x.2.2]⟩
  refine ⟨f, ?_⟩
  intro x y hxy
  have hf : raiseFirst x.1 = raiseFirst y.1 := congrArg Subtype.val hxy
  apply Subtype.ext
  funext i
  have hi := congrFun hf i
  by_cases h0 : i = 0
  · simpa [raiseFirst, h0] using hi
  · simpa [raiseFirst, h0] using hi

end LowerTail

#print axioms lower_tail_injection

end ShiftedUnimodality
