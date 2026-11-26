import InverseBase

set_option linter.unusedVariables false
set_option maxHeartbeats 2000000
set_option maxRecDepth 8000
namespace Inverse
namespace P8R7

theorem privateReplay (p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40 p41 p42 p43 p44 p45 p46 p47 p48 p49 p50 p51 p52 p53 p54 p55 : Prop)
    (h0 : (p1) ∨ (p2) ∨ (p3) ∨ (p4) ∨ (p5))
    (h1 : ¬ (p1) ∨ (p6))
    (h2 : ¬ (p2) ∨ (p7))
    (h3 : ¬ (p3) ∨ (p8))
    (h4 : ¬ (p4) ∨ (p9))
    (h5 : ¬ (p5) ∨ (p10))
    (h6 : ¬ (p7) ∨ ¬ (p11))
    (h7 : ¬ (p9) ∨ ¬ (p12))
    (h8 : ¬ (p11) ∨ ¬ (p6))
    (h9 : ¬ (p9) ∨ (p13))
    (h10 : (p8) ∨ (p10) ∨ (p14) ∨ (p15) ∨ (p16))
    (h11 : ¬ (p8) ∨ ¬ (p15))
    (h12 : ¬ (p10) ∨ ¬ (p15))
    (h13 : ¬ (p8) ∨ (p17))
    (h14 : ¬ (p10) ∨ (p18))
    (h15 : ¬ (p14) ∨ (p19))
    (h16 : ¬ (p15) ∨ ¬ (p18))
    (h17 : ¬ (p15) ∨ (p20))
    (h18 : ¬ (p16) ∨ (p21))
    (h19 : ¬ (p13) ∨ ¬ (p22))
    (h20 : (p23) ∨ (p24) ∨ (p25) ∨ (p26) ∨ (p27))
    (h21 : ¬ (p23) ∨ ¬ (p27))
    (h22 : ¬ (p26) ∨ ¬ (p28))
    (h23 : ¬ (p27) ∨ ¬ (p28))
    (h24 : ¬ (p27) ∨ (p29))
    (h25 : ¬ (p18) ∨ ¬ (p30))
    (h26 : ¬ (p30) ∨ ¬ (p17))
    (h27 : (p9) ∨ (p23) ∨ (p31))
    (h28 : ¬ (p9) ∨ ¬ (p23))
    (h29 : ¬ (p20) ∨ ¬ (p31))
    (h30 : ¬ (p20) ∨ (p32))
    (h31 : ¬ (p19) ∨ ¬ (p33))
    (h32 : ¬ (p21) ∨ ¬ (p33))
    (h33 : (p4) ∨ (p11) ∨ (p18) ∨ (p34))
    (h34 : ¬ (p33) ∨ ¬ (p35))
    (h35 : ¬ (p33) ∨ ¬ (p34))
    (h36 : ¬ (p33) ∨ ¬ (p36))
    (h37 : (p37) ∨ (p29) ∨ (p38) ∨ (p39) ∨ (p40) ∨ (p41))
    (h38 : (p12) ∨ (p22) ∨ (p28) ∨ (p42))
    (h39 : ¬ (p29) ∨ ¬ (p42))
    (h40 : ¬ (p29) ∨ (p43))
    (h41 : ¬ (p38) ∨ ¬ (p42))
    (h42 : ¬ (p38) ∨ (p44))
    (h43 : ¬ (p39) ∨ ¬ (p42))
    (h44 : ¬ (p39) ∨ ¬ (p44))
    (h45 : ¬ (p40) ∨ ¬ (p42))
    (h46 : ¬ (p40) ∨ ¬ (p44))
    (h47 : ¬ (p41) ∨ ¬ (p42))
    (h48 : ¬ (p41) ∨ ¬ (p44))
    (h49 : ¬ (p24) ∨ ¬ (p45))
    (h50 : ¬ (p37) ∨ ¬ (p45))
    (h51 : ¬ (p32) ∨ (p45))
    (h52 : ¬ (p25) ∨ ¬ (p32))
    (h53 : (p36) ∨ (p46) ∨ (p47) ∨ (p48) ∨ (p49) ∨ (p50))
    (h54 : (p15) ∨ (p30) ∨ (p35) ∨ (p51))
    (h55 : ¬ (p47) ∨ (p52))
    (h56 : ¬ (p48) ∨ ¬ (p51))
    (h57 : ¬ (p49) ∨ ¬ (p51))
    (h58 : ¬ (p50) ∨ ¬ (p51))
    (h59 : ¬ (p53) ∨ ¬ (p45))
    (h60 : (p29) ∨ (p44) ∨ (p54))
    (h61 : ¬ (p29) ∨ ¬ (p44))
    (h62 : ¬ (p29) ∨ ¬ (p54))
    (h63 : (p27) ∨ (p38) ∨ (p53) ∨ (p55))
    (h64 : ¬ (p27) ∨ ¬ (p55))
    (h65 : ¬ (p33) ∨ ¬ (p46))
    (h66 : ¬ (p33) ∨ ¬ (p52))
    (h67 : ¬ (p13) ∨ ¬ (p22))
    (h68 : ¬ (p26) ∨ ¬ (p43))
    (h69 : (p33)) : False := by
  have rup71 : ¬ (p19) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p19) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h69
    exact (Or.elim h31 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup72 : ¬ (p21) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p21) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h69
    exact (Or.elim h32 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup73 : ¬ (p35) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p35) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h69
    exact (Or.elim h34 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup74 : ¬ (p34) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p34) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h69
    exact (Or.elim h35 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup75 : ¬ (p36) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p36) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h69
    exact (Or.elim h36 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup76 : ¬ (p46) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p46) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h69
    exact (Or.elim h65 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup77 : ¬ (p52) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p52) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h69
    exact (Or.elim h66 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup78 : ¬ (p14) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p14) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p19) := rup71
    exact (Or.elim h15 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup79 : ¬ (p16) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p16) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p21) := rup72
    exact (Or.elim h18 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup80 : ¬ (p47) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p47) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p52) := rup77
    exact (Or.elim h55 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup81 : (p44) ∨ (p54) ∨ (p55) ∨ ¬ (p20) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p44) := fun v => denied (Or.inl v)
    have u1 : ¬ (p54) := fun v => denied (Or.inr (Or.inl v))
    have u2 : ¬ (p55) := fun v => denied (Or.inr (Or.inr (Or.inl v)))
    have u3 : (p20) := Classical.byContradiction (fun v => denied (Or.inr (Or.inr (Or.inr v))))
    have u4 : (p32) := (Or.elim h30 (fun v => (False.elim (v u3))) (fun tail => tail))
    have u5 : (p45) := (Or.elim h51 (fun v => (False.elim (v u4))) (fun tail => tail))
    have u6 : ¬ (p53) := (Or.elim h59 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u7 : ¬ (p31) := (Or.elim h29 (fun v => (False.elim (v u3))) (fun tail => tail))
    have u8 : ¬ (p38) := (Or.elim h42 (fun v => v) (fun tail => (False.elim (u0 tail))))
    have u9 : (p29) := (Or.elim h60 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u1 tail))))))
    have u10 : (p27) := (Or.elim h63 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (False.elim (u2 tail))))))))
    have u11 : ¬ (p42) := (Or.elim h39 (fun v => (False.elim (v u9))) (fun tail => tail))
    have u12 : ¬ (p23) := (Or.elim h21 (fun v => v) (fun tail => (False.elim (tail u10))))
    have u13 : ¬ (p28) := (Or.elim h23 (fun v => (False.elim (v u10))) (fun tail => tail))
    have u14 : (p9) := (Or.elim h27 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u12 v))) (fun tail => (False.elim (u7 tail))))))
    have u15 : ¬ (p12) := (Or.elim h7 (fun v => (False.elim (v u14))) (fun tail => tail))
    have u16 : (p13) := (Or.elim h9 (fun v => (False.elim (v u14))) (fun tail => tail))
    have u17 : (p22) := (Or.elim h38 (fun v => (False.elim (u15 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u13 v))) (fun tail => (False.elim (u11 tail))))))))
    exact (Or.elim h67 (fun v => (False.elim (v u16))) (fun tail => (False.elim (tail u17))))
  have rup82 : (p4) ∨ (p2) ∨ (p5) ∨ (p3) ∨ (p18) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p4) := fun v => denied (Or.inl v)
    have u1 : ¬ (p2) := fun v => denied (Or.inr (Or.inl v))
    have u2 : ¬ (p5) := fun v => denied (Or.inr (Or.inr (Or.inl v)))
    have u3 : ¬ (p3) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inl v))))
    have u4 : ¬ (p18) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inr v))))
    have u5 : ¬ (p34) := rup74
    have u6 : (p11) := (Or.elim h33 (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (False.elim (u5 tail))))))))
    have u7 : (p1) := (Or.elim h0 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u2 tail))))))))))
    have u8 : ¬ (p6) := (Or.elim h8 (fun v => (False.elim (v u6))) (fun tail => tail))
    exact (Or.elim h1 (fun v => (False.elim (v u7))) (fun tail => (False.elim (u8 tail))))
  have rup83 : ¬ (p9) ∨ ¬ (p44) ∨ ¬ (p32) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p9) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : (p44) := Classical.byContradiction (fun v => denied (Or.inr (Or.inl v)))
    have u2 : (p32) := Classical.byContradiction (fun v => denied (Or.inr (Or.inr v)))
    have u3 : ¬ (p41) := (Or.elim h48 (fun v => v) (fun tail => (False.elim (tail u1))))
    have u4 : ¬ (p40) := (Or.elim h46 (fun v => v) (fun tail => (False.elim (tail u1))))
    have u5 : ¬ (p39) := (Or.elim h44 (fun v => v) (fun tail => (False.elim (tail u1))))
    have u6 : (p45) := (Or.elim h51 (fun v => (False.elim (v u2))) (fun tail => tail))
    have u7 : ¬ (p37) := (Or.elim h50 (fun v => v) (fun tail => (False.elim (tail u6))))
    have u8 : ¬ (p29) := (Or.elim h61 (fun v => v) (fun tail => (False.elim (tail u1))))
    have u9 : (p38) := (Or.elim h37 (fun v => (False.elim (u7 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (False.elim (u3 tail))))))))))))
    have u10 : ¬ (p42) := (Or.elim h41 (fun v => (False.elim (v u9))) (fun tail => tail))
    have u11 : ¬ (p27) := (Or.elim h24 (fun v => v) (fun tail => (False.elim (u8 tail))))
    have u12 : ¬ (p24) := (Or.elim h49 (fun v => v) (fun tail => (False.elim (tail u6))))
    have u13 : ¬ (p25) := (Or.elim h52 (fun v => v) (fun tail => (False.elim (tail u2))))
    have u14 : ¬ (p12) := (Or.elim h7 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u15 : (p13) := (Or.elim h9 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u16 : ¬ (p23) := (Or.elim h28 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u17 : ¬ (p22) := (Or.elim h67 (fun v => (False.elim (v u15))) (fun tail => tail))
    have u18 : (p26) := (Or.elim h20 (fun v => (False.elim (u16 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u12 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u13 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u11 tail))))))))))
    have u19 : (p28) := (Or.elim h38 (fun v => (False.elim (u14 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u17 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u10 tail))))))))
    exact (Or.elim h22 (fun v => (False.elim (v u18))) (fun tail => (False.elim (tail u19))))
  have rup84 : (p4) ∨ (p5) ∨ (p3) ∨ (p18) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p4) := fun v => denied (Or.inl v)
    have u1 : ¬ (p5) := fun v => denied (Or.inr (Or.inl v))
    have u2 : ¬ (p3) := fun v => denied (Or.inr (Or.inr (Or.inl v)))
    have u3 : ¬ (p18) := fun v => denied (Or.inr (Or.inr (Or.inr v)))
    have u4 : ¬ (p34) := rup74
    have u5 : (p11) := (Or.elim h33 (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (False.elim (u4 tail))))))))
    have u6 : (p2) := (Or.elim rup82 (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u3 tail))))))))))
    have u7 : ¬ (p7) := (Or.elim h6 (fun v => v) (fun tail => (False.elim (tail u5))))
    exact (Or.elim h2 (fun v => (False.elim (v u6))) (fun tail => (False.elim (u7 tail))))
  have rup85 : (p55) ∨ (p44) ∨ ¬ (p20) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p55) := fun v => denied (Or.inl v)
    have u1 : ¬ (p44) := fun v => denied (Or.inr (Or.inl v))
    have u2 : (p20) := Classical.byContradiction (fun v => denied (Or.inr (Or.inr v)))
    have u3 : ¬ (p38) := (Or.elim h42 (fun v => v) (fun tail => (False.elim (u1 tail))))
    have u4 : (p32) := (Or.elim h30 (fun v => (False.elim (v u2))) (fun tail => tail))
    have u5 : (p45) := (Or.elim h51 (fun v => (False.elim (v u4))) (fun tail => tail))
    have u6 : ¬ (p53) := (Or.elim h59 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u7 : (p54) := (Or.elim rup81 (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (tail u2))))))))
    have u8 : (p27) := (Or.elim h63 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (False.elim (u0 tail))))))))
    have u9 : ¬ (p29) := (Or.elim h62 (fun v => v) (fun tail => (False.elim (tail u7))))
    exact (Or.elim h24 (fun v => (False.elim (v u8))) (fun tail => (False.elim (u9 tail))))
  have rup86 : (p15) ∨ (p51) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p15) := fun v => denied (Or.inl v)
    have u1 : ¬ (p51) := fun v => denied (Or.inr v)
    have u2 : ¬ (p14) := rup78
    have u3 : ¬ (p16) := rup79
    have u4 : ¬ (p35) := rup73
    have u5 : (p30) := (Or.elim h54 (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (False.elim (u1 tail))))))))
    have u6 : ¬ (p18) := (Or.elim h25 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u7 : ¬ (p17) := (Or.elim h26 (fun v => (False.elim (v u5))) (fun tail => tail))
    have u8 : ¬ (p10) := (Or.elim h14 (fun v => v) (fun tail => (False.elim (u6 tail))))
    have u9 : ¬ (p8) := (Or.elim h13 (fun v => v) (fun tail => (False.elim (u7 tail))))
    exact (Or.elim h10 (fun v => (False.elim (u9 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u3 tail))))))))))
  have rup87 : ¬ (p15) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p15) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p8) := (Or.elim h11 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u2 : ¬ (p10) := (Or.elim h12 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u3 : ¬ (p18) := (Or.elim h16 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u4 : (p20) := (Or.elim h17 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u5 : ¬ (p3) := (Or.elim h3 (fun v => v) (fun tail => (False.elim (u1 tail))))
    have u6 : ¬ (p5) := (Or.elim h5 (fun v => v) (fun tail => (False.elim (u2 tail))))
    have u7 : (p32) := (Or.elim h30 (fun v => (False.elim (v u4))) (fun tail => tail))
    have u8 : (p4) := (Or.elim rup84 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (False.elim (u3 tail))))))))
    have u9 : (p45) := (Or.elim h51 (fun v => (False.elim (v u7))) (fun tail => tail))
    have u10 : ¬ (p25) := (Or.elim h52 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u11 : (p9) := (Or.elim h4 (fun v => (False.elim (v u8))) (fun tail => tail))
    have u12 : ¬ (p24) := (Or.elim h49 (fun v => v) (fun tail => (False.elim (tail u9))))
    have u13 : ¬ (p37) := (Or.elim h50 (fun v => v) (fun tail => (False.elim (tail u9))))
    have u14 : ¬ (p12) := (Or.elim h7 (fun v => (False.elim (v u11))) (fun tail => tail))
    have u15 : (p13) := (Or.elim h9 (fun v => (False.elim (v u11))) (fun tail => tail))
    have u16 : ¬ (p23) := (Or.elim h28 (fun v => (False.elim (v u11))) (fun tail => tail))
    have u17 : ¬ (p44) := (Or.elim rup83 (fun v => (False.elim (v u11))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (tail u7))))))
    have u18 : ¬ (p22) := (Or.elim h19 (fun v => (False.elim (v u15))) (fun tail => tail))
    have u19 : ¬ (p38) := (Or.elim h42 (fun v => v) (fun tail => (False.elim (u17 tail))))
    have u20 : (p55) := (Or.elim rup85 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u17 v))) (fun tail => (False.elim (tail u4))))))
    have u21 : ¬ (p27) := (Or.elim h64 (fun v => v) (fun tail => (False.elim (tail u20))))
    have u22 : (p26) := (Or.elim h20 (fun v => (False.elim (u16 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u12 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u10 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u21 tail))))))))))
    have u23 : ¬ (p28) := (Or.elim h22 (fun v => (False.elim (v u22))) (fun tail => tail))
    have u24 : ¬ (p43) := (Or.elim h68 (fun v => (False.elim (v u22))) (fun tail => tail))
    have u25 : (p42) := (Or.elim h38 (fun v => (False.elim (u14 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u18 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u23 v))) (fun tail => tail))))))
    have u26 : ¬ (p29) := (Or.elim h40 (fun v => v) (fun tail => (False.elim (u24 tail))))
    have u27 : ¬ (p39) := (Or.elim h43 (fun v => v) (fun tail => (False.elim (tail u25))))
    have u28 : ¬ (p40) := (Or.elim h45 (fun v => v) (fun tail => (False.elim (tail u25))))
    have u29 : ¬ (p41) := (Or.elim h47 (fun v => v) (fun tail => (False.elim (tail u25))))
    exact (Or.elim h37 (fun v => (False.elim (u13 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u26 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u19 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u27 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u28 v))) (fun tail => (False.elim (u29 tail))))))))))))
  have rup88 : (p51) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p51) := fun v => denied v
    have u1 : ¬ (p15) := rup87
    exact (Or.elim rup86 (fun v => (False.elim (u1 v))) (fun tail => (False.elim (u0 tail))))
  have rup89 : ¬ (p48) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p48) := Classical.byContradiction (fun v => denied v)
    have u1 : (p51) := rup88
    exact (Or.elim h56 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup90 : ¬ (p50) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p50) := Classical.byContradiction (fun v => denied v)
    have u1 : (p51) := rup88
    exact (Or.elim h58 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup91 : (p49) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p49) := fun v => denied v
    have u1 : ¬ (p50) := rup90
    have u2 : ¬ (p36) := rup75
    have u3 : ¬ (p46) := rup76
    have u4 : ¬ (p47) := rup80
    have u5 : ¬ (p48) := rup89
    exact (Or.elim h53 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u1 tail))))))))))))
  have rup92 : False := by
    have u0 : (p49) := rup91
    have u1 : (p51) := rup88
    exact (Or.elim h57 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  exact rup92

private theorem c0 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (2*k+9) (2*k+10)) ∨ (Cell (2*k+9) (4*k+20)) ∨ (Cell (2*k+9) (4*k+21)) ∨ (Cell (2*k+9) (8*k+39)) ∨ (Cell (2*k+9) (8*k+41)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+39) (2*k+9) g (by omega)
  unfold Allowed at ha
  have options : z = (2*k+10) ∨ z = (4*k+20) ∨ z = (4*k+21) ∨ z = (8*k+39) ∨ z = (8*k+41) := by omega
  rcases options with e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))

