import PrimeSandwich
import SizeBasel
import SizeExpansion

/-! The cumulative size statistic for actual indexed primes and integer
partitions. The two prime estimates in each theorem are published inputs. -/
namespace SizeResult
open Filter SizeEnsemble SizeLimit
open scoped Topology Real
noncomputable section

private theorem prime_pos (n : ℕ) : 0 < primeAt n := by
  unfold primeAt
  have hp : Nat.Prime (Nat.nth Nat.Prime (n-1)) :=
    Nat.nth_mem_of_infinite Nat.infinite_setOf_prime _
  exact_mod_cast hp.pos

/-- The normalized geometric overflow probability tends to half the Basel sum
on the scale 1 / (log n)^2. -/
theorem overflow_limit
    (pnt : Tendsto (fun n : ℕ => primeAt n / ((n:ℝ)*Real.log n)) atTop (𝓝 1)) :
    Tendsto (fun n => (L n)^2 * PrimeSandwich.D n) atTop (𝓝 (π^2/12)) := by
  have hi := pnt.inv₀ (by norm_num : (1:ℝ) ≠ 0)
  have hq : Tendsto (fun n : ℕ => (n:ℝ)*Real.log n * PrimeSandwich.q n) atTop (𝓝 1) := by
    simpa [PrimeSandwich.q,OneBased.primeQ,one_div,div_eq_mul_inv,mul_assoc,mul_comm,mul_left_comm] using hi
  have hz := SizeLimit.sharp_limit PrimeSandwich.q_nonneg hq PrimeSandwich.D (π^2/6)
    SizeTriangle.basel (PrimeSandwich.sandwich.mono fun _ h => h.1)
    (PrimeSandwich.sandwich.mono fun _ h => h.2)
  convert hz using 2
  ring

/-- Theorem (1), in normalized limit form. -/
theorem size_gap_limit
    (pnt : Tendsto (fun n : ℕ => primeAt n / ((n:ℝ)*Real.log n)) atTop (𝓝 1))
    (mertens : Tendsto (fun n => H qPrime n / Real.log n) atTop (𝓝 (Real.exp eulerGamma))) :
    Tendsto (fun n : ℕ => Real.log n*(H qPrime n-literalSize n))
      atTop (𝓝 (Real.exp eulerGamma * (π^2/12))) := by
  simpa only [PrimeSandwich.gap_eq] using weighted_gap (overflow_limit pnt) mertens

/-- Theorem (2), isolating the constant at scale 1/log n. -/
theorem size_expansion (K : ℝ)
    (cipolla : Tendsto (fun n : ℕ => primeAt n / n - Real.log n - Real.log (Real.log n))
      atTop (𝓝 (-1)))
    (product : ∀ᶠ n : ℕ in atTop, |H qPrime n - Real.exp eulerGamma*Real.log (primeAt n)| ≤
      K/(Real.log n)^2) :
    Tendsto (fun n => L n*(literalSize n-Real.exp eulerGamma*(L n+loglog n))-
      Real.exp eulerGamma*loglog n) atTop (𝓝 (Real.exp eulerGamma*(-1-π^2/12))) := by
  obtain ⟨hi,hm⟩ := first_order_inputs (H qPrime) primeAt (Real.exp eulerGamma)
    (-1) K prime_pos cipolla product
  have hp : Tendsto (fun n : ℕ => primeAt n / ((n:ℝ)*Real.log n)) atTop (𝓝 1) := by
    simpa [one_div, div_eq_mul_inv, mul_assoc, mul_comm, mul_left_comm] using
      hi.inv₀ (by norm_num : (1:ℝ) ≠ 0)
  exact size_second literalSize (H qPrime) primeAt (Real.exp eulerGamma) (-1) K (π^2/12)
    prime_pos cipolla product (size_gap_limit hp hm)

/-- The bounded-error question after Figure 6. The centered sum vanishes,
is eventually positive, and its leading equivalent is explicit. -/
theorem figure_six (K : ℝ)
    (cipolla : Tendsto (fun n : ℕ => primeAt n / n - Real.log n - Real.log (Real.log n))
      atTop (𝓝 (-1)))
    (product : ∀ᶠ n : ℕ in atTop, |H qPrime n - Real.exp eulerGamma*Real.log (primeAt n)| ≤
      K/(Real.log n)^2) :
    let R := fun n => literalSize n - Real.exp eulerGamma*(L n+loglog n)
    Tendsto R atTop (𝓝 0) ∧
    Tendsto (fun n => R n * L n / loglog n) atTop (𝓝 (Real.exp eulerGamma)) ∧
    ∀ᶠ n in atTop, 0 < R n :=
  size_remainder (Real.exp_pos _) (size_expansion K cipolla product)

#print axioms size_gap_limit
#print axioms size_expansion
#print axioms figure_six
end
end SizeResult
