import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.Ring

namespace GrayBounds

def gray (n : ℕ) := n ^^^ (n/2)
def term (x y : ℕ) := gray (gray x + gray y)

/-- pair j holds the terms at indices 2j+1 and 2j+2. -/
def pair : ℕ → ℕ × ℕ
  | 0 => (1,1)
  | j+1 =>
    let (x,y) := pair j
    let z := term x y
    (z, term y z)

def seq (n : ℕ) : ℕ := if n%2=1 then (pair ((n-1)/2)).1 else (pair ((n-1)/2)).2
theorem seq_one : seq 1 = 1 := by decide
theorem seq_two : seq 2 = 1 := by decide

private theorem odd_term (j : ℕ) : seq (2*j+1) = (pair j).1 := by
  unfold seq; rw [if_pos (by omega), show (2*j+1-1)/2=j by omega]

private theorem even_term (j : ℕ) : seq (2*j+2) = (pair j).2 := by
  unfold seq; rw [if_neg (by omega), show (2*j+2-1)/2=j by omega]

theorem seq_rule {n : ℕ} (hn : 1 ≤ n) : seq (n+2) = term (seq n) (seq (n+1)) := by
  rcases Nat.mod_two_eq_zero_or_one n with h|h
  · let j := (n-2)/2
    have e : n=2*j+2 := by dsimp [j]; omega
    rw [e, show 2*j+2+2=2*(j+1)+2 by omega, even_term,
        show 2*j+2+1=2*(j+1)+1 by omega, odd_term, even_term]
    rfl
  · let j := (n-1)/2
    have e : n=2*j+1 := by dsimp [j]; omega
    rw [e, show 2*j+1+2=2*(j+1)+1 by omega, odd_term, odd_term,
        show 2*j+1+1=2*j+2 by omega, even_term]
    rfl

private def top (k x : ℕ) := x/2^k

private theorem top_gray (k x : ℕ) : top k (gray x) = gray (top k x) := by
  unfold top gray
  rw [Nat.xor_div_two_pow, Nat.div_div_eq_div_mul, Nat.div_div_eq_div_mul, Nat.mul_comm 2]

private theorem top_term (k x y : ℕ) : ∃ c : Fin 2,
    top k (term x y) = gray (gray (top k x)+gray (top k y)+c.val) := by
  unfold term
  rw [top_gray]
  have b := @Nat.add_div (gray x) (gray y) (2^k) (Nat.two_pow_pos _)
  by_cases h : 2^k ≤ gray x % 2^k + gray y % 2^k
  · refine ⟨1, ?_⟩
    rw [if_pos h] at b
    change top k (gray x + gray y) = _ at b
    rw [show gray (top k x) = top k (gray x) from (top_gray ..).symm,
      show gray (top k y) = top k (gray y) from (top_gray ..).symm]
    exact congrArg gray b
  · refine ⟨0, ?_⟩
    rw [if_neg h] at b
    rw [show gray (top k x) = top k (gray x) from (top_gray ..).symm,
      show gray (top k y) = top k (gray y) from (top_gray ..).symm]
    exact congrArg gray b

private def advance (p : ℕ × ℕ) (c d : Fin 2) : ℕ × ℕ :=
  let w := gray (gray p.1 + gray p.2 + c.val)
  (w/2, gray (gray p.2 + gray w + d.val)/2)

private def prefixPair (k : ℕ) : ℕ × ℕ :=
  (top (k+2) (pair (k+11)).1, top (k+2) (pair (k+11)).2)

private theorem step (k : ℕ) : ∃ c d : Fin 2,
    prefixPair (k+1) = advance (prefixPair k) c d := by
  let x := (pair (k+11)).1
  let y := (pair (k+11)).2
  let z := term x y
  obtain ⟨c,hc⟩ := top_term (k+2) x y
  obtain ⟨d,hd⟩ := top_term (k+2) y z
  refine ⟨c,d,?_⟩
  have drop (t : ℕ) : top (k+3) t = top (k+2) t / 2 := by
    unfold top; rw [Nat.div_div_eq_div_mul, pow_succ]
  change (top (k+3) z, top (k+3) (term y z)) = _
  change top (k+2) z = _ at hc
  rw [drop,drop,hd,hc]
  rfl