private theorem c1 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (2*k+9) (2*k+10)) ∨ (Cell (4*k+18) (2*k+9)) := by
  classical
  by_cases h : Cell (2*k+9) (2*k+10)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(2*k+9) = (4*k+18) := by omega
      have ht : (2*k+10)-1 = (2*k+9) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c2 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (2*k+9) (4*k+20)) ∨ (Cell (4*k+18) (4*k+19)) := by
  classical
  by_cases h : Cell (2*k+9) (4*k+20)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(2*k+9) = (4*k+18) := by omega
      have ht : (4*k+20)-1 = (4*k+19) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c3 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (2*k+9) (4*k+21)) ∨ (Cell (4*k+19) (4*k+20)) := by
  classical
  by_cases h : Cell (2*k+9) (4*k+21)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(2*k+9)+1 = (4*k+19) := by omega
      have ht : (4*k+21)-1 = (4*k+20) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c4 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (2*k+9) (8*k+39)) ∨ (Cell (4*k+18) (8*k+38)) := by
  classical
  by_cases h : Cell (2*k+9) (8*k+39)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(2*k+9) = (4*k+18) := by omega
      have ht : (8*k+39)-1 = (8*k+38) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c5 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (2*k+9) (8*k+41)) ∨ (Cell (4*k+19) (8*k+40)) := by
  classical
  by_cases h : Cell (2*k+9) (8*k+41)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(2*k+9)+1 = (4*k+19) := by omega
      have ht : (8*k+41)-1 = (8*k+40) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c6 (k : Nat) : ¬ (Cell (4*k+18) (4*k+19)) ∨ ¬ (Cell (4*k+18) (8*k+39)) := by
  by_cases h : Cell (4*k+18) (4*k+19)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c7 (k : Nat) : ¬ (Cell (4*k+18) (8*k+38)) ∨ ¬ (Cell (4*k+18) (16*k+75)) := by
  by_cases h : Cell (4*k+18) (8*k+38)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c8 (k : Nat) : ¬ (Cell (4*k+18) (8*k+39)) ∨ ¬ (Cell (4*k+18) (2*k+9)) := by
  by_cases h : Cell (4*k+18) (8*k+39)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c9 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (4*k+18) (8*k+38)) ∨ (Cell (8*k+36) (8*k+37)) := by
  classical
  by_cases h : Cell (4*k+18) (8*k+38)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(4*k+18) = (8*k+36) := by omega
      have ht : (8*k+38)-1 = (8*k+37) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c10 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (4*k+19) (4*k+20)) ∨ (Cell (4*k+19) (8*k+40)) ∨ (Cell (4*k+19) (8*k+41)) ∨ (Cell (4*k+19) (16*k+79)) ∨ (Cell (4*k+19) (16*k+81)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+39) (4*k+19) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+20) ∨ z = (8*k+40) ∨ z = (8*k+41) ∨ z = (16*k+79) ∨ z = (16*k+81) := by omega
  rcases options with e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))

