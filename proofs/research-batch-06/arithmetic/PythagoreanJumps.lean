import Mathlib.NumberTheory.SumPrimeReciprocals
import Mathlib.Data.Nat.Factorial.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

/-! Synchronized jumps in the Euclid-parameter formula for OEIS A400884. -/
namespace PythagoreanJumps

open Finset

/-- The i-th positive parameter of parity opposite to u, indexed from zero. -/
def secondParam (u i : ℕ) : ℕ := 2*i + if u%2=0 then 1 else 2

def leg (u v : ℕ) : ℕ := max (u^2-v^2) (2*u*v)
def hyp (u v : ℕ) : ℕ := u^2+v^2

noncomputable def term (N u v : ℕ) : ℝ :=
  if u.Coprime v then ((N / leg u v : ℕ) + (N / hyp u v : ℕ) : ℝ)^2 else 0

noncomputable def row (N u : ℕ) : ℝ := ∑ i ∈ range (u/2), term N u (secondParam u i)

/-- The exact floor sum, indexed by Euclid's unique coprime opposite-parity pairs. -/
noncomputable def count (N : ℕ) : ℝ := ∑ u ∈ range (N+1), row N u

private theorem term_nonneg (N u v : ℕ) : 0 ≤ term N u v := by
  unfold term; split <;> positivity

private theorem term_mono (N M u v : ℕ) (h : N≤M) : term N u v ≤ term M u v := by
  unfold term
  split
  · apply pow_le_pow_left₀ (by positivity)
    exact_mod_cast Nat.add_le_add (Nat.div_le_div_right h) (Nat.div_le_div_right h)
  · rfl

private theorem row_mono (N M u : ℕ) (h : N≤M) : row N u ≤ row M u :=
  sum_le_sum (fun _ _ => term_mono N M u _ h)

private theorem floor_step (N d : ℕ) (hd : 0<d) (hN : 0<N) (h : d ∣ N) :
    (N-1)/d+1=N/d := by
  obtain ⟨k,hk⟩ := h
  cases k with
  | zero => simp [hk] at hN
  | succ k =>
    rw [hk, Nat.mul_succ, show d*k+d-1=(d-1)+d*k by omega,
      Nat.add_mul_div_left _ _ hd, Nat.div_eq_of_lt (by omega : d-1<d)]
    rw [← Nat.mul_succ, Nat.mul_div_cancel_left _ hd]
    omega