-- Prefix certificate, computed from the 12th pair by closing under advance.
private def states : List (ℕ × ℕ) := [
  (978,555), (982,552), (982,568), (992,553), (993,552), (993,553), (993,555),
  (994,552), (994,568), (994,617), (994,618), (994,619), (995,552), (995,553),
  (995,568), (995,616), (995,617), (996,549), (996,550), (996,551), (997,548),
  (997,549), (1000,608), (1000,609), (1000,632), (1000,633), (1001,544), (1001,608),
  (1001,632), (1002,554), (1002,558), (1004,546), (1004,547), (1004,556), (1004,557),
  (1004,559), (1005,546), (1005,550), (1005,557), (1005,558), (1005,559), (1006,548),
  (1006,549), (1006,551), (1006,556), (1007,548), (1007,549), (1007,551), (1007,556),
  (1009,637), (1009,639), (1010,634), (1010,635), (1011,634), (1011,638), (1011,639),
  (1012,618), (1012,621), (1012,622), (1012,623), (1012,628), (1012,629), (1012,632),
  (1012,633), (1012,634), (1012,635), (1012,636), (1012,637), (1012,639), (1013,616),
  (1013,617), (1013,618), (1013,619), (1013,621), (1013,622), (1013,623), (1013,628),
  (1013,633), (1013,635), (1013,636), (1013,637), (1013,638), (1013,639), (1014,633),
  (1014,635), (1015,616), (1015,617), (1015,619), (1015,628), (1015,629), (1015,632),
  (1015,634), (1015,635), (1016,626), (1016,630), (1016,634), (1016,638), (1017,634),
  (1017,635), (1018,626), (1018,630), (1019,633), (1019,635), (1020,593), (1020,594),
  (1020,595), (1020,624), (1020,625), (1020,626), (1020,627), (1020,628), (1020,629),
  (1020,630), (1020,631), (1020,636), (1020,637), (1020,639), (1021,592), (1021,624),
  (1021,625), (1021,628), (1021,629), (1021,630), (1021,631), (1021,636), (1021,637),
  (1021,638), (1021,639), (1022,592), (1022,593), (1022,630), (1022,631), (1023,593),
  (1023,594), (1023,595), (1023,626), (1023,627), (1023,628), (1023,629), (1023,630)]

private theorem base : prefixPair 0 ∈ states := by decide

private theorem checked : states.all (fun p => decide (
    978 ≤ p.1 ∧ p.1 < 1024 ∧ 544 ≤ p.2 ∧ p.2 < 640 ∧
    ∀ c d : Fin 2, advance p c d ∈ states)) = true := by decide

private theorem invariant (k : ℕ) : prefixPair k ∈ states := by
  induction k with
  | zero => exact base
  | succ k ih =>
    obtain ⟨c,d,h⟩ := step k
    rw [h]
    exact (of_decide_eq_true (List.all_eq_true.mp checked _ ih)).2.2.2.2 c d

theorem dyadic_bounds (k : ℕ) :
    2^(k+11) ≤ seq (2*k+23) ∧ seq (2*k+23) < 2^(k+12) ∧
    2^(k+11) ≤ seq (2*k+24) ∧ seq (2*k+24) < 2^(k+12) := by
  have q := of_decide_eq_true (List.all_eq_true.mp checked _ (invariant k))
  let D := 2^(k+2)
  let x := (pair (k+11)).1
  let y := (pair (k+11)).2
  have hx : 978 ≤ x/D := q.1
  have hx' : x/D < 1024 := q.2.1
  have hy : 544 ≤ y/D := q.2.2.1
  have hy' : y/D < 640 := q.2.2.2.1
  have hD : 0 < D := Nat.two_pow_pos _
  rw [Nat.le_div_iff_mul_le hD] at hx hy
  rw [Nat.div_lt_iff_lt_mul hD] at hx' hy'
  have e1 : 2^(k+11) = D*512 := by dsimp [D]; rw [show k+11=k+2+9 by omega,pow_add]; rfl
  have e2 : 2^(k+12) = D*1024 := by dsimp [D]; rw [show k+12=k+2+10 by omega,pow_add]; rfl
  have a : seq (2*k+23) = x := by rw [show 2*k+23=2*(k+11)+1 by omega, odd_term]
  have b : seq (2*k+24) = y := by rw [show 2*k+24=2*(k+11)+2 by omega, even_term]
  rw [a,b,e1,e2]
  omega

#print axioms dyadic_bounds
end GrayBounds