private theorem c11 (k : Nat) : ¬ (Cell (4*k+19) (4*k+20)) ∨ ¬ (Cell (4*k+19) (16*k+79)) := by
  by_cases h : Cell (4*k+19) (4*k+20)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c12 (k : Nat) : ¬ (Cell (4*k+19) (8*k+40)) ∨ ¬ (Cell (4*k+19) (16*k+79)) := by
  by_cases h : Cell (4*k+19) (8*k+40)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c13 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (4*k+19) (4*k+20)) ∨ (Cell (8*k+38) (4*k+19)) := by
  classical
  by_cases h : Cell (4*k+19) (4*k+20)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(4*k+19) = (8*k+38) := by omega
      have ht : (4*k+20)-1 = (4*k+19) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c14 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (4*k+19) (8*k+40)) ∨ (Cell (8*k+38) (8*k+39)) := by
  classical
  by_cases h : Cell (4*k+19) (8*k+40)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(4*k+19) = (8*k+38) := by omega
      have ht : (8*k+40)-1 = (8*k+39) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c15 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (4*k+19) (8*k+41)) ∨ (Cell (8*k+39) (8*k+40)) := by
  classical
  by_cases h : Cell (4*k+19) (8*k+41)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(4*k+19)+1 = (8*k+39) := by omega
      have ht : (8*k+41)-1 = (8*k+40) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c16 (k : Nat) : ¬ (Cell (4*k+19) (16*k+79)) ∨ ¬ (Cell (8*k+38) (8*k+39)) := by
  by_cases h : Cell (4*k+19) (16*k+79)
  · right; intro h2
    have ht := half_time (v := (4*k+19)) (t := (16*k+79)) (ch := (8*k+38)) (u := (8*k+39)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c17 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (4*k+19) (16*k+79)) ∨ (Cell (8*k+38) (16*k+78)) := by
  classical
  by_cases h : Cell (4*k+19) (16*k+79)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(4*k+19) = (8*k+38) := by omega
      have ht : (16*k+79)-1 = (16*k+78) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c18 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (4*k+19) (16*k+81)) ∨ (Cell (8*k+39) (16*k+80)) := by
  classical
  by_cases h : Cell (4*k+19) (16*k+81)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(4*k+19)+1 = (8*k+39) := by omega
      have ht : (16*k+81)-1 = (16*k+80) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c19 (k : Nat) : ¬ (Cell (8*k+36) (8*k+37)) ∨ ¬ (Cell (8*k+36) (16*k+75)) := by
  by_cases h : Cell (8*k+36) (8*k+37)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c20 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (8*k+37) (8*k+38)) ∨ (Cell (8*k+37) (16*k+76)) ∨ (Cell (8*k+37) (16*k+77)) ∨ (Cell (8*k+37) (32*k+151)) ∨ (Cell (8*k+37) (32*k+153)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+39) (8*k+37) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+38) ∨ z = (16*k+76) ∨ z = (16*k+77) ∨ z = (32*k+151) ∨ z = (32*k+153) := by omega
  rcases options with e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))