private theorem term_jump (N u v : ℕ) (hN : 0<N) (hc : u.Coprime v)
    (hz : 0<hyp u v) (hd : hyp u v ∣ N) :
    (N:ℝ)/(hyp u v:ℕ) ≤ term N u v - term (N-1) u v := by
  let z := hyp u v
  let y := leg u v
  have step : (((N-1)/z : ℕ) : ℝ)+1=(N/z:ℕ) := by exact_mod_cast floor_step N z hz hN hd
  have inc : (((N-1)/y : ℕ) : ℝ) ≤ (N/y:ℕ) := by exact_mod_cast Nat.div_le_div_right (Nat.sub_le N 1)
  have realDiv : (N:ℝ)/z=(N/z:ℕ) := by
    apply (div_eq_iff (by exact_mod_cast hz.ne')).mpr
    exact_mod_cast (Nat.div_mul_cancel hd).symm
  simp only [term, if_pos hc]
  change (N:ℝ)/z ≤ ((N/y : ℕ)+(N/z : ℕ):ℝ)^2 - (((N-1)/y:ℕ)+((N-1)/z:ℕ):ℝ)^2
  rw [realDiv, ← step]
  have H := pow_le_pow_left₀ (by positivity : (0:ℝ) ≤ ((N-1)/y : ℕ)+((N-1)/z : ℕ))
    (add_le_add_right inc (((N-1)/z:ℕ):ℝ)) 2
  nlinarith [H, (Nat.cast_nonneg (N/y) : (0:ℝ) ≤ (N/y:ℕ)),
    (Nat.cast_nonneg ((N-1)/z) : (0:ℝ) ≤ ((N-1)/z:ℕ))]

private theorem row_jump (M p : ℕ) (hp : p.Prime) (h2 : 2<p) (hm : 2*p^2 ≤ M) :
    (M.factorial:ℝ)/(8*p) ≤ row M.factorial p - row (M.factorial-1) p := by
  let N := M.factorial
  have Npos : 0<N := Nat.factorial_pos M
  have Ppos : (0:ℝ)<p := by exact_mod_cast hp.pos
  have G (i : ℕ) (hi : i∈range (p/2)) :
      (N:ℝ)/(2*(p:ℝ)^2) ≤ term N p (secondParam p i)-term (N-1) p (secondParam p i) := by
    let v := secondParam p i
    have ih := mem_range.mp hi
    have ev : v=2*i+2 := by
      have hodd := hp.eq_two_or_odd.resolve_left (by omega)
      simp [v,secondParam, hodd]
    have P : 0<v := by omega
    have V : v<p := by
      have hodd := hp.eq_two_or_odd.resolve_left (by omega)
      omega
    have cop : p.Coprime v := hp.coprime_iff_not_dvd.mpr (Nat.not_dvd_of_pos_of_lt P V)
    have Z : 0<hyp p v := by unfold hyp; positivity
    have B : hyp p v ≤ 2*p^2 := by unfold hyp; nlinarith [Nat.pow_le_pow_left V.le 2]
    apply le_trans _ (term_jump N p v Npos cop Z (Nat.dvd_factorial Z (B.trans hm)))
    apply div_le_div_of_nonneg_left (by positivity) (by exact_mod_cast Z)
    exact_mod_cast B
  unfold row
  rw [← sum_sub_distrib]
  apply le_trans _ (sum_le_sum G)
  simp only [sum_const, card_range, nsmul_eq_mul]
  have H : p ≤ 4*(p/2) := by omega
  have Hr : (p:ℝ) ≤ 4*(p/2:ℕ) := by exact_mod_cast H
  change (N:ℝ)/(8*p) ≤ (p/2:ℕ)*((N:ℝ)/(2*(p:ℝ)^2))
  rw [← mul_div_assoc]
  apply (div_le_div_iff₀ (by positivity) (by positivity)).mpr
  nlinarith [mul_nonneg (show (0:ℝ) ≤ N*p by positivity) (sub_nonneg.mpr Hr)]

private noncomputable def oddWeight (p : ℕ) : ℝ := if p.Prime ∧ 2<p then 1/(p:ℝ) else 0

private theorem odd_primes_large (C : ℝ) :
    ∃ B : ℕ, C < ∑ p ∈ range B, oddWeight p := by
  by_contra! H
  have S : Summable oddWeight := summable_of_sum_range_le
    (fun i => by unfold oddWeight; split <;> positivity) H
  apply not_summable_one_div_on_primes
  apply (summable_nat_add_iff 3).mp
  apply ((summable_nat_add_iff 3).mpr S).congr
  intro i
  have hi : 2 < i+3 := by omega
  by_cases hp : (i+3).Prime <;> simp [oddWeight, Set.indicator, hp, hi]

/-- The normalized first differences of A400884 exceed every constant,
    arbitrarily far out. The witnesses in this proof are factorials. -/
theorem unbounded_jumps (C : ℝ) (cut : ℕ) :
    ∃ N : ℕ, cut ≤ N ∧ C*N < count N-count (N-1) := by
  obtain ⟨B, hB⟩ := odd_primes_large (8*C)
  let M := 2*(B+1)^2+B+cut+3
  let N := M.factorial
  have hN : 0 < N := Nat.factorial_pos M
  have hm : M ≤ N := Nat.self_le_factorial M
  have hBN : B ≤ N := by dsimp [M] at hm; omega
  refine ⟨N, by dsimp [M] at hm; omega, ?_⟩
  let changeRow := fun u : ℕ => row N u - row (N-1) u
  have hrow (u : ℕ) : 0 ≤ changeRow u := sub_nonneg.mpr (row_mono _ _ _ (Nat.sub_le N 1))
  have hrow' : 0 ≤ row N N := sum_nonneg (fun _ _ => term_nonneg _ _ _)
  have delta : count N-count (N-1) = (∑ u ∈ range N, changeRow u)+row N N := by
    unfold count
    rw [Nat.sub_add_cancel hN, sum_range_succ]
    dsimp [changeRow]; rw [sum_sub_distrib]; ring
  have bound : ∑ p ∈ range B, ((N:ℝ)/8)*oddWeight p ≤ ∑ p ∈ range B, changeRow p := by
    apply sum_le_sum
    intro p hp
    by_cases h : p.Prime ∧ 2<p
    · have pp := mem_range.mp hp
      have hM : 2*p^2 ≤ M := by
        dsimp [M]
        have hh := Nat.pow_le_pow_left (by omega : p≤B+1) 2
        omega
      unfold oddWeight changeRow
      rw [if_pos h]
      convert row_jump M p h.1 h.2 hM using 1
      change (N:ℝ)/8*(1/p)=(N:ℝ)/(8*p)
      ring
    · simpa [oddWeight,h] using hrow p
  rw [← mul_sum] at bound
  have bigger : (∑ p ∈ range B, changeRow p) ≤ ∑ p ∈ range N, changeRow p :=
    sum_le_sum_of_subset_of_nonneg (range_mono hBN) (fun i _ _ => hrow i)
  have pos : (0:ℝ) < (N:ℝ)/8 := by positivity
  rw [delta]
  calc
    C*N = ((N:ℝ)/8)*(8*C) := by ring
    _ < _ := mul_lt_mul_of_pos_left hB pos
    _ ≤ _ := bound
    _ ≤ _ := le_trans bigger (le_add_of_nonneg_right hrow')

#print axioms unbounded_jumps

private theorem log_step (x : ℝ) (hx : 1 ≤ x) :
    |(x+1)*Real.log (x+1)-x*Real.log x| ≤ 2*(x+1) := by
  have pos : 0<x := by linarith
  have pos' : 0<x+1 := by linarith
  have mono : Real.log x ≤ Real.log (x+1) := Real.log_le_log pos (by linarith)
  have h0 := Real.log_nonneg hx
  have h1 := Real.log_le_sub_one_of_pos pos'
  have bound : x*Real.log ((x+1)/x) ≤ 1 := by
    calc
      _ ≤ x*((x+1)/x-1) := mul_le_mul_of_nonneg_left
        (Real.log_le_sub_one_of_pos (div_pos pos' pos)) pos.le
      _ = 1 := by field_simp
  rw [Real.log_div pos'.ne' pos.ne'] at bound
  rw [abs_of_nonneg (by nlinarith [mul_nonneg pos.le (sub_nonneg.mpr mono)])]
  linarith

noncomputable def mainTerm (K c x : ℝ) := K*x^2-c*x*Real.log x

private theorem main_step (K c x : ℝ) (hx : 1≤x) :
    |mainTerm K c (x+1) - mainTerm K c x| ≤ (2*|K|+2*|c|)*(x+1) := by
  rw [show mainTerm K c (x+1) - mainTerm K c x =
    K*(2*x+1) - c*((x+1)*Real.log (x+1)-x*Real.log x) by unfold mainTerm; ring]
  apply (abs_sub _ _).trans
  rw [abs_mul, abs_mul, abs_of_nonneg (by linarith : 0 ≤ 2*x+1)]
  nlinarith [mul_le_mul_of_nonneg_left (log_step x hx) (abs_nonneg c), abs_nonneg K]

/-- No smooth two-term expression K n² - c n log n admits a linear error bound,
    for any real choices of K and c. -/
theorem no_linear_remainder (K c C : ℝ) (cut : ℕ) :
    ∃ N : ℕ, cut ≤ N ∧ C*N < |count N-mainTerm K c N| := by
  by_contra! bounds
  obtain ⟨N,hn,jump⟩ := unbounded_jumps (2*|C|+2*|K|+2*|c|) (cut+2)
  have P : cut≤N-1 := by omega
  have p1 := bounds N (by omega)
  have p0 := bounds (N-1) P
  have xn : ((N-1:ℕ):ℝ)+1=N := by exact_mod_cast (by omega : N-1+1=N)
  have d := main_step K c ((N-1:ℕ):ℝ) (by exact_mod_cast (by omega : 1 ≤ N-1))
  rw [xn] at d
  have C1 := mul_le_mul_of_nonneg_right (le_abs_self C) (Nat.cast_nonneg N : (0:ℝ) ≤ N)
  have C0 := mul_le_mul_of_nonneg_right (le_abs_self C) (Nat.cast_nonneg (N-1) : (0:ℝ) ≤ (N-1:ℕ))
  have C01 := mul_le_mul_of_nonneg_left
    (show ((N-1:ℕ):ℝ) ≤ N by linarith) (abs_nonneg C)
  linarith [le_abs_self (count N-mainTerm K c N),
    neg_le_abs (count (N-1)-mainTerm K c ((N-1:ℕ):ℝ)),
    le_abs_self (mainTerm K c N - mainTerm K c ((N-1:ℕ):ℝ))]

#print axioms no_linear_remainder

end PythagoreanJumps
