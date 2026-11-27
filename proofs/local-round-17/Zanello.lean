import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Tactic.Linarith

/-! Local formalization of the two-step divisibility argument for Zanello's
equal-area comparison. The comparison theorem under divisibility and the
six-row theorem for large widths remain external mathematical inputs. -/

namespace Zanello

abbrev Coeffs := List ℕ

/-- Coefficientwise polynomial addition with zero padding. -/
def plus : Coeffs → Coeffs → Coeffs
  | [], ys => ys
  | xs, [] => xs
  | x::xs, y::ys => (x+y) :: plus xs ys

def shifted (h : ℕ) (xs : Coeffs) := List.replicate h 0 ++ xs

/-- Gaussian polynomial in an h-by-w box, defined by the standard
q-Pascal recurrence P(h,w) = P(h-1,w) + q^h P(h,w-1). -/
def gaussian : ℕ → ℕ → Coeffs
  | 0, _ => [1]
  | h+1, w => Nat.rec [1]
      (fun j previous => plus (gaussian h (j+1)) (shifted (h+1) previous)) w

@[simp] theorem gaussian_zero_width (h : ℕ) : gaussian h 0 = [1] := by cases h <;> rfl

private def row (h : ℕ) : ℕ → List Coeffs
  | 0 => [[1]]
  | w+1 => gaussian h (w+1) :: row h w

private theorem head_row (h w : ℕ) : (row h w).head? = some (gaussian h w) := by
  cases w <;> simp [row]

/-- Evaluate a whole row once, keeping all smaller widths for the next row. -/
private def advance (h : ℕ) : List Coeffs → List Coeffs
  | [] => []
  | above::tail =>
    let next := advance h tail
    (match next.head? with
     | none => [1]
     | some previous => plus above (shifted h previous)) :: next

private theorem advance_row (h w : ℕ) : advance (h+1) (row h w) = row (h+1) w := by
  induction w with
  | zero => rfl
  | succ w ih =>
    simp only [row, advance, ih, head_row]
    rfl

private def table : ℕ → ℕ → List Coeffs
  | 0, w => List.replicate (w+1) [1]
  | h+1, w => advance (h+1) (table h w)

private theorem table_row (h w : ℕ) : table h w = row h w := by
  induction h with
  | zero =>
    induction w with
    | zero => rfl
    | succ w ih => exact congrArg (List.cons [1]) ih
  | succ h ih => simpa only [table, ih] using advance_row h w

private def fast (h w : ℕ) : Coeffs := (table h w).head?.getD []

private theorem fast_eq (h w : ℕ) : fast h w = gaussian h w := by
  simp [fast, table_row, head_row]

def coef (p : Coeffs) (k : ℕ) : ℤ := (p[k]?.getD 0 : ℕ)

def gap (p : Coeffs) (k : ℕ) : ℤ := coef p (k+1) - coef p k

/-- For palindromic polynomials of equal degree this is precisely the
nonnegative, unimodal difference condition. -/
def Compares (a d b c : ℕ) : Prop :=
  a*d = b*c ∧ coef (gaussian a d) 0 ≤ coef (gaussian b c) 0 ∧
    ∀ k, k < a*d/2 → gap (gaussian a d) k ≤ gap (gaussian b c) k

theorem compares_trans {a d t s b c : ℕ}
    (left : Compares a d t s) (right : Compares t s b c) : Compares a d b c :=
  ⟨left.1.trans right.1, left.2.1.trans right.2.1, fun k hk ↦
    (left.2.2 k hk).trans (right.2.2 k (left.1 ▸ hk))⟩

def DivisibilityCases : Prop :=
  ∀ a d b c : ℕ, 0 < a → a ≤ b → b ≤ c → c ≤ d → a*d = b*c →
    (a ∣ b ∨ a ∣ c) → Compares a d b c

/-- Factor b = h*t, with a ≤ t and a dividing h*c. The two rectangles
along the comparison path have the same area as the endpoints. -/
theorem divisor_bridge (divCases : DivisibilityCases) {a b c d h t : ℕ}
    (ha : 0 < a) (ht : a ≤ t) (hb : b = h*t) (hbc : b ≤ c)
    (hh : 0 < h) (area : a*d = b*c) (div : a ∣ h*c) : Compares a d b c := by
  have htpos : 0 < t := lt_of_lt_of_le ha ht
  have htb : t ≤ b := by rw [hb]; exact Nat.le_mul_of_pos_left _ hh
  have hcs : c ≤ h*c := Nat.le_mul_of_pos_left _ hh
  have eqMid : t*(h*c) = b*c := by rw [hb]; ac_rfl
  have hsd : h*c ≤ d := by
    apply Nat.le_of_mul_le_mul_left _ ha
    calc
      a*(h*c) ≤ t*(h*c) := Nat.mul_le_mul_right _ ht
      _ = a*d := eqMid.trans area.symm
  apply compares_trans (divCases a d t (h*c) ha ht (htb.trans (hbc.trans hcs)) hsd
      (area.trans eqMid.symm) (Or.inr div))
  exact divCases t (h*c) b c htpos htb hbc hcs eqMid (Or.inl ⟨h, by rw [hb]; ac_rfl⟩)

