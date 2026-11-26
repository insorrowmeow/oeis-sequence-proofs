import InverseBase

set_option linter.unusedVariables false
set_option maxHeartbeats 2000000
set_option maxRecDepth 8000
namespace Inverse
namespace P16R11

theorem privateReplay (p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40 p41 p42 p43 p44 p45 p46 p47 p48 p49 p50 p51 p52 p53 p54 p55 p56 p57 p58 p59 p60 p61 p62 p63 p64 p65 p66 p67 p68 p69 p70 p71 p72 p73 p74 p75 p76 p77 p78 p79 p80 p81 p82 p83 p84 p85 p86 p87 p88 p89 p90 p91 p92 p93 p94 p95 p96 p97 p98 p99 p100 p101 p102 p103 p104 p105 p106 p107 p108 p109 p110 p111 p112 p113 p114 p115 p116 p117 p118 p119 p120 p121 : Prop)
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
    (h12 : ¬ (p14) ∨ (p15))
    (h13 : ¬ (p16) ∨ ¬ (p8))
    (h14 : ¬ (p17) ∨ ¬ (p18))
    (h15 : ¬ (p17) ∨ (p19))
    (h16 : (p20) ∨ (p21) ∨ (p22) ∨ (p23) ∨ (p24) ∨ (p11))
    (h17 : (p5) ∨ (p17) ∨ (p25))
    (h18 : ¬ (p21) ∨ (p26))
    (h19 : ¬ (p23) ∨ ¬ (p25))
    (h20 : ¬ (p23) ∨ ¬ (p27))
    (h21 : ¬ (p24) ∨ ¬ (p25))
    (h22 : ¬ (p24) ∨ (p28))
    (h23 : ¬ (p12) ∨ ¬ (p29))
    (h24 : ¬ (p20) ∨ ¬ (p30))
    (h25 : ¬ (p12) ∨ (p30))
    (h26 : ¬ (p31) ∨ ¬ (p32))
    (h27 : ¬ (p15) ∨ ¬ (p33))
    (h28 : ¬ (p32) ∨ ¬ (p13))
    (h29 : (p4) ∨ (p12) ∨ (p34))
    (h30 : ¬ (p4) ∨ ¬ (p12))
    (h31 : ¬ (p15) ∨ (p35))
    (h32 : ¬ (p33) ∨ ¬ (p36))
    (h33 : (p37) ∨ (p38) ∨ (p39) ∨ (p40) ∨ (p41))
    (h34 : (p2) ∨ (p10) ∨ (p31) ∨ (p42))
    (h35 : ¬ (p37) ∨ (p42))
    (h36 : ¬ (p38) ∨ (p43))
    (h37 : ¬ (p39) ∨ (p44))
    (h38 : ¬ (p40) ∨ (p45))
    (h39 : ¬ (p41) ∨ (p46))
    (h40 : ¬ (p47) ∨ ¬ (p19))
    (h41 : (p48) ∨ (p49) ∨ (p50) ∨ (p51) ∨ (p52))
    (h42 : (p6) ∨ (p16) ∨ (p47) ∨ (p53))
    (h43 : ¬ (p49) ∨ ¬ (p53))
    (h44 : ¬ (p50) ∨ ¬ (p53))
    (h45 : ¬ (p51) ∨ ¬ (p53))
    (h46 : ¬ (p52) ∨ ¬ (p53))
    (h47 : ¬ (p26) ∨ ¬ (p25))
    (h48 : ¬ (p48) ∨ ¬ (p54))
    (h49 : ¬ (p26) ∨ (p54))
    (h50 : (p27) ∨ (p28) ∨ (p55) ∨ (p56) ∨ (p57))
    (h51 : (p7) ∨ (p18) ∨ (p26) ∨ (p58))
    (h52 : ¬ (p28) ∨ ¬ (p58))
    (h53 : ¬ (p55) ∨ ¬ (p58))
    (h54 : ¬ (p56) ∨ ¬ (p58))
    (h55 : ¬ (p57) ∨ ¬ (p58))
    (h56 : ¬ (p22) ∨ ¬ (p59))
    (h57 : ¬ (p60) ∨ (p59))
    (h58 : ¬ (p61) ∨ ¬ (p34))
    (h59 : (p29) ∨ (p60) ∨ (p62))
    (h60 : ¬ (p61) ∨ ¬ (p62))
    (h61 : (p36) ∨ (p63) ∨ (p64) ∨ (p65) ∨ (p66))
    (h62 : ¬ (p36) ∨ ¬ (p66))
    (h63 : ¬ (p36) ∨ (p67))
    (h64 : ¬ (p66) ∨ ¬ (p68))
    (h65 : ¬ (p66) ∨ (p69))
    (h66 : ¬ (p43) ∨ ¬ (p45))
    (h67 : ¬ (p43) ∨ ¬ (p70))
    (h68 : ¬ (p45) ∨ ¬ (p71))
    (h69 : ¬ (p45) ∨ ¬ (p42))
    (h70 : ¬ (p70) ∨ ¬ (p42))
    (h71 : (p15) ∨ (p36) ∨ (p72))
    (h72 : ¬ (p15) ∨ ¬ (p36))
    (h73 : ¬ (p45) ∨ ¬ (p72))
    (h74 : ¬ (p45) ∨ (p73))
    (h75 : ¬ (p44) ∨ ¬ (p74))
    (h76 : ¬ (p46) ∨ ¬ (p74))
    (h77 : (p14) ∨ (p32) ∨ (p43) ∨ (p75))
    (h78 : ¬ (p74) ∨ ¬ (p76))
    (h79 : ¬ (p74) ∨ ¬ (p75))
    (h80 : ¬ (p74) ∨ ¬ (p77))
    (h81 : ¬ (p74) ∨ (p78))
    (h82 : ¬ (p68) ∨ ¬ (p67))
    (h83 : (p79) ∨ (p69) ∨ (p80) ∨ (p81) ∨ (p82) ∨ (p83))
    (h84 : (p33) ∨ (p61) ∨ (p68) ∨ (p84))
    (h85 : ¬ (p69) ∨ ¬ (p84))
    (h86 : ¬ (p80) ∨ ¬ (p84))
    (h87 : ¬ (p80) ∨ (p85))
    (h88 : ¬ (p81) ∨ ¬ (p85))
    (h89 : ¬ (p82) ∨ ¬ (p85))
    (h90 : ¬ (p83) ∨ ¬ (p85))
    (h91 : ¬ (p73) ∨ ¬ (p86))
    (h92 : ¬ (p63) ∨ ¬ (p87))
    (h93 : ¬ (p79) ∨ ¬ (p87))
    (h94 : ¬ (p73) ∨ (p87))
    (h95 : (p88) ∨ (p89) ∨ (p90) ∨ (p91) ∨ (p92) ∨ (p93))
    (h96 : ¬ (p64) ∨ ¬ (p73))
    (h97 : ¬ (p89) ∨ (p94))
    (h98 : ¬ (p91) ∨ ¬ (p95))
    (h99 : ¬ (p92) ∨ (p96))
    (h100 : ¬ (p93) ∨ ¬ (p95))
    (h101 : ¬ (p45) ∨ ¬ (p88))
    (h102 : ¬ (p78) ∨ (p97))
    (h103 : (p77) ∨ (p98) ∨ (p99) ∨ (p100) ∨ (p101) ∨ (p102))
    (h104 : (p40) ∨ (p70) ∨ (p76) ∨ (p103))
    (h105 : ¬ (p99) ∨ (p104))
    (h106 : ¬ (p100) ∨ ¬ (p103))
    (h107 : ¬ (p101) ∨ ¬ (p103))
    (h108 : ¬ (p102) ∨ ¬ (p103))
    (h109 : ¬ (p65) ∨ ¬ (p105))
    (h110 : ¬ (p85) ∨ (p105))
    (h111 : ¬ (p106) ∨ ¬ (p87))
    (h112 : (p69) ∨ (p85) ∨ (p107))
    (h113 : ¬ (p69) ∨ ¬ (p85))
    (h114 : ¬ (p69) ∨ ¬ (p107))
    (h115 : ¬ (p85) ∨ ¬ (p107))
    (h116 : (p108) ∨ (p109) ∨ (p110) ∨ (p111) ∨ (p112) ∨ (p113))
    (h117 : (p66) ∨ (p80) ∨ (p106) ∨ (p114))
    (h118 : ¬ (p109) ∨ ¬ (p114))
    (h119 : ¬ (p110) ∨ ¬ (p114))
    (h120 : ¬ (p111) ∨ ¬ (p114))
    (h121 : ¬ (p112) ∨ ¬ (p114))
    (h122 : ¬ (p113) ∨ ¬ (p114))
    (h123 : ¬ (p108) ∨ ¬ (p115))
    (h124 : ¬ (p94) ∨ (p115))
    (h125 : (p95) ∨ (p96) ∨ (p116) ∨ (p117) ∨ (p118) ∨ (p119))
    (h126 : (p71) ∨ (p86) ∨ (p94) ∨ (p120))
    (h127 : ¬ (p96) ∨ ¬ (p120))
    (h128 : ¬ (p116) ∨ ¬ (p120))
    (h129 : ¬ (p117) ∨ ¬ (p120))
    (h130 : ¬ (p118) ∨ ¬ (p120))
    (h131 : ¬ (p119) ∨ ¬ (p120))
    (h132 : ¬ (p90) ∨ ¬ (p121))
    (h133 : ¬ (p97) ∨ (p121))
    (h134 : ¬ (p74) ∨ ¬ (p98))
    (h135 : ¬ (p74) ∨ ¬ (p104))
    (h136 : ¬ (p35) ∨ ¬ (p61))
    (h137 : (p74)) : False := by
  have rup139 : ¬ (p44) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p44) := Classical.byContradiction (fun v => denied v)
    have u1 : (p74) := h137
    exact (Or.elim h75 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup140 : ¬ (p46) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p46) := Classical.byContradiction (fun v => denied v)
    have u1 : (p74) := h137
    exact (Or.elim h76 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup141 : ¬ (p76) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p76) := Classical.byContradiction (fun v => denied v)
    have u1 : (p74) := h137
    exact (Or.elim h78 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup142 : ¬ (p75) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p75) := Classical.byContradiction (fun v => denied v)
    have u1 : (p74) := h137
    exact (Or.elim h79 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup143 : ¬ (p77) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p77) := Classical.byContradiction (fun v => denied v)
    have u1 : (p74) := h137
    exact (Or.elim h80 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup144 : (p78) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p78) := fun v => denied v
    have u1 : (p74) := h137
    exact (Or.elim h81 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup145 : ¬ (p98) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p98) := Classical.byContradiction (fun v => denied v)
    have u1 : (p74) := h137
    exact (Or.elim h134 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup146 : ¬ (p104) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p104) := Classical.byContradiction (fun v => denied v)
    have u1 : (p74) := h137
    exact (Or.elim h135 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup147 : ¬ (p39) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p39) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p44) := rup139
    exact (Or.elim h37 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup148 : ¬ (p41) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p41) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p46) := rup140
    exact (Or.elim h39 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup149 : (p97) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p97) := fun v => denied v
    have u1 : (p78) := rup144
    exact (Or.elim h102 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup150 : ¬ (p99) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p99) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p104) := rup146
    exact (Or.elim h105 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup151 : (p121) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p121) := fun v => denied v
    have u1 : (p97) := rup149
    exact (Or.elim h133 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup152 : ¬ (p90) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p90) := Classical.byContradiction (fun v => denied v)
    have u1 : (p121) := rup151
    exact (Or.elim h132 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup153 : ¬ (p107) ∨ (p114) ∨ (p106) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p107) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : ¬ (p114) := fun v => denied (Or.inr (Or.inl v))
    have u2 : ¬ (p106) := fun v => denied (Or.inr (Or.inr v))
    have u3 : ¬ (p69) := (Or.elim h114 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u4 : ¬ (p85) := (Or.elim h115 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u5 : ¬ (p66) := (Or.elim h65 (fun v => v) (fun tail => (False.elim (u3 tail))))
    have u6 : ¬ (p80) := (Or.elim h87 (fun v => v) (fun tail => (False.elim (u4 tail))))
    exact (Or.elim h117 (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u1 tail))))))))
  have rup154 : (p85) ∨ (p114) ∨ ¬ (p45) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p85) := fun v => denied (Or.inl v)
    have u1 : ¬ (p114) := fun v => denied (Or.inr (Or.inl v))
    have u2 : (p45) := Classical.byContradiction (fun v => denied (Or.inr (Or.inr v)))
    have u3 : (p73) := (Or.elim h74 (fun v => (False.elim (v u2))) (fun tail => tail))
    have u4 : (p87) := (Or.elim h94 (fun v => (False.elim (v u3))) (fun tail => tail))
    have u5 : ¬ (p106) := (Or.elim h111 (fun v => v) (fun tail => (False.elim (tail u4))))
    have u6 : ¬ (p107) := (Or.elim rup153 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (False.elim (u5 tail))))))
    have u7 : ¬ (p72) := (Or.elim h73 (fun v => (False.elim (v u2))) (fun tail => tail))
    have u8 : ¬ (p80) := (Or.elim h87 (fun v => v) (fun tail => (False.elim (u0 tail))))
    have u9 : (p69) := (Or.elim h112 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u6 tail))))))
    have u10 : (p66) := (Or.elim h117 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (False.elim (u1 tail))))))))
    have u11 : ¬ (p84) := (Or.elim h85 (fun v => (False.elim (v u9))) (fun tail => tail))
    have u12 : ¬ (p36) := (Or.elim h62 (fun v => v) (fun tail => (False.elim (tail u10))))
    have u13 : ¬ (p68) := (Or.elim h64 (fun v => (False.elim (v u10))) (fun tail => tail))
    have u14 : (p15) := (Or.elim h71 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u12 v))) (fun tail => (False.elim (u7 tail))))))
    have u15 : ¬ (p33) := (Or.elim h27 (fun v => (False.elim (v u14))) (fun tail => tail))
    have u16 : (p35) := (Or.elim h31 (fun v => (False.elim (v u14))) (fun tail => tail))
    have u17 : (p61) := (Or.elim h84 (fun v => (False.elim (u15 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u13 v))) (fun tail => (False.elim (u11 tail))))))))
    exact (Or.elim h136 (fun v => (False.elim (v u16))) (fun tail => (False.elim (tail u17))))
  have rup155 : (p12) ∨ (p13) ∨ (p31) ∨ (p34) ∨ (p42) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p12) := fun v => denied (Or.inl v)
    have u1 : ¬ (p13) := fun v => denied (Or.inr (Or.inl v))
    have u2 : ¬ (p31) := fun v => denied (Or.inr (Or.inr (Or.inl v)))
    have u3 : ¬ (p34) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inl v))))
    have u4 : ¬ (p42) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inr v))))
    have u5 : ¬ (p10) := (Or.elim h10 (fun v => v) (fun tail => (False.elim (u0 tail))))
    have u6 : (p4) := (Or.elim h29 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u3 tail))))))
    have u7 : (p2) := (Or.elim h34 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u4 tail))))))))
    have u8 : ¬ (p9) := (Or.elim h7 (fun v => v) (fun tail => (False.elim (tail u6))))
    have u9 : ¬ (p1) := (Or.elim h0 (fun v => v) (fun tail => (False.elim (tail u7))))
    exact (Or.elim h11 (fun v => (False.elim (u9 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (False.elim (u1 tail))))))
  have rup156 : (p26) ∨ (p58) ∨ (p24) ∨ (p7) ∨ (p5) ∨ (p11) ∨ (p22) ∨ (p20) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p26) := fun v => denied (Or.inl v)
    have u1 : ¬ (p58) := fun v => denied (Or.inr (Or.inl v))
    have u2 : ¬ (p24) := fun v => denied (Or.inr (Or.inr (Or.inl v)))
    have u3 : ¬ (p7) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inl v))))
    have u4 : ¬ (p5) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl v)))))
    have u5 : ¬ (p11) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl v))))))
    have u6 : ¬ (p22) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl v)))))))
    have u7 : ¬ (p20) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr v)))))))
    have u8 : ¬ (p21) := (Or.elim h18 (fun v => v) (fun tail => (False.elim (u0 tail))))
    have u9 : (p18) := (Or.elim h51 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u1 tail))))))))
    have u10 : (p23) := (Or.elim h16 (fun v => (False.elim (u7 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u5 tail))))))))))))
    have u11 : ¬ (p17) := (Or.elim h14 (fun v => v) (fun tail => (False.elim (tail u9))))
    have u12 : ¬ (p25) := (Or.elim h19 (fun v => (False.elim (v u10))) (fun tail => tail))
    exact (Or.elim h17 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u11 v))) (fun tail => (False.elim (u12 tail))))))
  have rup157 : ¬ (p26) ∨ ¬ (p3) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p26) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : (p3) := Classical.byContradiction (fun v => denied (Or.inr v))
    have u2 : (p8) := (Or.elim h6 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u3 : ¬ (p16) := (Or.elim h13 (fun v => v) (fun tail => (False.elim (tail u2))))
    have u4 : ¬ (p6) := (Or.elim h4 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u5 : ¬ (p5) := (Or.elim h3 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u6 : ¬ (p25) := (Or.elim h47 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u7 : (p54) := (Or.elim h49 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u8 : (p17) := (Or.elim h17 (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u6 tail))))))
    have u9 : ¬ (p48) := (Or.elim h48 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u10 : (p19) := (Or.elim h15 (fun v => (False.elim (v u8))) (fun tail => tail))
    have u11 : ¬ (p47) := (Or.elim h40 (fun v => v) (fun tail => (False.elim (tail u10))))
    have u12 : (p53) := (Or.elim h42 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u11 v))) (fun tail => tail))))))
    have u13 : ¬ (p49) := (Or.elim h43 (fun v => v) (fun tail => (False.elim (tail u12))))
    have u14 : ¬ (p50) := (Or.elim h44 (fun v => v) (fun tail => (False.elim (tail u12))))
    have u15 : ¬ (p51) := (Or.elim h45 (fun v => v) (fun tail => (False.elim (tail u12))))
    have u16 : ¬ (p52) := (Or.elim h46 (fun v => v) (fun tail => (False.elim (tail u12))))
    exact (Or.elim h41 (fun v => (False.elim (u9 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u13 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u14 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u15 v))) (fun tail => (False.elim (u16 tail))))))))))
  have rup158 : (p58) ∨ (p20) ∨ (p26) ∨ (p7) ∨ (p5) ∨ (p11) ∨ (p22) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p58) := fun v => denied (Or.inl v)
    have u1 : ¬ (p20) := fun v => denied (Or.inr (Or.inl v))
    have u2 : ¬ (p26) := fun v => denied (Or.inr (Or.inr (Or.inl v)))
    have u3 : ¬ (p7) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inl v))))
    have u4 : ¬ (p5) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl v)))))
    have u5 : ¬ (p11) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl v))))))
    have u6 : ¬ (p22) := fun v => denied (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr v))))))
    have u7 : (p24) := (Or.elim rup156 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (False.elim (u1 tail))))))))))))))))
    have u8 : (p18) := (Or.elim h51 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u0 tail))))))))
    have u9 : ¬ (p25) := (Or.elim h21 (fun v => (False.elim (v u7))) (fun tail => tail))
    have u10 : ¬ (p17) := (Or.elim h14 (fun v => v) (fun tail => (False.elim (tail u8))))
    exact (Or.elim h17 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u10 v))) (fun tail => (False.elim (u9 tail))))))
  have rup159 : ¬ (p85) ∨ ¬ (p45) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p85) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : (p45) := Classical.byContradiction (fun v => denied (Or.inr v))
    have u2 : ¬ (p75) := rup142
    have u3 : (p73) := (Or.elim h74 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u4 : (p87) := (Or.elim h94 (fun v => (False.elim (v u3))) (fun tail => tail))
    have u5 : ¬ (p79) := (Or.elim h93 (fun v => v) (fun tail => (False.elim (tail u4))))
    have u6 : ¬ (p63) := (Or.elim h92 (fun v => v) (fun tail => (False.elim (tail u4))))
    have u7 : ¬ (p64) := (Or.elim h96 (fun v => v) (fun tail => (False.elim (tail u3))))
    have u8 : ¬ (p42) := (Or.elim h69 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u9 : ¬ (p43) := (Or.elim h66 (fun v => v) (fun tail => (False.elim (tail u1))))
    have u10 : ¬ (p81) := (Or.elim h88 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u11 : ¬ (p82) := (Or.elim h89 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u12 : ¬ (p83) := (Or.elim h90 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u13 : (p105) := (Or.elim h110 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u14 : ¬ (p69) := (Or.elim h113 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u15 : (p80) := (Or.elim h83 (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u14 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u10 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u11 v))) (fun tail => (False.elim (u12 tail))))))))))))
    have u16 : ¬ (p65) := (Or.elim h109 (fun v => v) (fun tail => (False.elim (tail u13))))
    have u17 : ¬ (p66) := (Or.elim h65 (fun v => v) (fun tail => (False.elim (u14 tail))))
    have u18 : ¬ (p84) := (Or.elim h86 (fun v => (False.elim (v u15))) (fun tail => tail))
    have u19 : (p36) := (Or.elim h61 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u7 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u16 v))) (fun tail => (False.elim (u17 tail))))))))))
    have u20 : ¬ (p33) := (Or.elim h32 (fun v => v) (fun tail => (False.elim (tail u19))))
    have u21 : (p67) := (Or.elim h63 (fun v => (False.elim (v u19))) (fun tail => tail))
    have u22 : ¬ (p15) := (Or.elim h72 (fun v => v) (fun tail => (False.elim (tail u19))))
    have u23 : ¬ (p68) := (Or.elim h82 (fun v => v) (fun tail => (False.elim (tail u21))))
    have u24 : ¬ (p14) := (Or.elim h12 (fun v => v) (fun tail => (False.elim (u22 tail))))
    have u25 : (p61) := (Or.elim h84 (fun v => (False.elim (u20 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u23 v))) (fun tail => (False.elim (u18 tail))))))))
    have u26 : (p32) := (Or.elim h77 (fun v => (False.elim (u24 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u9 v))) (fun tail => (False.elim (u2 tail))))))))
    have u27 : ¬ (p34) := (Or.elim h58 (fun v => (False.elim (v u25))) (fun tail => tail))
    have u28 : ¬ (p62) := (Or.elim h60 (fun v => (False.elim (v u25))) (fun tail => tail))
    have u29 : ¬ (p31) := (Or.elim h26 (fun v => v) (fun tail => (False.elim (tail u26))))
    have u30 : ¬ (p13) := (Or.elim h28 (fun v => (False.elim (v u26))) (fun tail => tail))
    have u31 : (p12) := (Or.elim rup155 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u30 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u29 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u27 v))) (fun tail => (False.elim (u8 tail))))))))))
    have u32 : ¬ (p29) := (Or.elim h23 (fun v => (False.elim (v u31))) (fun tail => tail))
    have u33 : (p30) := (Or.elim h25 (fun v => (False.elim (v u31))) (fun tail => tail))
    have u34 : ¬ (p4) := (Or.elim h30 (fun v => v) (fun tail => (False.elim (tail u31))))
    have u35 : (p60) := (Or.elim h59 (fun v => (False.elim (u32 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u28 tail))))))
    have u36 : ¬ (p20) := (Or.elim h24 (fun v => v) (fun tail => (False.elim (tail u33))))
    have u37 : ¬ (p2) := (Or.elim h2 (fun v => v) (fun tail => (False.elim (u34 tail))))
    have u38 : (p59) := (Or.elim h57 (fun v => (False.elim (v u35))) (fun tail => tail))
    have u39 : (p10) := (Or.elim h34 (fun v => (False.elim (u37 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u29 v))) (fun tail => (False.elim (u8 tail))))))))
    have u40 : ¬ (p22) := (Or.elim h56 (fun v => v) (fun tail => (False.elim (tail u38))))
    have u41 : ¬ (p9) := (Or.elim h8 (fun v => v) (fun tail => (False.elim (tail u39))))
    have u42 : ¬ (p11) := (Or.elim h9 (fun v => (False.elim (v u39))) (fun tail => tail))
    have u43 : (p1) := (Or.elim h11 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u41 v))) (fun tail => (False.elim (u30 tail))))))
    have u44 : (p3) := (Or.elim h1 (fun v => (False.elim (v u43))) (fun tail => tail))
    have u45 : ¬ (p5) := (Or.elim h3 (fun v => (False.elim (v u44))) (fun tail => tail))
    have u46 : ¬ (p7) := (Or.elim h5 (fun v => (False.elim (v u44))) (fun tail => tail))
    have u47 : ¬ (p26) := (Or.elim rup157 (fun v => v) (fun tail => (False.elim (tail u44))))
    have u48 : ¬ (p21) := (Or.elim h18 (fun v => v) (fun tail => (False.elim (u47 tail))))
    have u49 : (p58) := (Or.elim rup158 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u36 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u47 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u46 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u45 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u42 v))) (fun tail => (False.elim (u40 tail))))))))))))))
    have u50 : ¬ (p28) := (Or.elim h52 (fun v => v) (fun tail => (False.elim (tail u49))))
    have u51 : ¬ (p55) := (Or.elim h53 (fun v => v) (fun tail => (False.elim (tail u49))))
    have u52 : ¬ (p56) := (Or.elim h54 (fun v => v) (fun tail => (False.elim (tail u49))))
    have u53 : ¬ (p57) := (Or.elim h55 (fun v => v) (fun tail => (False.elim (tail u49))))
    have u54 : ¬ (p24) := (Or.elim h22 (fun v => v) (fun tail => (False.elim (u50 tail))))
    have u55 : (p27) := (Or.elim h50 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u50 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u51 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u52 v))) (fun tail => (False.elim (u53 tail))))))))))
    have u56 : (p23) := (Or.elim h16 (fun v => (False.elim (u36 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u48 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u40 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u54 v))) (fun tail => (False.elim (u42 tail))))))))))))
    exact (Or.elim h20 (fun v => (False.elim (v u56))) (fun tail => (False.elim (tail u55))))
  have rup160 : ¬ (p45) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p45) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p90) := rup152
    have u2 : ¬ (p71) := (Or.elim h68 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u3 : (p73) := (Or.elim h74 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u4 : ¬ (p88) := (Or.elim h101 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u5 : ¬ (p85) := (Or.elim rup159 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u6 : ¬ (p86) := (Or.elim h91 (fun v => (False.elim (v u3))) (fun tail => tail))
    have u7 : (p114) := (Or.elim rup154 (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (tail u0))))))
    have u8 : ¬ (p109) := (Or.elim h118 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u9 : ¬ (p110) := (Or.elim h119 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u10 : ¬ (p111) := (Or.elim h120 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u11 : ¬ (p112) := (Or.elim h121 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u12 : ¬ (p113) := (Or.elim h122 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u13 : (p108) := (Or.elim h116 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u9 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u10 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u11 v))) (fun tail => (False.elim (u12 tail))))))))))))
    have u14 : ¬ (p115) := (Or.elim h123 (fun v => (False.elim (v u13))) (fun tail => tail))
    have u15 : ¬ (p94) := (Or.elim h124 (fun v => v) (fun tail => (False.elim (u14 tail))))
    have u16 : ¬ (p89) := (Or.elim h97 (fun v => v) (fun tail => (False.elim (u15 tail))))
    have u17 : (p120) := (Or.elim h126 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u15 v))) (fun tail => tail))))))
    have u18 : ¬ (p96) := (Or.elim h127 (fun v => v) (fun tail => (False.elim (tail u17))))
    have u19 : ¬ (p116) := (Or.elim h128 (fun v => v) (fun tail => (False.elim (tail u17))))
    have u20 : ¬ (p117) := (Or.elim h129 (fun v => v) (fun tail => (False.elim (tail u17))))
    have u21 : ¬ (p118) := (Or.elim h130 (fun v => v) (fun tail => (False.elim (tail u17))))
    have u22 : ¬ (p119) := (Or.elim h131 (fun v => v) (fun tail => (False.elim (tail u17))))
    have u23 : ¬ (p92) := (Or.elim h99 (fun v => v) (fun tail => (False.elim (u18 tail))))
    have u24 : (p95) := (Or.elim h125 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u18 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u19 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u20 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u21 v))) (fun tail => (False.elim (u22 tail))))))))))))
    have u25 : ¬ (p91) := (Or.elim h98 (fun v => v) (fun tail => (False.elim (tail u24))))
    have u26 : ¬ (p93) := (Or.elim h100 (fun v => v) (fun tail => (False.elim (tail u24))))
    exact (Or.elim h95 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u16 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u25 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u23 v))) (fun tail => (False.elim (u26 tail))))))))))))
  have rup161 : ¬ (p40) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p40) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p45) := rup160
    exact (Or.elim h38 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup162 : ¬ (p70) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p70) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p41) := rup148
    have u2 : ¬ (p40) := rup161
    have u3 : ¬ (p39) := rup147
    have u4 : ¬ (p43) := (Or.elim h67 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u5 : ¬ (p42) := (Or.elim h70 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u6 : ¬ (p38) := (Or.elim h36 (fun v => v) (fun tail => (False.elim (u4 tail))))
    have u7 : ¬ (p37) := (Or.elim h35 (fun v => v) (fun tail => (False.elim (u5 tail))))
    exact (Or.elim h33 (fun v => (False.elim (u7 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u1 tail))))))))))
  have rup163 : (p103) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p103) := fun v => denied v
    have u1 : ¬ (p70) := rup162
    have u2 : ¬ (p76) := rup141
    have u3 : ¬ (p40) := rup161
    exact (Or.elim h104 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u0 tail))))))))
  have rup164 : ¬ (p100) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p100) := Classical.byContradiction (fun v => denied v)
    have u1 : (p103) := rup163
    exact (Or.elim h106 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup165 : ¬ (p101) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p101) := Classical.byContradiction (fun v => denied v)
    have u1 : (p103) := rup163
    exact (Or.elim h107 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup166 : ¬ (p102) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p102) := Classical.byContradiction (fun v => denied v)
    have u1 : (p103) := rup163
    exact (Or.elim h108 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup167 : False := by
    have u0 : ¬ (p101) := rup165
    have u1 : ¬ (p102) := rup166
    have u2 : ¬ (p77) := rup143
    have u3 : ¬ (p98) := rup145
    have u4 : ¬ (p99) := rup150
    have u5 : ¬ (p100) := rup164
    exact (Or.elim h103 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u1 tail))))))))))))
  exact rup167

