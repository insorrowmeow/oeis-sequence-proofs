import Quartic
import Mathlib.RingTheory.PowerSeries.Basic
import Mathlib.Algebra.BigOperators.NatAntidiagonal
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.GeomSum

/-! Ordered labelled forests, including the empty forest. At each node the
    left forest holds its children and the right forest holds its siblings. -/
namespace VoloshynTrees
open Finset

inductive Forest
| empty
| cons (label : ℕ) (children rest : Forest)
deriving DecidableEq, Repr

def labels : Forest → ℕ
  | .empty => 0
  | .cons a _ v => a+labels v

def marks : Forest → ℕ
  | .empty => 0
  | .cons a u v => (if a=2+labels u then 1 else 0)+marks u+marks v

def nodes : Forest → ℕ
  | .empty => 0
  | .cons _ u v => nodes u+nodes v+1

def valid : Forest → Prop
  | .empty => True
  | .cons a u v => 2≤a ∧ a≤2+labels u ∧ valid u ∧ valid v

def choices (u v : Forest) : List Forest :=
  (List.range (labels u)).map (fun i => .cons (2+i) u v) ++ [.cons (2+labels u) u v]

def joinAll (A B : List Forest) : List Forest :=
  A.flatMap fun u => B.flatMap (choices u)

def forests : (n : ℕ) → List Forest
  | 0 => [.empty]
  | n+1 => (List.finRange (n+1)).flatMap fun i => joinAll (forests i.val) (forests (n-i.val))
termination_by n => n
decreasing_by all_goals have := i.isLt; omega

private def total {α R : Type*} [AddCommMonoid R] (l : List α) (f : α → R) : R :=
  (l.map f).sum

section Sum
variable {α β R : Type*} [CommRing R]
private lemma t_append (a b : List α) (f : α → R) :
    total (a++b) f = total a f+total b f := by simp [total]
private lemma t_map (a : List α) (g : α → β) (f : β → R) :
    total (a.map g) f = total a (fun x => f (g x)) := by simp [total, List.map_map, Function.comp_def]
private lemma t_bind (a : List α) (g : α → List β) (f : β → R) :
    total (a.flatMap g) f = total a (fun x => total (g x) f) := by
  induction a with
  | nil => rfl
  | cons b l ih => simpa [List.flatMap_cons, total] using congrArg (total (g b) f+·) ih
private lemma t_mul (c : R) (a : List α) (f : α → R) :
    c*total a f=total a (fun x => c*f x) := by
  induction a with
  | nil => simp [total]
  | cons b l ih => simpa [total, mul_add] using congrArg (c*f b+·) ih
private lemma t_sub (a : List α) (f g : α → R) :
    total a (fun x => f x-g x) = total a f-total a g := by
  induction a with
  | nil => simp [total]
  | cons b l ih => simpa [total,sub_add_sub_comm] using congrArg (f b-g b+·) ih
private lemma t_add (a : List α) (f g : α → R) :
    total a (fun x => f x+g x) = total a f+total a g := by
  induction a with
  | nil => simp [total]
  | cons b l ih => simp [total,add_add_add_comm] at ih ⊢
private lemma t_fin (n : ℕ) (f : Fin n → R) : total (List.finRange n) f=∑ i,f i := by
  simpa [total,List.finRange,Function.comp_def] using Fin.sum_ofFn f
private lemma t_range (n : ℕ) (f : ℕ → R) : total (List.range n) f=∑ i ∈ range n, f i := by
  induction n with
  | zero => simp [total]
  | succ n ih => simpa [List.range_succ,total,sum_range_succ] using congrArg (·+f n) ih
end Sum

section Weights
variable {R : Type*} [CommRing R]
def wt (z x : R) (u : Forest) := z^marks u * x^labels u
def Wrow (z x : R) (n : ℕ) := total (forests n) (wt z x)

private theorem local_choice (z x : R) (u v : Forest) :
    (1-x)*total (choices u v) (wt z x) =
    x^2*(wt z 1 u-wt z x u+z*(1-x)*wt z x u)*wt z x v := by
  have hterm (i : ℕ) (hi : i<labels u) :
      wt z x (.cons (2+i) u v) = (z^marks u * x^2 * wt z x v)*x^i := by
    simp [wt,marks,labels,hi.ne, pow_add,add_assoc]
    ring
  have hmax : wt z x (.cons (2+labels u) u v) =
      (z^marks u*x^2*wt z x v)*z*x^labels u := by
    simp [wt,marks,labels,pow_add]
    ring
  rw [choices,t_append,t_map,t_range]
  have hsum : (∑ i ∈ range (labels u), wt z x (.cons (2+i) u v)) =
      (z^marks u*x^2*wt z x v)*∑ i ∈ range (labels u), x^i := by
    rw [mul_sum]; exact sum_congr rfl fun i hi => hterm i (mem_range.mp hi)
  rw [hsum]
  simp only [total,List.map_cons,List.map_nil,List.sum_cons,List.sum_nil,add_zero,hmax]
  have hgeom := mul_neg_geom_sum x (labels u)
  simp only [wt,one_pow,mul_one] at *
  linear_combination (z^marks u*x^2*(z^marks v*x^labels v))*hgeom

