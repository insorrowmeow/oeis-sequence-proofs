import Mathlib.Algebra.Polynomial.BigOperators
import Mathlib.Algebra.Polynomial.Reverse
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.LinearCombination

/-! Necessity for at most three ordinary factors in Conjecture 5.4 of
Connelly--Ito--Martinez--Shevchenko--Yang (arXiv:2605.12822). The coefficient
of (1-X)P at an explicit left-half index is negative when the numerical
alternatives fail. All variables and degrees are unbounded. -/

namespace ThreeFactors
open Polynomial Finset
noncomputable section
abbrev P := Polynomial ℤ
def G (r k : ℕ) : P := ∑ i ∈ range k, X^(r*i)
def I := G 1

theorem last (r k : ℕ) : G r (k+1) = G r k + X^(r*k) := by simp [G,sum_range_succ]

theorem first (r k : ℕ) : G r (k+1) = 1+X^r*G r k := by
  rw [G, sum_range_succ', G, mul_sum]
  simp only [Nat.mul_zero,pow_zero,Nat.mul_succ,pow_add]
  simp [mul_comm, add_comm]

theorem telescope (k : ℕ) : I k * (1-X) = 1-X^k := by
  induction k with
  | zero => simp [I,G]
  | succ k ih =>
    change G 1 (k+1) * _ = _
    rw [last, one_mul, add_mul, ← I, ih,pow_succ]
    ring

theorem boundI (k : ℕ) : (I k).natDegree ≤ k-1 := by
  unfold I G
  apply natDegree_sum_le_of_forall_le
  intro i hi
  simp only [natDegree_X_pow,one_mul]
  simp at hi
  omega


theorem step_poly (R : P) (r a b : ℕ) :
    R * (I (a+r) * (1-X)) * G r (b+1) =
      R*(1-X^(a+r+r*b)) + X^r*(R*(I a*(1-X))*G r b) := by
  simp only [telescope,pow_add]
  have hg := first r b
  have hl := last r b
  linear_combination R * hg - R * X^a * X^r * hl

theorem transfer (R : P) (r s b j : ℕ)
    (hlo : R.natDegree < j+r) (hhi : j < s+r*b) (u : ℕ) :
    (R*(I (s+r*u)*(1-X))*G r (b+u)).coeff (j+r*u) =
    (R*(I s*(1-X))*G r b).coeff j := by
  induction u with
  | zero => simp
  | succ u ih =>
    simp only [Nat.mul_succ, ← Nat.add_assoc] at *
    rw [step_poly,coeff_add,coeff_X_pow_mul]
    have h1 : R.natDegree < j+r*u+r := by omega
    have h2 : j+r*u+r < s+r*u+r+r*(b+u) := by
      rw [Nat.mul_add]
      omega
    rw [mul_sub,mul_one,coeff_sub,coeff_eq_zero_of_natDegree_lt h1,coeff_mul_X_pow',
      if_neg (by omega),sub_zero,zero_add,ih]

theorem coeffI {s d : ℕ} : (I s).coeff d = if d<s then 1 else 0 := by
  unfold I G
  simp [finset_sum_coeff,coeff_X_pow]

theorem coeff_pair {s v n : ℕ} (hn : n<s) (hv : s≤v) :
    (I s * I v).coeff n = (n:ℤ)+1 := by
  rw [coeff_mul]
  apply Eq.trans (sum_congr rfl (g:=fun _ => (1:ℤ)) ?_)
  · simp
  · intro p hp
    have h := Finset.mem_antidiagonal.mp hp
    rw [coeffI,coeffI,if_pos (by omega),if_pos (by omega)]
    rfl

def diff (a b c r n : ℕ) : P := I a * I b * I c * G r n * (1-X)

private theorem base_poly (a b c r m : ℕ) (U : P) (hU : U = I a*I b) :
    diff a b c r (m+2) =
      U - X^c*U + X^r*U - X^(r+c)*U +
        X^(r+r)*(U*(1-X^c)*G r m) := by
  unfold diff
  rw [← hU, show m+2 = (m+1)+1 by omega,first, first]
  have hc := telescope c
  simp only [pow_add]
  linear_combination U*(1+X^r*(1+X^r*G r m))*hc

theorem base_drop {a b c r : ℕ} (ha : 1≤a) (hab : a≤b) (hbc : b≤c)
    (hcr : c<r) (m : ℕ) :
    (diff a b c r (m+2)).coeff (max c (a+b-1)) < 0 := by
  let t := max c (a+b-1)
  have ht : t = max c (a+b-1) := rfl
  let U := I a*I b
  have deg : U.natDegree ≤ a-1+(b-1) := natDegree_mul_le_of_le (boundI a) (boundI b)
  have hc : c≤t := by omega
  have htc : t-c<a := by omega
  have hu : U.coeff t = 0 := coeff_eq_zero_of_natDegree_lt (by omega)
  change (diff a b c r (m+2)).coeff t < 0
  rw [base_poly a b c r m U rfl,coeff_add,coeff_sub,coeff_add,coeff_sub,hu]
  simp only [coeff_X_pow_mul']
  rw [if_pos hc, if_neg (show ¬r+c≤t by omega), if_neg (show ¬r+r≤t by omega)]
  have hx : U.coeff (t-c)=(t-c:ℕ)+1 := coeff_pair htc hab
  rw [hx]
  split_ifs with hr
  · rw [show U.coeff (t-r)=(t-r:ℕ)+1 from coeff_pair (by omega) hab]
    omega
  · omega

private theorem move_factor (a b c r n : ℕ) :
    diff a b c r n = (I b * I c) * (I a * (1-X)) * G r n := by unfold diff; ring

private theorem swap12 (a b c r n : ℕ) : diff a b c r n = diff b a c r n := by
  unfold diff; ring

private theorem swap13 (a b c r n : ℕ) : diff a b c r n = diff c b a r n := by
  unfold diff; ring

private theorem remove (r s v w B j u : ℕ)
    (hlo : v-1+(w-1)<j+r) (hhi : j<s+r*B) :
    (diff (s+r*u) v w r (B+u)).coeff (j+r*u) =
    (diff s v w r B).coeff j := by
  rw [move_factor,move_factor s]
  apply transfer _ _ _ _ _ _ hhi
  exact (natDegree_mul_le_of_le (boundI _) (boundI _)).trans_lt hlo

theorem drop {a b c r : ℕ} (ha : 1≤a) (hab : a≤b) (hbc : b≤c)
    (hcr : c<r) (u v w m : ℕ) :
    (diff (a+r*u) (b+r*v) (c+r*w) r (m+2+(u+v+w))).coeff
      (max c (a+b-1)+r*(u+v+w)) < 0 := by
  let t := max c (a+b-1)
  have ht : t = max c (a+b-1) := rfl
  have e1 := remove r a (b+r*v) (c+r*w) (m+2+v+w) (t+r*v+r*w) u
  have e2 := remove r b a (c+r*w) (m+2+w) (t+r*w) v
  have e3 := remove r c b a (m+2) t w
  have lo1 : b+r*v-1+(c+r*w-1)<t+r*v+r*w+r := by omega
  have lo2 : a-1+(c+r*w-1)<t+r*w+r := by omega
  have lo3 : b-1+(a-1)<t+r := by omega
  have hi1 : t+r*v+r*w < a+r*(m+2+v+w) := by simp only [Nat.mul_add,Nat.mul_two]; omega
  have hi2 : t+r*w < b+r*(m+2+w) := by simp only [Nat.mul_add,Nat.mul_two]; omega
  have hi3 : t < c+r*(m+2) := by simp only [Nat.mul_add,Nat.mul_two]; omega
  have A := e1 lo1 hi1
  have B := e2 lo2 hi2
  have C := e3 lo3 hi3
  change (diff _ _ _ _ _).coeff (t+r*(u+v+w)) < 0
  rw [show t+r*(u+v+w)=t+r*v+r*w+r*u by ring,
    show m+2+(u+v+w)=m+2+v+w+u by omega,A,swap12,
    show t+r*v+r*w=t+r*w+r*v by omega,show m+2+v+w=m+2+w+v by omega,B,
    swap13]
  -- Normalize the harmless order of the two unchanged ordinary factors.
  have S : diff (c+r*w) a b r (m+2+w) = diff (c+r*w) b a r (m+2+w) := by
    unfold diff; ring
  rw [S,C]
  have E : diff c b a r (m+2) = diff a b c r (m+2) := by unfold diff; ring
  rw [E]
  exact base_drop ha hab hbc hcr m

def product (a b c r m : ℕ) : P := I a * I b * I c * G r m
def Unimodal (p : P) := ∃ k, (∀ i<k, p.coeff i ≤ p.coeff (i+1)) ∧
  (∀ i, k≤i → p.coeff (i+1) ≤ p.coeff i)

private theorem symmetricG (r n : ℕ) :
    (G r n).natDegree ≤ r*(n-1) ∧ reflect (r*(n-1)) (G r n) = G r n := by
  constructor
  · unfold G
    apply natDegree_sum_le_of_forall_le
    intro i hi
    rw [natDegree_X_pow]
    apply Nat.mul_le_mul_left
    simp only [mem_range] at hi
    omega
  · let rev : P →+ P := { toFun := reflect (r*(n-1)), map_zero' := reflect_zero,
                          map_add' := fun a b => reflect_add a b _ }
    change rev (∑ i ∈ range n, X^(r*i)) = _
    rw [map_sum]
    unfold G
    rw [← sum_range_reflect (fun i => (X : P) ^ (r*i)) n]
    apply sum_congr rfl
    intro j hj
    simp only [mem_range] at hj
    change reflect _ ((X : P)^_) = _
    rw [reflect_monomial,revAt_le (Nat.mul_le_mul_left r (by omega : j≤n-1))]
    simp only [Nat.mul_sub]

private theorem buildSymm {p q : P} {D E : ℕ}
    (hp : p.natDegree ≤ D ∧ reflect D p = p) (hq : q.natDegree ≤ E ∧ reflect E q = q) :
    (p*q).natDegree ≤ D+E ∧ reflect (D+E) (p*q) = p*q :=
  ⟨natDegree_mul_le_of_le hp.1 hq.1, by rw [reflect_mul _ _ hp.1 hq.1,hp.2,hq.2]⟩

private theorem symmetricProd (a b c r m : ℕ) :
    reflect (a-1+(b-1)+(c-1)+r*(m-1)) (product a b c r m) = product a b c r m := by
  simpa [product,I] using (buildSymm (buildSymm (buildSymm
    (symmetricG 1 a) (symmetricG 1 b)) (symmetricG 1 c)) (symmetricG r m)).2

private theorem noUnimodal {p : P} {D t : ℕ} (hs : reflect D p=p)
    (ht : 2*(t+1)≤D) (hd : p.coeff (t+1) < p.coeff t) : ¬Unimodal p := by
  rintro ⟨k,up,down⟩
  have hkt : k≤t := by by_contra! h; exact (not_le_of_gt hd) (up t h)
  have hsym (j : ℕ) (hj : j≤D) : p.coeff (D-j) = p.coeff j := by
    have H := congrArg (fun v : P => v.coeff j) hs
    simpa [coeff_reflect,revAt_le hj] using H
  have h := down (D-(t+1)) (by omega)
  rw [show D-(t+1)+1=D-t by omega,hsym t (by omega),hsym (t+1) (by omega)] at h
  omega

theorem residue_obstruction {a b c r : ℕ} (ha : 1≤a) (hab : a≤b) (hbc : b≤c)
    (hcr : c<r) (u v w m : ℕ) :
    ¬ Unimodal (product (a+r*u) (b+r*v) (c+r*w) r (m+2+(u+v+w))) := by
  let t := max c (a+b-1)
  let j := t+r*(u+v+w)
  have ht : t=max c (a+b-1) := rfl
  have hpos : 0<j := by dsimp [j]; omega
  have H := drop ha hab hbc hcr u v w m
  change ((product (a+r*u) (b+r*v) (c+r*w) r (m+2+(u+v+w)))*(1-X)).coeff j < 0 at H
  have hj : j=(j-1)+1 := by omega
  rw [hj,mul_sub,mul_one,coeff_sub,coeff_mul_X] at H
  apply noUnimodal (symmetricProd ..) (t:=j-1) _ (sub_neg.mp H)
  dsimp [j]
  rw [show m+2+(u+v+w)-1=m+1+(u+v+w) by omega]
  simp only [Nat.mul_add,Nat.mul_one, Nat.two_mul]
  omega

private theorem ordered {r A B C n : ℕ} (hr : 2≤r)
    (hA : 1≤A%r) (hab : A%r≤B%r) (hbc : B%r≤C%r)
    (hn : 2+(A/r+B/r+C/r)≤n) : ¬Unimodal (product A B C r n) := by
  have H := residue_obstruction hA hab hbc (Nat.mod_lt C (by omega))
    (A/r) (B/r) (C/r) (n-(2+(A/r+B/r+C/r)))
  simpa only [Nat.mod_add_div, show n-(2+(A/r+B/r+C/r))+2+(A/r+B/r+C/r)=n by omega] using H

/-- Necessity in Conjecture 5.4 for any three lengths and any stride.
Use ordinary unit factors for the one-factor and two-factor instances. -/
theorem necessity (A B C r n : ℕ) (hr : 2≤r) (H : Unimodal (product A B C r n)) :
    r∣A ∨ r∣B ∨ r∣C ∨ n≤1+(A/r+B/r+C/r) := by
  by_contra! hp
  obtain ⟨hA,hB,hC,hn⟩ := hp
  have posA : 1≤A%r := by have := mt Nat.dvd_of_mod_eq_zero hA; omega
  have posB : 1≤B%r := by have := mt Nat.dvd_of_mod_eq_zero hB; omega
  have posC : 1≤C%r := by have := mt Nat.dvd_of_mod_eq_zero hC; omega
  have fail {x y z : ℕ} (hpo : 1≤x%r) (hxy : x%r≤y%r) (hyz : y%r≤z%r)
      (hs : 2+(x/r+y/r+z/r)≤n) (eq : product A B C r n=product x y z r n) : False :=
    ordered hr hpo hxy hyz hs (eq ▸ H)
  rcases le_total (A%r) (B%r) with h1|h1 <;>
    rcases le_total (B%r) (C%r) with h2|h2 <;>
    rcases le_total (A%r) (C%r) with h3|h3
  all_goals first
    | exact fail posA (y:=B) (z:=C) (by omega) (by omega) (by omega) rfl
    | exact fail posA (y:=C) (z:=B) (by omega) (by omega) (by omega) (by unfold product; ring)
    | exact fail posB (y:=A) (z:=C) (by omega) (by omega) (by omega) (by unfold product; ring)
    | exact fail posB (y:=C) (z:=A) (by omega) (by omega) (by omega) (by unfold product; ring)
    | exact fail posC (y:=B) (z:=A) (by omega) (by omega) (by omega) (by unfold product; ring)
    | exact fail posC (y:=A) (z:=B) (by omega) (by omega) (by omega) (by unfold product; ring)

#print axioms drop
#print axioms necessity

private theorem Ione : I 1 = 1 := by simp [I,G]

theorem necessity_two (A B r n : ℕ) (hr : 2≤r) (H : Unimodal (I A*I B*G r n)) :
    r∣A ∨ r∣B ∨ n≤1+(A/r+B/r) := by
  have h := necessity A B 1 r n hr (by simpa [product,Ione] using H)
  have hz : 1/r=0 := Nat.div_eq_of_lt (by omega)
  simp only [Nat.dvd_one,show r≠1 by omega, false_or,hz,add_zero] at h
  exact h

theorem necessity_one (A r n : ℕ) (hr : 2≤r) (H : Unimodal (I A*G r n)) :
    r∣A ∨ n≤1+A/r := by
  have h := necessity_two A 1 r n hr (by simpa [Ione] using H)
  have hz : 1/r=0 := Nat.div_eq_of_lt (by omega)
  simpa only [Nat.dvd_one,show r≠1 by omega, false_or,hz,add_zero] using h

end
end ThreeFactors
