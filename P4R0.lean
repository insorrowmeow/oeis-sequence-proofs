import InverseBase

set_option linter.unusedVariables false
set_option maxHeartbeats 2000000
set_option maxRecDepth 8000
namespace Inverse
namespace P4R0

theorem privateReplay (p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40 p41 p42 p43 p44 p45 p46 p47 p48 p49 p50 p51 p52 p53 p54 p55 p56 p57 p58 p59 p60 p61 p62 p63 p64 p65 p66 p67 p68 : Prop)
    (h0 : ¬ (p1) ∨ ¬ (p2))
    (h1 : ¬ (p1) ∨ (p3))
    (h2 : ¬ (p2) ∨ (p4))
    (h3 : ¬ (p3) ∨ ¬ (p5))
    (h4 : ¬ (p3) ∨ ¬ (p6))
    (h5 : ¬ (p3) ∨ ¬ (p7))
    (h6 : ¬ (p3) ∨ (p8))
    (h7 : ¬ (p9) ∨ ¬ (p4))
    (h8 : ¬ (p9) ∨ ¬ (p10))
    (h9 : ¬ (p10) ∨ ¬ (p11))
    (h10 : ¬ (p10) ∨ (p12))
    (h11 : (p1) ∨ (p9) ∨ (p13))
    (h12 : ¬ (p14) ∨ ¬ (p15))
    (h13 : ¬ (p14) ∨ ¬ (p13))
    (h14 : ¬ (p14) ∨ ¬ (p16))
    (h15 : ¬ (p14) ∨ (p17))
    (h16 : ¬ (p18) ∨ ¬ (p8))
    (h17 : ¬ (p19) ∨ ¬ (p20))
    (h18 : ¬ (p19) ∨ (p21))
    (h19 : (p22) ∨ (p23) ∨ (p24) ∨ (p25) ∨ (p26) ∨ (p27) ∨ (p11))
    (h20 : (p5) ∨ (p19) ∨ (p28))
    (h21 : ¬ (p23) ∨ ¬ (p28))
    (h22 : ¬ (p23) ∨ (p29))
    (h23 : ¬ (p25) ∨ ¬ (p29))
    (h24 : ¬ (p25) ∨ ¬ (p28))
    (h25 : ¬ (p25) ∨ ¬ (p30))
    (h26 : ¬ (p26) ∨ ¬ (p29))
    (h27 : ¬ (p26) ∨ ¬ (p28))
    (h28 : ¬ (p26) ∨ (p31))
    (h29 : ¬ (p27) ∨ ¬ (p29))
    (h30 : ¬ (p27) ∨ ¬ (p28))
    (h31 : ¬ (p27) ∨ ¬ (p30))
    (h32 : ¬ (p22) ∨ ¬ (p32))
    (h33 : ¬ (p12) ∨ (p32))
    (h34 : ¬ (p33) ∨ (p34))
    (h35 : (p4) ∨ (p12) ∨ (p35))
    (h36 : ¬ (p4) ∨ ¬ (p12))
    (h37 : ¬ (p17) ∨ ¬ (p36))
    (h38 : ¬ (p17) ∨ ¬ (p35))
    (h39 : (p16) ∨ (p37) ∨ (p38) ∨ (p39) ∨ (p40) ∨ (p41))
    (h40 : (p2) ∨ (p10) ∨ (p15) ∨ (p42))
    (h41 : ¬ (p38) ∨ (p43))
    (h42 : ¬ (p39) ∨ ¬ (p42))
    (h43 : ¬ (p40) ∨ ¬ (p42))
    (h44 : ¬ (p41) ∨ ¬ (p42))
    (h45 : ¬ (p44) ∨ ¬ (p21))
    (h46 : (p45) ∨ (p46) ∨ (p47) ∨ (p48) ∨ (p49) ∨ (p50))
    (h47 : (p6) ∨ (p18) ∨ (p44) ∨ (p51))
    (h48 : ¬ (p46) ∨ ¬ (p51))
    (h49 : ¬ (p47) ∨ ¬ (p51))
    (h50 : ¬ (p48) ∨ ¬ (p51))
    (h51 : ¬ (p49) ∨ ¬ (p51))
    (h52 : ¬ (p50) ∨ ¬ (p51))
    (h53 : ¬ (p45) ∨ ¬ (p52))
    (h54 : ¬ (p29) ∨ (p52))
    (h55 : (p30) ∨ (p31) ∨ (p53) ∨ (p54) ∨ (p55) ∨ (p56))
    (h56 : (p7) ∨ (p20) ∨ (p29) ∨ (p57))
    (h57 : ¬ (p31) ∨ ¬ (p57))
    (h58 : ¬ (p31) ∨ (p58))
    (h59 : ¬ (p53) ∨ (p59))
    (h60 : ¬ (p54) ∨ ¬ (p57))
    (h61 : ¬ (p55) ∨ ¬ (p57))
    (h62 : ¬ (p56) ∨ ¬ (p57))
    (h63 : ¬ (p24) ∨ ¬ (p34))
    (h64 : ¬ (p24) ∨ ¬ (p60))
    (h65 : ¬ (p61) ∨ (p60))
    (h66 : (p36) ∨ (p62) ∨ (p63) ∨ (p64) ∨ (p65) ∨ (p66) ∨ (p35))
    (h67 : (p33) ∨ (p61) ∨ (p67))
    (h68 : ¬ (p62) ∨ ¬ (p67))
    (h69 : ¬ (p63) ∨ ¬ (p67))
    (h70 : ¬ (p64) ∨ ¬ (p67))
    (h71 : ¬ (p65) ∨ ¬ (p67))
    (h72 : ¬ (p66) ∨ ¬ (p67))
    (h73 : ¬ (p14) ∨ ¬ (p37))
    (h74 : ¬ (p14) ∨ ¬ (p43))
    (h75 : ¬ (p25) ∨ ¬ (p58))
    (h76 : ¬ (p25) ∨ ¬ (p68))
    (h77 : ¬ (p59) ∨ (p68))
    (h78 : ¬ (p27) ∨ ¬ (p31))
    (h79 : ¬ (p27) ∨ ¬ (p59))
    (h80 : (p14)) : False := by
  have rup82 : ¬ (p15) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p15) := Classical.byContradiction (fun v => denied v)
    have u1 : (p14) := h80
    exact (Or.elim h12 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup83 : ¬ (p13) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p13) := Classical.byContradiction (fun v => denied v)
    have u1 : (p14) := h80
    exact (Or.elim h13 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup84 : ¬ (p16) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p16) := Classical.byContradiction (fun v => denied v)
    have u1 : (p14) := h80
    exact (Or.elim h14 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup85 : (p17) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p17) := fun v => denied v
    have u1 : (p14) := h80
    exact (Or.elim h15 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup86 : ¬ (p37) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p37) := Classical.byContradiction (fun v => denied v)
    have u1 : (p14) := h80
    exact (Or.elim h73 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup87 : ¬ (p43) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p43) := Classical.byContradiction (fun v => denied v)
    have u1 : (p14) := h80
    exact (Or.elim h74 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup88 : ¬ (p36) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p36) := Classical.byContradiction (fun v => denied v)
    have u1 : (p17) := rup85
    exact (Or.elim h37 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup89 : ¬ (p35) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p35) := Classical.byContradiction (fun v => denied v)
    have u1 : (p17) := rup85
    exact (Or.elim h38 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup90 : ¬ (p38) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p38) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p43) := rup87
    exact (Or.elim h41 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup91 : (p12) ∨ (p42) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p12) := fun v => denied (Or.inl v)
    have u1 : ¬ (p42) := fun v => denied (Or.inr v)
    have u2 : ¬ (p35) := rup89
    have u3 : ¬ (p15) := rup82
    have u4 : ¬ (p13) := rup83
    have u5 : ¬ (p10) := (Or.elim h10 (fun v => v) (fun tail => (False.elim (u0 tail))))
    have u6 : (p4) := (Or.elim h35 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u2 tail))))))
    have u7 : (p2) := (Or.elim h40 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (False.elim (u1 tail))))))))
    have u8 : ¬ (p9) := (Or.elim h7 (fun v => v) (fun tail => (False.elim (tail u6))))
    have u9 : ¬ (p1) := (Or.elim h0 (fun v => v) (fun tail => (False.elim (tail u7))))
    exact (Or.elim h11 (fun v => (False.elim (u9 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (False.elim (u4 tail))))))
  have rup92 : ¬ (p26) ∨ ¬ (p3) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p26) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : (p3) := Classical.byContradiction (fun v => denied (Or.inr v))
    have u2 : ¬ (p7) := (Or.elim h5 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u3 : ¬ (p5) := (Or.elim h3 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u4 : ¬ (p29) := (Or.elim h26 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u5 : ¬ (p28) := (Or.elim h27 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u6 : (p31) := (Or.elim h28 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u7 : (p19) := (Or.elim h20 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u5 tail))))))
    have u8 : ¬ (p57) := (Or.elim h57 (fun v => (False.elim (v u6))) (fun tail => tail))
    have u9 : ¬ (p20) := (Or.elim h17 (fun v => (False.elim (v u7))) (fun tail => tail))
    exact (Or.elim h56 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u9 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (False.elim (u8 tail))))))))
  have rup93 : ¬ (p23) ∨ ¬ (p3) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p23) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : (p3) := Classical.byContradiction (fun v => denied (Or.inr v))
    have u2 : (p8) := (Or.elim h6 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u3 : ¬ (p18) := (Or.elim h16 (fun v => v) (fun tail => (False.elim (tail u2))))
    have u4 : ¬ (p6) := (Or.elim h4 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u5 : ¬ (p5) := (Or.elim h3 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u6 : ¬ (p28) := (Or.elim h21 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u7 : (p29) := (Or.elim h22 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u8 : (p19) := (Or.elim h20 (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u6 tail))))))
    have u9 : (p52) := (Or.elim h54 (fun v => (False.elim (v u7))) (fun tail => tail))
    have u10 : (p21) := (Or.elim h18 (fun v => (False.elim (v u8))) (fun tail => tail))
    have u11 : ¬ (p45) := (Or.elim h53 (fun v => v) (fun tail => (False.elim (tail u9))))
    have u12 : ¬ (p44) := (Or.elim h45 (fun v => v) (fun tail => (False.elim (tail u10))))
    have u13 : (p51) := (Or.elim h47 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u12 v))) (fun tail => tail))))))
    have u14 : ¬ (p46) := (Or.elim h48 (fun v => v) (fun tail => (False.elim (tail u13))))
    have u15 : ¬ (p47) := (Or.elim h49 (fun v => v) (fun tail => (False.elim (tail u13))))
    have u16 : ¬ (p48) := (Or.elim h50 (fun v => v) (fun tail => (False.elim (tail u13))))
    have u17 : ¬ (p49) := (Or.elim h51 (fun v => v) (fun tail => (False.elim (tail u13))))
    have u18 : ¬ (p50) := (Or.elim h52 (fun v => v) (fun tail => (False.elim (tail u13))))
    exact (Or.elim h46 (fun v => (False.elim (u11 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u14 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u15 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u16 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u17 v))) (fun tail => (False.elim (u18 tail))))))))))))
  have rup94 : ¬ (p29) ∨ (p24) ∨ (p42) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p29) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : ¬ (p24) := fun v => denied (Or.inr (Or.inl v))
    have u2 : ¬ (p42) := fun v => denied (Or.inr (Or.inr v))
    have u3 : ¬ (p15) := rup82
    have u4 : ¬ (p13) := rup83
    have u5 : (p12) := (Or.elim rup91 (fun v => v) (fun tail => (False.elim (u2 tail))))
    have u6 : ¬ (p4) := (Or.elim h36 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u7 : ¬ (p2) := (Or.elim h2 (fun v => v) (fun tail => (False.elim (u6 tail))))
    have u8 : (p10) := (Or.elim h40 (fun v => (False.elim (u7 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (False.elim (u2 tail))))))))
    have u9 : ¬ (p9) := (Or.elim h8 (fun v => v) (fun tail => (False.elim (tail u8))))
    have u10 : (p1) := (Or.elim h11 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u9 v))) (fun tail => (False.elim (u4 tail))))))
    have u11 : (p3) := (Or.elim h1 (fun v => (False.elim (v u10))) (fun tail => tail))
    have u12 : ¬ (p23) := (Or.elim rup93 (fun v => v) (fun tail => (False.elim (tail u11))))
    have u13 : ¬ (p26) := (Or.elim rup92 (fun v => v) (fun tail => (False.elim (tail u11))))
    have u14 : ¬ (p11) := (Or.elim h9 (fun v => (False.elim (v u8))) (fun tail => tail))
    have u15 : (p32) := (Or.elim h33 (fun v => (False.elim (v u5))) (fun tail => tail))
    have u16 : ¬ (p22) := (Or.elim h32 (fun v => v) (fun tail => (False.elim (tail u15))))
    have u17 : ¬ (p25) := (Or.elim h23 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u18 : ¬ (p27) := (Or.elim h29 (fun v => v) (fun tail => (False.elim (tail u0))))
    exact (Or.elim h19 (fun v => (False.elim (u16 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u12 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u17 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u13 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u18 v))) (fun tail => (False.elim (u14 tail))))))))))))))
  have rup95 : ¬ (p25) ∨ (p29) ∨ ¬ (p3) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p25) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : ¬ (p29) := fun v => denied (Or.inr (Or.inl v))
    have u2 : (p3) := Classical.byContradiction (fun v => denied (Or.inr (Or.inr v)))
    have u3 : ¬ (p7) := (Or.elim h5 (fun v => (False.elim (v u2))) (fun tail => tail))
    have u4 : ¬ (p5) := (Or.elim h3 (fun v => (False.elim (v u2))) (fun tail => tail))
    have u5 : ¬ (p28) := (Or.elim h24 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u6 : ¬ (p30) := (Or.elim h25 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u7 : ¬ (p58) := (Or.elim h75 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u8 : ¬ (p68) := (Or.elim h76 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u9 : (p19) := (Or.elim h20 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u5 tail))))))
    have u10 : ¬ (p31) := (Or.elim h58 (fun v => v) (fun tail => (False.elim (u7 tail))))
    have u11 : ¬ (p59) := (Or.elim h77 (fun v => v) (fun tail => (False.elim (u8 tail))))
    have u12 : ¬ (p20) := (Or.elim h17 (fun v => (False.elim (v u9))) (fun tail => tail))
    have u13 : ¬ (p53) := (Or.elim h59 (fun v => v) (fun tail => (False.elim (u11 tail))))
    have u14 : (p57) := (Or.elim h56 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u12 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => tail))))))
    have u15 : ¬ (p54) := (Or.elim h60 (fun v => v) (fun tail => (False.elim (tail u14))))
    have u16 : ¬ (p55) := (Or.elim h61 (fun v => v) (fun tail => (False.elim (tail u14))))
    have u17 : ¬ (p56) := (Or.elim h62 (fun v => v) (fun tail => (False.elim (tail u14))))
    exact (Or.elim h55 (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u10 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u13 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u15 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u16 v))) (fun tail => (False.elim (u17 tail))))))))))))
  have rup96 : (p24) ∨ (p42) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p24) := fun v => denied (Or.inl v)
    have u1 : ¬ (p42) := fun v => denied (Or.inr v)
    have u2 : ¬ (p15) := rup82
    have u3 : ¬ (p13) := rup83
    have u4 : (p12) := (Or.elim rup91 (fun v => v) (fun tail => (False.elim (u1 tail))))
    have u5 : ¬ (p4) := (Or.elim h36 (fun v => v) (fun tail => (False.elim (tail u4))))
    have u6 : ¬ (p2) := (Or.elim h2 (fun v => v) (fun tail => (False.elim (u5 tail))))
    have u7 : (p10) := (Or.elim h40 (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u1 tail))))))))
    have u8 : ¬ (p9) := (Or.elim h8 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u9 : (p1) := (Or.elim h11 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (False.elim (u3 tail))))))
    have u10 : (p3) := (Or.elim h1 (fun v => (False.elim (v u9))) (fun tail => tail))
    have u11 : ¬ (p23) := (Or.elim rup93 (fun v => v) (fun tail => (False.elim (tail u10))))
    have u12 : ¬ (p26) := (Or.elim rup92 (fun v => v) (fun tail => (False.elim (tail u10))))
    have u13 : ¬ (p7) := (Or.elim h5 (fun v => (False.elim (v u10))) (fun tail => tail))
    have u14 : ¬ (p5) := (Or.elim h3 (fun v => (False.elim (v u10))) (fun tail => tail))
    have u15 : ¬ (p11) := (Or.elim h9 (fun v => (False.elim (v u7))) (fun tail => tail))
    have u16 : (p32) := (Or.elim h33 (fun v => (False.elim (v u4))) (fun tail => tail))
    have u17 : ¬ (p22) := (Or.elim h32 (fun v => v) (fun tail => (False.elim (tail u16))))
    have u18 : ¬ (p29) := (Or.elim rup94 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u1 tail))))))
    have u19 : ¬ (p25) := (Or.elim rup95 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u18 v))) (fun tail => (False.elim (tail u10))))))
    have u20 : (p27) := (Or.elim h19 (fun v => (False.elim (u17 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u11 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u19 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u12 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u15 tail))))))))))))))
    have u21 : ¬ (p28) := (Or.elim h30 (fun v => (False.elim (v u20))) (fun tail => tail))
    have u22 : ¬ (p30) := (Or.elim h31 (fun v => (False.elim (v u20))) (fun tail => tail))
    have u23 : ¬ (p31) := (Or.elim h78 (fun v => (False.elim (v u20))) (fun tail => tail))
    have u24 : ¬ (p59) := (Or.elim h79 (fun v => (False.elim (v u20))) (fun tail => tail))
    have u25 : (p19) := (Or.elim h20 (fun v => (False.elim (u14 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u21 tail))))))
    have u26 : ¬ (p53) := (Or.elim h59 (fun v => v) (fun tail => (False.elim (u24 tail))))
    have u27 : ¬ (p20) := (Or.elim h17 (fun v => (False.elim (v u25))) (fun tail => tail))
    have u28 : (p57) := (Or.elim h56 (fun v => (False.elim (u13 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u27 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u18 v))) (fun tail => tail))))))
    have u29 : ¬ (p54) := (Or.elim h60 (fun v => v) (fun tail => (False.elim (tail u28))))
    have u30 : ¬ (p55) := (Or.elim h61 (fun v => v) (fun tail => (False.elim (tail u28))))
    have u31 : ¬ (p56) := (Or.elim h62 (fun v => v) (fun tail => (False.elim (tail u28))))
    exact (Or.elim h55 (fun v => (False.elim (u22 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u23 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u26 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u29 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u30 v))) (fun tail => (False.elim (u31 tail))))))))))))
  have rup97 : ¬ (p67) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p67) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p35) := rup89
    have u2 : ¬ (p36) := rup88
    have u3 : ¬ (p62) := (Or.elim h68 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u4 : ¬ (p63) := (Or.elim h69 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u5 : ¬ (p64) := (Or.elim h70 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u6 : ¬ (p65) := (Or.elim h71 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u7 : ¬ (p66) := (Or.elim h72 (fun v => v) (fun tail => (False.elim (tail u0))))
    exact (Or.elim h66 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u7 v))) (fun tail => (False.elim (u1 tail))))))))))))))
  have rup98 : ¬ (p24) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p24) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p67) := rup97
    have u2 : ¬ (p34) := (Or.elim h63 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u3 : ¬ (p60) := (Or.elim h64 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u4 : ¬ (p33) := (Or.elim h34 (fun v => v) (fun tail => (False.elim (u2 tail))))
    have u5 : ¬ (p61) := (Or.elim h65 (fun v => v) (fun tail => (False.elim (u3 tail))))
    exact (Or.elim h67 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (False.elim (u1 tail))))))
  have rup99 : (p42) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p42) := fun v => denied v
    have u1 : ¬ (p24) := rup98
    exact (Or.elim rup96 (fun v => (False.elim (u1 v))) (fun tail => (False.elim (u0 tail))))
  have rup100 : ¬ (p39) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p39) := Classical.byContradiction (fun v => denied v)
    have u1 : (p42) := rup99
    exact (Or.elim h42 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup101 : ¬ (p41) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p41) := Classical.byContradiction (fun v => denied v)
    have u1 : (p42) := rup99
    exact (Or.elim h44 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup102 : (p40) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p40) := fun v => denied v
    have u1 : ¬ (p39) := rup100
    have u2 : ¬ (p16) := rup84
    have u3 : ¬ (p37) := rup86
    have u4 : ¬ (p38) := rup90
    have u5 : ¬ (p41) := rup101
    exact (Or.elim h39 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u5 tail))))))))))))
  have rup103 : False := by
    have u0 : (p40) := rup102
    have u1 : (p42) := rup99
    exact (Or.elim h43 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  exact rup103

private theorem c0 (k : Nat) : ¬ (Cell (2*k+15) (4*k+32)) ∨ ¬ (Cell (2*k+15) (8*k+65)) := by
  by_cases h : Cell (2*k+15) (4*k+32)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c1 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (2*k+15) (4*k+32)) ∨ (Cell (4*k+30) (4*k+31)) := by
  classical
  by_cases h : Cell (2*k+15) (4*k+32)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(2*k+15) = (4*k+30) := by omega
      have ht : (4*k+32)-1 = (4*k+31) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c2 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (2*k+15) (8*k+65)) ∨ (Cell (4*k+31) (8*k+64)) := by
  classical
  by_cases h : Cell (2*k+15) (8*k+65)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(2*k+15)+1 = (4*k+31) := by omega
      have ht : (8*k+65)-1 = (8*k+64) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c3 (k : Nat) : ¬ (Cell (4*k+30) (4*k+31)) ∨ ¬ (Cell (4*k+30) (8*k+62)) := by
  by_cases h : Cell (4*k+30) (4*k+31)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c4 (k : Nat) : ¬ (Cell (4*k+30) (4*k+31)) ∨ ¬ (Cell (4*k+30) (16*k+123)) := by
  by_cases h : Cell (4*k+30) (4*k+31)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c5 (k : Nat) : ¬ (Cell (4*k+30) (4*k+31)) ∨ ¬ (Cell (4*k+30) (16*k+125)) := by
  by_cases h : Cell (4*k+30) (4*k+31)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c6 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (4*k+30) (4*k+31)) ∨ (Cell (8*k+60) (4*k+30)) := by
  classical
  by_cases h : Cell (4*k+30) (4*k+31)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(4*k+30) = (8*k+60) := by omega
      have ht : (4*k+31)-1 = (4*k+30) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c7 (k : Nat) : ¬ (Cell (4*k+31) (4*k+32)) ∨ ¬ (Cell (4*k+31) (8*k+64)) := by
  by_cases h : Cell (4*k+31) (4*k+32)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c8 (k : Nat) : ¬ (Cell (4*k+31) (4*k+32)) ∨ ¬ (Cell (4*k+31) (8*k+65)) := by
  by_cases h : Cell (4*k+31) (4*k+32)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c9 (k : Nat) : ¬ (Cell (4*k+31) (8*k+65)) ∨ ¬ (Cell (8*k+62) (4*k+31)) := by
  by_cases h : Cell (4*k+31) (8*k+65)
  · right; intro h2
    have ht := half_time (v := (4*k+31)) (t := (8*k+65)) (ch := (8*k+62)) (u := (4*k+31)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c10 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (4*k+31) (8*k+65)) ∨ (Cell (8*k+63) (8*k+64)) := by
  classical
  by_cases h : Cell (4*k+31) (8*k+65)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(4*k+31)+1 = (8*k+63) := by omega
      have ht : (8*k+65)-1 = (8*k+64) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c11 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (2*k+15) (4*k+32)) ∨ (Cell (4*k+31) (4*k+32)) ∨ (Cell (8*k+64) (4*k+32)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (4*k+32) (4*k+32) g (by omega)
  unfold Allowed at ha
  have options : z = (2*k+15) ∨ z = (4*k+31) ∨ z = (8*k+64) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c12 (k : Nat) : ¬ (Cell (4*k+32) (16*k+132)) ∨ ¬ (Cell (8*k+64) (8*k+65)) := by
  by_cases h : Cell (4*k+32) (16*k+132)
  · right; intro h2
    have ht := half_time (v := (4*k+32)) (t := (16*k+132)) (ch := (8*k+64)) (u := (8*k+65)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c13 (k : Nat) : ¬ (Cell (4*k+32) (16*k+132)) ∨ ¬ (Cell (8*k+64) (4*k+32)) := by
  by_cases h : Cell (4*k+32) (16*k+132)
  · right; intro h2
    have ht := half_time (v := (4*k+32)) (t := (16*k+132)) (ch := (8*k+64)) (u := (4*k+32)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c14 (k : Nat) : ¬ (Cell (4*k+32) (16*k+132)) ∨ ¬ (Cell (8*k+65) (8*k+66)) := by
  by_cases h : Cell (4*k+32) (16*k+132)
  · right; intro h2
    have ht := half_time (v := (4*k+32)) (t := (16*k+132)) (ch := (8*k+65)) (u := (8*k+66)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c15 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (4*k+32) (16*k+132)) ∨ (Cell (8*k+64) (16*k+131)) := by
  classical
  by_cases h : Cell (4*k+32) (16*k+132)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(4*k+32) = (8*k+64) := by omega
      have ht : (16*k+132)-1 = (16*k+131) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c16 (k : Nat) : ¬ (Cell (8*k+60) (16*k+123)) ∨ ¬ (Cell (8*k+60) (4*k+30)) := by
  by_cases h : Cell (8*k+60) (16*k+123)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c17 (k : Nat) : ¬ (Cell (8*k+61) (8*k+62)) ∨ ¬ (Cell (8*k+61) (16*k+125)) := by
  by_cases h : Cell (8*k+61) (8*k+62)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c18 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (8*k+61) (8*k+62)) ∨ (Cell (16*k+122) (8*k+61)) := by
  classical
  by_cases h : Cell (8*k+61) (8*k+62)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+61) = (16*k+122) := by omega
      have ht : (8*k+62)-1 = (8*k+61) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c19 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (8*k+62) (8*k+63)) ∨ (Cell (8*k+62) (16*k+126)) ∨ (Cell (8*k+62) (16*k+127)) ∨ (Cell (8*k+62) (32*k+251)) ∨ (Cell (8*k+62) (32*k+253)) ∨ (Cell (8*k+62) (32*k+252)) ∨ (Cell (8*k+62) (4*k+31)) := by
  obtain ⟨z, hz, ha⟩ := row (4*k+32) (8*k+62) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+63) ∨ z = (16*k+126) ∨ z = (16*k+127) ∨ z = (32*k+251) ∨ z = (32*k+253) ∨ z = (32*k+252) ∨ z = (4*k+31) := by omega
  rcases options with e | e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))))