private theorem block_choice (z x : R) (A B : List Forest) :
    (1-x)*total (joinAll A B) (wt z x) =
    x^2*(total A (wt z 1)-total A (wt z x)+z*(1-x)*total A (wt z x))*total B (wt z x) := by
  simp only [joinAll,t_bind]
  rw [t_mul]
  calc
    _ = total A (fun u => total B (fun v =>
         x^2*(wt z 1 u-wt z x u+z*(1-x)*wt z x u)*wt z x v)) := by
      congr 1; funext u; rw [t_mul]; congr 1; funext v; exact local_choice .. 
    _ = _ := by
      simp_rw [← t_mul]
      rw [show (fun u => x^2*(wt z 1 u-wt z x u+z*(1-x)*wt z x u)*total B (wt z x)) =
        (fun u => (x^2*total B (wt z x))*(wt z 1 u-wt z x u+z*(1-x)*wt z x u)) by
          funext u; ring]
      rw [← t_mul,t_add,t_sub,← t_mul]
      ring

theorem row_rec (z x : R) (n : ℕ) : (1-x)*Wrow z x (n+1) =
    x^2*∑ i ∈ range (n+1), (Wrow z 1 i-Wrow z x i+z*(1-x)*Wrow z x i)*Wrow z x (n-i) := by
  unfold Wrow
  rw [forests,t_bind,t_mul,t_fin,← Fin.sum_univ_eq_sum_range]
  rw [mul_sum]
  apply sum_congr rfl
  intro i _
  rw [block_choice]
  ring

end Weights

section GeneratingFunction
noncomputable section
open PowerSeries
variable {K : Type*} [Field K]
local notation "P" => Polynomial K
local notation "B" => PowerSeries P

def forestSeries (z : K) : PowerSeries K := mk (Wrow z 1)
def catalyticSeries (z : K) : B := mk (Wrow (Polynomial.C z) Polynomial.X)

theorem row_map {A D : Type*} [CommRing A] [CommRing D] (φ : A →+* D) (z x : A) (n : ℕ) :
    φ (Wrow z x n) = Wrow (φ z) (φ x) n := by
  unfold Wrow total
  induction forests n with
  | nil => simp
  | cons b l ih => simp [wt] at ih ⊢; exact ih

theorem forest_kernel (z : K) :
    Voloshyn.kernelA X (C _ (Polynomial.C z)) (C _ Polynomial.X)*(catalyticSeries z)^2 +
    Voloshyn.kernelB X (PowerSeries.map Polynomial.C (forestSeries z)) (C _ Polynomial.X)*
      catalyticSeries z - (1-C _ Polynomial.X) = (0:B) := by
  let w := catalyticSeries z
  let f := PowerSeries.map Polynomial.C (forestSeries z)
  let x := (Polynomial.X : P)
  let v := Polynomial.C z
  have rec : C P (1-x)*(w-1) = X*(C P (x^2)*
      ((f-w+C P (v*(1-x))*w)*w)) := by
    apply PowerSeries.ext; intro n
    cases n with
    | zero =>
      simp [w,catalyticSeries,coeff_C_mul,Wrow,forests,total,wt,marks,labels]
    | succ n =>
      rw [coeff_C_mul,map_sub,coeff_one,if_neg (by omega),sub_zero,
          coeff_succ_X_mul,coeff_C_mul,coeff_mul,Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
      have hc (i : ℕ) : coeff P i f = Wrow v (1:P) i := by
        simp only [f,coeff_map,forestSeries,coeff_mk]
        simpa [v] using row_map (Polynomial.C : K →+* P) z 1 i
      simp only [map_add,map_sub,coeff_C_mul,hc,w,catalyticSeries,coeff_mk]
      exact row_rec v x n
  change Voloshyn.kernelA X (C P v) (C P x)*w^2 + Voloshyn.kernelB X f (C P x)*w -
    (1-C P x)=0
  simp only [map_sub,map_mul,map_pow,map_one] at rec
  unfold Voloshyn.kernelA Voloshyn.kernelB
  linear_combination rec

#print axioms forest_kernel
end
end GeneratingFunction
end VoloshynTrees