private theorem c21 (k : Nat) : ¬ (Cell (8*k+37) (8*k+38)) ∨ ¬ (Cell (8*k+37) (32*k+153)) := by
  by_cases h : Cell (8*k+37) (8*k+38)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c22 (k : Nat) : ¬ (Cell (8*k+37) (32*k+151)) ∨ ¬ (Cell (16*k+74) (16*k+75)) := by
  by_cases h : Cell (8*k+37) (32*k+151)
  · right; intro h2
    have ht := half_time (v := (8*k+37)) (t := (32*k+151)) (ch := (16*k+74)) (u := (16*k+75)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c23 (k : Nat) : ¬ (Cell (8*k+37) (32*k+153)) ∨ ¬ (Cell (16*k+74) (16*k+75)) := by
  by_cases h : Cell (8*k+37) (32*k+153)
  · right; intro h2
    have ht := half_time (v := (8*k+37)) (t := (32*k+153)) (ch := (16*k+74)) (u := (16*k+75)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c24 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (8*k+37) (32*k+153)) ∨ (Cell (16*k+75) (32*k+152)) := by
  classical
  by_cases h : Cell (8*k+37) (32*k+153)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(8*k+37)+1 = (16*k+75) := by omega
      have ht : (32*k+153)-1 = (32*k+152) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c25 (k : Nat) : ¬ (Cell (8*k+38) (8*k+39)) ∨ ¬ (Cell (8*k+38) (16*k+79)) := by
  by_cases h : Cell (8*k+38) (8*k+39)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c26 (k : Nat) : ¬ (Cell (8*k+38) (16*k+79)) ∨ ¬ (Cell (8*k+38) (4*k+19)) := by
  by_cases h : Cell (8*k+38) (16*k+79)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c27 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (4*k+18) (8*k+38)) ∨ (Cell (8*k+37) (8*k+38)) ∨ (Cell (16*k+76) (8*k+38)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+39) (8*k+38) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+18) ∨ z = (8*k+37) ∨ z = (16*k+76) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c28 (k : Nat) : ¬ (Cell (4*k+18) (8*k+38)) ∨ ¬ (Cell (8*k+37) (8*k+38)) := by
  by_cases h : Cell (4*k+18) (8*k+38)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c29 (k : Nat) : ¬ (Cell (8*k+38) (16*k+78)) ∨ ¬ (Cell (16*k+76) (8*k+38)) := by
  by_cases h : Cell (8*k+38) (16*k+78)
  · right; intro h2
    have ht := half_time (v := (8*k+38)) (t := (16*k+78)) (ch := (16*k+76)) (u := (8*k+38)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c30 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (8*k+38) (16*k+78)) ∨ (Cell (16*k+76) (16*k+77)) := by
  classical
  by_cases h : Cell (8*k+38) (16*k+78)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+38) = (16*k+76) := by omega
      have ht : (16*k+78)-1 = (16*k+77) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c31 (k : Nat) : ¬ (Cell (8*k+39) (8*k+40)) ∨ ¬ (Cell (8*k+39) (32*k+160)) := by
  by_cases h : Cell (8*k+39) (8*k+40)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c32 (k : Nat) : ¬ (Cell (8*k+39) (16*k+80)) ∨ ¬ (Cell (8*k+39) (32*k+160)) := by
  by_cases h : Cell (8*k+39) (16*k+80)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c33 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (2*k+9) (8*k+39)) ∨ (Cell (4*k+18) (8*k+39)) ∨ (Cell (8*k+38) (8*k+39)) ∨ (Cell (16*k+78) (8*k+39)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+39) (8*k+39) g (by omega)
  unfold Allowed at ha
  have options : z = (2*k+9) ∨ z = (4*k+18) ∨ z = (8*k+38) ∨ z = (16*k+78) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c34 (k : Nat) : ¬ (Cell (8*k+39) (32*k+160)) ∨ ¬ (Cell (16*k+78) (16*k+79)) := by
  by_cases h : Cell (8*k+39) (32*k+160)
  · right; intro h2
    have ht := half_time (v := (8*k+39)) (t := (32*k+160)) (ch := (16*k+78)) (u := (16*k+79)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c35 (k : Nat) : ¬ (Cell (8*k+39) (32*k+160)) ∨ ¬ (Cell (16*k+78) (8*k+39)) := by
  by_cases h : Cell (8*k+39) (32*k+160)
  · right; intro h2
    have ht := half_time (v := (8*k+39)) (t := (32*k+160)) (ch := (16*k+78)) (u := (8*k+39)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c36 (k : Nat) : ¬ (Cell (8*k+39) (32*k+160)) ∨ ¬ (Cell (16*k+79) (16*k+80)) := by
  by_cases h : Cell (8*k+39) (32*k+160)
  · right; intro h2
    have ht := half_time (v := (8*k+39)) (t := (32*k+160)) (ch := (16*k+79)) (u := (16*k+80)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c37 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (16*k+75) (16*k+76)) ∨ (Cell (16*k+75) (32*k+152)) ∨ (Cell (16*k+75) (32*k+153)) ∨ (Cell (16*k+75) (64*k+303)) ∨ (Cell (16*k+75) (64*k+305)) ∨ (Cell (16*k+75) (64*k+304)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+39) (16*k+75) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+76) ∨ z = (32*k+152) ∨ z = (32*k+153) ∨ z = (64*k+303) ∨ z = (64*k+305) ∨ z = (64*k+304) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c38 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (4*k+18) (16*k+75)) ∨ (Cell (8*k+36) (16*k+75)) ∨ (Cell (16*k+74) (16*k+75)) ∨ (Cell (32*k+150) (16*k+75)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+39) (16*k+75) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+18) ∨ z = (8*k+36) ∨ z = (16*k+74) ∨ z = (32*k+150) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c39 (k : Nat) : ¬ (Cell (16*k+75) (32*k+152)) ∨ ¬ (Cell (32*k+150) (16*k+75)) := by
  by_cases h : Cell (16*k+75) (32*k+152)
  · right; intro h2
    have ht := half_time (v := (16*k+75)) (t := (32*k+152)) (ch := (32*k+150)) (u := (16*k+75)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c40 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (16*k+75) (32*k+152)) ∨ (Cell (32*k+150) (32*k+151)) := by
  classical
  by_cases h : Cell (16*k+75) (32*k+152)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+75) = (32*k+150) := by omega
      have ht : (32*k+152)-1 = (32*k+151) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c41 (k : Nat) : ¬ (Cell (16*k+75) (32*k+153)) ∨ ¬ (Cell (32*k+150) (16*k+75)) := by
  by_cases h : Cell (16*k+75) (32*k+153)
  · right; intro h2
    have ht := half_time (v := (16*k+75)) (t := (32*k+153)) (ch := (32*k+150)) (u := (16*k+75)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c42 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (16*k+75) (32*k+153)) ∨ (Cell (32*k+151) (32*k+152)) := by
  classical
  by_cases h : Cell (16*k+75) (32*k+153)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(16*k+75)+1 = (32*k+151) := by omega
      have ht : (32*k+153)-1 = (32*k+152) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c43 (k : Nat) : ¬ (Cell (16*k+75) (64*k+303)) ∨ ¬ (Cell (32*k+150) (16*k+75)) := by
  by_cases h : Cell (16*k+75) (64*k+303)
  · right; intro h2
    have ht := half_time (v := (16*k+75)) (t := (64*k+303)) (ch := (32*k+150)) (u := (16*k+75)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c44 (k : Nat) : ¬ (Cell (16*k+75) (64*k+303)) ∨ ¬ (Cell (32*k+151) (32*k+152)) := by
  by_cases h : Cell (16*k+75) (64*k+303)
  · right; intro h2
    have ht := half_time (v := (16*k+75)) (t := (64*k+303)) (ch := (32*k+151)) (u := (32*k+152)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c45 (k : Nat) : ¬ (Cell (16*k+75) (64*k+305)) ∨ ¬ (Cell (32*k+150) (16*k+75)) := by
  by_cases h : Cell (16*k+75) (64*k+305)
  · right; intro h2
    have ht := half_time (v := (16*k+75)) (t := (64*k+305)) (ch := (32*k+150)) (u := (16*k+75)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c46 (k : Nat) : ¬ (Cell (16*k+75) (64*k+305)) ∨ ¬ (Cell (32*k+151) (32*k+152)) := by
  by_cases h : Cell (16*k+75) (64*k+305)
  · right; intro h2
    have ht := half_time (v := (16*k+75)) (t := (64*k+305)) (ch := (32*k+151)) (u := (32*k+152)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c47 (k : Nat) : ¬ (Cell (16*k+75) (64*k+304)) ∨ ¬ (Cell (32*k+150) (16*k+75)) := by
  by_cases h : Cell (16*k+75) (64*k+304)
  · right; intro h2
    have ht := half_time (v := (16*k+75)) (t := (64*k+304)) (ch := (32*k+150)) (u := (16*k+75)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c48 (k : Nat) : ¬ (Cell (16*k+75) (64*k+304)) ∨ ¬ (Cell (32*k+151) (32*k+152)) := by
  by_cases h : Cell (16*k+75) (64*k+304)
  · right; intro h2
    have ht := half_time (v := (16*k+75)) (t := (64*k+304)) (ch := (32*k+151)) (u := (32*k+152)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c49 (k : Nat) : ¬ (Cell (8*k+37) (16*k+76)) ∨ ¬ (Cell (32*k+152) (16*k+76)) := by
  by_cases h : Cell (8*k+37) (16*k+76)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c50 (k : Nat) : ¬ (Cell (16*k+75) (16*k+76)) ∨ ¬ (Cell (32*k+152) (16*k+76)) := by
  by_cases h : Cell (16*k+75) (16*k+76)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c51 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (16*k+76) (16*k+77)) ∨ (Cell (32*k+152) (16*k+76)) := by
  classical
  by_cases h : Cell (16*k+76) (16*k+77)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+76) = (32*k+152) := by omega
      have ht : (16*k+77)-1 = (16*k+76) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c52 (k : Nat) : ¬ (Cell (8*k+37) (16*k+77)) ∨ ¬ (Cell (16*k+76) (16*k+77)) := by
  by_cases h : Cell (8*k+37) (16*k+77)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c53 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (16*k+79) (16*k+80)) ∨ (Cell (16*k+79) (32*k+160)) ∨ (Cell (16*k+79) (32*k+161)) ∨ (Cell (16*k+79) (64*k+319)) ∨ (Cell (16*k+79) (64*k+321)) ∨ (Cell (16*k+79) (64*k+320)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+39) (16*k+79) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+80) ∨ z = (32*k+160) ∨ z = (32*k+161) ∨ z = (64*k+319) ∨ z = (64*k+321) ∨ z = (64*k+320) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c54 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (4*k+19) (16*k+79)) ∨ (Cell (8*k+38) (16*k+79)) ∨ (Cell (16*k+78) (16*k+79)) ∨ (Cell (32*k+158) (16*k+79)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+39) (16*k+79) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+19) ∨ z = (8*k+38) ∨ z = (16*k+78) ∨ z = (32*k+158) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c55 (k : Nat) (g : GoodBelow (8*k+39)) : ¬ (Cell (16*k+79) (32*k+161)) ∨ (Cell (32*k+159) (32*k+160)) := by
  classical
  by_cases h : Cell (16*k+79) (32*k+161)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(16*k+79)+1 = (32*k+159) := by omega
      have ht : (32*k+161)-1 = (32*k+160) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c56 (k : Nat) : ¬ (Cell (16*k+79) (64*k+319)) ∨ ¬ (Cell (32*k+158) (16*k+79)) := by
  by_cases h : Cell (16*k+79) (64*k+319)
  · right; intro h2
    have ht := half_time (v := (16*k+79)) (t := (64*k+319)) (ch := (32*k+158)) (u := (16*k+79)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c57 (k : Nat) : ¬ (Cell (16*k+79) (64*k+321)) ∨ ¬ (Cell (32*k+158) (16*k+79)) := by
  by_cases h : Cell (16*k+79) (64*k+321)
  · right; intro h2
    have ht := half_time (v := (16*k+79)) (t := (64*k+321)) (ch := (32*k+158)) (u := (16*k+79)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c58 (k : Nat) : ¬ (Cell (16*k+79) (64*k+320)) ∨ ¬ (Cell (32*k+158) (16*k+79)) := by
  by_cases h : Cell (16*k+79) (64*k+320)
  · right; intro h2
    have ht := half_time (v := (16*k+79)) (t := (64*k+320)) (ch := (32*k+158)) (u := (16*k+79)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c59 (k : Nat) : ¬ (Cell (32*k+152) (32*k+153)) ∨ ¬ (Cell (32*k+152) (16*k+76)) := by
  by_cases h : Cell (32*k+152) (32*k+153)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c60 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (16*k+75) (32*k+152)) ∨ (Cell (32*k+151) (32*k+152)) ∨ (Cell (64*k+304) (32*k+152)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+39) (32*k+152) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+75) ∨ z = (32*k+151) ∨ z = (64*k+304) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c61 (k : Nat) : ¬ (Cell (16*k+75) (32*k+152)) ∨ ¬ (Cell (32*k+151) (32*k+152)) := by
  by_cases h : Cell (16*k+75) (32*k+152)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c62 (k : Nat) : ¬ (Cell (16*k+75) (32*k+152)) ∨ ¬ (Cell (64*k+304) (32*k+152)) := by
  by_cases h : Cell (16*k+75) (32*k+152)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c63 (k : Nat) (g : GoodBelow (8*k+39)) : (Cell (8*k+37) (32*k+153)) ∨ (Cell (16*k+75) (32*k+153)) ∨ (Cell (32*k+152) (32*k+153)) ∨ (Cell (64*k+306) (32*k+153)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+39) (32*k+153) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+37) ∨ z = (16*k+75) ∨ z = (32*k+152) ∨ z = (64*k+306) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c64 (k : Nat) : ¬ (Cell (8*k+37) (32*k+153)) ∨ ¬ (Cell (64*k+306) (32*k+153)) := by
  by_cases h : Cell (8*k+37) (32*k+153)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c65 (k : Nat) : ¬ (Cell (8*k+39) (32*k+160)) ∨ ¬ (Cell (16*k+79) (32*k+160)) := by
  by_cases h : Cell (8*k+39) (32*k+160)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c66 (k : Nat) : ¬ (Cell (8*k+39) (32*k+160)) ∨ ¬ (Cell (32*k+159) (32*k+160)) := by
  by_cases h : Cell (8*k+39) (32*k+160)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c67 (k : Nat) : ¬ (Cell (8*k+36) (8*k+37)) ∨ ¬ (Cell (8*k+36) (16*k+75)) := by
  by_cases h : Cell (8*k+36) (8*k+37)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c68 (k : Nat) : ¬ (Cell (8*k+37) (32*k+151)) ∨ ¬ (Cell (32*k+150) (32*k+151)) := by
  by_cases h : Cell (8*k+37) (32*k+151)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