private theorem c20 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (4*k+30) (8*k+62)) ∨ (Cell (8*k+61) (8*k+62)) ∨ (Cell (16*k+124) (8*k+62)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (4*k+32) (8*k+62) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+30) ∨ z = (8*k+61) ∨ z = (16*k+124) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c21 (k : Nat) : ¬ (Cell (8*k+62) (16*k+126)) ∨ ¬ (Cell (16*k+124) (8*k+62)) := by
  by_cases h : Cell (8*k+62) (16*k+126)
  · right; intro h2
    have ht := half_time (v := (8*k+62)) (t := (16*k+126)) (ch := (16*k+124)) (u := (8*k+62)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c22 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (8*k+62) (16*k+126)) ∨ (Cell (16*k+124) (16*k+125)) := by
  classical
  by_cases h : Cell (8*k+62) (16*k+126)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+62) = (16*k+124) := by omega
      have ht : (16*k+126)-1 = (16*k+125) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c23 (k : Nat) : ¬ (Cell (8*k+62) (32*k+251)) ∨ ¬ (Cell (16*k+124) (16*k+125)) := by
  by_cases h : Cell (8*k+62) (32*k+251)
  · right; intro h2
    have ht := half_time (v := (8*k+62)) (t := (32*k+251)) (ch := (16*k+124)) (u := (16*k+125)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c24 (k : Nat) : ¬ (Cell (8*k+62) (32*k+251)) ∨ ¬ (Cell (16*k+124) (8*k+62)) := by
  by_cases h : Cell (8*k+62) (32*k+251)
  · right; intro h2
    have ht := half_time (v := (8*k+62)) (t := (32*k+251)) (ch := (16*k+124)) (u := (8*k+62)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c25 (k : Nat) : ¬ (Cell (8*k+62) (32*k+251)) ∨ ¬ (Cell (16*k+125) (16*k+126)) := by
  by_cases h : Cell (8*k+62) (32*k+251)
  · right; intro h2
    have ht := half_time (v := (8*k+62)) (t := (32*k+251)) (ch := (16*k+125)) (u := (16*k+126)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c26 (k : Nat) : ¬ (Cell (8*k+62) (32*k+253)) ∨ ¬ (Cell (16*k+124) (16*k+125)) := by
  by_cases h : Cell (8*k+62) (32*k+253)
  · right; intro h2
    have ht := half_time (v := (8*k+62)) (t := (32*k+253)) (ch := (16*k+124)) (u := (16*k+125)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c27 (k : Nat) : ¬ (Cell (8*k+62) (32*k+253)) ∨ ¬ (Cell (16*k+124) (8*k+62)) := by
  by_cases h : Cell (8*k+62) (32*k+253)
  · right; intro h2
    have ht := half_time (v := (8*k+62)) (t := (32*k+253)) (ch := (16*k+124)) (u := (8*k+62)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c28 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (8*k+62) (32*k+253)) ∨ (Cell (16*k+125) (32*k+252)) := by
  classical
  by_cases h : Cell (8*k+62) (32*k+253)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(8*k+62)+1 = (16*k+125) := by omega
      have ht : (32*k+253)-1 = (32*k+252) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c29 (k : Nat) : ¬ (Cell (8*k+62) (32*k+252)) ∨ ¬ (Cell (16*k+124) (16*k+125)) := by
  by_cases h : Cell (8*k+62) (32*k+252)
  · right; intro h2
    have ht := half_time (v := (8*k+62)) (t := (32*k+252)) (ch := (16*k+124)) (u := (16*k+125)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c30 (k : Nat) : ¬ (Cell (8*k+62) (32*k+252)) ∨ ¬ (Cell (16*k+124) (8*k+62)) := by
  by_cases h : Cell (8*k+62) (32*k+252)
  · right; intro h2
    have ht := half_time (v := (8*k+62)) (t := (32*k+252)) (ch := (16*k+124)) (u := (8*k+62)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c31 (k : Nat) : ¬ (Cell (8*k+62) (32*k+252)) ∨ ¬ (Cell (16*k+125) (16*k+126)) := by
  by_cases h : Cell (8*k+62) (32*k+252)
  · right; intro h2
    have ht := half_time (v := (8*k+62)) (t := (32*k+252)) (ch := (16*k+125)) (u := (16*k+126)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c32 (k : Nat) : ¬ (Cell (8*k+62) (8*k+63)) ∨ ¬ (Cell (16*k+126) (8*k+63)) := by
  by_cases h : Cell (8*k+62) (8*k+63)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c33 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (8*k+63) (8*k+64)) ∨ (Cell (16*k+126) (8*k+63)) := by
  classical
  by_cases h : Cell (8*k+63) (8*k+64)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+63) = (16*k+126) := by omega
      have ht : (8*k+64)-1 = (8*k+63) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c34 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (8*k+63) (16*k+128)) ∨ (Cell (16*k+126) (16*k+127)) := by
  classical
  by_cases h : Cell (8*k+63) (16*k+128)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+63) = (16*k+126) := by omega
      have ht : (16*k+128)-1 = (16*k+127) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c35 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (4*k+31) (8*k+64)) ∨ (Cell (8*k+63) (8*k+64)) ∨ (Cell (16*k+128) (8*k+64)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (4*k+32) (8*k+64) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+31) ∨ z = (8*k+63) ∨ z = (16*k+128) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c36 (k : Nat) : ¬ (Cell (4*k+31) (8*k+64)) ∨ ¬ (Cell (8*k+63) (8*k+64)) := by
  by_cases h : Cell (4*k+31) (8*k+64)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c37 (k : Nat) : ¬ (Cell (8*k+64) (16*k+131)) ∨ ¬ (Cell (16*k+128) (16*k+129)) := by
  by_cases h : Cell (8*k+64) (16*k+131)
  · right; intro h2
    have ht := half_time (v := (8*k+64)) (t := (16*k+131)) (ch := (16*k+128)) (u := (16*k+129)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c38 (k : Nat) : ¬ (Cell (8*k+64) (16*k+131)) ∨ ¬ (Cell (16*k+128) (8*k+64)) := by
  by_cases h : Cell (8*k+64) (16*k+131)
  · right; intro h2
    have ht := half_time (v := (8*k+64)) (t := (16*k+131)) (ch := (16*k+128)) (u := (8*k+64)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c39 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (8*k+65) (8*k+66)) ∨ (Cell (8*k+65) (16*k+132)) ∨ (Cell (8*k+65) (16*k+133)) ∨ (Cell (8*k+65) (32*k+263)) ∨ (Cell (8*k+65) (32*k+265)) ∨ (Cell (8*k+65) (32*k+264)) := by
  obtain ⟨z, hz, ha⟩ := row (4*k+32) (8*k+65) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+66) ∨ z = (16*k+132) ∨ z = (16*k+133) ∨ z = (32*k+263) ∨ z = (32*k+265) ∨ z = (32*k+264) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c40 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (2*k+15) (8*k+65)) ∨ (Cell (4*k+31) (8*k+65)) ∨ (Cell (8*k+64) (8*k+65)) ∨ (Cell (16*k+130) (8*k+65)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (4*k+32) (8*k+65) g (by omega)
  unfold Allowed at ha
  have options : z = (2*k+15) ∨ z = (4*k+31) ∨ z = (8*k+64) ∨ z = (16*k+130) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c41 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (8*k+65) (16*k+133)) ∨ (Cell (16*k+131) (16*k+132)) := by
  classical
  by_cases h : Cell (8*k+65) (16*k+133)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(8*k+65)+1 = (16*k+131) := by omega
      have ht : (16*k+133)-1 = (16*k+132) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c42 (k : Nat) : ¬ (Cell (8*k+65) (32*k+263)) ∨ ¬ (Cell (16*k+130) (8*k+65)) := by
  by_cases h : Cell (8*k+65) (32*k+263)
  · right; intro h2
    have ht := half_time (v := (8*k+65)) (t := (32*k+263)) (ch := (16*k+130)) (u := (8*k+65)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c43 (k : Nat) : ¬ (Cell (8*k+65) (32*k+265)) ∨ ¬ (Cell (16*k+130) (8*k+65)) := by
  by_cases h : Cell (8*k+65) (32*k+265)
  · right; intro h2
    have ht := half_time (v := (8*k+65)) (t := (32*k+265)) (ch := (16*k+130)) (u := (8*k+65)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c44 (k : Nat) : ¬ (Cell (8*k+65) (32*k+264)) ∨ ¬ (Cell (16*k+130) (8*k+65)) := by
  by_cases h : Cell (8*k+65) (32*k+264)
  · right; intro h2
    have ht := half_time (v := (8*k+65)) (t := (32*k+264)) (ch := (16*k+130)) (u := (8*k+65)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c45 (k : Nat) : ¬ (Cell (16*k+122) (16*k+123)) ∨ ¬ (Cell (16*k+122) (8*k+61)) := by
  by_cases h : Cell (16*k+122) (16*k+123)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c46 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (16*k+123) (16*k+124)) ∨ (Cell (16*k+123) (32*k+248)) ∨ (Cell (16*k+123) (32*k+249)) ∨ (Cell (16*k+123) (64*k+495)) ∨ (Cell (16*k+123) (64*k+497)) ∨ (Cell (16*k+123) (64*k+496)) := by
  obtain ⟨z, hz, ha⟩ := row (4*k+32) (16*k+123) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+124) ∨ z = (32*k+248) ∨ z = (32*k+249) ∨ z = (64*k+495) ∨ z = (64*k+497) ∨ z = (64*k+496) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c47 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (4*k+30) (16*k+123)) ∨ (Cell (8*k+60) (16*k+123)) ∨ (Cell (16*k+122) (16*k+123)) ∨ (Cell (32*k+246) (16*k+123)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (4*k+32) (16*k+123) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+30) ∨ z = (8*k+60) ∨ z = (16*k+122) ∨ z = (32*k+246) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c48 (k : Nat) : ¬ (Cell (16*k+123) (32*k+248)) ∨ ¬ (Cell (32*k+246) (16*k+123)) := by
  by_cases h : Cell (16*k+123) (32*k+248)
  · right; intro h2
    have ht := half_time (v := (16*k+123)) (t := (32*k+248)) (ch := (32*k+246)) (u := (16*k+123)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c49 (k : Nat) : ¬ (Cell (16*k+123) (32*k+249)) ∨ ¬ (Cell (32*k+246) (16*k+123)) := by
  by_cases h : Cell (16*k+123) (32*k+249)
  · right; intro h2
    have ht := half_time (v := (16*k+123)) (t := (32*k+249)) (ch := (32*k+246)) (u := (16*k+123)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c50 (k : Nat) : ¬ (Cell (16*k+123) (64*k+495)) ∨ ¬ (Cell (32*k+246) (16*k+123)) := by
  by_cases h : Cell (16*k+123) (64*k+495)
  · right; intro h2
    have ht := half_time (v := (16*k+123)) (t := (64*k+495)) (ch := (32*k+246)) (u := (16*k+123)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c51 (k : Nat) : ¬ (Cell (16*k+123) (64*k+497)) ∨ ¬ (Cell (32*k+246) (16*k+123)) := by
  by_cases h : Cell (16*k+123) (64*k+497)
  · right; intro h2
    have ht := half_time (v := (16*k+123)) (t := (64*k+497)) (ch := (32*k+246)) (u := (16*k+123)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c52 (k : Nat) : ¬ (Cell (16*k+123) (64*k+496)) ∨ ¬ (Cell (32*k+246) (16*k+123)) := by
  by_cases h : Cell (16*k+123) (64*k+496)
  · right; intro h2
    have ht := half_time (v := (16*k+123)) (t := (64*k+496)) (ch := (32*k+246)) (u := (16*k+123)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c53 (k : Nat) : ¬ (Cell (16*k+123) (16*k+124)) ∨ ¬ (Cell (32*k+248) (16*k+124)) := by
  by_cases h : Cell (16*k+123) (16*k+124)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c54 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (16*k+124) (16*k+125)) ∨ (Cell (32*k+248) (16*k+124)) := by
  classical
  by_cases h : Cell (16*k+124) (16*k+125)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+124) = (32*k+248) := by omega
      have ht : (16*k+125)-1 = (16*k+124) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c55 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (16*k+125) (16*k+126)) ∨ (Cell (16*k+125) (32*k+252)) ∨ (Cell (16*k+125) (32*k+253)) ∨ (Cell (16*k+125) (64*k+503)) ∨ (Cell (16*k+125) (64*k+505)) ∨ (Cell (16*k+125) (64*k+504)) := by
  obtain ⟨z, hz, ha⟩ := row (4*k+32) (16*k+125) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+126) ∨ z = (32*k+252) ∨ z = (32*k+253) ∨ z = (64*k+503) ∨ z = (64*k+505) ∨ z = (64*k+504) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c56 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (4*k+30) (16*k+125)) ∨ (Cell (8*k+61) (16*k+125)) ∨ (Cell (16*k+124) (16*k+125)) ∨ (Cell (32*k+250) (16*k+125)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (4*k+32) (16*k+125) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+30) ∨ z = (8*k+61) ∨ z = (16*k+124) ∨ z = (32*k+250) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c57 (k : Nat) : ¬ (Cell (16*k+125) (32*k+252)) ∨ ¬ (Cell (32*k+250) (16*k+125)) := by
  by_cases h : Cell (16*k+125) (32*k+252)
  · right; intro h2
    have ht := half_time (v := (16*k+125)) (t := (32*k+252)) (ch := (32*k+250)) (u := (16*k+125)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c58 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (16*k+125) (32*k+252)) ∨ (Cell (32*k+250) (32*k+251)) := by
  classical
  by_cases h : Cell (16*k+125) (32*k+252)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+125) = (32*k+250) := by omega
      have ht : (32*k+252)-1 = (32*k+251) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c59 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (16*k+125) (32*k+253)) ∨ (Cell (32*k+251) (32*k+252)) := by
  classical
  by_cases h : Cell (16*k+125) (32*k+253)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(16*k+125)+1 = (32*k+251) := by omega
      have ht : (32*k+253)-1 = (32*k+252) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c60 (k : Nat) : ¬ (Cell (16*k+125) (64*k+503)) ∨ ¬ (Cell (32*k+250) (16*k+125)) := by
  by_cases h : Cell (16*k+125) (64*k+503)
  · right; intro h2
    have ht := half_time (v := (16*k+125)) (t := (64*k+503)) (ch := (32*k+250)) (u := (16*k+125)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c61 (k : Nat) : ¬ (Cell (16*k+125) (64*k+505)) ∨ ¬ (Cell (32*k+250) (16*k+125)) := by
  by_cases h : Cell (16*k+125) (64*k+505)
  · right; intro h2
    have ht := half_time (v := (16*k+125)) (t := (64*k+505)) (ch := (32*k+250)) (u := (16*k+125)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c62 (k : Nat) : ¬ (Cell (16*k+125) (64*k+504)) ∨ ¬ (Cell (32*k+250) (16*k+125)) := by
  by_cases h : Cell (16*k+125) (64*k+504)
  · right; intro h2
    have ht := half_time (v := (16*k+125)) (t := (64*k+504)) (ch := (32*k+250)) (u := (16*k+125)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c63 (k : Nat) : ¬ (Cell (8*k+62) (16*k+127)) ∨ ¬ (Cell (16*k+126) (16*k+127)) := by
  by_cases h : Cell (8*k+62) (16*k+127)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c64 (k : Nat) : ¬ (Cell (8*k+62) (16*k+127)) ∨ ¬ (Cell (32*k+254) (16*k+127)) := by
  by_cases h : Cell (8*k+62) (16*k+127)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c65 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (16*k+127) (16*k+128)) ∨ (Cell (32*k+254) (16*k+127)) := by
  classical
  by_cases h : Cell (16*k+127) (16*k+128)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+127) = (32*k+254) := by omega
      have ht : (16*k+128)-1 = (16*k+127) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c66 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (16*k+128) (16*k+129)) ∨ (Cell (16*k+128) (32*k+258)) ∨ (Cell (16*k+128) (32*k+259)) ∨ (Cell (16*k+128) (64*k+515)) ∨ (Cell (16*k+128) (64*k+517)) ∨ (Cell (16*k+128) (64*k+516)) ∨ (Cell (16*k+128) (8*k+64)) := by
  obtain ⟨z, hz, ha⟩ := row (4*k+32) (16*k+128) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+129) ∨ z = (32*k+258) ∨ z = (32*k+259) ∨ z = (64*k+515) ∨ z = (64*k+517) ∨ z = (64*k+516) ∨ z = (8*k+64) := by omega
  rcases options with e | e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))))

