import Mathlib.Data.Nat.Digits
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Ring

namespace EzermanMeyerSole

def rev (n : ℕ) : ℕ := Nat.ofDigits 10 (Nat.digits 10 n).reverse
def digit (n j : ℕ) : ℕ := n / 10^j % 10

/-- Coefficient in the product of the two ordinary decimal digit polynomials. -/
def column (a b j : ℕ) : ℕ :=
  ∑ i ∈ Finset.range (j+1), digit a i * digit b (j-i)

def PolynomialPair (a b : ℕ) : Prop :=
  ∀ j, column a b j = digit (a*b) j

def PalindromicPair (a b : ℕ) : Prop := rev (a*b) = rev a * rev b

def conjecture4 : Prop := ∀ a b : ℕ, 0<a → 0<b → a%10≠0 → b%10≠0 →
  rev a≠a → rev b≠b → PalindromicPair a b → PolynomialPair a b

def first := 778998
def second := 857

private theorem read_back (xs : List ℕ) (n : ℕ) (h : Nat.ofDigits 10 xs=n)
    (hb : ∀ z ∈ xs, z<10) (hl : ∀ hh : xs ≠ [], xs.getLast hh ≠ 0) :
    rev n = Nat.ofDigits 10 xs.reverse := by
  rw [← h, rev, Nat.digits_ofDigits _ (by decide) _ hb hl]

theorem exact_reversals :
    first*second = 667601286 ∧
    rev first = 899877 ∧ rev second = 758 ∧
    rev (first*second) = 682106766 := by
  refine ⟨by decide, ?_, ?_, ?_⟩
  · exact read_back [8,9,9,8,7,7] first rfl (by simp) (by decide)
  · exact read_back [7,5,8] second rfl (by simp) (by decide)
  · exact read_back [6,8,2,1,0,6,7,6,6] (first*second) rfl (by simp) (by decide)

theorem witness : rev first ≠ first ∧ rev second ≠ second ∧
    PalindromicPair first second ∧ ¬ PolynomialPair first second := by
  obtain ⟨_,h₁,h₂,h₃⟩ := exact_reversals
  refine ⟨by rw [h₁]; decide,by rw [h₂]; decide, ?_,?_⟩
  · unfold PalindromicPair
    rw [h₃,h₁,h₂]
  intro h
  have hh := h 0
  exact (by decide : column first second 0 ≠ digit (first*second) 0) hh

theorem conjecture4_false : ¬ conjecture4 := by
  intro h
  obtain ⟨ha,hb,hp,hn⟩ := witness
  exact hn (h first second (by decide) (by decide) (by decide) (by decide) ha hb hp)

private def blocks (l : List ℕ) (g h : ℕ) :=
  l ++ List.replicate g 0 ++ l ++ List.replicate h 0 ++ l

private theorem reverse_blocks (l : List ℕ) (g h : ℕ) :
    (blocks l g h).reverse = blocks l.reverse h g := by
  simp [blocks,List.append_assoc]

private theorem zero_word (m : ℕ) : Nat.ofDigits 10 (List.replicate m 0) = 0 := by
  induction m with
  | zero => rfl
  | succ m ih => simp [List.replicate_succ,Nat.ofDigits,ih]

private def multiplier (g h : ℕ) := 1+10^g+10^g*10^h

private theorem evaluate_blocks (l : List ℕ) (g h : ℕ) :
    Nat.ofDigits 10 (blocks l g h) =
      Nat.ofDigits 10 l * multiplier (l.length+g) (l.length+h) := by
  simp [blocks,multiplier,Nat.ofDigits_append,List.length_append,zero_word,pow_add]
  ring

private theorem canonical_blocks (l : List ℕ) (g h : ℕ) (hn : l ≠ [])
    (hs : ∀ n ∈ l, n<10) (he : l.getLast hn ≠ 0) :
    Nat.digits 10 (Nat.ofDigits 10 (blocks l g h)) = blocks l g h := by
  apply Nat.digits_ofDigits _ (by decide)
  · intro n H
    simp only [blocks,List.mem_append,List.mem_replicate] at H
    rcases H with (((H|H)|H)|H)|H
    all_goals first | exact hs _ H | obtain ⟨_,rfl⟩ := H; decide
  · intro _
    unfold blocks
    rw [List.getLast_append_of_right_ne_nil _ l hn]
    exact he

private theorem reversed_copies (l : List ℕ) (g h : ℕ) (hn : l ≠ [])
    (hs : ∀ n ∈ l, n<10) (he : l.getLast hn ≠ 0) :
    rev (Nat.ofDigits 10 l * multiplier (l.length+g) (l.length+h)) =
      Nat.ofDigits 10 l.reverse * multiplier (l.length+h) (l.length+g) := by
  rw [← evaluate_blocks,rev,canonical_blocks l g h hn hs he,reverse_blocks,evaluate_blocks]
  simp

/-- Table 1 supplies the seed 77,80088. The unequal spacings change under reversal. -/
def family (t : ℕ) := 77 * multiplier (7+t) (8+t)

private theorem rev_family (t : ℕ) : rev (family t) = 77*multiplier (8+t) (7+t) := by
  have h := reversed_copies [7,7] (5+t) (6+t) (by decide) (by simp) (by decide)
  simpa [family, ← Nat.add_assoc] using h

private theorem rev_product (t : ℕ) :
    rev (family t * 80088) = 6776616*multiplier (8+t) (7+t) := by
  have h := reversed_copies [6,7,7,6,6,1,6] t (1+t) (by decide) (by simp) (by decide)
  have h' : rev (6166776*multiplier (7+t) (8+t)) = 6776616*multiplier (8+t) (7+t) := by
    simpa [← Nat.add_assoc] using h
  rw [family,show 77*multiplier (7+t) (8+t)*80088 = 6166776*multiplier (7+t) (8+t) by ring]
  exact h'

theorem family_witness (t : ℕ) :
    rev (family t) ≠ family t ∧ rev 80088 ≠ 80088 ∧
    PalindromicPair (family t) 80088 ∧ ¬ PolynomialPair (family t) 80088 := by
  have hrev := read_back [8,8,0,0,8] 80088 rfl (by simp) (by decide)
  change rev 80088 = 88008 at hrev
  have hmono : (10:ℕ)^(7+t) < 10^(8+t) := Nat.pow_lt_pow_right (by decide) (by omega)
  refine ⟨?_,by rw [hrev]; decide,?_,?_⟩
  · rw [rev_family,family,multiplier,multiplier,mul_comm (10^(8+t)) (10^(7+t))]
    omega
  · unfold PalindromicPair
    rw [rev_family,hrev,rev_product]; ring
  · intro hp
    have h := hp 0
    have hf : family t % 10 = 7 := by
      simp [family,multiplier,Nat.add_mod,Nat.mul_mod,show 7+t=(6+t)+1 by omega,
        show 8+t=(7+t)+1 by omega,pow_succ]
    have hd : digit (family t) 0 = 7 := by simpa [digit] using hf
    have hr : digit (family t * 80088) 0 = 6 := by
      simp [digit,Nat.mul_mod,hf]
    change digit (family t) 0 * 8 = digit (family t * 80088) 0 at h
    rw [hd,hr] at h
    contradiction

#print axioms family_witness
#print axioms conjecture4_false
end EzermanMeyerSole