theorem exclude (k : Nat) (g : GoodBelow (8*k+39)) (bad : Cell (8*k+39) (4*(8*k+39)+4)) : False := by
  have badNormalized : Cell (8*k+39) (32*k+160) := by
    rw [show (32*k+160) = 4*(8*k+39)+4 by omega]
    exact bad
  exact privateReplay
    (Cell (2*k+9) (2*k+10))
    (Cell (2*k+9) (4*k+20))
    (Cell (2*k+9) (4*k+21))
    (Cell (2*k+9) (8*k+39))
    (Cell (2*k+9) (8*k+41))
    (Cell (4*k+18) (2*k+9))
    (Cell (4*k+18) (4*k+19))
    (Cell (4*k+19) (4*k+20))
    (Cell (4*k+18) (8*k+38))
    (Cell (4*k+19) (8*k+40))
    (Cell (4*k+18) (8*k+39))
    (Cell (4*k+18) (16*k+75))
    (Cell (8*k+36) (8*k+37))
    (Cell (4*k+19) (8*k+41))
    (Cell (4*k+19) (16*k+79))
    (Cell (4*k+19) (16*k+81))
    (Cell (8*k+38) (4*k+19))
    (Cell (8*k+38) (8*k+39))
    (Cell (8*k+39) (8*k+40))
    (Cell (8*k+38) (16*k+78))
    (Cell (8*k+39) (16*k+80))
    (Cell (8*k+36) (16*k+75))
    (Cell (8*k+37) (8*k+38))
    (Cell (8*k+37) (16*k+76))
    (Cell (8*k+37) (16*k+77))
    (Cell (8*k+37) (32*k+151))
    (Cell (8*k+37) (32*k+153))
    (Cell (16*k+74) (16*k+75))
    (Cell (16*k+75) (32*k+152))
    (Cell (8*k+38) (16*k+79))
    (Cell (16*k+76) (8*k+38))
    (Cell (16*k+76) (16*k+77))
    (Cell (8*k+39) (32*k+160))
    (Cell (16*k+78) (8*k+39))
    (Cell (16*k+78) (16*k+79))
    (Cell (16*k+79) (16*k+80))
    (Cell (16*k+75) (16*k+76))
    (Cell (16*k+75) (32*k+153))
    (Cell (16*k+75) (64*k+303))
    (Cell (16*k+75) (64*k+305))
    (Cell (16*k+75) (64*k+304))
    (Cell (32*k+150) (16*k+75))
    (Cell (32*k+150) (32*k+151))
    (Cell (32*k+151) (32*k+152))
    (Cell (32*k+152) (16*k+76))
    (Cell (16*k+79) (32*k+160))
    (Cell (16*k+79) (32*k+161))
    (Cell (16*k+79) (64*k+319))
    (Cell (16*k+79) (64*k+321))
    (Cell (16*k+79) (64*k+320))
    (Cell (32*k+158) (16*k+79))
    (Cell (32*k+159) (32*k+160))
    (Cell (32*k+152) (32*k+153))
    (Cell (64*k+304) (32*k+152))
    (Cell (64*k+306) (32*k+153))
    (c0 k g)
    (c1 k g)
    (c2 k g)
    (c3 k g)
    (c4 k g)
    (c5 k g)
    (c6 k)
    (c7 k)
    (c8 k)
    (c9 k g)
    (c10 k g)
    (c11 k)
    (c12 k)
    (c13 k g)
    (c14 k g)
    (c15 k g)
    (c16 k)
    (c17 k g)
    (c18 k g)
    (c19 k)
    (c20 k g)
    (c21 k)
    (c22 k)
    (c23 k)
    (c24 k g)
    (c25 k)
    (c26 k)
    (c27 k g)
    (c28 k)
    (c29 k)
    (c30 k g)
    (c31 k)
    (c32 k)
    (c33 k g)
    (c34 k)
    (c35 k)
    (c36 k)
    (c37 k g)
    (c38 k g)
    (c39 k)
    (c40 k g)
    (c41 k)
    (c42 k g)
    (c43 k)
    (c44 k)
    (c45 k)
    (c46 k)
    (c47 k)
    (c48 k)
    (c49 k)
    (c50 k)
    (c51 k g)
    (c52 k)
    (c53 k g)
    (c54 k g)
    (c55 k g)
    (c56 k)
    (c57 k)
    (c58 k)
    (c59 k)
    (c60 k g)
    (c61 k)
    (c62 k)
    (c63 k g)
    (c64 k)
    (c65 k)
    (c66 k)
    (c67 k)
    (c68 k)
    badNormalized
end P8R7
end Inverse