private theorem c0 (k : Nat) : ¬ (Cell (2*k+4) (4*k+10)) ∨ ¬ (Cell (2*k+4) (8*k+21)) := by
  by_cases h : Cell (2*k+4) (4*k+10)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c1 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (2*k+4) (4*k+10)) ∨ (Cell (4*k+8) (4*k+9)) := by
  classical
  by_cases h : Cell (2*k+4) (4*k+10)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(2*k+4) = (4*k+8) := by omega
      have ht : (4*k+10)-1 = (4*k+9) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c2 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (2*k+4) (8*k+21)) ∨ (Cell (4*k+9) (8*k+20)) := by
  classical
  by_cases h : Cell (2*k+4) (8*k+21)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(2*k+4)+1 = (4*k+9) := by omega
      have ht : (8*k+21)-1 = (8*k+20) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c3 (k : Nat) : ¬ (Cell (4*k+8) (4*k+9)) ∨ ¬ (Cell (4*k+8) (8*k+18)) := by
  by_cases h : Cell (4*k+8) (4*k+9)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c4 (k : Nat) : ¬ (Cell (4*k+8) (4*k+9)) ∨ ¬ (Cell (4*k+8) (16*k+35)) := by
  by_cases h : Cell (4*k+8) (4*k+9)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c5 (k : Nat) : ¬ (Cell (4*k+8) (4*k+9)) ∨ ¬ (Cell (4*k+8) (16*k+37)) := by
  by_cases h : Cell (4*k+8) (4*k+9)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c6 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (4*k+8) (4*k+9)) ∨ (Cell (8*k+16) (4*k+8)) := by
  classical
  by_cases h : Cell (4*k+8) (4*k+9)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(4*k+8) = (8*k+16) := by omega
      have ht : (4*k+9)-1 = (4*k+8) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c7 (k : Nat) : ¬ (Cell (4*k+9) (4*k+10)) ∨ ¬ (Cell (4*k+9) (8*k+20)) := by
  by_cases h : Cell (4*k+9) (4*k+10)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c8 (k : Nat) : ¬ (Cell (4*k+9) (4*k+10)) ∨ ¬ (Cell (4*k+9) (8*k+21)) := by
  by_cases h : Cell (4*k+9) (4*k+10)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c9 (k : Nat) : ¬ (Cell (4*k+9) (8*k+21)) ∨ ¬ (Cell (8*k+18) (4*k+9)) := by
  by_cases h : Cell (4*k+9) (8*k+21)
  · right; intro h2
    have ht := half_time (v := (4*k+9)) (t := (8*k+21)) (ch := (8*k+18)) (u := (4*k+9)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c10 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (4*k+9) (8*k+21)) ∨ (Cell (8*k+19) (8*k+20)) := by
  classical
  by_cases h : Cell (4*k+9) (8*k+21)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(4*k+9)+1 = (8*k+19) := by omega
      have ht : (8*k+21)-1 = (8*k+20) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c11 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (2*k+4) (4*k+10)) ∨ (Cell (4*k+9) (4*k+10)) ∨ (Cell (8*k+20) (4*k+10)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (4*k+10) g (by omega)
  unfold Allowed at ha
  have options : z = (2*k+4) ∨ z = (4*k+9) ∨ z = (8*k+20) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c12 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (4*k+10) (16*k+43)) ∨ (Cell (8*k+20) (16*k+42)) := by
  classical
  by_cases h : Cell (4*k+10) (16*k+43)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(4*k+10) = (8*k+20) := by omega
      have ht : (16*k+43)-1 = (16*k+42) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c13 (k : Nat) : ¬ (Cell (8*k+16) (16*k+35)) ∨ ¬ (Cell (8*k+16) (4*k+8)) := by
  by_cases h : Cell (8*k+16) (16*k+35)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c14 (k : Nat) : ¬ (Cell (8*k+17) (8*k+18)) ∨ ¬ (Cell (8*k+17) (16*k+37)) := by
  by_cases h : Cell (8*k+17) (8*k+18)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c15 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (8*k+17) (8*k+18)) ∨ (Cell (16*k+34) (8*k+17)) := by
  classical
  by_cases h : Cell (8*k+17) (8*k+18)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+17) = (16*k+34) := by omega
      have ht : (8*k+18)-1 = (8*k+17) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c16 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (8*k+18) (8*k+19)) ∨ (Cell (8*k+18) (16*k+38)) ∨ (Cell (8*k+18) (16*k+39)) ∨ (Cell (8*k+18) (32*k+75)) ∨ (Cell (8*k+18) (32*k+77)) ∨ (Cell (8*k+18) (4*k+9)) := by
  obtain ⟨z, hz, ha⟩ := row (16*k+43) (8*k+18) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+19) ∨ z = (16*k+38) ∨ z = (16*k+39) ∨ z = (32*k+75) ∨ z = (32*k+77) ∨ z = (4*k+9) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c17 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (4*k+8) (8*k+18)) ∨ (Cell (8*k+17) (8*k+18)) ∨ (Cell (16*k+36) (8*k+18)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (8*k+18) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+8) ∨ z = (8*k+17) ∨ z = (16*k+36) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c18 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (8*k+18) (16*k+38)) ∨ (Cell (16*k+36) (16*k+37)) := by
  classical
  by_cases h : Cell (8*k+18) (16*k+38)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+18) = (16*k+36) := by omega
      have ht : (16*k+38)-1 = (16*k+37) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c19 (k : Nat) : ¬ (Cell (8*k+18) (32*k+75)) ∨ ¬ (Cell (16*k+36) (8*k+18)) := by
  by_cases h : Cell (8*k+18) (32*k+75)
  · right; intro h2
    have ht := half_time (v := (8*k+18)) (t := (32*k+75)) (ch := (16*k+36)) (u := (8*k+18)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c20 (k : Nat) : ¬ (Cell (8*k+18) (32*k+75)) ∨ ¬ (Cell (16*k+37) (16*k+38)) := by
  by_cases h : Cell (8*k+18) (32*k+75)
  · right; intro h2
    have ht := half_time (v := (8*k+18)) (t := (32*k+75)) (ch := (16*k+37)) (u := (16*k+38)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c21 (k : Nat) : ¬ (Cell (8*k+18) (32*k+77)) ∨ ¬ (Cell (16*k+36) (8*k+18)) := by
  by_cases h : Cell (8*k+18) (32*k+77)
  · right; intro h2
    have ht := half_time (v := (8*k+18)) (t := (32*k+77)) (ch := (16*k+36)) (u := (8*k+18)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c22 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (8*k+18) (32*k+77)) ∨ (Cell (16*k+37) (32*k+76)) := by
  classical
  by_cases h : Cell (8*k+18) (32*k+77)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(8*k+18)+1 = (16*k+37) := by omega
      have ht : (32*k+77)-1 = (32*k+76) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c23 (k : Nat) : ¬ (Cell (8*k+19) (8*k+20)) ∨ ¬ (Cell (8*k+19) (16*k+40)) := by
  by_cases h : Cell (8*k+19) (8*k+20)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c24 (k : Nat) : ¬ (Cell (8*k+18) (8*k+19)) ∨ ¬ (Cell (16*k+38) (8*k+19)) := by
  by_cases h : Cell (8*k+18) (8*k+19)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c25 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (8*k+19) (8*k+20)) ∨ (Cell (16*k+38) (8*k+19)) := by
  classical
  by_cases h : Cell (8*k+19) (8*k+20)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+19) = (16*k+38) := by omega
      have ht : (8*k+20)-1 = (8*k+19) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c26 (k : Nat) : ¬ (Cell (8*k+20) (8*k+21)) ∨ ¬ (Cell (8*k+20) (16*k+43)) := by
  by_cases h : Cell (8*k+20) (8*k+21)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c27 (k : Nat) : ¬ (Cell (8*k+20) (16*k+42)) ∨ ¬ (Cell (8*k+20) (32*k+83)) := by
  by_cases h : Cell (8*k+20) (16*k+42)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c28 (k : Nat) : ¬ (Cell (8*k+20) (16*k+43)) ∨ ¬ (Cell (8*k+20) (4*k+10)) := by
  by_cases h : Cell (8*k+20) (16*k+43)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c29 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (4*k+9) (8*k+20)) ∨ (Cell (8*k+19) (8*k+20)) ∨ (Cell (16*k+40) (8*k+20)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (8*k+20) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+9) ∨ z = (8*k+19) ∨ z = (16*k+40) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c30 (k : Nat) : ¬ (Cell (4*k+9) (8*k+20)) ∨ ¬ (Cell (8*k+19) (8*k+20)) := by
  by_cases h : Cell (4*k+9) (8*k+20)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c31 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (8*k+20) (16*k+42)) ∨ (Cell (16*k+40) (16*k+41)) := by
  classical
  by_cases h : Cell (8*k+20) (16*k+42)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+20) = (16*k+40) := by omega
      have ht : (16*k+42)-1 = (16*k+41) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c32 (k : Nat) : ¬ (Cell (8*k+20) (32*k+83)) ∨ ¬ (Cell (16*k+41) (16*k+42)) := by
  by_cases h : Cell (8*k+20) (32*k+83)
  · right; intro h2
    have ht := half_time (v := (8*k+20)) (t := (32*k+83)) (ch := (16*k+41)) (u := (16*k+42)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c33 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (8*k+21) (8*k+22)) ∨ (Cell (8*k+21) (16*k+44)) ∨ (Cell (8*k+21) (16*k+45)) ∨ (Cell (8*k+21) (32*k+87)) ∨ (Cell (8*k+21) (32*k+89)) := by
  obtain ⟨z, hz, ha⟩ := row (16*k+43) (8*k+21) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+22) ∨ z = (16*k+44) ∨ z = (16*k+45) ∨ z = (32*k+87) ∨ z = (32*k+89) := by omega
  rcases options with e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))

