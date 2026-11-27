import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! A primitive four-weight family refuting Gatzweiler--Krattenthaler
Conjecture 4 with unbounded shift divided by largest index. Lists of
four distinct exponents stand for their indicator vectors. -/

namespace UnboundedShift
open Polynomial Finset
noncomputable section
abbrev P := Polynomial ℤ
def s (k : ℕ) := 2*k+3
def r (k : ℕ) := 2*s k^2+2
def x (k : ℕ) := 2*s k^2
def y (k : ℕ) := r k+2*s k
def m (k : ℕ) := (2*k+1)*r k + 2*s k*(2*k+2)+2
def F (k : ℕ) := m k+s k
def bin (j : ℕ) : P := 1-X^j
def geom (d l : ℕ) : P := ∑ i ∈ range l, X^(i*d)

theorem parameter_bounds (k : ℕ) :
    0 < s k ∧ s k < x k ∧ x k < r k ∧ r k < y k ∧ (k+1)*y k ≤ m k := by
  dsimp [s,x,r,y,m]
  constructor <;> try omega
  repeat' constructor <;> ring_nf <;> omega

theorem coprime_sr (k : ℕ) : Nat.Coprime (s k) (r k) := by
  rw [show r k = (2*s k)*s k+2 by simp [r]; ring, Nat.coprime_mul_right_add_right]
  rw [show s k = (k+1)*2+1 by simp [s]; omega, Nat.coprime_mul_right_add_left]
  simp

def represented (k z : ℕ) := ∃ a b : ℕ, z=a*s k+b*r k

theorem gap (k : ℕ) : ¬represented k (F k) := by
  have H : F k + r k + s k = s k * r k := by dsimp [F,m,r,s]; ring
  rintro ⟨a,b,e⟩
  have he : (a+1)*s k + (b+1)*r k = s k*r k := by rw [← H,e];ring
  have hsub : (b+1)*r k = s k*r k-(a+1)*s k := by omega
  have dvd : s k ∣ (b+1)*r k := by
    rw [hsub]
    exact Nat.dvd_sub (dvd_mul_right _ _) (dvd_mul_left _ _)
  have sm := (parameter_bounds k).1
  have rp : 0 < r k := by dsimp [r];omega
  have sb : s k ≤ b+1 := Nat.le_of_dvd (by omega) ((coprime_sr k).dvd_of_dvd_mul_right dvd)
  have hh := Nat.mul_le_mul_right (r k) sb
  have hp : 0 < (a+1)*s k := Nat.mul_pos (by omega) sm
  omega

private theorem geom_mul (d l : ℕ) : geom d l * bin d = bin (l*d) := by
  induction l with
  | zero => simp [geom,bin]
  | succ l ih =>
    rw [geom, sum_range_succ]
    change (geom d l+X^(l*d))*bin d=_
    rw [add_mul,ih]
    simp only [bin,Nat.succ_mul,pow_add]
    ring

def core (k : ℕ) : P :=
  geom (s k) (r k-1) * geom (r k) (s k-1) - X^(F k)

def witness (k : ℕ) : P := core k * geom (x k) (s k) * geom (y k) (s k-1)

private theorem core_algebra (a b c : P) :
    (1-a*b)*(1-a*c)-a*((1-c)*(1-b)) = (1-a)*(1-a*b*c) := by ring

private theorem core_expand (a b c u v : P) :
    (a*b-c)*(u*v) = (a*u)*(b*v)-c*(u*v) := by ring

private theorem expC (k : ℕ) : F k+r k+s k = s k*r k := by
  dsimp [F,m,r,s]; ring

private theorem expA (k : ℕ) : (r k-1)*s k = F k+r k := by
  have hr : 1 ≤ r k := by dsimp [r]; omega
  have H := congrArg (· * s k) (Nat.sub_add_cancel hr)
  simp only [Nat.add_mul, Nat.one_mul] at H
  rw [Nat.mul_comm (r k) (s k), ← expC] at H
  omega

private theorem expB (k : ℕ) : (s k-1)*r k = F k+s k := by
  dsimp [F,m,r,s]
  ring_nf