private theorem c67 (k : Nat) (g : GoodBelow (4*k+32)) : (Cell (8*k+63) (16*k+128)) ∨ (Cell (16*k+127) (16*k+128)) ∨ (Cell (32*k+256) (16*k+128)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (4*k+32) (16*k+128) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+63) ∨ z = (16*k+127) ∨ z = (32*k+256) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c68 (k : Nat) : ¬ (Cell (16*k+128) (32*k+258)) ∨ ¬ (Cell (32*k+256) (16*k+128)) := by
  by_cases h : Cell (16*k+128) (32*k+258)
  · right; intro h2
    have ht := half_time (v := (16*k+128)) (t := (32*k+258)) (ch := (32*k+256)) (u := (16*k+128)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c69 (k : Nat) : ¬ (Cell (16*k+128) (32*k+259)) ∨ ¬ (Cell (32*k+256) (16*k+128)) := by
  by_cases h : Cell (16*k+128) (32*k+259)
  · right; intro h2
    have ht := half_time (v := (16*k+128)) (t := (32*k+259)) (ch := (32*k+256)) (u := (16*k+128)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c70 (k : Nat) : ¬ (Cell (16*k+128) (64*k+515)) ∨ ¬ (Cell (32*k+256) (16*k+128)) := by
  by_cases h : Cell (16*k+128) (64*k+515)
  · right; intro h2
    have ht := half_time (v := (16*k+128)) (t := (64*k+515)) (ch := (32*k+256)) (u := (16*k+128)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c71 (k : Nat) : ¬ (Cell (16*k+128) (64*k+517)) ∨ ¬ (Cell (32*k+256) (16*k+128)) := by
  by_cases h : Cell (16*k+128) (64*k+517)
  · right; intro h2
    have ht := half_time (v := (16*k+128)) (t := (64*k+517)) (ch := (32*k+256)) (u := (16*k+128)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c72 (k : Nat) : ¬ (Cell (16*k+128) (64*k+516)) ∨ ¬ (Cell (32*k+256) (16*k+128)) := by
  by_cases h : Cell (16*k+128) (64*k+516)
  · right; intro h2
    have ht := half_time (v := (16*k+128)) (t := (64*k+516)) (ch := (32*k+256)) (u := (16*k+128)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c73 (k : Nat) : ¬ (Cell (4*k+32) (16*k+132)) ∨ ¬ (Cell (8*k+65) (16*k+132)) := by
  by_cases h : Cell (4*k+32) (16*k+132)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c74 (k : Nat) : ¬ (Cell (4*k+32) (16*k+132)) ∨ ¬ (Cell (16*k+131) (16*k+132)) := by
  by_cases h : Cell (4*k+32) (16*k+132)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c75 (k : Nat) : ¬ (Cell (8*k+62) (32*k+251)) ∨ ¬ (Cell (32*k+250) (32*k+251)) := by
  by_cases h : Cell (8*k+62) (32*k+251)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c76 (k : Nat) : ¬ (Cell (8*k+62) (32*k+251)) ∨ ¬ (Cell (64*k+502) (32*k+251)) := by
  by_cases h : Cell (8*k+62) (32*k+251)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c77 (k : Nat) (g : GoodBelow (4*k+32)) : ¬ (Cell (32*k+251) (32*k+252)) ∨ (Cell (64*k+502) (32*k+251)) := by
  classical
  by_cases h : Cell (32*k+251) (32*k+252)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+251) = (64*k+502) := by omega
      have ht : (32*k+252)-1 = (32*k+251) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c78 (k : Nat) : ¬ (Cell (8*k+62) (32*k+252)) ∨ ¬ (Cell (16*k+125) (32*k+252)) := by
  by_cases h : Cell (8*k+62) (32*k+252)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c79 (k : Nat) : ¬ (Cell (8*k+62) (32*k+252)) ∨ ¬ (Cell (32*k+251) (32*k+252)) := by
  by_cases h : Cell (8*k+62) (32*k+252)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

theorem exclude (k : Nat) (g : GoodBelow (4*k+32)) (bad : Cell (4*k+32) (4*(4*k+32)+4)) : False := by
  have badNormalized : Cell (4*k+32) (16*k+132) := by
    rw [show (16*k+132) = 4*(4*k+32)+4 by omega]
    exact bad
  exact privateReplay
    (Cell (2*k+15) (4*k+32))
    (Cell (2*k+15) (8*k+65))
    (Cell (4*k+30) (4*k+31))
    (Cell (4*k+31) (8*k+64))
    (Cell (4*k+30) (8*k+62))
    (Cell (4*k+30) (16*k+123))
    (Cell (4*k+30) (16*k+125))
    (Cell (8*k+60) (4*k+30))
    (Cell (4*k+31) (4*k+32))
    (Cell (4*k+31) (8*k+65))
    (Cell (8*k+62) (4*k+31))
    (Cell (8*k+63) (8*k+64))
    (Cell (8*k+64) (4*k+32))
    (Cell (4*k+32) (16*k+132))
    (Cell (8*k+64) (8*k+65))
    (Cell (8*k+65) (8*k+66))
    (Cell (8*k+64) (16*k+131))
    (Cell (8*k+60) (16*k+123))
    (Cell (8*k+61) (8*k+62))
    (Cell (8*k+61) (16*k+125))
    (Cell (16*k+122) (8*k+61))
    (Cell (8*k+62) (8*k+63))
    (Cell (8*k+62) (16*k+126))
    (Cell (8*k+62) (16*k+127))
    (Cell (8*k+62) (32*k+251))
    (Cell (8*k+62) (32*k+253))
    (Cell (8*k+62) (32*k+252))
    (Cell (16*k+124) (8*k+62))
    (Cell (16*k+124) (16*k+125))
    (Cell (16*k+125) (16*k+126))
    (Cell (16*k+125) (32*k+252))
    (Cell (16*k+126) (8*k+63))
    (Cell (8*k+63) (16*k+128))
    (Cell (16*k+126) (16*k+127))
    (Cell (16*k+128) (8*k+64))
    (Cell (16*k+128) (16*k+129))
    (Cell (8*k+65) (16*k+132))
    (Cell (8*k+65) (16*k+133))
    (Cell (8*k+65) (32*k+263))
    (Cell (8*k+65) (32*k+265))
    (Cell (8*k+65) (32*k+264))
    (Cell (16*k+130) (8*k+65))
    (Cell (16*k+131) (16*k+132))
    (Cell (16*k+122) (16*k+123))
    (Cell (16*k+123) (16*k+124))
    (Cell (16*k+123) (32*k+248))
    (Cell (16*k+123) (32*k+249))
    (Cell (16*k+123) (64*k+495))
    (Cell (16*k+123) (64*k+497))
    (Cell (16*k+123) (64*k+496))
    (Cell (32*k+246) (16*k+123))
    (Cell (32*k+248) (16*k+124))
    (Cell (16*k+125) (32*k+253))
    (Cell (16*k+125) (64*k+503))
    (Cell (16*k+125) (64*k+505))
    (Cell (16*k+125) (64*k+504))
    (Cell (32*k+250) (16*k+125))
    (Cell (32*k+250) (32*k+251))
    (Cell (32*k+251) (32*k+252))
    (Cell (32*k+254) (16*k+127))
    (Cell (16*k+127) (16*k+128))
    (Cell (16*k+128) (32*k+258))
    (Cell (16*k+128) (32*k+259))
    (Cell (16*k+128) (64*k+515))
    (Cell (16*k+128) (64*k+517))
    (Cell (16*k+128) (64*k+516))
    (Cell (32*k+256) (16*k+128))
    (Cell (64*k+502) (32*k+251))
    (c0 k)
    (c1 k g)
    (c2 k g)
    (c3 k)
    (c4 k)
    (c5 k)
    (c6 k g)
    (c7 k)
    (c8 k)
    (c9 k)
    (c10 k g)
    (c11 k g)
    (c12 k)
    (c13 k)
    (c14 k)
    (c15 k g)
    (c16 k)
    (c17 k)
    (c18 k g)
    (c19 k g)
    (c20 k g)
    (c21 k)
    (c22 k g)
    (c23 k)
    (c24 k)
    (c25 k)
    (c26 k)
    (c27 k)
    (c28 k g)
    (c29 k)
    (c30 k)
    (c31 k)
    (c32 k)
    (c33 k g)
    (c34 k g)
    (c35 k g)
    (c36 k)
    (c37 k)
    (c38 k)
    (c39 k g)
    (c40 k g)
    (c41 k g)
    (c42 k)
    (c43 k)
    (c44 k)
    (c45 k)
    (c46 k g)
    (c47 k g)
    (c48 k)
    (c49 k)
    (c50 k)
    (c51 k)
    (c52 k)
    (c53 k)
    (c54 k g)
    (c55 k g)
    (c56 k g)
    (c57 k)
    (c58 k g)
    (c59 k g)
    (c60 k)
    (c61 k)
    (c62 k)
    (c63 k)
    (c64 k)
    (c65 k g)
    (c66 k g)
    (c67 k g)
    (c68 k)
    (c69 k)
    (c70 k)
    (c71 k)
    (c72 k)
    (c73 k)
    (c74 k)
    (c75 k)
    (c76 k)
    (c77 k g)
    (c78 k)
    (c79 k)
    badNormalized
end P4R0
end Inverse