private theorem c34 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (2*k+4) (8*k+21)) ∨ (Cell (4*k+9) (8*k+21)) ∨ (Cell (8*k+20) (8*k+21)) ∨ (Cell (16*k+42) (8*k+21)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (8*k+21) g (by omega)
  unfold Allowed at ha
  have options : z = (2*k+4) ∨ z = (4*k+9) ∨ z = (8*k+20) ∨ z = (16*k+42) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c35 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (8*k+21) (8*k+22)) ∨ (Cell (16*k+42) (8*k+21)) := by
  classical
  by_cases h : Cell (8*k+21) (8*k+22)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+21) = (16*k+42) := by omega
      have ht : (8*k+22)-1 = (8*k+21) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c36 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (8*k+21) (16*k+44)) ∨ (Cell (16*k+42) (16*k+43)) := by
  classical
  by_cases h : Cell (8*k+21) (16*k+44)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+21) = (16*k+42) := by omega
      have ht : (16*k+44)-1 = (16*k+43) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c37 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (8*k+21) (16*k+45)) ∨ (Cell (16*k+43) (16*k+44)) := by
  classical
  by_cases h : Cell (8*k+21) (16*k+45)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(8*k+21)+1 = (16*k+43) := by omega
      have ht : (16*k+45)-1 = (16*k+44) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c38 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (8*k+21) (32*k+87)) ∨ (Cell (16*k+42) (32*k+86)) := by
  classical
  by_cases h : Cell (8*k+21) (32*k+87)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+21) = (16*k+42) := by omega
      have ht : (32*k+87)-1 = (32*k+86) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c39 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (8*k+21) (32*k+89)) ∨ (Cell (16*k+43) (32*k+88)) := by
  classical
  by_cases h : Cell (8*k+21) (32*k+89)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(8*k+21)+1 = (16*k+43) := by omega
      have ht : (32*k+89)-1 = (32*k+88) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c40 (k : Nat) : ¬ (Cell (16*k+34) (16*k+35)) ∨ ¬ (Cell (16*k+34) (8*k+17)) := by
  by_cases h : Cell (16*k+34) (16*k+35)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c41 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (16*k+35) (16*k+36)) ∨ (Cell (16*k+35) (32*k+72)) ∨ (Cell (16*k+35) (32*k+73)) ∨ (Cell (16*k+35) (64*k+143)) ∨ (Cell (16*k+35) (64*k+145)) := by
  obtain ⟨z, hz, ha⟩ := row (16*k+43) (16*k+35) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+36) ∨ z = (32*k+72) ∨ z = (32*k+73) ∨ z = (64*k+143) ∨ z = (64*k+145) := by omega
  rcases options with e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))

