import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.Sum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace PerimeterTriangle

/-- The three corner labels after subtracting 1, in cyclic order. -/
@[ext] structure Corners where
  a : ℕ
  b : ℕ
  c : ℕ
  deriving DecidableEq

def rot (x : Corners) : Corners := ⟨x.b, x.c, x.a⟩
def SameOrbit (x y : Corners) := y = x ∨ y = rot x ∨ y = rot (rot x)
def Canon (x : Corners) : Prop := (x.a < x.c ∧ x.b ≤ x.c) ∨ (x.a=x.b ∧ x.b=x.c)
def Allowed (n : ℕ) (x : Corners) : Prop :=
  x.a+x.b < n ∧ x.b+x.c < n ∧ x.c+x.a < n

theorem canonical_exists (x : Corners) : ∃ y, Canon y ∧ SameOrbit x y := by
  by_cases h : Canon x
  · exact ⟨x, h, Or.inl rfl⟩
  by_cases j : Canon (rot x)
  · exact ⟨rot x, j, Or.inr (Or.inl rfl)⟩
  refine ⟨rot (rot x), ?_, Or.inr (Or.inr rfl)⟩
  simp only [Canon,rot] at *; omega

theorem canonical_unique {x y : Corners} (h : Canon x) (j : Canon y)
    (q : SameOrbit x y) : y=x := by
  rcases q with rfl|rfl|rfl <;> ext <;> simp only [rot,Canon] at * <;> omega

theorem allowed_rot (n : ℕ) (x : Corners) : Allowed n (rot x) ↔ Allowed n x := by
  simp only [Allowed,rot]; tauto

def weight (x : Corners) := x.c + max x.a x.b

private theorem valid {n : ℕ} {x : Corners} (h : Canon x) :
    Allowed n x ↔ weight x < n := by
  unfold Allowed weight; unfold Canon at h; omega