private theorem core_identity (k : ℕ) :
    core k * (bin (s k) * bin (r k)) = bin (F k) * bin (s k*r k) := by
  calc
    _ = (geom (s k) (r k-1)*bin (s k))*(geom (r k) (s k-1)*bin (r k))-
        X^(F k)*(bin (s k)*bin (r k)) := core_expand _ _ _ _ _
    _ = _ := by rw [geom_mul,geom_mul,expA,expB,← expC]; simp only [bin,pow_add]; apply core_algebra

theorem numerator_identity (k : ℕ) :
    witness k * (bin (s k)*bin (r k)*bin (x k)*bin (y k)) =
      bin (m k+s k)*bin (m k+r k)*bin (m k+x k)*bin (m k+y k) := by
  have A : s k*x k = m k+r k := by dsimp [s,x,r,m]; ring
  have B : (s k-1)*y k = m k+x k := by dsimp [s,x,r,y,m]; ring_nf
  have C : s k*r k = m k+y k := by dsimp [s,r,y,m]; ring
  calc
    _ = (core k*(bin (s k)*bin (r k))) * (geom (x k) (s k)*bin (x k)) *
        (geom (y k) (s k-1)*bin (y k)) := by unfold witness; ring
    _ = _ := by rw [core_identity,geom_mul,geom_mul,A,B,C]; unfold F; ring

def supported (k : ℕ) (p : P) := ∀ i, ¬represented k i → p.coeff i=0

private theorem supported_one (k : ℕ) : supported k 1 := by
  intro i h
  have hi : i ≠ 0 := by rintro rfl; exact h ⟨0,0,by simp⟩
  simpa [coeff_X_pow,hi] using (coeff_X_pow (R:=ℤ) 0 i)

private theorem supported_mul_geom {k d} {p : P} (hp : supported k p)
    (hd : represented k d) (l : ℕ) : supported k (p*geom d l) := by
  obtain ⟨a,b,hab⟩ := hd
  intro i hi
  rw [geom,mul_sum,finset_sum_coeff]
  apply sum_eq_zero
  intro j _
  rw [coeff_mul_X_pow']
  split_ifs with hj
  · apply hp
    rintro ⟨c,e,hce⟩
    apply hi
    refine ⟨c+j*a,e+j*b,?_⟩
    calc
      i = (i-j*d)+j*d := (Nat.sub_add_cancel hj).symm
      _ = _ := by rw [hce,hab]; ring
  · rfl

private theorem geom_constant {d l : ℕ} (hd : 0<d) (hl : 0<l) :
    (geom d l).coeff 0 = 1 := by
  rw [geom,finset_sum_coeff,Finset.sum_eq_single 0]
  · simp
  · intro i hi hin
    have hpos : 0 < i*d := Nat.mul_pos (Nat.pos_of_ne_zero hin) hd
    simp [coeff_X_pow, hin, hd.ne']
  · intro h
    simp [hl] at h

theorem negative_coeff (k : ℕ) : (witness k).coeff (F k) = -1 := by
  have hh := parameter_bounds k
  have hs : represented k (s k) := ⟨1,0,by simp⟩
  have hr : represented k (r k) := ⟨0,1,by simp⟩
  have hx : represented k (x k) := ⟨2*s k,0,by simp [x];ring⟩
  have hy : represented k (y k) := ⟨2,1,by simp [y,add_comm]⟩
  have hp := supported_mul_geom (supported_mul_geom (supported_mul_geom
    (supported_mul_geom (supported_one k) hs (r k-1)) hr (s k-1)) hx (s k)) hy (s k-1)
  simp only [one_mul] at hp
  have hz := hp (F k) (gap k)
  unfold witness core
  rw [sub_mul,sub_mul,coeff_sub,hz,zero_sub,mul_assoc]
  rw [coeff_X_pow_mul',if_pos le_rfl,Nat.sub_self,Polynomial.mul_coeff_zero]
  rw [geom_constant (by omega) (by omega), geom_constant (by omega) (by dsimp [s];omega)]
  norm_num

#print axioms parameter_bounds
#print axioms numerator_identity
#print axioms negative_coeff
end
end UnboundedShift