private theorem c42 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (4*k+8) (16*k+35)) ∨ (Cell (8*k+16) (16*k+35)) ∨ (Cell (16*k+34) (16*k+35)) ∨ (Cell (32*k+70) (16*k+35)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (16*k+35) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+8) ∨ z = (8*k+16) ∨ z = (16*k+34) ∨ z = (32*k+70) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c43 (k : Nat) : ¬ (Cell (16*k+35) (32*k+72)) ∨ ¬ (Cell (32*k+70) (16*k+35)) := by
  by_cases h : Cell (16*k+35) (32*k+72)
  · right; intro h2
    have ht := half_time (v := (16*k+35)) (t := (32*k+72)) (ch := (32*k+70)) (u := (16*k+35)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c44 (k : Nat) : ¬ (Cell (16*k+35) (32*k+73)) ∨ ¬ (Cell (32*k+70) (16*k+35)) := by
  by_cases h : Cell (16*k+35) (32*k+73)
  · right; intro h2
    have ht := half_time (v := (16*k+35)) (t := (32*k+73)) (ch := (32*k+70)) (u := (16*k+35)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c45 (k : Nat) : ¬ (Cell (16*k+35) (64*k+143)) ∨ ¬ (Cell (32*k+70) (16*k+35)) := by
  by_cases h : Cell (16*k+35) (64*k+143)
  · right; intro h2
    have ht := half_time (v := (16*k+35)) (t := (64*k+143)) (ch := (32*k+70)) (u := (16*k+35)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c46 (k : Nat) : ¬ (Cell (16*k+35) (64*k+145)) ∨ ¬ (Cell (32*k+70) (16*k+35)) := by
  by_cases h : Cell (16*k+35) (64*k+145)
  · right; intro h2
    have ht := half_time (v := (16*k+35)) (t := (64*k+145)) (ch := (32*k+70)) (u := (16*k+35)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c47 (k : Nat) : ¬ (Cell (16*k+36) (16*k+37)) ∨ ¬ (Cell (16*k+36) (8*k+18)) := by
  by_cases h : Cell (16*k+36) (16*k+37)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c48 (k : Nat) : ¬ (Cell (16*k+35) (16*k+36)) ∨ ¬ (Cell (32*k+72) (16*k+36)) := by
  by_cases h : Cell (16*k+35) (16*k+36)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c49 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (16*k+36) (16*k+37)) ∨ (Cell (32*k+72) (16*k+36)) := by
  classical
  by_cases h : Cell (16*k+36) (16*k+37)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+36) = (32*k+72) := by omega
      have ht : (16*k+37)-1 = (16*k+36) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c50 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (16*k+37) (16*k+38)) ∨ (Cell (16*k+37) (32*k+76)) ∨ (Cell (16*k+37) (32*k+77)) ∨ (Cell (16*k+37) (64*k+151)) ∨ (Cell (16*k+37) (64*k+153)) := by
  obtain ⟨z, hz, ha⟩ := row (16*k+43) (16*k+37) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+38) ∨ z = (32*k+76) ∨ z = (32*k+77) ∨ z = (64*k+151) ∨ z = (64*k+153) := by omega
  rcases options with e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))

