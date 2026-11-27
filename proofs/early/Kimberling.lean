import Std

namespace Kimberling

/-- The entries available while testing n are the accepted smaller integers
and the candidate n itself. Non-strict ordering permits repeated indices. -/
def Blocked (S : Nat → Prop) (n : Nat) : Prop :=
  ∃ x y z, 1 ≤ x ∧ x ≤ y ∧ y ≤ z ∧ z ≤ n ∧
    (S x ∨ x = n) ∧ (S y ∨ y = n) ∧ (S z ∨ z = n) ∧ x*y = n+z

/-- Scan integers in increasing order, inserting 1 initially and accepting
each later candidate precisely when no admissible triple blocks it. -/
def GreedyRule (S : Nat → Prop) : Prop :=
  ¬ S 0 ∧ S 1 ∧ ∀ n, 2 ≤ n → (S n ↔ ¬ Blocked S n)

def expected (n : Nat) : Prop := n = 3 ∨ n % 3 = 1

private theorem small_values {v : Nat} (h : expected v) (bound : v ≤ 3) :
    v = 1 ∨ v = 3 := by unfold expected at h; omega

private theorem allowed {n : Nat} (hn : expected n) : ¬ Blocked expected n := by
  intro ⟨x,y,z,_,hxy,hyz,hzn,hx,hy,hz,heq⟩
  have pull {v : Nat} (hv : expected v ∨ v=n) : expected v :=
    hv.elim id (fun h => h ▸ hn)
  have hx' := pull hx
  have hy' := pull hy
  have hz' := pull hz
  have small (hz3 : z ≤ 3) : False := by
    have hxs := small_values hx' (by omega)
    have hys := small_values hy' (by omega)
    have hzs := small_values hz' hz3
    unfold expected at hn
    rcases hxs with rfl|rfl <;> rcases hys with rfl|rfl <;>
      rcases hzs with rfl|rfl <;> omega
  rcases hn with hn|hn
  · exact small (by omega)
  rcases hz' with hz3|hz1
  · exact small (by omega)
  have hmod := congrArg (fun t => t % 3) heq
  change x*y % 3 = (n+z) % 3 at hmod
  rw [Nat.mul_mod, Nat.add_mod, hn, hz1] at hmod
  rcases hx' with hx3|hx1 <;> rcases hy' with hy3|hy1 <;>
    simp_all

private theorem excluded {n : Nat} (hn : 2 ≤ n) (he : ¬ expected n) :
    Blocked expected n := by
  unfold expected at he
  by_cases h2 : n = 2
  · subst n; exact ⟨2,2,2, by unfold expected; decide⟩
  by_cases h5 : n = 5
  · subst n; exact ⟨3,3,4, by unfold expected; decide⟩
  by_cases h6 : n = 6
  · subst n; exact ⟨3,3,3, by unfold expected; decide⟩
  by_cases h0 : n % 3 = 0
  · let k := (n-9)/9
    have hs : n = 9+9*k ∨ n = 12+9*k ∨ n = 15+9*k := by dsimp [k]; omega
    rcases hs with h|h|h
    · refine ⟨4,4+3*k,7+3*k,?_⟩
      unfold expected
      omega
    · refine ⟨4,4+3*k,4+3*k,?_⟩
      unfold expected
      omega
    · refine ⟨4,7+3*k,13+3*k,?_⟩
      unfold expected
      omega
  · let k := (n-8)/6
    have hs : n = 8+6*k ∨ n = 11+6*k := by dsimp [k]; omega
    rcases hs with h|h
    · refine ⟨3,4+3*k,4+3*k,?_⟩
      unfold expected
      omega
    · refine ⟨3,7+3*k,10+3*k,?_⟩
      unfold expected
      omega

theorem expected_obeys_rule : GreedyRule expected := by
  refine ⟨by unfold expected; decide, by unfold expected; decide, fun n hn => ⟨fun h => allowed h, ?_⟩⟩
  intro h
  by_cases he : expected n
  · exact he
  · exact False.elim (h (excluded hn he))

private theorem transfer {S T : Nat → Prop} {n : Nat}
    (h : ∀ v, v < n → (S v ↔ T v)) (hs : Blocked S n) : Blocked T n := by
  obtain ⟨x,y,z,hx1,hxy,hyz,hzn,hx,hy,hz,heq⟩ := hs
  have lift {v : Nat} (hv : v ≤ n) (hm : S v ∨ v=n) : T v ∨ v=n := by
    by_cases he : v=n
    · exact Or.inr he
    · exact Or.inl ((h v (by omega)).mp (hm.resolve_right he))
  exact ⟨x,y,z,hx1,hxy,hyz,hzn,lift (by omega) hx,lift (by omega) hy,lift hzn hz,heq⟩

/-- The increasing sequence specified in OEIS A026488 has precisely these
members. Strong induction proves uniqueness for the original greedy rule. -/
theorem a026488 {S : Nat → Prop} (hs : GreedyRule S) (n : Nat) :
    S n ↔ n = 3 ∨ n % 3 = 1 := by
  change S n ↔ expected n
  induction n using Nat.strongRecOn with
  | ind n ih =>
    obtain ⟨h0,h1,hr⟩ := hs
    obtain ⟨t0,t1,tr⟩ := expected_obeys_rule
    by_cases hn0 : n=0
    · subst n; exact ⟨fun h => False.elim (h0 h), fun h => False.elim (t0 h)⟩
    by_cases hn1 : n=1
    · subst n; exact ⟨fun _ => t1, fun _ => h1⟩
    have h2 : 2 ≤ n := by omega
    rw [hr n h2, tr n h2]
    exact ⟨fun h ht => h (transfer (fun v hv => (ih v hv).symm) ht),
           fun h ht => h (transfer ih ht)⟩

end Kimberling

#print axioms Kimberling.expected_obeys_rule
#print axioms Kimberling.a026488