def Layer (t : ℕ) := {x : Corners // Canon x ∧ weight x = t}
def Classes (n : ℕ) := {x : Corners // Canon x ∧ Allowed n x}

def oddLayer (k : ℕ) : Layer (2*k+1) ≃ Fin (k+1) × Fin (k+1) where
  toFun x := by
    have h := x.property.1
    have e := x.property.2
    simp only [Canon,weight] at h e
    exact (⟨x.val.a,by omega⟩,⟨x.val.b,by omega⟩)
  invFun p := ⟨⟨p.1.val,p.2.val,2*k+1-max p.1.val p.2.val⟩,
    by have := p.1.isLt; have := p.2.isLt; simp only [weight,Canon]; omega⟩
  left_inv x := by
    rcases x with ⟨x,h,e⟩
    change x.c + max x.a x.b = 2*k+1 at e
    apply Subtype.ext; apply Corners.ext
    · rfl
    · rfl
    · change 2*k+1-max x.a x.b = x.c; omega
  right_inv p := by rfl

def evenLayer (k : ℕ) : Layer (2*k) ≃ (Fin k × Fin k) ⊕ Fin (k+1) where
  toFun x := by
    have h := x.property.1
    have e := x.property.2
    simp only [Canon,weight] at h e
    by_cases m : max x.val.a x.val.b = k
    · exact Sum.inr ⟨x.val.a,by omega⟩
    · exact Sum.inl (⟨x.val.a,by omega⟩,⟨x.val.b,by omega⟩)
  invFun
    | Sum.inl p => ⟨⟨p.1.val,p.2.val,2*k-max p.1.val p.2.val⟩,
        by have := p.1.isLt; have := p.2.isLt; simp only [weight,Canon]; omega⟩
    | Sum.inr a => ⟨⟨a.val,k,k⟩, by
      have ha : a.val ≤ k := Nat.le_of_lt_succ a.isLt
      constructor
      · by_cases eq : a.val=k
        · exact Or.inr ⟨eq,rfl⟩
        · exact Or.inl ⟨by change a.val < k; omega, le_rfl⟩
      · change k + max a.val k = 2*k; rw [max_eq_right ha]; omega⟩
  left_inv x := by
    rcases x with ⟨x,h,e⟩
    simp only [Canon,weight] at h e
    by_cases m : max x.a x.b = k <;> simp [m] <;> apply Subtype.ext <;> apply Corners.ext <;> dsimp <;> omega
  right_inv p := by
    rcases p with p|a
    · have h : max p.1.val p.2.val ≠ k := by have := p.1.isLt; have := p.2.isLt; omega
      simp [h]
    · have h : max a.val k = k := by have := a.isLt; omega
      simp [h]

def layers (n : ℕ) : Classes n ≃ (j : Fin n) × Layer j.val where
  toFun x := ⟨⟨weight x.val,(valid x.property.1).mp x.property.2⟩,
    ⟨x.val,x.property.1,rfl⟩⟩
  invFun y := ⟨y.2.val,y.2.property.1,(valid y.2.property.1).mpr
    (y.2.property.2.symm ▸ y.1.isLt)⟩
  left_inv x := rfl
  right_inv y := by
    rcases y with ⟨⟨j,hj⟩,x,h,e⟩; dsimp at e; subst j; rfl

private noncomputable instance layerFintype (t : ℕ) : Fintype (Layer t) := by
  by_cases h : t % 2 = 0
  · have e : t = 2*(t/2) := by omega
    exact e ▸ Fintype.ofEquiv _ (evenLayer (t/2)).symm
  · have e : t = 2*(t/2)+1 := by omega
    exact e ▸ Fintype.ofEquiv _ (oddLayer (t/2)).symm

private theorem layerCard (t : ℕ) : Fintype.card (Layer t) = ((t+1)^2+3)/4 := by
  obtain ⟨k,rfl|rfl⟩ : ∃ k, t = 2*k ∨ t=2*k+1 := ⟨t/2,by omega⟩
  · rw [Fintype.card_congr (evenLayer k)]
    simp only [Fintype.card_sum,Fintype.card_prod,Fintype.card_fin]
    have he : (2*k+1)^2+3=4*(k*k+(k+1)) := by ring
    rw [he]; omega
  · rw [Fintype.card_congr (oddLayer k)]
    simp only [Fintype.card_prod,Fintype.card_fin]
    have he : (2*k+1+1)^2+3=4*((k+1)*(k+1))+3 := by ring
    rw [he]; omega

noncomputable instance classFintype (n : ℕ) : Fintype (Classes n) :=
  Fintype.ofEquiv _ (layers n).symm

/-- Counting the unique canonical representatives of the admissible rotation orbits.
The term at j counts the new orbits at perimeter sum j+3. -/
theorem a175287 (n : ℕ) :
    Fintype.card (Classes n) = ∑ j : Fin n, ((j.val+1)^2+3)/4 := by
  rw [Fintype.card_congr (layers n), Fintype.card_sigma]
  exact Finset.sum_congr rfl (fun i _ => layerCard i.val)

#print axioms a175287

/-- The six actual labels are one plus each entry of this pair.
The first triple holds the corners; the second holds midpoints in edge order. -/
def Fits (n : ℕ) (x y : Corners) : Prop :=
  x.a + y.a + x.b + 1 = n ∧ x.b + y.b + x.c + 1 = n ∧ x.c + y.c + x.a + 1 = n

def FullClasses (n : ℕ) :=
  {p : Corners × Corners // Canon p.1 ∧ Fits n p.1 p.2}

private def fill (n : ℕ) (x : Corners) : Corners :=
  ⟨n-1-(x.a+x.b),n-1-(x.b+x.c),n-1-(x.c+x.a)⟩

theorem fit_rotate (n : ℕ) (x y : Corners) : Fits n (rot x) (rot y) ↔ Fits n x y := by
  simp only [rot,Fits]; tauto

theorem middle_unique {n : ℕ} {x y : Corners} (h : Fits n x y) : fill n x = y := by
  unfold Fits at h
  ext <;> simp only [fill] <;> omega

def fillEquiv (n : ℕ) : FullClasses n ≃ Classes n where
  toFun p := ⟨p.val.1,p.property.1,by
    have h := p.property.2; unfold Fits at h; unfold Allowed; omega⟩
  invFun x := ⟨(x.val,fill n x.val),x.property.1,by
    have h := x.property.2; unfold Allowed at h
    simp only [Fits,fill]; omega⟩
  left_inv p := by
    apply Subtype.ext; apply Prod.ext
    · rfl
    · exact middle_unique p.property.2
  right_inv _ := rfl

noncomputable instance fullFintype (n : ℕ) : Fintype (FullClasses n) :=
  Fintype.ofEquiv _ (fillEquiv n).symm

theorem a175287_full (n : ℕ) :
    Fintype.card (FullClasses n) = ∑ j : Fin n, ((j.val+1)^2+3)/4 := by
  rw [Fintype.card_congr (fillEquiv n),a175287]

#print axioms a175287_full
end PerimeterTriangle