private theorem c51 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (4*k+8) (16*k+37)) ∨ (Cell (8*k+17) (16*k+37)) ∨ (Cell (16*k+36) (16*k+37)) ∨ (Cell (32*k+74) (16*k+37)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (16*k+37) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+8) ∨ z = (8*k+17) ∨ z = (16*k+36) ∨ z = (32*k+74) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c52 (k : Nat) : ¬ (Cell (16*k+37) (32*k+76)) ∨ ¬ (Cell (32*k+74) (16*k+37)) := by
  by_cases h : Cell (16*k+37) (32*k+76)
  · right; intro h2
    have ht := half_time (v := (16*k+37)) (t := (32*k+76)) (ch := (32*k+74)) (u := (16*k+37)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c53 (k : Nat) : ¬ (Cell (16*k+37) (32*k+77)) ∨ ¬ (Cell (32*k+74) (16*k+37)) := by
  by_cases h : Cell (16*k+37) (32*k+77)
  · right; intro h2
    have ht := half_time (v := (16*k+37)) (t := (32*k+77)) (ch := (32*k+74)) (u := (16*k+37)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c54 (k : Nat) : ¬ (Cell (16*k+37) (64*k+151)) ∨ ¬ (Cell (32*k+74) (16*k+37)) := by
  by_cases h : Cell (16*k+37) (64*k+151)
  · right; intro h2
    have ht := half_time (v := (16*k+37)) (t := (64*k+151)) (ch := (32*k+74)) (u := (16*k+37)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c55 (k : Nat) : ¬ (Cell (16*k+37) (64*k+153)) ∨ ¬ (Cell (32*k+74) (16*k+37)) := by
  by_cases h : Cell (16*k+37) (64*k+153)
  · right; intro h2
    have ht := half_time (v := (16*k+37)) (t := (64*k+153)) (ch := (32*k+74)) (u := (16*k+37)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c56 (k : Nat) : ¬ (Cell (8*k+18) (16*k+39)) ∨ ¬ (Cell (32*k+78) (16*k+39)) := by
  by_cases h : Cell (8*k+18) (16*k+39)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c57 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (16*k+39) (16*k+40)) ∨ (Cell (32*k+78) (16*k+39)) := by
  classical
  by_cases h : Cell (16*k+39) (16*k+40)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+39) = (32*k+78) := by omega
      have ht : (16*k+40)-1 = (16*k+39) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c58 (k : Nat) : ¬ (Cell (16*k+40) (32*k+83)) ∨ ¬ (Cell (16*k+40) (8*k+20)) := by
  by_cases h : Cell (16*k+40) (32*k+83)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c59 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (8*k+19) (16*k+40)) ∨ (Cell (16*k+39) (16*k+40)) ∨ (Cell (32*k+80) (16*k+40)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (16*k+40) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+19) ∨ z = (16*k+39) ∨ z = (32*k+80) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c60 (k : Nat) : ¬ (Cell (16*k+40) (32*k+83)) ∨ ¬ (Cell (32*k+80) (16*k+40)) := by
  by_cases h : Cell (16*k+40) (32*k+83)
  · right; intro h2
    have ht := half_time (v := (16*k+40)) (t := (32*k+83)) (ch := (32*k+80)) (u := (16*k+40)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c61 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (16*k+41) (16*k+42)) ∨ (Cell (16*k+41) (32*k+84)) ∨ (Cell (16*k+41) (32*k+85)) ∨ (Cell (16*k+41) (64*k+167)) ∨ (Cell (16*k+41) (64*k+169)) := by
  obtain ⟨z, hz, ha⟩ := row (16*k+43) (16*k+41) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+42) ∨ z = (32*k+84) ∨ z = (32*k+85) ∨ z = (64*k+167) ∨ z = (64*k+169) := by omega
  rcases options with e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))