theorem gcd_bridge (divCases : DivisibilityCases) {a b c d : ℕ}
    (ha : 0 < a) (hbc : b ≤ c) (area : a*d = b*c)
    (ht : a ≤ b / Nat.gcd a b) : Compares a d b c := by
  apply divisor_bridge (h := Nat.gcd a b) (t := b / Nat.gcd a b) divCases ha ht
  · exact (Nat.mul_div_cancel' (Nat.gcd_dvd_right a b)).symm
  · exact hbc
  · exact Nat.gcd_pos_of_pos_left _ ha
  · exact area
  · exact Nat.dvd_gcd_mul_iff_dvd_mul.mpr ⟨d, area.symm⟩

/-- The manuscript's sharper numerical condition b gcd(a,c) ≥ a². -/
theorem sharp_gcd_bridge (divCases : DivisibilityCases) {a b c d : ℕ}
    (ha : 0 < a) (hbc : b ≤ c) (area : a*d=b*c)
    (bound : a*a ≤ b*Nat.gcd a c) : Compares a d b c := by
  let g := Nat.gcd a c
  let h := a/g
  have hg : 0 < g := Nat.gcd_pos_of_pos_left _ ha
  have hga : g ∣ a := Nat.gcd_dvd_left _ _
  have hgc : g ∣ c := Nat.gcd_dvd_right _ _
  have hh : 0 < h := Nat.div_pos (Nat.le_of_dvd ha hga) hg
  have gha : g*h = a := Nat.mul_div_cancel' hga
  have hdb : h ∣ b := (Nat.div_dvd_iff_dvd_mul hga hg.ne').mpr <|
    Nat.dvd_gcd_mul_iff_dvd_mul.mpr ⟨d, by rw [Nat.mul_comm c b, ← area]⟩
  have hab : a*h ≤ b := by
    apply Nat.le_of_mul_le_mul_left _ hg
    calc
      g*(a*h) = a*(g*h) := by ac_rfl
      _ = a*a := by rw [gha]
      _ ≤ b*g := bound
      _ = g*b := Nat.mul_comm _ _
  apply divisor_bridge (h := h) (t := b/h) divCases ha
    ((Nat.le_div_iff_mul_le hh).mpr hab) (Nat.mul_div_cancel' hdb).symm hbc hh area
  obtain ⟨k,hk⟩ := hgc
  exact ⟨k, by rw [hk, ← gha]; ac_rfl⟩

/-- A comparison for a fixed pair of short sides and every ordered pair of
widths of the required area. -/
def ShortPair (a b : ℕ) : Prop :=
  ∀ c d : ℕ, b ≤ c → c ≤ d → a*d=b*c → Compares a d b c

/-- Reuse a whole solved pair (a,t) when t divides either side of the more
balanced rectangle, provided a ≤ t ≤ b. -/
theorem lift_short_pair (divCases : DivisibilityCases) {a b c d t : ℕ}
    (ha : 0 < a) (hat : a ≤ t) (htb : t ≤ b) (hbc : b ≤ c)
    (area : a*d=b*c) (div : t ∣ b ∨ t ∣ c) (small : ShortPair a t) :
    Compares a d b c := by
  let s := b*c/t
  have ht : 0 < t := lt_of_lt_of_le ha hat
  have hprod : t ∣ b*c := div.elim (fun h ↦ dvd_mul_of_dvd_left h c)
    (fun h ↦ dvd_mul_of_dvd_right h b)
  have mid : t*s=b*c := Nat.mul_div_cancel' hprod
  have hcs : c ≤ s := (Nat.le_div_iff_mul_le ht).mpr <| calc
    c*t = t*c := Nat.mul_comm _ _
    _ ≤ b*c := Nat.mul_le_mul_right _ htb
  have hsd : s ≤ d := by
    apply Nat.le_of_mul_le_mul_left _ ha
    calc
      a*s ≤ t*s := Nat.mul_le_mul_right _ hat
      _ = a*d := mid.trans area.symm
  exact compares_trans (small s d (htb.trans (hbc.trans hcs)) hsd (area.trans mid.symm))
    (divCases t s b c ht htb hbc hcs mid div)

/-- It suffices to settle the primitive tuples left after the direct
divisibility test, the quadratic bound, and division of b by a proper
factor. The individual lift lemma above also allows a divisor of c. -/
theorem primitive_reduction (divCases : DivisibilityCases) {a : ℕ} (ha : 0 < a)
    (primitive : ∀ b c d : ℕ, a ≤ b → b ≤ c → c ≤ d → a*d=b*c →
      ¬ a ∣ b → ¬ a ∣ c → b*Nat.gcd a c < a*a →
      (∀ t, a ≤ t → t < b → ¬ t ∣ b) → Compares a d b c) :
    ∀ b, a ≤ b → ShortPair a b := by
  intro b
  induction b using Nat.strong_induction_on with
  | h b ih =>
    intro hb c d hbc hcd area
    by_cases direct : a ∣ b ∨ a ∣ c
    · exact divCases a d b c ha hb hbc hcd area direct
    by_cases large : a*a ≤ b*Nat.gcd a c
    · exact sharp_gcd_bridge divCases ha hbc area large
    by_cases mid : ∃ t, a ≤ t ∧ t < b ∧ t ∣ b
    · obtain ⟨t,hat,htb,ht⟩ := mid
      exact lift_short_pair divCases ha hat htb.le hbc area (Or.inl ht) (ih t htb hat)
    · exact primitive b c d hb hbc hcd area (fun h ↦ direct (Or.inl h))
        (fun h ↦ direct (Or.inr h)) (Nat.lt_of_not_ge large)
        (fun t hat htb ht ↦ mid ⟨t,hat,htb,ht⟩)

/-- Width-independent list of pairs that suffice at any fixed smallest side. -/
def primitiveHeights (a : ℕ) : List ℕ :=
  (List.range (a*a)).filter fun b ↦ decide (a < b ∧ ¬ a ∣ b ∧
    1 < Nat.gcd a b ∧ b / Nat.gcd a b < a) &&
    (List.range b).all (fun t ↦ decide (a ≤ t → ¬ t ∣ b))

/-- Every a needs precisely a finite *sufficient* list of whole
fixed-short-side pairs; no assertion of necessity is made for list members. -/
theorem list_reduction (divCases : DivisibilityCases) {a : ℕ} (ha : 0 < a)
    (openPairs : ∀ b ∈ primitiveHeights a, ShortPair a b) :
    ∀ b, a ≤ b → ShortPair a b := by
  apply primitive_reduction divCases ha
  intro b c d hab hbc hcd area noB noC bound noT
  by_cases big : a ≤ b / Nat.gcd a b
  · exact gcd_bridge divCases ha hbc area big
  have hcop : Nat.gcd a b ≠ 1 := by
    intro hg
    have dvd : a ∣ Nat.gcd a b * c := Nat.dvd_gcd_mul_iff_dvd_mul.mpr ⟨d,area.symm⟩
    exact noC (by simpa [hg] using dvd)
  have hbb : b < a*a := lt_of_le_of_lt
    (Nat.le_mul_of_pos_right _ (Nat.gcd_pos_of_pos_left c ha)) bound
  have hstrict : a < b := lt_of_le_of_ne hab (fun e ↦ noB (e ▸ dvd_refl _))
  apply openPairs b _ c d hbc hcd area
  simp only [primitiveHeights, List.mem_filter, List.mem_range, Bool.and_eq_true,
    decide_eq_true_eq, List.all_eq_true]
  exact ⟨hbb, ⟨⟨hstrict, noB, (by have := Nat.gcd_pos_of_pos_left b ha; omega),
    Nat.lt_of_not_ge big⟩, fun t ht hat ↦ noT t hat ht⟩⟩

/- Independent arithmetic inventory. Each row gives all remaining b in
increasing order, with row index a-4 for 4 ≤ a ≤ 24. This statement
classifies the reductions, not the polynomial certificates at those pairs. -/
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem primitive_lists_through_twenty_four :
    (List.range 21).map (fun j ↦ primitiveHeights (j+4)) =
    [[6], [], [8,9,10,15], [], [10,12,14], [12,15,21], [12,14,15,16,18,25,35],
     [], [14,15,16,18,20,21,22,27,33], [],
     [16,18,20,21,22,24,26,35,49,77,91], [18,20,21,24,25,27,33,35,39,55,65],
     [18,20,22,24,26,28,30], [], [20,21,22,24,26,27,28,30,32,33,34,39,45,51],
     [], [22,24,25,26,28,30,32,34,35,36,38,45,55,65,85,95],
     [24,27,28,30,33,35,36,39,45,49,51,57,77,91,119,133],
     [24,26,28,30,32,33,34,36,38,40,42,55,77,121,143,187,209], [],
     [26,27,28,30,32,33,34,36,38,39,40,42,44,45,46,51,57,63,69]] := by decide

private def test (a d b c : ℕ) : Bool :=
  let p := fast a d
  let q := fast b c
  decide (a*d = b*c) && decide (coef p 0 ≤ coef q 0) &&
    (List.range (a*d/2)).all (fun k ↦ decide (gap p k ≤ gap q k))

private theorem test_sound {a d b c : ℕ} (h : test a d b c = true) : Compares a d b c := by
  simpa [test, Compares, fast_eq, List.all_eq_true, and_assoc] using h

set_option maxRecDepth 200000 in
set_option maxHeartbeats 0 in
theorem finite_four_six :
    Compares 4 9 6 6 ∧ Compares 4 15 6 10 ∧ Compares 4 21 6 14 ∧
    Compares 4 27 6 18 ∧ Compares 4 33 6 22 := by
  exact ⟨test_sound (by decide), test_sound (by decide), test_sound (by decide),
    test_sound (by decide), test_sound (by decide)⟩

private def diff (p q : Coeffs) (j : ℕ) := coef q j - coef p j

/-- Explicit nonnegativity and mirror symmetry at every degree for the finite
exceptions to the literature reduction. Combined with `finite_four_six`,
this verifies both halves even without importing Gaussian symmetry. -/
def AllCoefficients (a d b c : ℕ) : Prop :=
  ∀ j ≤ a*d, 0 ≤ diff (gaussian a d) (gaussian b c) j ∧
    diff (gaussian a d) (gaussian b c) j = diff (gaussian a d) (gaussian b c) (a*d-j)

private def checkAll (a d b c : ℕ) : Bool :=
  let e := diff (fast a d) (fast b c)
  (List.range (a*d+1)).all (fun j ↦ decide (0 ≤ e j ∧ e j = e (a*d-j)))

private theorem checkAll_sound {a d b c : ℕ} (h : checkAll a d b c = true) :
    AllCoefficients a d b c := by
  simpa [AllCoefficients, checkAll, fast_eq, List.all_eq_true, Nat.lt_succ_iff] using h

set_option maxRecDepth 200000 in
set_option maxHeartbeats 0 in
theorem finite_all_coefficients :
    AllCoefficients 4 9 6 6 ∧ AllCoefficients 4 15 6 10 ∧ AllCoefficients 4 21 6 14 ∧
    AllCoefficients 4 27 6 18 ∧ AllCoefficients 4 33 6 22 := by
  exact ⟨checkAll_sound (by decide), checkAll_sound (by decide), checkAll_sound (by decide),
    checkAll_sound (by decide), checkAll_sound (by decide)⟩

/- The external six-row result is only needed on this one residue class. -/
def LargeFourSix : Prop :=
  ∀ c d : ℕ, 25 < c → c % 4 = 2 → 4*d=6*c → Compares 4 d 6 c

private theorem residues {b c d : ℕ} (area : 4*d=b*c) (hb : ¬ 4 ∣ b)
    (hc : ¬ 4 ∣ c) : b%4 = 2 ∧ c%4 = 2 := by
  have hz : (b*c)%4=0 := by rw [← area]; omega
  rw [Nat.mul_mod] at hz
  have h1 : b%4=1 ∨ b%4=2 ∨ b%4=3 := by omega
  have h2 : c%4=1 ∨ c%4=2 ∨ c%4=3 := by omega
  rcases h1 with h1|h1|h1 <;> rcases h2 with h2|h2|h2 <;>
    simp [h1,h2] at hz ⊢

/-- The full a=4 conclusion is conditional only on the two specified
literature theorems. The five individual small rectangles are computed above. -/
theorem four_rows (divCases : DivisibilityCases) (large : LargeFourSix)
    {b c d : ℕ} (hb : 4 ≤ b) (hbc : b ≤ c) (hcd : c ≤ d) (area : 4*d=b*c) :
    Compares 4 d b c := by
  by_cases hb4 : 4 ∣ b
  · exact divCases 4 d b c (by decide) hb hbc hcd area (Or.inl hb4)
  by_cases hc4 : 4 ∣ c
  · exact divCases 4 d b c (by decide) hb hbc hcd area (Or.inr hc4)
  obtain ⟨rb,rc⟩ := residues area hb4 hc4
  by_cases hb6 : b=6
  · subst b
    by_cases big : 25<c
    · exact large c d big rc area
    have cases : c=6 ∨ c=10 ∨ c=14 ∨ c=18 ∨ c=22 := by omega
    obtain ⟨f₁,f₂,f₃,f₄,f₅⟩ := finite_four_six
    rcases cases with rfl|rfl|rfl|rfl|rfl
    · have : d=9 := by omega
      simpa [this] using f₁
    · have : d=15 := by omega
      simpa [this] using f₂
    · have : d=21 := by omega
      simpa [this] using f₃
    · have : d=27 := by omega
      simpa [this] using f₄
    · have : d=33 := by omega
      simpa [this] using f₅
  · exact divisor_bridge (h := 2) (t := b/2) divCases (by decide)
      (by omega) (by omega) hbc (by decide) area (by omega)

/-- Zero-shift specialization of the local fixed-height asymptotic result. -/
def FixedHeightCases : Prop :=
  ∀ a b : ℕ, 0 < a → a < b → 5 ≤ b → ∃ C : ℕ,
    ∀ c d : ℕ, C ≤ c → b ≤ c → a*d=b*c → Compares a d b c

private theorem finite_threshold (P : ℕ → ℕ → Prop) (B : ℕ)
    (thresholds : ∀ b < B, ∃ C, ∀ c ≥ C, P b c) :
    ∃ C, ∀ b < B, ∀ c ≥ C, P b c := by
  induction B with
  | zero => exact ⟨0, fun _ hb ↦ (Nat.not_lt_zero _ hb).elim⟩
  | succ B ih =>
    obtain ⟨C,hC⟩ := ih (fun b hb ↦ thresholds b (by omega))
    obtain ⟨D,hD⟩ := thresholds B (by omega)
    refine ⟨max C D, ?_⟩
    intro b hb c hc
    rcases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ hb) with h | rfl
    · exact hC b h c ((le_max_left _ _).trans hc)
    · exact hD c ((le_max_right _ _).trans hc)

/-- For each fixed a ≥ 4 a single threshold suffices simultaneously for
every b. For a ≤ 3 the original paper already proves every width. -/
theorem finitely_many_possible_exceptions (divCases : DivisibilityCases)
    (fixed : FixedHeightCases) {a : ℕ} (ha : 4 ≤ a) :
    ∃ C : ℕ, ∀ b c d : ℕ, C ≤ c → a ≤ b → b ≤ c → c ≤ d → a*d=b*c →
      Compares a d b c := by
  let P := fun (b c : ℕ) ↦ ∀ d : ℕ, a ≤ b → b ≤ c → a*d=b*c → Compares a d b c
  have ha0 : 0 < a := by omega
  have same {c d : ℕ} (area : a*d=a*c) : Compares a d a c := by
    have hdc : d=c := Nat.eq_of_mul_eq_mul_left ha0 area
    subst d
    exact ⟨rfl, le_rfl, fun _ _ ↦ le_rfl⟩
  have thresholds (b : ℕ) (_ : b < a*a) : ∃ C, ∀ c ≥ C, P b c := by
    by_cases hab : a < b
    · obtain ⟨C,hC⟩ := fixed a b ha0 hab (by omega)
      exact ⟨C, fun c hc d _ hbc area ↦ hC c d hc hbc area⟩
    · refine ⟨0, ?_⟩
      intro c _ d hb _ area
      obtain rfl : a=b := by omega
      exact same area
  obtain ⟨C,hC⟩ := finite_threshold P (a*a) thresholds
  refine ⟨C, ?_⟩
  intro b c d hc hb hbc _ area
  by_cases small : b < a*a
  · exact hC b small c hc d hb hbc area
  · apply sharp_gcd_bridge divCases ha0 hbc area
    exact (Nat.le_of_not_gt small).trans (Nat.le_mul_of_pos_right _
      (Nat.gcd_pos_of_pos_left _ ha0))

#print axioms gcd_bridge
#print axioms sharp_gcd_bridge
#print axioms primitive_reduction
#print axioms list_reduction
#print axioms primitive_lists_through_twenty_four
#print axioms finite_four_six
#print axioms finite_all_coefficients
#print axioms four_rows
#print axioms finitely_many_possible_exceptions

end Zanello
