import Mathlib.Data.Int.Interval

namespace ThreeFactorDrop

/-- The allowed first exponent x for x+y=n, 0≤x<a and 0≤y<b. -/
def exponents (a b n : ℤ) := Finset.Icc (max 0 (n-b+1)) (min (a-1) n)

theorem mem_exponents (a b n x : ℤ) :
    x ∈ exponents a b n ↔ 0 ≤ x ∧ x < a ∧ 0 ≤ n-x ∧ n-x < b := by
  simp only [exponents,Finset.mem_Icc,max_le_iff,le_min_iff]
  omega

def U (a b n : ℤ) : ℤ := (exponents a b n).card

theorem off_right {a b n : ℤ} (h : a+b-2 < n) : U a b n=0 := by
  simp only [U,exponents,Int.card_Icc]
  omega

theorem off_left {a b n : ℤ} (h : n<0) : U a b n=0 := by
  simp only [U,exponents,Int.card_Icc]
  omega

theorem left_part {a b n : ℤ} (h : n < a) (hab : a ≤ b) :
    U a b n = max 0 (n+1) := by
  simp only [U,exponents,Int.card_Icc]
  omega

/-- The residue sum from the polynomial reduction, together with the bounds
    putting the strict drop in the first half and covering the full residue class. -/
theorem residue_drop {r a b c : ℤ} (ha : 1 ≤ a) (hab : a ≤ b) (hbc : b ≤ c)
    (hc : c < r) :
    let t := max c (a+b-1)
    U a b t - U a b (t-c) + U a b (t-r) - U a b (t-r-c) =
      -(min (t-c+1) (r-c)) ∧
      0 < min (t-c+1) (r-c) ∧ 2*t ≤ a+b+c-3+r ∧
      t < 2*r ∧ a+b+c-2 < t+r := by
  dsimp only
  set t := max c (a+b-1) with ht
  have z1 : U a b t=0 := off_right (by omega)
  have z2 : U a b (t-r-c)=0 := off_left (by omega)
  have e1 := left_part (n:=t-c) (by omega : t-c<a) hab
  have e2 := left_part (n:=t-r) (by omega : t-r<a) hab
  rw [z1,z2,e1,e2]
  omega

#print axioms mem_exponents
#print axioms residue_drop
end ThreeFactorDrop