private theorem c62 (k : Nat) : ¬ (Cell (16*k+41) (16*k+42)) ∨ ¬ (Cell (16*k+41) (64*k+169)) := by
  by_cases h : Cell (16*k+41) (16*k+42)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c63 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (16*k+41) (16*k+42)) ∨ (Cell (32*k+82) (16*k+41)) := by
  classical
  by_cases h : Cell (16*k+41) (16*k+42)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+41) = (32*k+82) := by omega
      have ht : (16*k+42)-1 = (16*k+41) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c64 (k : Nat) : ¬ (Cell (16*k+41) (64*k+169)) ∨ ¬ (Cell (32*k+82) (32*k+83)) := by
  by_cases h : Cell (16*k+41) (64*k+169)
  · right; intro h2
    have ht := half_time (v := (16*k+41)) (t := (64*k+169)) (ch := (32*k+82)) (u := (32*k+83)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c65 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (16*k+41) (64*k+169)) ∨ (Cell (32*k+83) (64*k+168)) := by
  classical
  by_cases h : Cell (16*k+41) (64*k+169)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(16*k+41)+1 = (32*k+83) := by omega
      have ht : (64*k+169)-1 = (64*k+168) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c66 (k : Nat) : ¬ (Cell (16*k+42) (16*k+43)) ∨ ¬ (Cell (16*k+42) (32*k+86)) := by
  by_cases h : Cell (16*k+42) (16*k+43)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c67 (k : Nat) : ¬ (Cell (16*k+42) (16*k+43)) ∨ ¬ (Cell (16*k+42) (32*k+87)) := by
  by_cases h : Cell (16*k+42) (16*k+43)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c68 (k : Nat) : ¬ (Cell (16*k+42) (32*k+86)) ∨ ¬ (Cell (16*k+42) (64*k+171)) := by
  by_cases h : Cell (16*k+42) (32*k+86)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c69 (k : Nat) : ¬ (Cell (16*k+42) (32*k+86)) ∨ ¬ (Cell (16*k+42) (8*k+21)) := by
  by_cases h : Cell (16*k+42) (32*k+86)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c70 (k : Nat) : ¬ (Cell (16*k+42) (32*k+87)) ∨ ¬ (Cell (16*k+42) (8*k+21)) := by
  by_cases h : Cell (16*k+42) (32*k+87)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c71 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (8*k+20) (16*k+42)) ∨ (Cell (16*k+41) (16*k+42)) ∨ (Cell (32*k+84) (16*k+42)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (16*k+42) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+20) ∨ z = (16*k+41) ∨ z = (32*k+84) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c72 (k : Nat) : ¬ (Cell (8*k+20) (16*k+42)) ∨ ¬ (Cell (16*k+41) (16*k+42)) := by
  by_cases h : Cell (8*k+20) (16*k+42)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c73 (k : Nat) : ¬ (Cell (16*k+42) (32*k+86)) ∨ ¬ (Cell (32*k+84) (16*k+42)) := by
  by_cases h : Cell (16*k+42) (32*k+86)
  · right; intro h2
    have ht := half_time (v := (16*k+42)) (t := (32*k+86)) (ch := (32*k+84)) (u := (16*k+42)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c74 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (16*k+42) (32*k+86)) ∨ (Cell (32*k+84) (32*k+85)) := by
  classical
  by_cases h : Cell (16*k+42) (32*k+86)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+42) = (32*k+84) := by omega
      have ht : (32*k+86)-1 = (32*k+85) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c75 (k : Nat) : ¬ (Cell (16*k+43) (16*k+44)) ∨ ¬ (Cell (16*k+43) (64*k+176)) := by
  by_cases h : Cell (16*k+43) (16*k+44)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c76 (k : Nat) : ¬ (Cell (16*k+43) (32*k+88)) ∨ ¬ (Cell (16*k+43) (64*k+176)) := by
  by_cases h : Cell (16*k+43) (32*k+88)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c77 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (4*k+10) (16*k+43)) ∨ (Cell (8*k+20) (16*k+43)) ∨ (Cell (16*k+42) (16*k+43)) ∨ (Cell (32*k+86) (16*k+43)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (16*k+43) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+10) ∨ z = (8*k+20) ∨ z = (16*k+42) ∨ z = (32*k+86) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c78 (k : Nat) : ¬ (Cell (16*k+43) (64*k+176)) ∨ ¬ (Cell (32*k+86) (32*k+87)) := by
  by_cases h : Cell (16*k+43) (64*k+176)
  · right; intro h2
    have ht := half_time (v := (16*k+43)) (t := (64*k+176)) (ch := (32*k+86)) (u := (32*k+87)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c79 (k : Nat) : ¬ (Cell (16*k+43) (64*k+176)) ∨ ¬ (Cell (32*k+86) (16*k+43)) := by
  by_cases h : Cell (16*k+43) (64*k+176)
  · right; intro h2
    have ht := half_time (v := (16*k+43)) (t := (64*k+176)) (ch := (32*k+86)) (u := (16*k+43)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c80 (k : Nat) : ¬ (Cell (16*k+43) (64*k+176)) ∨ ¬ (Cell (32*k+87) (32*k+88)) := by
  by_cases h : Cell (16*k+43) (64*k+176)
  · right; intro h2
    have ht := half_time (v := (16*k+43)) (t := (64*k+176)) (ch := (32*k+87)) (u := (32*k+88)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c81 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (16*k+43) (64*k+176)) ∨ (Cell (32*k+86) (64*k+175)) := by
  classical
  by_cases h : Cell (16*k+43) (64*k+176)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+43) = (32*k+86) := by omega
      have ht : (64*k+176)-1 = (64*k+175) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c82 (k : Nat) : ¬ (Cell (32*k+82) (32*k+83)) ∨ ¬ (Cell (32*k+82) (16*k+41)) := by
  by_cases h : Cell (32*k+82) (32*k+83)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c83 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (32*k+83) (32*k+84)) ∨ (Cell (32*k+83) (64*k+168)) ∨ (Cell (32*k+83) (64*k+169)) ∨ (Cell (32*k+83) (128*k+335)) ∨ (Cell (32*k+83) (128*k+337)) ∨ (Cell (32*k+83) (128*k+336)) := by
  obtain ⟨z, hz, ha⟩ := row (16*k+43) (32*k+83) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+84) ∨ z = (64*k+168) ∨ z = (64*k+169) ∨ z = (128*k+335) ∨ z = (128*k+337) ∨ z = (128*k+336) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c84 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (8*k+20) (32*k+83)) ∨ (Cell (16*k+40) (32*k+83)) ∨ (Cell (32*k+82) (32*k+83)) ∨ (Cell (64*k+166) (32*k+83)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (32*k+83) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+20) ∨ z = (16*k+40) ∨ z = (32*k+82) ∨ z = (64*k+166) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c85 (k : Nat) : ¬ (Cell (32*k+83) (64*k+168)) ∨ ¬ (Cell (64*k+166) (32*k+83)) := by
  by_cases h : Cell (32*k+83) (64*k+168)
  · right; intro h2
    have ht := half_time (v := (32*k+83)) (t := (64*k+168)) (ch := (64*k+166)) (u := (32*k+83)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c86 (k : Nat) : ¬ (Cell (32*k+83) (64*k+169)) ∨ ¬ (Cell (64*k+166) (32*k+83)) := by
  by_cases h : Cell (32*k+83) (64*k+169)
  · right; intro h2
    have ht := half_time (v := (32*k+83)) (t := (64*k+169)) (ch := (64*k+166)) (u := (32*k+83)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c87 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (32*k+83) (64*k+169)) ∨ (Cell (64*k+167) (64*k+168)) := by
  classical
  by_cases h : Cell (32*k+83) (64*k+169)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(32*k+83)+1 = (64*k+167) := by omega
      have ht : (64*k+169)-1 = (64*k+168) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c88 (k : Nat) : ¬ (Cell (32*k+83) (128*k+335)) ∨ ¬ (Cell (64*k+167) (64*k+168)) := by
  by_cases h : Cell (32*k+83) (128*k+335)
  · right; intro h2
    have ht := half_time (v := (32*k+83)) (t := (128*k+335)) (ch := (64*k+167)) (u := (64*k+168)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c89 (k : Nat) : ¬ (Cell (32*k+83) (128*k+337)) ∨ ¬ (Cell (64*k+167) (64*k+168)) := by
  by_cases h : Cell (32*k+83) (128*k+337)
  · right; intro h2
    have ht := half_time (v := (32*k+83)) (t := (128*k+337)) (ch := (64*k+167)) (u := (64*k+168)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c90 (k : Nat) : ¬ (Cell (32*k+83) (128*k+336)) ∨ ¬ (Cell (64*k+167) (64*k+168)) := by
  by_cases h : Cell (32*k+83) (128*k+336)
  · right; intro h2
    have ht := half_time (v := (32*k+83)) (t := (128*k+336)) (ch := (64*k+167)) (u := (64*k+168)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c91 (k : Nat) : ¬ (Cell (32*k+84) (32*k+85)) ∨ ¬ (Cell (32*k+84) (64*k+171)) := by
  by_cases h : Cell (32*k+84) (32*k+85)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c92 (k : Nat) : ¬ (Cell (16*k+41) (32*k+84)) ∨ ¬ (Cell (64*k+168) (32*k+84)) := by
  by_cases h : Cell (16*k+41) (32*k+84)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c93 (k : Nat) : ¬ (Cell (32*k+83) (32*k+84)) ∨ ¬ (Cell (64*k+168) (32*k+84)) := by
  by_cases h : Cell (32*k+83) (32*k+84)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c94 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (32*k+84) (32*k+85)) ∨ (Cell (64*k+168) (32*k+84)) := by
  classical
  by_cases h : Cell (32*k+84) (32*k+85)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+84) = (64*k+168) := by omega
      have ht : (32*k+85)-1 = (32*k+84) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c95 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (32*k+85) (32*k+86)) ∨ (Cell (32*k+85) (64*k+172)) ∨ (Cell (32*k+85) (64*k+173)) ∨ (Cell (32*k+85) (128*k+343)) ∨ (Cell (32*k+85) (128*k+345)) ∨ (Cell (32*k+85) (128*k+344)) := by
  obtain ⟨z, hz, ha⟩ := row (16*k+43) (32*k+85) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+86) ∨ z = (64*k+172) ∨ z = (64*k+173) ∨ z = (128*k+343) ∨ z = (128*k+345) ∨ z = (128*k+344) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c96 (k : Nat) : ¬ (Cell (16*k+41) (32*k+85)) ∨ ¬ (Cell (32*k+84) (32*k+85)) := by
  by_cases h : Cell (16*k+41) (32*k+85)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c97 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (32*k+85) (64*k+172)) ∨ (Cell (64*k+170) (64*k+171)) := by
  classical
  by_cases h : Cell (32*k+85) (64*k+172)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+85) = (64*k+170) := by omega
      have ht : (64*k+172)-1 = (64*k+171) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c98 (k : Nat) : ¬ (Cell (32*k+85) (128*k+343)) ∨ ¬ (Cell (64*k+171) (64*k+172)) := by
  by_cases h : Cell (32*k+85) (128*k+343)
  · right; intro h2
    have ht := half_time (v := (32*k+85)) (t := (128*k+343)) (ch := (64*k+171)) (u := (64*k+172)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c99 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (32*k+85) (128*k+345)) ∨ (Cell (64*k+171) (128*k+344)) := by
  classical
  by_cases h : Cell (32*k+85) (128*k+345)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(32*k+85)+1 = (64*k+171) := by omega
      have ht : (128*k+345)-1 = (128*k+344) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c100 (k : Nat) : ¬ (Cell (32*k+85) (128*k+344)) ∨ ¬ (Cell (64*k+171) (64*k+172)) := by
  by_cases h : Cell (32*k+85) (128*k+344)
  · right; intro h2
    have ht := half_time (v := (32*k+85)) (t := (128*k+344)) (ch := (64*k+171)) (u := (64*k+172)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c101 (k : Nat) : ¬ (Cell (16*k+42) (32*k+86)) ∨ ¬ (Cell (32*k+85) (32*k+86)) := by
  by_cases h : Cell (16*k+42) (32*k+86)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c102 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (32*k+86) (64*k+175)) ∨ (Cell (64*k+173) (64*k+174)) := by
  classical
  by_cases h : Cell (32*k+86) (64*k+175)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(32*k+86)+1 = (64*k+173) := by omega
      have ht : (64*k+175)-1 = (64*k+174) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c103 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (32*k+87) (32*k+88)) ∨ (Cell (32*k+87) (64*k+176)) ∨ (Cell (32*k+87) (64*k+177)) ∨ (Cell (32*k+87) (128*k+351)) ∨ (Cell (32*k+87) (128*k+353)) ∨ (Cell (32*k+87) (128*k+352)) := by
  obtain ⟨z, hz, ha⟩ := row (16*k+43) (32*k+87) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+88) ∨ z = (64*k+176) ∨ z = (64*k+177) ∨ z = (128*k+351) ∨ z = (128*k+353) ∨ z = (128*k+352) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c104 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (8*k+21) (32*k+87)) ∨ (Cell (16*k+42) (32*k+87)) ∨ (Cell (32*k+86) (32*k+87)) ∨ (Cell (64*k+174) (32*k+87)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (32*k+87) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+21) ∨ z = (16*k+42) ∨ z = (32*k+86) ∨ z = (64*k+174) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c105 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (32*k+87) (64*k+177)) ∨ (Cell (64*k+175) (64*k+176)) := by
  classical
  by_cases h : Cell (32*k+87) (64*k+177)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(32*k+87)+1 = (64*k+175) := by omega
      have ht : (64*k+177)-1 = (64*k+176) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c106 (k : Nat) : ¬ (Cell (32*k+87) (128*k+351)) ∨ ¬ (Cell (64*k+174) (32*k+87)) := by
  by_cases h : Cell (32*k+87) (128*k+351)
  · right; intro h2
    have ht := half_time (v := (32*k+87)) (t := (128*k+351)) (ch := (64*k+174)) (u := (32*k+87)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c107 (k : Nat) : ¬ (Cell (32*k+87) (128*k+353)) ∨ ¬ (Cell (64*k+174) (32*k+87)) := by
  by_cases h : Cell (32*k+87) (128*k+353)
  · right; intro h2
    have ht := half_time (v := (32*k+87)) (t := (128*k+353)) (ch := (64*k+174)) (u := (32*k+87)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c108 (k : Nat) : ¬ (Cell (32*k+87) (128*k+352)) ∨ ¬ (Cell (64*k+174) (32*k+87)) := by
  by_cases h : Cell (32*k+87) (128*k+352)
  · right; intro h2
    have ht := half_time (v := (32*k+87)) (t := (128*k+352)) (ch := (64*k+174)) (u := (32*k+87)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c109 (k : Nat) : ¬ (Cell (16*k+41) (64*k+167)) ∨ ¬ (Cell (128*k+334) (64*k+167)) := by
  by_cases h : Cell (16*k+41) (64*k+167)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c110 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (64*k+167) (64*k+168)) ∨ (Cell (128*k+334) (64*k+167)) := by
  classical
  by_cases h : Cell (64*k+167) (64*k+168)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(64*k+167) = (128*k+334) := by omega
      have ht : (64*k+168)-1 = (64*k+167) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c111 (k : Nat) : ¬ (Cell (64*k+168) (64*k+169)) ∨ ¬ (Cell (64*k+168) (32*k+84)) := by
  by_cases h : Cell (64*k+168) (64*k+169)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c112 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (32*k+83) (64*k+168)) ∨ (Cell (64*k+167) (64*k+168)) ∨ (Cell (128*k+336) (64*k+168)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (64*k+168) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+83) ∨ z = (64*k+167) ∨ z = (128*k+336) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c113 (k : Nat) : ¬ (Cell (32*k+83) (64*k+168)) ∨ ¬ (Cell (64*k+167) (64*k+168)) := by
  by_cases h : Cell (32*k+83) (64*k+168)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c114 (k : Nat) : ¬ (Cell (32*k+83) (64*k+168)) ∨ ¬ (Cell (128*k+336) (64*k+168)) := by
  by_cases h : Cell (32*k+83) (64*k+168)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c115 (k : Nat) : ¬ (Cell (64*k+167) (64*k+168)) ∨ ¬ (Cell (128*k+336) (64*k+168)) := by
  by_cases h : Cell (64*k+167) (64*k+168)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c116 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (64*k+169) (64*k+170)) ∨ (Cell (64*k+169) (128*k+340)) ∨ (Cell (64*k+169) (128*k+341)) ∨ (Cell (64*k+169) (256*k+679)) ∨ (Cell (64*k+169) (256*k+681)) ∨ (Cell (64*k+169) (256*k+680)) := by
  obtain ⟨z, hz, ha⟩ := row (16*k+43) (64*k+169) g (by omega)
  unfold Allowed at ha
  have options : z = (64*k+170) ∨ z = (128*k+340) ∨ z = (128*k+341) ∨ z = (256*k+679) ∨ z = (256*k+681) ∨ z = (256*k+680) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c117 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (16*k+41) (64*k+169)) ∨ (Cell (32*k+83) (64*k+169)) ∨ (Cell (64*k+168) (64*k+169)) ∨ (Cell (128*k+338) (64*k+169)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (64*k+169) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+41) ∨ z = (32*k+83) ∨ z = (64*k+168) ∨ z = (128*k+338) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c118 (k : Nat) : ¬ (Cell (64*k+169) (128*k+340)) ∨ ¬ (Cell (128*k+338) (64*k+169)) := by
  by_cases h : Cell (64*k+169) (128*k+340)
  · right; intro h2
    have ht := half_time (v := (64*k+169)) (t := (128*k+340)) (ch := (128*k+338)) (u := (64*k+169)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c119 (k : Nat) : ¬ (Cell (64*k+169) (128*k+341)) ∨ ¬ (Cell (128*k+338) (64*k+169)) := by
  by_cases h : Cell (64*k+169) (128*k+341)
  · right; intro h2
    have ht := half_time (v := (64*k+169)) (t := (128*k+341)) (ch := (128*k+338)) (u := (64*k+169)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c120 (k : Nat) : ¬ (Cell (64*k+169) (256*k+679)) ∨ ¬ (Cell (128*k+338) (64*k+169)) := by
  by_cases h : Cell (64*k+169) (256*k+679)
  · right; intro h2
    have ht := half_time (v := (64*k+169)) (t := (256*k+679)) (ch := (128*k+338)) (u := (64*k+169)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c121 (k : Nat) : ¬ (Cell (64*k+169) (256*k+681)) ∨ ¬ (Cell (128*k+338) (64*k+169)) := by
  by_cases h : Cell (64*k+169) (256*k+681)
  · right; intro h2
    have ht := half_time (v := (64*k+169)) (t := (256*k+681)) (ch := (128*k+338)) (u := (64*k+169)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c122 (k : Nat) : ¬ (Cell (64*k+169) (256*k+680)) ∨ ¬ (Cell (128*k+338) (64*k+169)) := by
  by_cases h : Cell (64*k+169) (256*k+680)
  · right; intro h2
    have ht := half_time (v := (64*k+169)) (t := (256*k+680)) (ch := (128*k+338)) (u := (64*k+169)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c123 (k : Nat) : ¬ (Cell (64*k+169) (64*k+170)) ∨ ¬ (Cell (128*k+340) (64*k+170)) := by
  by_cases h : Cell (64*k+169) (64*k+170)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c124 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (64*k+170) (64*k+171)) ∨ (Cell (128*k+340) (64*k+170)) := by
  classical
  by_cases h : Cell (64*k+170) (64*k+171)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(64*k+170) = (128*k+340) := by omega
      have ht : (64*k+171)-1 = (64*k+170) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c125 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (64*k+171) (64*k+172)) ∨ (Cell (64*k+171) (128*k+344)) ∨ (Cell (64*k+171) (128*k+345)) ∨ (Cell (64*k+171) (256*k+687)) ∨ (Cell (64*k+171) (256*k+689)) ∨ (Cell (64*k+171) (256*k+688)) := by
  obtain ⟨z, hz, ha⟩ := row (16*k+43) (64*k+171) g (by omega)
  unfold Allowed at ha
  have options : z = (64*k+172) ∨ z = (128*k+344) ∨ z = (128*k+345) ∨ z = (256*k+687) ∨ z = (256*k+689) ∨ z = (256*k+688) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c126 (k : Nat) (g : GoodBelow (16*k+43)) : (Cell (16*k+42) (64*k+171)) ∨ (Cell (32*k+84) (64*k+171)) ∨ (Cell (64*k+170) (64*k+171)) ∨ (Cell (128*k+342) (64*k+171)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (16*k+43) (64*k+171) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+42) ∨ z = (32*k+84) ∨ z = (64*k+170) ∨ z = (128*k+342) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c127 (k : Nat) : ¬ (Cell (64*k+171) (128*k+344)) ∨ ¬ (Cell (128*k+342) (64*k+171)) := by
  by_cases h : Cell (64*k+171) (128*k+344)
  · right; intro h2
    have ht := half_time (v := (64*k+171)) (t := (128*k+344)) (ch := (128*k+342)) (u := (64*k+171)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c128 (k : Nat) : ¬ (Cell (64*k+171) (128*k+345)) ∨ ¬ (Cell (128*k+342) (64*k+171)) := by
  by_cases h : Cell (64*k+171) (128*k+345)
  · right; intro h2
    have ht := half_time (v := (64*k+171)) (t := (128*k+345)) (ch := (128*k+342)) (u := (64*k+171)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c129 (k : Nat) : ¬ (Cell (64*k+171) (256*k+687)) ∨ ¬ (Cell (128*k+342) (64*k+171)) := by
  by_cases h : Cell (64*k+171) (256*k+687)
  · right; intro h2
    have ht := half_time (v := (64*k+171)) (t := (256*k+687)) (ch := (128*k+342)) (u := (64*k+171)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c130 (k : Nat) : ¬ (Cell (64*k+171) (256*k+689)) ∨ ¬ (Cell (128*k+342) (64*k+171)) := by
  by_cases h : Cell (64*k+171) (256*k+689)
  · right; intro h2
    have ht := half_time (v := (64*k+171)) (t := (256*k+689)) (ch := (128*k+342)) (u := (64*k+171)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c131 (k : Nat) : ¬ (Cell (64*k+171) (256*k+688)) ∨ ¬ (Cell (128*k+342) (64*k+171)) := by
  by_cases h : Cell (64*k+171) (256*k+688)
  · right; intro h2
    have ht := half_time (v := (64*k+171)) (t := (256*k+688)) (ch := (128*k+342)) (u := (64*k+171)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c132 (k : Nat) : ¬ (Cell (32*k+85) (64*k+173)) ∨ ¬ (Cell (128*k+346) (64*k+173)) := by
  by_cases h : Cell (32*k+85) (64*k+173)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c133 (k : Nat) (g : GoodBelow (16*k+43)) : ¬ (Cell (64*k+173) (64*k+174)) ∨ (Cell (128*k+346) (64*k+173)) := by
  classical
  by_cases h : Cell (64*k+173) (64*k+174)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(64*k+173) = (128*k+346) := by omega
      have ht : (64*k+174)-1 = (64*k+173) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c134 (k : Nat) : ¬ (Cell (16*k+43) (64*k+176)) ∨ ¬ (Cell (32*k+87) (64*k+176)) := by
  by_cases h : Cell (16*k+43) (64*k+176)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c135 (k : Nat) : ¬ (Cell (16*k+43) (64*k+176)) ∨ ¬ (Cell (64*k+175) (64*k+176)) := by
  by_cases h : Cell (16*k+43) (64*k+176)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c136 (k : Nat) : ¬ (Cell (16*k+40) (16*k+41)) ∨ ¬ (Cell (16*k+40) (32*k+83)) := by
  by_cases h : Cell (16*k+40) (16*k+41)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

theorem exclude (k : Nat) (g : GoodBelow (16*k+43)) (bad : Cell (16*k+43) (4*(16*k+43)+4)) : False := by
  have badNormalized : Cell (16*k+43) (64*k+176) := by
    rw [show (64*k+176) = 4*(16*k+43)+4 by omega]
    exact bad
  exact privateReplay
    (Cell (2*k+4) (4*k+10))
    (Cell (2*k+4) (8*k+21))
    (Cell (4*k+8) (4*k+9))
    (Cell (4*k+9) (8*k+20))
    (Cell (4*k+8) (8*k+18))
    (Cell (4*k+8) (16*k+35))
    (Cell (4*k+8) (16*k+37))
    (Cell (8*k+16) (4*k+8))
    (Cell (4*k+9) (4*k+10))
    (Cell (4*k+9) (8*k+21))
    (Cell (8*k+18) (4*k+9))
    (Cell (8*k+19) (8*k+20))
    (Cell (8*k+20) (4*k+10))
    (Cell (4*k+10) (16*k+43))
    (Cell (8*k+20) (16*k+42))
    (Cell (8*k+16) (16*k+35))
    (Cell (8*k+17) (8*k+18))
    (Cell (8*k+17) (16*k+37))
    (Cell (16*k+34) (8*k+17))
    (Cell (8*k+18) (8*k+19))
    (Cell (8*k+18) (16*k+38))
    (Cell (8*k+18) (16*k+39))
    (Cell (8*k+18) (32*k+75))
    (Cell (8*k+18) (32*k+77))
    (Cell (16*k+36) (8*k+18))
    (Cell (16*k+36) (16*k+37))
    (Cell (16*k+37) (16*k+38))
    (Cell (16*k+37) (32*k+76))
    (Cell (8*k+19) (16*k+40))
    (Cell (16*k+38) (8*k+19))
    (Cell (8*k+20) (8*k+21))
    (Cell (8*k+20) (16*k+43))
    (Cell (8*k+20) (32*k+83))
    (Cell (16*k+40) (8*k+20))
    (Cell (16*k+40) (16*k+41))
    (Cell (16*k+41) (16*k+42))
    (Cell (8*k+21) (8*k+22))
    (Cell (8*k+21) (16*k+44))
    (Cell (8*k+21) (16*k+45))
    (Cell (8*k+21) (32*k+87))
    (Cell (8*k+21) (32*k+89))
    (Cell (16*k+42) (8*k+21))
    (Cell (16*k+42) (16*k+43))
    (Cell (16*k+43) (16*k+44))
    (Cell (16*k+42) (32*k+86))
    (Cell (16*k+43) (32*k+88))
    (Cell (16*k+34) (16*k+35))
    (Cell (16*k+35) (16*k+36))
    (Cell (16*k+35) (32*k+72))
    (Cell (16*k+35) (32*k+73))
    (Cell (16*k+35) (64*k+143))
    (Cell (16*k+35) (64*k+145))
    (Cell (32*k+70) (16*k+35))
    (Cell (32*k+72) (16*k+36))
    (Cell (16*k+37) (32*k+77))
    (Cell (16*k+37) (64*k+151))
    (Cell (16*k+37) (64*k+153))
    (Cell (32*k+74) (16*k+37))
    (Cell (32*k+78) (16*k+39))
    (Cell (16*k+39) (16*k+40))
    (Cell (16*k+40) (32*k+83))
    (Cell (32*k+80) (16*k+40))
    (Cell (16*k+41) (32*k+84))
    (Cell (16*k+41) (32*k+85))
    (Cell (16*k+41) (64*k+167))
    (Cell (16*k+41) (64*k+169))
    (Cell (32*k+82) (16*k+41))
    (Cell (32*k+82) (32*k+83))
    (Cell (32*k+83) (64*k+168))
    (Cell (16*k+42) (32*k+87))
    (Cell (16*k+42) (64*k+171))
    (Cell (32*k+84) (16*k+42))
    (Cell (32*k+84) (32*k+85))
    (Cell (16*k+43) (64*k+176))
    (Cell (32*k+86) (16*k+43))
    (Cell (32*k+86) (32*k+87))
    (Cell (32*k+87) (32*k+88))
    (Cell (32*k+86) (64*k+175))
    (Cell (32*k+83) (32*k+84))
    (Cell (32*k+83) (64*k+169))
    (Cell (32*k+83) (128*k+335))
    (Cell (32*k+83) (128*k+337))
    (Cell (32*k+83) (128*k+336))
    (Cell (64*k+166) (32*k+83))
    (Cell (64*k+167) (64*k+168))
    (Cell (32*k+84) (64*k+171))
    (Cell (64*k+168) (32*k+84))
    (Cell (32*k+85) (32*k+86))
    (Cell (32*k+85) (64*k+172))
    (Cell (32*k+85) (64*k+173))
    (Cell (32*k+85) (128*k+343))
    (Cell (32*k+85) (128*k+345))
    (Cell (32*k+85) (128*k+344))
    (Cell (64*k+170) (64*k+171))
    (Cell (64*k+171) (64*k+172))
    (Cell (64*k+171) (128*k+344))
    (Cell (64*k+173) (64*k+174))
    (Cell (32*k+87) (64*k+176))
    (Cell (32*k+87) (64*k+177))
    (Cell (32*k+87) (128*k+351))
    (Cell (32*k+87) (128*k+353))
    (Cell (32*k+87) (128*k+352))
    (Cell (64*k+174) (32*k+87))
    (Cell (64*k+175) (64*k+176))
    (Cell (128*k+334) (64*k+167))
    (Cell (64*k+168) (64*k+169))
    (Cell (128*k+336) (64*k+168))
    (Cell (64*k+169) (64*k+170))
    (Cell (64*k+169) (128*k+340))
    (Cell (64*k+169) (128*k+341))
    (Cell (64*k+169) (256*k+679))
    (Cell (64*k+169) (256*k+681))
    (Cell (64*k+169) (256*k+680))
    (Cell (128*k+338) (64*k+169))
    (Cell (128*k+340) (64*k+170))
    (Cell (64*k+171) (128*k+345))
    (Cell (64*k+171) (256*k+687))
    (Cell (64*k+171) (256*k+689))
    (Cell (64*k+171) (256*k+688))
    (Cell (128*k+342) (64*k+171))
    (Cell (128*k+346) (64*k+173))
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
    (c12 k g)
    (c13 k)
    (c14 k)
    (c15 k g)
    (c16 k g)
    (c17 k g)
    (c18 k g)
    (c19 k)
    (c20 k)
    (c21 k)
    (c22 k g)
    (c23 k)
    (c24 k)
    (c25 k g)
    (c26 k)
    (c27 k)
    (c28 k)
    (c29 k g)
    (c30 k)
    (c31 k g)
    (c32 k)
    (c33 k g)
    (c34 k g)
    (c35 k g)
    (c36 k g)
    (c37 k g)
    (c38 k g)
    (c39 k g)
    (c40 k)
    (c41 k g)
    (c42 k g)
    (c43 k)
    (c44 k)
    (c45 k)
    (c46 k)
    (c47 k)
    (c48 k)
    (c49 k g)
    (c50 k g)
    (c51 k g)
    (c52 k)
    (c53 k)
    (c54 k)
    (c55 k)
    (c56 k)
    (c57 k g)
    (c58 k)
    (c59 k g)
    (c60 k)
    (c61 k g)
    (c62 k)
    (c63 k g)
    (c64 k)
    (c65 k g)
    (c66 k)
    (c67 k)
    (c68 k)
    (c69 k)
    (c70 k)
    (c71 k g)
    (c72 k)
    (c73 k)
    (c74 k g)
    (c75 k)
    (c76 k)
    (c77 k g)
    (c78 k)
    (c79 k)
    (c80 k)
    (c81 k g)
    (c82 k)
    (c83 k g)
    (c84 k g)
    (c85 k)
    (c86 k)
    (c87 k g)
    (c88 k)
    (c89 k)
    (c90 k)
    (c91 k)
    (c92 k)
    (c93 k)
    (c94 k g)
    (c95 k g)
    (c96 k)
    (c97 k g)
    (c98 k)
    (c99 k g)
    (c100 k)
    (c101 k)
    (c102 k g)
    (c103 k g)
    (c104 k g)
    (c105 k g)
    (c106 k)
    (c107 k)
    (c108 k)
    (c109 k)
    (c110 k g)
    (c111 k)
    (c112 k g)
    (c113 k)
    (c114 k)
    (c115 k)
    (c116 k g)
    (c117 k g)
    (c118 k)
    (c119 k)
    (c120 k)
    (c121 k)
    (c122 k)
    (c123 k)
    (c124 k g)
    (c125 k g)
    (c126 k g)
    (c127 k)
    (c128 k)
    (c129 k)
    (c130 k)
    (c131 k)
    (c132 k)
    (c133 k g)
    (c134 k)
    (c135 k)
    (c136 k)
    badNormalized
end P16R11
end Inverse
