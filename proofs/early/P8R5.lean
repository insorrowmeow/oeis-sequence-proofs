import InverseBase

set_option linter.unusedVariables false
set_option maxHeartbeats 2000000
set_option maxRecDepth 8000
namespace Inverse
namespace P8R5

theorem privateReplay (p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40 p41 p42 p43 p44 p45 p46 p47 p48 p49 p50 p51 p52 p53 p54 p55 p56 p57 p58 p59 p60 p61 p62 p63 p64 p65 p66 p67 p68 p69 p70 p71 p72 p73 p74 p75 p76 p77 p78 p79 p80 p81 p82 p83 p84 p85 p86 p87 p88 p89 p90 p91 p92 p93 p94 p95 p96 p97 p98 p99 p100 p101 p102 p103 p104 p105 p106 p107 p108 p109 p110 p111 p112 p113 p114 p115 p116 p117 p118 p119 p120 p121 p122 p123 p124 p125 p126 p127 p128 p129 p130 p131 p132 p133 p134 p135 p136 p137 p138 p139 p140 p141 p142 p143 p144 p145 p146 p147 p148 p149 p150 p151 p152 p153 p154 p155 p156 p157 p158 p159 p160 p161 p162 p163 p164 p165 p166 p167 p168 p169 p170 p171 p172 p173 p174 p175 p176 p177 : Prop)
    (h0 : ¬ (p1) ∨ ¬ (p2))
    (h1 : ¬ (p1) ∨ (p3))
    (h2 : ¬ (p2) ∨ (p4))
    (h3 : ¬ (p3) ∨ ¬ (p5))
    (h4 : ¬ (p3) ∨ ¬ (p6))
    (h5 : ¬ (p3) ∨ (p7))
    (h6 : ¬ (p8) ∨ ¬ (p4))
    (h7 : ¬ (p8) ∨ ¬ (p9))
    (h8 : ¬ (p9) ∨ (p10))
    (h9 : ¬ (p11) ∨ ¬ (p10))
    (h10 : (p1) ∨ (p8) ∨ (p12))
    (h11 : ¬ (p13) ∨ (p14))
    (h12 : ¬ (p15) ∨ ¬ (p7))
    (h13 : ¬ (p16) ∨ ¬ (p17))
    (h14 : ¬ (p16) ∨ ¬ (p18))
    (h15 : ¬ (p16) ∨ (p19))
    (h16 : (p5) ∨ (p16) ∨ (p20))
    (h17 : ¬ (p21) ∨ ¬ (p22))
    (h18 : ¬ (p21) ∨ ¬ (p20))
    (h19 : ¬ (p21) ∨ (p23))
    (h20 : ¬ (p10) ∨ ¬ (p24))
    (h21 : ¬ (p10) ∨ ¬ (p25))
    (h22 : ¬ (p10) ∨ ¬ (p26))
    (h23 : ¬ (p10) ∨ (p27))
    (h24 : ¬ (p28) ∨ ¬ (p14))
    (h25 : ¬ (p28) ∨ ¬ (p29))
    (h26 : ¬ (p14) ∨ ¬ (p12))
    (h27 : ¬ (p29) ∨ ¬ (p12))
    (h28 : (p4) ∨ (p10) ∨ (p30))
    (h29 : ¬ (p4) ∨ ¬ (p10))
    (h30 : ¬ (p14) ∨ ¬ (p30))
    (h31 : ¬ (p14) ∨ (p31))
    (h32 : ¬ (p29) ∨ ¬ (p30))
    (h33 : (p2) ∨ (p9) ∨ (p28) ∨ (p32))
    (h34 : ¬ (p33) ∨ ¬ (p34))
    (h35 : ¬ (p33) ∨ ¬ (p32))
    (h36 : ¬ (p33) ∨ ¬ (p35))
    (h37 : ¬ (p33) ∨ (p36))
    (h38 : ¬ (p37) ∨ ¬ (p19))
    (h39 : ¬ (p38) ∨ ¬ (p19))
    (h40 : (p6) ∨ (p15) ∨ (p37) ∨ (p39))
    (h41 : ¬ (p40) ∨ ¬ (p39))
    (h42 : (p22) ∨ (p41) ∨ (p42) ∨ (p43) ∨ (p44) ∨ (p45) ∨ (p20))
    (h43 : ¬ (p41) ∨ (p46))
    (h44 : ¬ (p43) ∨ ¬ (p47))
    (h45 : ¬ (p44) ∨ (p48))
    (h46 : ¬ (p45) ∨ ¬ (p47))
    (h47 : ¬ (p23) ∨ ¬ (p49))
    (h48 : ¬ (p50) ∨ ¬ (p27))
    (h49 : ¬ (p51) ∨ ¬ (p27))
    (h50 : ¬ (p52) ∨ ¬ (p27))
    (h51 : ¬ (p23) ∨ ¬ (p53))
    (h52 : ¬ (p54) ∨ ¬ (p55))
    (h53 : (p11) ∨ (p21) ∨ (p50) ∨ (p56))
    (h54 : ¬ (p54) ∨ (p56))
    (h55 : ¬ (p55) ∨ ¬ (p57))
    (h56 : ¬ (p55) ∨ ¬ (p56))
    (h57 : (p31) ∨ (p58) ∨ (p59) ∨ (p60) ∨ (p61) ∨ (p62) ∨ (p30))
    (h58 : (p24) ∨ (p54) ∨ (p63))
    (h59 : ¬ (p31) ∨ (p63))
    (h60 : ¬ (p58) ∨ ¬ (p63))
    (h61 : ¬ (p58) ∨ (p64))
    (h62 : ¬ (p60) ∨ ¬ (p64))
    (h63 : ¬ (p60) ∨ ¬ (p63))
    (h64 : ¬ (p60) ∨ ¬ (p65))
    (h65 : ¬ (p61) ∨ ¬ (p64))
    (h66 : ¬ (p61) ∨ ¬ (p63))
    (h67 : ¬ (p61) ∨ ¬ (p65))
    (h68 : ¬ (p62) ∨ ¬ (p64))
    (h69 : ¬ (p62) ∨ ¬ (p63))
    (h70 : ¬ (p62) ∨ ¬ (p65))
    (h71 : (p66) ∨ (p67) ∨ (p68) ∨ (p69) ∨ (p70) ∨ (p71))
    (h72 : ¬ (p66) ∨ ¬ (p67))
    (h73 : ¬ (p31) ∨ ¬ (p72))
    (h74 : ¬ (p66) ∨ (p72))
    (h75 : ¬ (p67) ∨ (p73))
    (h76 : ¬ (p69) ∨ ¬ (p74))
    (h77 : ¬ (p70) ∨ ¬ (p74))
    (h78 : ¬ (p71) ∨ ¬ (p74))
    (h79 : ¬ (p36) ∨ ¬ (p75))
    (h80 : (p14) ∨ (p66) ∨ (p76))
    (h81 : ¬ (p14) ∨ ¬ (p66))
    (h82 : ¬ (p36) ∨ ¬ (p77))
    (h83 : ¬ (p36) ∨ ¬ (p76))
    (h84 : ¬ (p36) ∨ (p78))
    (h85 : (p35) ∨ (p79) ∨ (p80) ∨ (p81) ∨ (p82) ∨ (p83))
    (h86 : (p13) ∨ (p29) ∨ (p34) ∨ (p84))
    (h87 : ¬ (p80) ∨ (p85))
    (h88 : ¬ (p81) ∨ ¬ (p84))
    (h89 : ¬ (p82) ∨ ¬ (p84))
    (h90 : ¬ (p83) ∨ (p86))
    (h91 : ¬ (p87) ∨ ¬ (p39))
    (h92 : (p88) ∨ (p89) ∨ (p90) ∨ (p91) ∨ (p92) ∨ (p93))
    (h93 : (p17) ∨ (p38) ∨ (p87) ∨ (p94))
    (h94 : ¬ (p89) ∨ ¬ (p94))
    (h95 : ¬ (p90) ∨ ¬ (p94))
    (h96 : ¬ (p91) ∨ ¬ (p94))
    (h97 : ¬ (p92) ∨ ¬ (p94))
    (h98 : ¬ (p93) ∨ ¬ (p94))
    (h99 : ¬ (p88) ∨ ¬ (p95))
    (h100 : ¬ (p46) ∨ (p95))
    (h101 : (p47) ∨ (p48) ∨ (p96) ∨ (p97) ∨ (p98) ∨ (p99))
    (h102 : (p18) ∨ (p40) ∨ (p46) ∨ (p100))
    (h103 : ¬ (p48) ∨ ¬ (p100))
    (h104 : ¬ (p96) ∨ ¬ (p100))
    (h105 : ¬ (p97) ∨ ¬ (p100))
    (h106 : ¬ (p98) ∨ ¬ (p100))
    (h107 : ¬ (p99) ∨ ¬ (p100))
    (h108 : ¬ (p42) ∨ ¬ (p101))
    (h109 : ¬ (p102) ∨ (p101))
    (h110 : (p103) ∨ (p104) ∨ (p105) ∨ (p106) ∨ (p107) ∨ (p108) ∨ (p53))
    (h111 : (p49) ∨ (p102) ∨ (p109))
    (h112 : ¬ (p104) ∨ ¬ (p109))
    (h113 : ¬ (p105) ∨ ¬ (p109))
    (h114 : ¬ (p106) ∨ ¬ (p109))
    (h115 : ¬ (p107) ∨ ¬ (p109))
    (h116 : ¬ (p108) ∨ ¬ (p109))
    (h117 : ¬ (p103) ∨ ¬ (p110))
    (h118 : ¬ (p111) ∨ (p110))
    (h119 : (p57) ∨ (p112) ∨ (p113) ∨ (p114) ∨ (p115) ∨ (p116) ∨ (p56))
    (h120 : ¬ (p57) ∨ ¬ (p56))
    (h121 : (p51) ∨ (p111) ∨ (p117))
    (h122 : ¬ (p112) ∨ ¬ (p117))
    (h123 : ¬ (p113) ∨ ¬ (p117))
    (h124 : ¬ (p114) ∨ ¬ (p117))
    (h125 : ¬ (p115) ∨ ¬ (p117))
    (h126 : ¬ (p116) ∨ ¬ (p117))
    (h127 : (p118) ∨ (p119) ∨ (p120) ∨ (p121) ∨ (p122) ∨ (p123))
    (h128 : (p25) ∨ (p52) ∨ (p57) ∨ (p124))
    (h129 : ¬ (p119) ∨ ¬ (p124))
    (h130 : ¬ (p120) ∨ ¬ (p124))
    (h131 : ¬ (p121) ∨ ¬ (p124))
    (h132 : ¬ (p122) ∨ ¬ (p124))
    (h133 : ¬ (p123) ∨ ¬ (p124))
    (h134 : ¬ (p64) ∨ ¬ (p63))
    (h135 : ¬ (p118) ∨ ¬ (p125))
    (h136 : ¬ (p64) ∨ (p125))
    (h137 : (p65) ∨ (p126) ∨ (p127) ∨ (p128) ∨ (p129) ∨ (p130))
    (h138 : (p26) ∨ (p55) ∨ (p64) ∨ (p131))
    (h139 : ¬ (p126) ∨ ¬ (p131))
    (h140 : ¬ (p127) ∨ ¬ (p131))
    (h141 : ¬ (p128) ∨ ¬ (p131))
    (h142 : ¬ (p129) ∨ ¬ (p131))
    (h143 : ¬ (p130) ∨ ¬ (p131))
    (h144 : ¬ (p132) ∨ ¬ (p72))
    (h145 : (p58) ∨ (p65) ∨ (p133))
    (h146 : ¬ (p58) ∨ ¬ (p133))
    (h147 : ¬ (p65) ∨ ¬ (p133))
    (h148 : ¬ (p73) ∨ (p133))
    (h149 : ¬ (p74) ∨ ¬ (p134))
    (h150 : ¬ (p59) ∨ ¬ (p135))
    (h151 : ¬ (p74) ∨ (p135))
    (h152 : (p77) ∨ (p136) ∨ (p137) ∨ (p138) ∨ (p139) ∨ (p140) ∨ (p76))
    (h153 : (p67) ∨ (p74) ∨ (p141))
    (h154 : ¬ (p136) ∨ ¬ (p141))
    (h155 : ¬ (p136) ∨ (p142))
    (h156 : ¬ (p137) ∨ ¬ (p141))
    (h157 : ¬ (p138) ∨ ¬ (p142))
    (h158 : ¬ (p138) ∨ ¬ (p141))
    (h159 : ¬ (p138) ∨ ¬ (p143))
    (h160 : ¬ (p139) ∨ ¬ (p142))
    (h161 : ¬ (p139) ∨ ¬ (p144))
    (h162 : ¬ (p139) ∨ ¬ (p141))
    (h163 : ¬ (p139) ∨ ¬ (p143))
    (h164 : ¬ (p139) ∨ (p145))
    (h165 : ¬ (p140) ∨ ¬ (p142))
    (h166 : ¬ (p140) ∨ ¬ (p141))
    (h167 : ¬ (p140) ∨ ¬ (p143))
    (h168 : ¬ (p140) ∨ (p144))
    (h169 : ¬ (p78) ∨ ¬ (p146))
    (h170 : ¬ (p68) ∨ ¬ (p147))
    (h171 : ¬ (p78) ∨ (p147))
    (h172 : ¬ (p78) ∨ ¬ (p148))
    (h173 : ¬ (p86) ∨ ¬ (p149))
    (h174 : ¬ (p33) ∨ ¬ (p79))
    (h175 : ¬ (p33) ∨ ¬ (p85))
    (h176 : ¬ (p150) ∨ ¬ (p135))
    (h177 : (p151) ∨ (p152) ∨ (p153) ∨ (p154) ∨ (p155) ∨ (p156))
    (h178 : (p69) ∨ (p132) ∨ (p150) ∨ (p157))
    (h179 : ¬ (p152) ∨ ¬ (p157))
    (h180 : ¬ (p153) ∨ ¬ (p157))
    (h181 : ¬ (p154) ∨ ¬ (p157))
    (h182 : ¬ (p155) ∨ ¬ (p157))
    (h183 : ¬ (p156) ∨ ¬ (p157))
    (h184 : ¬ (p151) ∨ ¬ (p158))
    (h185 : ¬ (p142) ∨ (p158))
    (h186 : (p143) ∨ (p145) ∨ (p159) ∨ (p160) ∨ (p161) ∨ (p162))
    (h187 : (p70) ∨ (p134) ∨ (p142) ∨ (p163))
    (h188 : ¬ (p70) ∨ ¬ (p142))
    (h189 : ¬ (p145) ∨ ¬ (p163))
    (h190 : ¬ (p145) ∨ (p164))
    (h191 : ¬ (p159) ∨ (p165))
    (h192 : ¬ (p160) ∨ ¬ (p163))
    (h193 : ¬ (p161) ∨ ¬ (p163))
    (h194 : ¬ (p162) ∨ ¬ (p163))
    (h195 : (p136) ∨ (p143) ∨ (p166))
    (h196 : ¬ (p137) ∨ ¬ (p167))
    (h197 : ¬ (p168) ∨ (p167))
    (h198 : (p149) ∨ (p169) ∨ (p170) ∨ (p171) ∨ (p172) ∨ (p173) ∨ (p148))
    (h199 : (p75) ∨ (p146) ∨ (p168) ∨ (p174))
    (h200 : ¬ (p169) ∨ ¬ (p174))
    (h201 : ¬ (p170) ∨ ¬ (p174))
    (h202 : ¬ (p171) ∨ ¬ (p174))
    (h203 : ¬ (p172) ∨ ¬ (p174))
    (h204 : ¬ (p173) ∨ ¬ (p174))
    (h205 : ¬ (p138) ∨ ¬ (p164))
    (h206 : ¬ (p138) ∨ ¬ (p175))
    (h207 : ¬ (p144) ∨ ¬ (p175))
    (h208 : ¬ (p165) ∨ (p175))
    (h209 : ¬ (p176) ∨ ¬ (p166))
    (h210 : ¬ (p140) ∨ ¬ (p145))
    (h211 : (p139) ∨ (p159) ∨ (p176) ∨ (p177))
    (h212 : ¬ (p159) ∨ ¬ (p177))
    (h213 : ¬ (p54) ∨ ¬ (p55))
    (h214 : (p33)) : False := by
  have rup216 : ¬ (p34) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p34) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h214
    exact (Or.elim h34 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup217 : ¬ (p32) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p32) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h214
    exact (Or.elim h35 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup218 : ¬ (p35) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p35) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h214
    exact (Or.elim h36 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup219 : (p36) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p36) := fun v => denied v
    have u1 : (p33) := h214
    exact (Or.elim h37 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup220 : ¬ (p79) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p79) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h214
    exact (Or.elim h174 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup221 : ¬ (p85) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p85) := Classical.byContradiction (fun v => denied v)
    have u1 : (p33) := h214
    exact (Or.elim h175 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup222 : ¬ (p75) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p75) := Classical.byContradiction (fun v => denied v)
    have u1 : (p36) := rup219
    exact (Or.elim h79 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup223 : ¬ (p77) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p77) := Classical.byContradiction (fun v => denied v)
    have u1 : (p36) := rup219
    exact (Or.elim h82 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup224 : ¬ (p76) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p76) := Classical.byContradiction (fun v => denied v)
    have u1 : (p36) := rup219
    exact (Or.elim h83 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup225 : (p78) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p78) := fun v => denied v
    have u1 : (p36) := rup219
    exact (Or.elim h84 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup226 : ¬ (p80) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p80) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p85) := rup221
    exact (Or.elim h87 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup227 : ¬ (p146) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p146) := Classical.byContradiction (fun v => denied v)
    have u1 : (p78) := rup225
    exact (Or.elim h169 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup228 : (p147) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p147) := fun v => denied v
    have u1 : (p78) := rup225
    exact (Or.elim h171 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup229 : ¬ (p148) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p148) := Classical.byContradiction (fun v => denied v)
    have u1 : (p78) := rup225
    exact (Or.elim h172 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup230 : ¬ (p68) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p68) := Classical.byContradiction (fun v => denied v)
    have u1 : (p147) := rup228
    exact (Or.elim h170 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup231 : (p10) ∨ ¬ (p14) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p10) := fun v => denied (Or.inl v)
    have u1 : (p14) := Classical.byContradiction (fun v => denied (Or.inr v))
    have u2 : ¬ (p32) := rup217
    have u3 : ¬ (p30) := (Or.elim h30 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u4 : ¬ (p12) := (Or.elim h26 (fun v => (False.elim (v u1))) (fun tail => tail))
    have u5 : ¬ (p28) := (Or.elim h24 (fun v => v) (fun tail => (False.elim (tail u1))))
    have u6 : ¬ (p9) := (Or.elim h8 (fun v => v) (fun tail => (False.elim (u0 tail))))
    have u7 : (p4) := (Or.elim h28 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u3 tail))))))
    have u8 : (p2) := (Or.elim h33 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (False.elim (u2 tail))))))))
    have u9 : ¬ (p8) := (Or.elim h6 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u10 : ¬ (p1) := (Or.elim h0 (fun v => v) (fun tail => (False.elim (tail u8))))
    exact (Or.elim h10 (fun v => (False.elim (u10 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u9 v))) (fun tail => (False.elim (u4 tail))))))
  have rup232 : ¬ (p131) ∨ (p65) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p131) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : ¬ (p65) := fun v => denied (Or.inr v)
    have u2 : ¬ (p126) := (Or.elim h139 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u3 : ¬ (p127) := (Or.elim h140 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u4 : ¬ (p128) := (Or.elim h141 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u5 : ¬ (p129) := (Or.elim h142 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u6 : ¬ (p130) := (Or.elim h143 (fun v => v) (fun tail => (False.elim (tail u0))))
    exact (Or.elim h137 (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (False.elim (u6 tail))))))))))))
  have rup233 : ¬ (p67) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p67) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p76) := rup224
    have u2 : ¬ (p32) := rup217
    have u3 : ¬ (p66) := (Or.elim h72 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u4 : (p73) := (Or.elim h75 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u5 : (p14) := (Or.elim h80 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (False.elim (u1 tail))))))
    have u6 : (p133) := (Or.elim h148 (fun v => (False.elim (v u4))) (fun tail => tail))
    have u7 : ¬ (p28) := (Or.elim h24 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u8 : ¬ (p12) := (Or.elim h26 (fun v => (False.elim (v u5))) (fun tail => tail))
    have u9 : (p31) := (Or.elim h31 (fun v => (False.elim (v u5))) (fun tail => tail))
    have u10 : ¬ (p65) := (Or.elim h147 (fun v => v) (fun tail => (False.elim (tail u6))))
    have u11 : (p63) := (Or.elim h59 (fun v => (False.elim (v u9))) (fun tail => tail))
    have u12 : ¬ (p64) := (Or.elim h134 (fun v => v) (fun tail => (False.elim (tail u11))))
    have u13 : (p10) := (Or.elim rup231 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u14 : ¬ (p11) := (Or.elim h9 (fun v => v) (fun tail => (False.elim (tail u13))))
    have u15 : ¬ (p26) := (Or.elim h22 (fun v => (False.elim (v u13))) (fun tail => tail))
    have u16 : (p27) := (Or.elim h23 (fun v => (False.elim (v u13))) (fun tail => tail))
    have u17 : ¬ (p4) := (Or.elim h29 (fun v => v) (fun tail => (False.elim (tail u13))))
    have u18 : ¬ (p50) := (Or.elim h48 (fun v => v) (fun tail => (False.elim (tail u16))))
    have u19 : ¬ (p51) := (Or.elim h49 (fun v => v) (fun tail => (False.elim (tail u16))))
    have u20 : ¬ (p2) := (Or.elim h2 (fun v => v) (fun tail => (False.elim (u17 tail))))
    have u21 : (p9) := (Or.elim h33 (fun v => (False.elim (u20 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u7 v))) (fun tail => (False.elim (u2 tail))))))))
    have u22 : ¬ (p8) := (Or.elim h7 (fun v => v) (fun tail => (False.elim (tail u21))))
    have u23 : (p1) := (Or.elim h10 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u22 v))) (fun tail => (False.elim (u8 tail))))))
    have u24 : (p3) := (Or.elim h1 (fun v => (False.elim (v u23))) (fun tail => tail))
    have u25 : ¬ (p5) := (Or.elim h3 (fun v => (False.elim (v u24))) (fun tail => tail))
    have u26 : ¬ (p6) := (Or.elim h4 (fun v => (False.elim (v u24))) (fun tail => tail))
    have u27 : (p7) := (Or.elim h5 (fun v => (False.elim (v u24))) (fun tail => tail))
    have u28 : ¬ (p15) := (Or.elim h12 (fun v => v) (fun tail => (False.elim (tail u27))))
    have u29 : ¬ (p131) := (Or.elim rup232 (fun v => v) (fun tail => (False.elim (u10 tail))))
    have u30 : (p55) := (Or.elim h138 (fun v => (False.elim (u15 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u12 v))) (fun tail => (False.elim (u29 tail))))))))
    have u31 : ¬ (p57) := (Or.elim h55 (fun v => (False.elim (v u30))) (fun tail => tail))
    have u32 : ¬ (p56) := (Or.elim h56 (fun v => (False.elim (v u30))) (fun tail => tail))
    have u33 : (p21) := (Or.elim h53 (fun v => (False.elim (u14 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u18 v))) (fun tail => (False.elim (u32 tail))))))))
    have u34 : ¬ (p22) := (Or.elim h17 (fun v => (False.elim (v u33))) (fun tail => tail))
    have u35 : ¬ (p20) := (Or.elim h18 (fun v => (False.elim (v u33))) (fun tail => tail))
    have u36 : (p23) := (Or.elim h19 (fun v => (False.elim (v u33))) (fun tail => tail))
    have u37 : (p16) := (Or.elim h16 (fun v => (False.elim (u25 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u35 tail))))))
    have u38 : ¬ (p49) := (Or.elim h47 (fun v => (False.elim (v u36))) (fun tail => tail))
    have u39 : ¬ (p53) := (Or.elim h51 (fun v => (False.elim (v u36))) (fun tail => tail))
    have u40 : ¬ (p17) := (Or.elim h13 (fun v => (False.elim (v u37))) (fun tail => tail))
    have u41 : ¬ (p18) := (Or.elim h14 (fun v => (False.elim (v u37))) (fun tail => tail))
    have u42 : (p19) := (Or.elim h15 (fun v => (False.elim (v u37))) (fun tail => tail))
    have u43 : ¬ (p37) := (Or.elim h38 (fun v => v) (fun tail => (False.elim (tail u42))))
    have u44 : ¬ (p38) := (Or.elim h39 (fun v => v) (fun tail => (False.elim (tail u42))))
    have u45 : (p39) := (Or.elim h40 (fun v => (False.elim (u26 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u28 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u43 v))) (fun tail => tail))))))
    have u46 : ¬ (p40) := (Or.elim h41 (fun v => v) (fun tail => (False.elim (tail u45))))
    have u47 : ¬ (p87) := (Or.elim h91 (fun v => v) (fun tail => (False.elim (tail u45))))
    have u48 : (p94) := (Or.elim h93 (fun v => (False.elim (u40 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u44 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u47 v))) (fun tail => tail))))))
    have u49 : ¬ (p89) := (Or.elim h94 (fun v => v) (fun tail => (False.elim (tail u48))))
    have u50 : ¬ (p90) := (Or.elim h95 (fun v => v) (fun tail => (False.elim (tail u48))))
    have u51 : ¬ (p91) := (Or.elim h96 (fun v => v) (fun tail => (False.elim (tail u48))))
    have u52 : ¬ (p92) := (Or.elim h97 (fun v => v) (fun tail => (False.elim (tail u48))))
    have u53 : ¬ (p93) := (Or.elim h98 (fun v => v) (fun tail => (False.elim (tail u48))))
    have u54 : (p88) := (Or.elim h92 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u49 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u50 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u51 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u52 v))) (fun tail => (False.elim (u53 tail))))))))))))
    have u55 : ¬ (p95) := (Or.elim h99 (fun v => (False.elim (v u54))) (fun tail => tail))
    have u56 : ¬ (p46) := (Or.elim h100 (fun v => v) (fun tail => (False.elim (u55 tail))))
    have u57 : ¬ (p41) := (Or.elim h43 (fun v => v) (fun tail => (False.elim (u56 tail))))
    have u58 : (p100) := (Or.elim h102 (fun v => (False.elim (u41 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u46 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u56 v))) (fun tail => tail))))))
    have u59 : ¬ (p48) := (Or.elim h103 (fun v => v) (fun tail => (False.elim (tail u58))))
    have u60 : ¬ (p96) := (Or.elim h104 (fun v => v) (fun tail => (False.elim (tail u58))))
    have u61 : ¬ (p97) := (Or.elim h105 (fun v => v) (fun tail => (False.elim (tail u58))))
    have u62 : ¬ (p98) := (Or.elim h106 (fun v => v) (fun tail => (False.elim (tail u58))))
    have u63 : ¬ (p99) := (Or.elim h107 (fun v => v) (fun tail => (False.elim (tail u58))))
    have u64 : ¬ (p44) := (Or.elim h45 (fun v => v) (fun tail => (False.elim (u59 tail))))
    have u65 : (p47) := (Or.elim h101 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u59 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u60 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u61 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u62 v))) (fun tail => (False.elim (u63 tail))))))))))))
    have u66 : ¬ (p43) := (Or.elim h44 (fun v => v) (fun tail => (False.elim (tail u65))))
    have u67 : ¬ (p45) := (Or.elim h46 (fun v => v) (fun tail => (False.elim (tail u65))))
    have u68 : (p42) := (Or.elim h42 (fun v => (False.elim (u34 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u57 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u66 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u64 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u67 v))) (fun tail => (False.elim (u35 tail))))))))))))))
    have u69 : ¬ (p101) := (Or.elim h108 (fun v => (False.elim (v u68))) (fun tail => tail))
    have u70 : ¬ (p102) := (Or.elim h109 (fun v => v) (fun tail => (False.elim (u69 tail))))
    have u71 : (p109) := (Or.elim h111 (fun v => (False.elim (u38 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u70 v))) (fun tail => tail))))
    have u72 : ¬ (p104) := (Or.elim h112 (fun v => v) (fun tail => (False.elim (tail u71))))
    have u73 : ¬ (p105) := (Or.elim h113 (fun v => v) (fun tail => (False.elim (tail u71))))
    have u74 : ¬ (p106) := (Or.elim h114 (fun v => v) (fun tail => (False.elim (tail u71))))
    have u75 : ¬ (p107) := (Or.elim h115 (fun v => v) (fun tail => (False.elim (tail u71))))
    have u76 : ¬ (p108) := (Or.elim h116 (fun v => v) (fun tail => (False.elim (tail u71))))
    have u77 : (p103) := (Or.elim h110 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u72 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u73 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u74 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u75 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u76 v))) (fun tail => (False.elim (u39 tail))))))))))))))
    have u78 : ¬ (p110) := (Or.elim h117 (fun v => (False.elim (v u77))) (fun tail => tail))
    have u79 : ¬ (p111) := (Or.elim h118 (fun v => v) (fun tail => (False.elim (u78 tail))))
    have u80 : (p117) := (Or.elim h121 (fun v => (False.elim (u19 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u79 v))) (fun tail => tail))))
    have u81 : ¬ (p112) := (Or.elim h122 (fun v => v) (fun tail => (False.elim (tail u80))))
    have u82 : ¬ (p113) := (Or.elim h123 (fun v => v) (fun tail => (False.elim (tail u80))))
    have u83 : ¬ (p114) := (Or.elim h124 (fun v => v) (fun tail => (False.elim (tail u80))))
    have u84 : ¬ (p115) := (Or.elim h125 (fun v => v) (fun tail => (False.elim (tail u80))))
    have u85 : ¬ (p116) := (Or.elim h126 (fun v => v) (fun tail => (False.elim (tail u80))))
    exact (Or.elim h119 (fun v => (False.elim (u31 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u81 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u82 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u83 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u84 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u85 v))) (fun tail => (False.elim (u32 tail))))))))))))))
  have rup234 : ¬ (p144) ∨ (p177) ∨ (p176) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p144) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : ¬ (p177) := fun v => denied (Or.inr (Or.inl v))
    have u2 : ¬ (p176) := fun v => denied (Or.inr (Or.inr v))
    have u3 : ¬ (p139) := (Or.elim h161 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u4 : ¬ (p175) := (Or.elim h207 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u5 : (p159) := (Or.elim h211 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u1 tail))))))))
    have u6 : ¬ (p165) := (Or.elim h208 (fun v => v) (fun tail => (False.elim (u4 tail))))
    exact (Or.elim h191 (fun v => (False.elim (v u5))) (fun tail => (False.elim (u6 tail))))
  have rup235 : ¬ (p136) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p136) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p67) := rup233
    have u2 : ¬ (p68) := rup230
    have u3 : ¬ (p141) := (Or.elim h154 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u4 : (p142) := (Or.elim h155 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u5 : (p74) := (Or.elim h153 (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u3 tail))))))
    have u6 : (p158) := (Or.elim h185 (fun v => (False.elim (v u4))) (fun tail => tail))
    have u7 : ¬ (p70) := (Or.elim h188 (fun v => v) (fun tail => (False.elim (tail u4))))
    have u8 : ¬ (p69) := (Or.elim h76 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u9 : ¬ (p71) := (Or.elim h78 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u10 : (p135) := (Or.elim h151 (fun v => (False.elim (v u5))) (fun tail => tail))
    have u11 : ¬ (p151) := (Or.elim h184 (fun v => v) (fun tail => (False.elim (tail u6))))
    have u12 : (p66) := (Or.elim h71 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u7 v))) (fun tail => (False.elim (u9 tail))))))))))))
    have u13 : ¬ (p150) := (Or.elim h176 (fun v => v) (fun tail => (False.elim (tail u10))))
    have u14 : (p72) := (Or.elim h74 (fun v => (False.elim (v u12))) (fun tail => tail))
    have u15 : ¬ (p132) := (Or.elim h144 (fun v => v) (fun tail => (False.elim (tail u14))))
    have u16 : (p157) := (Or.elim h178 (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u15 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u13 v))) (fun tail => tail))))))
    have u17 : ¬ (p152) := (Or.elim h179 (fun v => v) (fun tail => (False.elim (tail u16))))
    have u18 : ¬ (p153) := (Or.elim h180 (fun v => v) (fun tail => (False.elim (tail u16))))
    have u19 : ¬ (p154) := (Or.elim h181 (fun v => v) (fun tail => (False.elim (tail u16))))
    have u20 : ¬ (p155) := (Or.elim h182 (fun v => v) (fun tail => (False.elim (tail u16))))
    have u21 : ¬ (p156) := (Or.elim h183 (fun v => v) (fun tail => (False.elim (tail u16))))
    exact (Or.elim h177 (fun v => (False.elim (u11 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u17 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u18 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u19 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u20 v))) (fun tail => (False.elim (u21 tail))))))))))))
  have rup236 : ¬ (p143) ∨ (p137) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p143) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : ¬ (p137) := fun v => denied (Or.inr v)
    have u2 : ¬ (p76) := rup224
    have u3 : ¬ (p136) := rup235
    have u4 : ¬ (p77) := rup223
    have u5 : ¬ (p138) := (Or.elim h159 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u6 : ¬ (p139) := (Or.elim h163 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u7 : ¬ (p140) := (Or.elim h167 (fun v => v) (fun tail => (False.elim (tail u0))))
    exact (Or.elim h152 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u7 v))) (fun tail => (False.elim (u2 tail))))))))))))))
  have rup237 : (p139) ∨ (p177) ∨ (p137) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p139) := fun v => denied (Or.inl v)
    have u1 : ¬ (p177) := fun v => denied (Or.inr (Or.inl v))
    have u2 : ¬ (p137) := fun v => denied (Or.inr (Or.inr v))
    have u3 : ¬ (p76) := rup224
    have u4 : ¬ (p136) := rup235
    have u5 : ¬ (p77) := rup223
    have u6 : ¬ (p143) := (Or.elim rup236 (fun v => v) (fun tail => (False.elim (u2 tail))))
    have u7 : (p166) := (Or.elim h195 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => tail))))
    have u8 : ¬ (p176) := (Or.elim h209 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u9 : ¬ (p144) := (Or.elim rup234 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (False.elim (u8 tail))))))
    have u10 : ¬ (p140) := (Or.elim h168 (fun v => v) (fun tail => (False.elim (u9 tail))))
    have u11 : (p138) := (Or.elim h152 (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u10 v))) (fun tail => (False.elim (u3 tail))))))))))))))
    have u12 : (p159) := (Or.elim h211 (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (False.elim (u1 tail))))))))
    have u13 : ¬ (p175) := (Or.elim h206 (fun v => (False.elim (v u11))) (fun tail => tail))
    have u14 : (p165) := (Or.elim h191 (fun v => (False.elim (v u12))) (fun tail => tail))
    exact (Or.elim h208 (fun v => (False.elim (v u14))) (fun tail => (False.elim (u13 tail))))
  have rup238 : ¬ (p139) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p139) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p67) := rup233
    have u2 : ¬ (p142) := (Or.elim h160 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u3 : ¬ (p141) := (Or.elim h162 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u4 : (p145) := (Or.elim h164 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u5 : (p74) := (Or.elim h153 (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u3 tail))))))
    have u6 : ¬ (p163) := (Or.elim h189 (fun v => (False.elim (v u4))) (fun tail => tail))
    have u7 : ¬ (p70) := (Or.elim h77 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u8 : ¬ (p134) := (Or.elim h149 (fun v => (False.elim (v u5))) (fun tail => tail))
    exact (Or.elim h187 (fun v => (False.elim (u7 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u6 tail))))))))
  have rup239 : ¬ (p138) ∨ (p137) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p138) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : ¬ (p137) := fun v => denied (Or.inr v)
    have u2 : ¬ (p139) := rup238
    have u3 : ¬ (p67) := rup233
    have u4 : (p177) := (Or.elim rup237 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u1 tail))))))
    have u5 : ¬ (p159) := (Or.elim h212 (fun v => v) (fun tail => (False.elim (tail u4))))
    have u6 : ¬ (p143) := (Or.elim rup236 (fun v => v) (fun tail => (False.elim (u1 tail))))
    have u7 : ¬ (p142) := (Or.elim h157 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u8 : ¬ (p141) := (Or.elim h158 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u9 : ¬ (p164) := (Or.elim h205 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u10 : (p74) := (Or.elim h153 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u8 tail))))))
    have u11 : ¬ (p145) := (Or.elim h190 (fun v => v) (fun tail => (False.elim (u9 tail))))
    have u12 : ¬ (p70) := (Or.elim h77 (fun v => v) (fun tail => (False.elim (tail u10))))
    have u13 : ¬ (p134) := (Or.elim h149 (fun v => (False.elim (v u10))) (fun tail => tail))
    have u14 : (p163) := (Or.elim h187 (fun v => (False.elim (u12 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u13 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u7 v))) (fun tail => tail))))))
    have u15 : ¬ (p160) := (Or.elim h192 (fun v => v) (fun tail => (False.elim (tail u14))))
    have u16 : ¬ (p161) := (Or.elim h193 (fun v => v) (fun tail => (False.elim (tail u14))))
    have u17 : ¬ (p162) := (Or.elim h194 (fun v => v) (fun tail => (False.elim (tail u14))))
    exact (Or.elim h186 (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u11 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u15 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u16 v))) (fun tail => (False.elim (u17 tail))))))))))))
  have rup240 : (p137) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p137) := fun v => denied v
    have u1 : ¬ (p76) := rup224
    have u2 : ¬ (p136) := rup235
    have u3 : ¬ (p139) := rup238
    have u4 : ¬ (p77) := rup223
    have u5 : ¬ (p67) := rup233
    have u6 : ¬ (p143) := (Or.elim rup236 (fun v => v) (fun tail => (False.elim (u0 tail))))
    have u7 : (p177) := (Or.elim rup237 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u0 tail))))))
    have u8 : ¬ (p159) := (Or.elim h212 (fun v => v) (fun tail => (False.elim (tail u7))))
    have u9 : ¬ (p138) := (Or.elim rup239 (fun v => v) (fun tail => (False.elim (u0 tail))))
    have u10 : (p140) := (Or.elim h152 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u9 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u1 tail))))))))))))))
    have u11 : ¬ (p142) := (Or.elim h165 (fun v => (False.elim (v u10))) (fun tail => tail))
    have u12 : ¬ (p141) := (Or.elim h166 (fun v => (False.elim (v u10))) (fun tail => tail))
    have u13 : ¬ (p145) := (Or.elim h210 (fun v => (False.elim (v u10))) (fun tail => tail))
    have u14 : (p74) := (Or.elim h153 (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u12 tail))))))
    have u15 : ¬ (p70) := (Or.elim h77 (fun v => v) (fun tail => (False.elim (tail u14))))
    have u16 : ¬ (p134) := (Or.elim h149 (fun v => (False.elim (v u14))) (fun tail => tail))
    have u17 : (p163) := (Or.elim h187 (fun v => (False.elim (u15 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u16 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u11 v))) (fun tail => tail))))))
    have u18 : ¬ (p160) := (Or.elim h192 (fun v => v) (fun tail => (False.elim (tail u17))))
    have u19 : ¬ (p161) := (Or.elim h193 (fun v => v) (fun tail => (False.elim (tail u17))))
    have u20 : ¬ (p162) := (Or.elim h194 (fun v => v) (fun tail => (False.elim (tail u17))))
    exact (Or.elim h186 (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u13 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u18 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u19 v))) (fun tail => (False.elim (u20 tail))))))))))))
  have rup241 : ¬ (p141) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p141) := Classical.byContradiction (fun v => denied v)
    have u1 : (p137) := rup240
    exact (Or.elim h156 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup242 : ¬ (p167) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p167) := Classical.byContradiction (fun v => denied v)
    have u1 : (p137) := rup240
    exact (Or.elim h196 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup243 : (p74) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p74) := fun v => denied v
    have u1 : ¬ (p141) := rup241
    have u2 : ¬ (p67) := rup233
    exact (Or.elim h153 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u1 tail))))))
  have rup244 : ¬ (p168) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p168) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p167) := rup242
    exact (Or.elim h197 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup245 : ¬ (p69) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p69) := Classical.byContradiction (fun v => denied v)
    have u1 : (p74) := rup243
    exact (Or.elim h76 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup246 : ¬ (p70) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p70) := Classical.byContradiction (fun v => denied v)
    have u1 : (p74) := rup243
    exact (Or.elim h77 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup247 : ¬ (p71) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p71) := Classical.byContradiction (fun v => denied v)
    have u1 : (p74) := rup243
    exact (Or.elim h78 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup248 : (p135) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p135) := fun v => denied v
    have u1 : (p74) := rup243
    exact (Or.elim h151 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup249 : (p174) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p174) := fun v => denied v
    have u1 : ¬ (p168) := rup244
    have u2 : ¬ (p75) := rup222
    have u3 : ¬ (p146) := rup227
    exact (Or.elim h199 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (False.elim (u0 tail))))))))
  have rup250 : (p66) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p66) := fun v => denied v
    have u1 : ¬ (p69) := rup245
    have u2 : ¬ (p68) := rup230
    have u3 : ¬ (p67) := rup233
    have u4 : ¬ (p70) := rup246
    have u5 : ¬ (p71) := rup247
    exact (Or.elim h71 (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (False.elim (u5 tail))))))))))))
  have rup251 : ¬ (p59) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p59) := Classical.byContradiction (fun v => denied v)
    have u1 : (p135) := rup248
    exact (Or.elim h150 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup252 : ¬ (p169) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p169) := Classical.byContradiction (fun v => denied v)
    have u1 : (p174) := rup249
    exact (Or.elim h200 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup253 : ¬ (p170) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p170) := Classical.byContradiction (fun v => denied v)
    have u1 : (p174) := rup249
    exact (Or.elim h201 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup254 : ¬ (p171) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p171) := Classical.byContradiction (fun v => denied v)
    have u1 : (p174) := rup249
    exact (Or.elim h202 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup255 : ¬ (p172) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p172) := Classical.byContradiction (fun v => denied v)
    have u1 : (p174) := rup249
    exact (Or.elim h203 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup256 : ¬ (p173) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p173) := Classical.byContradiction (fun v => denied v)
    have u1 : (p174) := rup249
    exact (Or.elim h204 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup257 : (p72) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p72) := fun v => denied v
    have u1 : (p66) := rup250
    exact (Or.elim h74 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup258 : ¬ (p14) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p14) := Classical.byContradiction (fun v => denied v)
    have u1 : (p66) := rup250
    exact (Or.elim h81 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup259 : (p149) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p149) := fun v => denied v
    have u1 : ¬ (p171) := rup254
    have u2 : ¬ (p169) := rup252
    have u3 : ¬ (p170) := rup253
    have u4 : ¬ (p172) := rup255
    have u5 : ¬ (p173) := rup256
    have u6 : ¬ (p148) := rup229
    exact (Or.elim h198 (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (False.elim (u6 tail))))))))))))))
  have rup260 : ¬ (p31) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p31) := Classical.byContradiction (fun v => denied v)
    have u1 : (p72) := rup257
    exact (Or.elim h73 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup261 : ¬ (p13) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p13) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p14) := rup258
    exact (Or.elim h11 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup262 : ¬ (p86) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p86) := Classical.byContradiction (fun v => denied v)
    have u1 : (p149) := rup259
    exact (Or.elim h173 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup263 : ¬ (p83) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p83) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p86) := rup262
    exact (Or.elim h90 (fun v => (False.elim (v u0))) (fun tail => (False.elim (u1 tail))))
  have rup264 : ¬ (p84) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p84) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p83) := rup263
    have u2 : ¬ (p80) := rup226
    have u3 : ¬ (p79) := rup220
    have u4 : ¬ (p35) := rup218
    have u5 : ¬ (p81) := (Or.elim h88 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u6 : ¬ (p82) := (Or.elim h89 (fun v => v) (fun tail => (False.elim (tail u0))))
    exact (Or.elim h85 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (False.elim (u1 tail))))))))))))
  have rup265 : (p29) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p29) := fun v => denied v
    have u1 : ¬ (p84) := rup264
    have u2 : ¬ (p34) := rup216
    have u3 : ¬ (p13) := rup261
    exact (Or.elim h86 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (False.elim (u1 tail))))))))
  have rup266 : ¬ (p28) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p28) := Classical.byContradiction (fun v => denied v)
    have u1 : (p29) := rup265
    exact (Or.elim h25 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup267 : ¬ (p12) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p12) := Classical.byContradiction (fun v => denied v)
    have u1 : (p29) := rup265
    exact (Or.elim h27 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup268 : ¬ (p30) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p30) := Classical.byContradiction (fun v => denied v)
    have u1 : (p29) := rup265
    exact (Or.elim h32 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup269 : (p10) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p10) := fun v => denied v
    have u1 : ¬ (p30) := rup268
    have u2 : ¬ (p32) := rup217
    have u3 : ¬ (p28) := rup266
    have u4 : ¬ (p12) := rup267
    have u5 : ¬ (p9) := (Or.elim h8 (fun v => v) (fun tail => (False.elim (u0 tail))))
    have u6 : (p4) := (Or.elim h28 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u1 tail))))))
    have u7 : (p2) := (Or.elim h33 (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (False.elim (u2 tail))))))))
    have u8 : ¬ (p8) := (Or.elim h6 (fun v => v) (fun tail => (False.elim (tail u6))))
    have u9 : ¬ (p1) := (Or.elim h0 (fun v => v) (fun tail => (False.elim (tail u7))))
    exact (Or.elim h10 (fun v => (False.elim (u9 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (False.elim (u4 tail))))))
  have rup270 : ¬ (p24) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p24) := Classical.byContradiction (fun v => denied v)
    have u1 : (p10) := rup269
    exact (Or.elim h20 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup271 : ¬ (p25) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p25) := Classical.byContradiction (fun v => denied v)
    have u1 : (p10) := rup269
    exact (Or.elim h21 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup272 : ¬ (p26) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p26) := Classical.byContradiction (fun v => denied v)
    have u1 : (p10) := rup269
    exact (Or.elim h22 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup273 : (p27) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p27) := fun v => denied v
    have u1 : (p10) := rup269
    exact (Or.elim h23 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup274 : ¬ (p52) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p52) := Classical.byContradiction (fun v => denied v)
    have u1 : (p27) := rup273
    exact (Or.elim h50 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup275 : ¬ (p61) ∨ (p131) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p61) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : ¬ (p131) := fun v => denied (Or.inr v)
    have u2 : ¬ (p26) := rup272
    have u3 : ¬ (p24) := rup270
    have u4 : ¬ (p64) := (Or.elim h65 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u5 : ¬ (p63) := (Or.elim h66 (fun v => (False.elim (v u0))) (fun tail => tail))
    have u6 : (p55) := (Or.elim h138 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (False.elim (u1 tail))))))))
    have u7 : (p54) := (Or.elim h58 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u5 tail))))))
    exact (Or.elim h213 (fun v => (False.elim (v u7))) (fun tail => (False.elim (tail u6))))
  have rup276 : ¬ (p63) ∨ ¬ (p133) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p63) := Classical.byContradiction (fun v => denied (Or.inl v))
    have u1 : (p133) := Classical.byContradiction (fun v => denied (Or.inr v))
    have u2 : ¬ (p30) := rup268
    have u3 : ¬ (p31) := rup260
    have u4 : ¬ (p59) := rup251
    have u5 : ¬ (p65) := (Or.elim h147 (fun v => v) (fun tail => (False.elim (tail u1))))
    have u6 : ¬ (p131) := (Or.elim rup232 (fun v => v) (fun tail => (False.elim (u5 tail))))
    have u7 : ¬ (p61) := (Or.elim rup275 (fun v => v) (fun tail => (False.elim (u6 tail))))
    have u8 : ¬ (p58) := (Or.elim h146 (fun v => v) (fun tail => (False.elim (tail u1))))
    have u9 : ¬ (p60) := (Or.elim h63 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u10 : ¬ (p62) := (Or.elim h69 (fun v => v) (fun tail => (False.elim (tail u0))))
    exact (Or.elim h57 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u9 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u7 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u10 v))) (fun tail => (False.elim (u2 tail))))))))))))))
  have rup277 : ¬ (p133) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p133) := Classical.byContradiction (fun v => denied v)
    have u1 : ¬ (p24) := rup270
    have u2 : ¬ (p26) := rup272
    have u3 : ¬ (p30) := rup268
    have u4 : ¬ (p31) := rup260
    have u5 : ¬ (p59) := rup251
    have u6 : ¬ (p58) := (Or.elim h146 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u7 : ¬ (p65) := (Or.elim h147 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u8 : ¬ (p131) := (Or.elim rup232 (fun v => v) (fun tail => (False.elim (u7 tail))))
    have u9 : ¬ (p61) := (Or.elim rup275 (fun v => v) (fun tail => (False.elim (u8 tail))))
    have u10 : ¬ (p63) := (Or.elim rup276 (fun v => v) (fun tail => (False.elim (tail u0))))
    have u11 : (p54) := (Or.elim h58 (fun v => (False.elim (u1 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u10 tail))))))
    have u12 : ¬ (p55) := (Or.elim h52 (fun v => (False.elim (v u11))) (fun tail => tail))
    have u13 : (p64) := (Or.elim h138 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u12 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u8 tail))))))))
    have u14 : ¬ (p60) := (Or.elim h62 (fun v => v) (fun tail => (False.elim (tail u13))))
    have u15 : ¬ (p62) := (Or.elim h68 (fun v => v) (fun tail => (False.elim (tail u13))))
    exact (Or.elim h57 (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u14 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u9 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u15 v))) (fun tail => (False.elim (u3 tail))))))))))))))
  have rup278 : (p58) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p58) := fun v => denied v
    have u1 : ¬ (p133) := rup277
    have u2 : ¬ (p30) := rup268
    have u3 : ¬ (p31) := rup260
    have u4 : ¬ (p59) := rup251
    have u5 : (p65) := (Or.elim h145 (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => v) (fun tail => (False.elim (u1 tail))))))
    have u6 : ¬ (p60) := (Or.elim h64 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u7 : ¬ (p61) := (Or.elim h67 (fun v => v) (fun tail => (False.elim (tail u5))))
    have u8 : ¬ (p62) := (Or.elim h70 (fun v => v) (fun tail => (False.elim (tail u5))))
    exact (Or.elim h57 (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u6 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u7 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u8 v))) (fun tail => (False.elim (u2 tail))))))))))))))
  have rup279 : ¬ (p63) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p63) := Classical.byContradiction (fun v => denied v)
    have u1 : (p58) := rup278
    exact (Or.elim h60 (fun v => (False.elim (v u1))) (fun tail => (False.elim (tail u0))))
  have rup280 : (p64) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p64) := fun v => denied v
    have u1 : (p58) := rup278
    exact (Or.elim h61 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup281 : (p54) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p54) := fun v => denied v
    have u1 : ¬ (p63) := rup279
    have u2 : ¬ (p24) := rup270
    exact (Or.elim h58 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (False.elim (u1 tail))))))
  have rup282 : (p125) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p125) := fun v => denied v
    have u1 : (p64) := rup280
    exact (Or.elim h136 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup283 : (p56) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p56) := fun v => denied v
    have u1 : (p54) := rup281
    exact (Or.elim h54 (fun v => (False.elim (v u1))) (fun tail => (False.elim (u0 tail))))
  have rup284 : ¬ (p118) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p118) := Classical.byContradiction (fun v => denied v)
    have u1 : (p125) := rup282
    exact (Or.elim h135 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup285 : ¬ (p57) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p57) := Classical.byContradiction (fun v => denied v)
    have u1 : (p56) := rup283
    exact (Or.elim h120 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup286 : (p124) := by
    apply Classical.byContradiction
    intro denied
    have u0 : ¬ (p124) := fun v => denied v
    have u1 : ¬ (p57) := rup285
    have u2 : ¬ (p25) := rup271
    have u3 : ¬ (p52) := rup274
    exact (Or.elim h128 (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u1 v))) (fun tail => (False.elim (u0 tail))))))))
  have rup287 : ¬ (p119) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p119) := Classical.byContradiction (fun v => denied v)
    have u1 : (p124) := rup286
    exact (Or.elim h129 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup288 : ¬ (p120) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p120) := Classical.byContradiction (fun v => denied v)
    have u1 : (p124) := rup286
    exact (Or.elim h130 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup289 : ¬ (p121) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p121) := Classical.byContradiction (fun v => denied v)
    have u1 : (p124) := rup286
    exact (Or.elim h131 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup290 : ¬ (p122) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p122) := Classical.byContradiction (fun v => denied v)
    have u1 : (p124) := rup286
    exact (Or.elim h132 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup291 : ¬ (p123) := by
    apply Classical.byContradiction
    intro denied
    have u0 : (p123) := Classical.byContradiction (fun v => denied v)
    have u1 : (p124) := rup286
    exact (Or.elim h133 (fun v => (False.elim (v u0))) (fun tail => (False.elim (tail u1))))
  have rup292 : False := by
    have u0 : ¬ (p119) := rup287
    have u1 : ¬ (p123) := rup291
    have u2 : ¬ (p120) := rup288
    have u3 : ¬ (p121) := rup289
    have u4 : ¬ (p122) := rup290
    have u5 : ¬ (p118) := rup284
    exact (Or.elim h127 (fun v => (False.elim (u5 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u0 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u2 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u3 v))) (fun tail => (Or.elim tail (fun v => (False.elim (u4 v))) (fun tail => (False.elim (u1 tail))))))))))))
  exact rup292

private theorem c0 (k : Nat) : ¬ (Cell (2*k+8) (4*k+18)) ∨ ¬ (Cell (2*k+8) (8*k+37)) := by
  by_cases h : Cell (2*k+8) (4*k+18)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c1 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (2*k+8) (4*k+18)) ∨ (Cell (4*k+16) (4*k+17)) := by
  classical
  by_cases h : Cell (2*k+8) (4*k+18)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(2*k+8) = (4*k+16) := by omega
      have ht : (4*k+18)-1 = (4*k+17) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c2 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (2*k+8) (8*k+37)) ∨ (Cell (4*k+17) (8*k+36)) := by
  classical
  by_cases h : Cell (2*k+8) (8*k+37)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(2*k+8)+1 = (4*k+17) := by omega
      have ht : (8*k+37)-1 = (8*k+36) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c3 (k : Nat) : ¬ (Cell (4*k+16) (4*k+17)) ∨ ¬ (Cell (4*k+16) (8*k+34)) := by
  by_cases h : Cell (4*k+16) (4*k+17)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c4 (k : Nat) : ¬ (Cell (4*k+16) (4*k+17)) ∨ ¬ (Cell (4*k+16) (16*k+67)) := by
  by_cases h : Cell (4*k+16) (4*k+17)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c5 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (4*k+16) (4*k+17)) ∨ (Cell (8*k+32) (4*k+16)) := by
  classical
  by_cases h : Cell (4*k+16) (4*k+17)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(4*k+16) = (8*k+32) := by omega
      have ht : (4*k+17)-1 = (4*k+16) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c6 (k : Nat) : ¬ (Cell (4*k+17) (4*k+18)) ∨ ¬ (Cell (4*k+17) (8*k+36)) := by
  by_cases h : Cell (4*k+17) (4*k+18)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c7 (k : Nat) : ¬ (Cell (4*k+17) (4*k+18)) ∨ ¬ (Cell (4*k+17) (8*k+37)) := by
  by_cases h : Cell (4*k+17) (4*k+18)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c8 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (4*k+17) (8*k+37)) ∨ (Cell (8*k+35) (8*k+36)) := by
  classical
  by_cases h : Cell (4*k+17) (8*k+37)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(4*k+17)+1 = (8*k+35) := by omega
      have ht : (8*k+37)-1 = (8*k+36) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c9 (k : Nat) : ¬ (Cell (4*k+17) (16*k+71)) ∨ ¬ (Cell (8*k+35) (8*k+36)) := by
  by_cases h : Cell (4*k+17) (16*k+71)
  · right; intro h2
    have ht := half_time (v := (4*k+17)) (t := (16*k+71)) (ch := (8*k+35)) (u := (8*k+36)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c10 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (2*k+8) (4*k+18)) ∨ (Cell (4*k+17) (4*k+18)) ∨ (Cell (8*k+36) (4*k+18)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (4*k+18) g (by omega)
  unfold Allowed at ha
  have options : z = (2*k+8) ∨ z = (4*k+17) ∨ z = (8*k+36) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c11 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (4*k+18) (16*k+75)) ∨ (Cell (8*k+36) (16*k+74)) := by
  classical
  by_cases h : Cell (4*k+18) (16*k+75)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(4*k+18) = (8*k+36) := by omega
      have ht : (16*k+75)-1 = (16*k+74) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c12 (k : Nat) : ¬ (Cell (8*k+32) (16*k+67)) ∨ ¬ (Cell (8*k+32) (4*k+16)) := by
  by_cases h : Cell (8*k+32) (16*k+67)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c13 (k : Nat) : ¬ (Cell (8*k+33) (8*k+34)) ∨ ¬ (Cell (8*k+33) (32*k+135)) := by
  by_cases h : Cell (8*k+33) (8*k+34)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c14 (k : Nat) : ¬ (Cell (8*k+33) (8*k+34)) ∨ ¬ (Cell (8*k+33) (32*k+137)) := by
  by_cases h : Cell (8*k+33) (8*k+34)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c15 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (8*k+33) (8*k+34)) ∨ (Cell (16*k+66) (8*k+33)) := by
  classical
  by_cases h : Cell (8*k+33) (8*k+34)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+33) = (16*k+66) := by omega
      have ht : (8*k+34)-1 = (8*k+33) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c16 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (4*k+16) (8*k+34)) ∨ (Cell (8*k+33) (8*k+34)) ∨ (Cell (16*k+68) (8*k+34)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (8*k+34) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+16) ∨ z = (8*k+33) ∨ z = (16*k+68) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c17 (k : Nat) : ¬ (Cell (8*k+34) (16*k+71)) ∨ ¬ (Cell (16*k+68) (16*k+69)) := by
  by_cases h : Cell (8*k+34) (16*k+71)
  · right; intro h2
    have ht := half_time (v := (8*k+34)) (t := (16*k+71)) (ch := (16*k+68)) (u := (16*k+69)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c18 (k : Nat) : ¬ (Cell (8*k+34) (16*k+71)) ∨ ¬ (Cell (16*k+68) (8*k+34)) := by
  by_cases h : Cell (8*k+34) (16*k+71)
  · right; intro h2
    have ht := half_time (v := (8*k+34)) (t := (16*k+71)) (ch := (16*k+68)) (u := (8*k+34)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c19 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (8*k+34) (16*k+71)) ∨ (Cell (16*k+69) (16*k+70)) := by
  classical
  by_cases h : Cell (8*k+34) (16*k+71)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(8*k+34)+1 = (16*k+69) := by omega
      have ht : (16*k+71)-1 = (16*k+70) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c20 (k : Nat) : ¬ (Cell (8*k+35) (8*k+36)) ∨ ¬ (Cell (8*k+35) (16*k+72)) := by
  by_cases h : Cell (8*k+35) (8*k+36)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c21 (k : Nat) : ¬ (Cell (8*k+35) (8*k+36)) ∨ ¬ (Cell (8*k+35) (32*k+143)) := by
  by_cases h : Cell (8*k+35) (8*k+36)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c22 (k : Nat) : ¬ (Cell (8*k+35) (8*k+36)) ∨ ¬ (Cell (8*k+35) (32*k+145)) := by
  by_cases h : Cell (8*k+35) (8*k+36)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c23 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (8*k+35) (8*k+36)) ∨ (Cell (16*k+70) (8*k+35)) := by
  classical
  by_cases h : Cell (8*k+35) (8*k+36)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+35) = (16*k+70) := by omega
      have ht : (8*k+36)-1 = (8*k+35) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c24 (k : Nat) : ¬ (Cell (8*k+36) (8*k+37)) ∨ ¬ (Cell (8*k+36) (16*k+74)) := by
  by_cases h : Cell (8*k+36) (8*k+37)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c25 (k : Nat) : ¬ (Cell (8*k+36) (8*k+37)) ∨ ¬ (Cell (8*k+36) (16*k+75)) := by
  by_cases h : Cell (8*k+36) (8*k+37)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c26 (k : Nat) : ¬ (Cell (8*k+36) (16*k+74)) ∨ ¬ (Cell (8*k+36) (4*k+18)) := by
  by_cases h : Cell (8*k+36) (16*k+74)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c27 (k : Nat) : ¬ (Cell (8*k+36) (16*k+75)) ∨ ¬ (Cell (8*k+36) (4*k+18)) := by
  by_cases h : Cell (8*k+36) (16*k+75)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c28 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (4*k+17) (8*k+36)) ∨ (Cell (8*k+35) (8*k+36)) ∨ (Cell (16*k+72) (8*k+36)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (8*k+36) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+17) ∨ z = (8*k+35) ∨ z = (16*k+72) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c29 (k : Nat) : ¬ (Cell (4*k+17) (8*k+36)) ∨ ¬ (Cell (8*k+35) (8*k+36)) := by
  by_cases h : Cell (4*k+17) (8*k+36)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c30 (k : Nat) : ¬ (Cell (8*k+36) (16*k+74)) ∨ ¬ (Cell (16*k+72) (8*k+36)) := by
  by_cases h : Cell (8*k+36) (16*k+74)
  · right; intro h2
    have ht := half_time (v := (8*k+36)) (t := (16*k+74)) (ch := (16*k+72)) (u := (8*k+36)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c31 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (8*k+36) (16*k+74)) ∨ (Cell (16*k+72) (16*k+73)) := by
  classical
  by_cases h : Cell (8*k+36) (16*k+74)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+36) = (16*k+72) := by omega
      have ht : (16*k+74)-1 = (16*k+73) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c32 (k : Nat) : ¬ (Cell (8*k+36) (16*k+75)) ∨ ¬ (Cell (16*k+72) (8*k+36)) := by
  by_cases h : Cell (8*k+36) (16*k+75)
  · right; intro h2
    have ht := half_time (v := (8*k+36)) (t := (16*k+75)) (ch := (16*k+72)) (u := (8*k+36)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c33 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (2*k+8) (8*k+37)) ∨ (Cell (4*k+17) (8*k+37)) ∨ (Cell (8*k+36) (8*k+37)) ∨ (Cell (16*k+74) (8*k+37)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (8*k+37) g (by omega)
  unfold Allowed at ha
  have options : z = (2*k+8) ∨ z = (4*k+17) ∨ z = (8*k+36) ∨ z = (16*k+74) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c34 (k : Nat) : ¬ (Cell (8*k+37) (32*k+152)) ∨ ¬ (Cell (16*k+74) (16*k+75)) := by
  by_cases h : Cell (8*k+37) (32*k+152)
  · right; intro h2
    have ht := half_time (v := (8*k+37)) (t := (32*k+152)) (ch := (16*k+74)) (u := (16*k+75)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c35 (k : Nat) : ¬ (Cell (8*k+37) (32*k+152)) ∨ ¬ (Cell (16*k+74) (8*k+37)) := by
  by_cases h : Cell (8*k+37) (32*k+152)
  · right; intro h2
    have ht := half_time (v := (8*k+37)) (t := (32*k+152)) (ch := (16*k+74)) (u := (8*k+37)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c36 (k : Nat) : ¬ (Cell (8*k+37) (32*k+152)) ∨ ¬ (Cell (16*k+75) (16*k+76)) := by
  by_cases h : Cell (8*k+37) (32*k+152)
  · right; intro h2
    have ht := half_time (v := (8*k+37)) (t := (32*k+152)) (ch := (16*k+75)) (u := (16*k+76)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c37 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (8*k+37) (32*k+152)) ∨ (Cell (16*k+74) (32*k+151)) := by
  classical
  by_cases h : Cell (8*k+37) (32*k+152)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(8*k+37) = (16*k+74) := by omega
      have ht : (32*k+152)-1 = (32*k+151) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c38 (k : Nat) : ¬ (Cell (16*k+66) (16*k+67)) ∨ ¬ (Cell (16*k+66) (8*k+33)) := by
  by_cases h : Cell (16*k+66) (16*k+67)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c39 (k : Nat) : ¬ (Cell (16*k+66) (32*k+135)) ∨ ¬ (Cell (16*k+66) (8*k+33)) := by
  by_cases h : Cell (16*k+66) (32*k+135)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c40 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (4*k+16) (16*k+67)) ∨ (Cell (8*k+32) (16*k+67)) ∨ (Cell (16*k+66) (16*k+67)) ∨ (Cell (32*k+134) (16*k+67)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (16*k+67) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+16) ∨ z = (8*k+32) ∨ z = (16*k+66) ∨ z = (32*k+134) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c41 (k : Nat) : ¬ (Cell (16*k+67) (32*k+137)) ∨ ¬ (Cell (32*k+134) (16*k+67)) := by
  by_cases h : Cell (16*k+67) (32*k+137)
  · right; intro h2
    have ht := half_time (v := (16*k+67)) (t := (32*k+137)) (ch := (32*k+134)) (u := (16*k+67)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c42 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+68) (16*k+69)) ∨ (Cell (16*k+68) (32*k+138)) ∨ (Cell (16*k+68) (32*k+139)) ∨ (Cell (16*k+68) (64*k+275)) ∨ (Cell (16*k+68) (64*k+277)) ∨ (Cell (16*k+68) (64*k+276)) ∨ (Cell (16*k+68) (8*k+34)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (16*k+68) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+69) ∨ z = (32*k+138) ∨ z = (32*k+139) ∨ z = (64*k+275) ∨ z = (64*k+277) ∨ z = (64*k+276) ∨ z = (8*k+34) := by omega
  rcases options with e | e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))))

private theorem c43 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (16*k+68) (32*k+138)) ∨ (Cell (32*k+136) (32*k+137)) := by
  classical
  by_cases h : Cell (16*k+68) (32*k+138)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+68) = (32*k+136) := by omega
      have ht : (32*k+138)-1 = (32*k+137) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c44 (k : Nat) : ¬ (Cell (16*k+68) (64*k+275)) ∨ ¬ (Cell (32*k+137) (32*k+138)) := by
  by_cases h : Cell (16*k+68) (64*k+275)
  · right; intro h2
    have ht := half_time (v := (16*k+68)) (t := (64*k+275)) (ch := (32*k+137)) (u := (32*k+138)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c45 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (16*k+68) (64*k+277)) ∨ (Cell (32*k+137) (64*k+276)) := by
  classical
  by_cases h : Cell (16*k+68) (64*k+277)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(16*k+68)+1 = (32*k+137) := by omega
      have ht : (64*k+277)-1 = (64*k+276) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c46 (k : Nat) : ¬ (Cell (16*k+68) (64*k+276)) ∨ ¬ (Cell (32*k+137) (32*k+138)) := by
  by_cases h : Cell (16*k+68) (64*k+276)
  · right; intro h2
    have ht := half_time (v := (16*k+68)) (t := (64*k+276)) (ch := (32*k+137)) (u := (32*k+138)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c47 (k : Nat) : ¬ (Cell (16*k+69) (16*k+70)) ∨ ¬ (Cell (16*k+69) (32*k+140)) := by
  by_cases h : Cell (16*k+69) (16*k+70)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c48 (k : Nat) : ¬ (Cell (16*k+70) (16*k+71)) ∨ ¬ (Cell (16*k+70) (8*k+35)) := by
  by_cases h : Cell (16*k+70) (16*k+71)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c49 (k : Nat) : ¬ (Cell (16*k+70) (32*k+142)) ∨ ¬ (Cell (16*k+70) (8*k+35)) := by
  by_cases h : Cell (16*k+70) (32*k+142)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c50 (k : Nat) : ¬ (Cell (16*k+70) (32*k+143)) ∨ ¬ (Cell (16*k+70) (8*k+35)) := by
  by_cases h : Cell (16*k+70) (32*k+143)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c51 (k : Nat) : ¬ (Cell (16*k+69) (16*k+70)) ∨ ¬ (Cell (32*k+140) (16*k+70)) := by
  by_cases h : Cell (16*k+69) (16*k+70)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c52 (k : Nat) : ¬ (Cell (16*k+71) (16*k+72)) ∨ ¬ (Cell (16*k+71) (32*k+145)) := by
  by_cases h : Cell (16*k+71) (16*k+72)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c53 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (4*k+17) (16*k+71)) ∨ (Cell (8*k+34) (16*k+71)) ∨ (Cell (16*k+70) (16*k+71)) ∨ (Cell (32*k+142) (16*k+71)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (16*k+71) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+17) ∨ z = (8*k+34) ∨ z = (16*k+70) ∨ z = (32*k+142) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c54 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (16*k+71) (16*k+72)) ∨ (Cell (32*k+142) (16*k+71)) := by
  classical
  by_cases h : Cell (16*k+71) (16*k+72)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+71) = (32*k+142) := by omega
      have ht : (16*k+72)-1 = (16*k+71) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c55 (k : Nat) : ¬ (Cell (16*k+71) (32*k+145)) ∨ ¬ (Cell (32*k+142) (32*k+143)) := by
  by_cases h : Cell (16*k+71) (32*k+145)
  · right; intro h2
    have ht := half_time (v := (16*k+71)) (t := (32*k+145)) (ch := (32*k+142)) (u := (32*k+143)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c56 (k : Nat) : ¬ (Cell (16*k+71) (32*k+145)) ∨ ¬ (Cell (32*k+142) (16*k+71)) := by
  by_cases h : Cell (16*k+71) (32*k+145)
  · right; intro h2
    have ht := half_time (v := (16*k+71)) (t := (32*k+145)) (ch := (32*k+142)) (u := (16*k+71)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c57 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+72) (16*k+73)) ∨ (Cell (16*k+72) (32*k+146)) ∨ (Cell (16*k+72) (32*k+147)) ∨ (Cell (16*k+72) (64*k+291)) ∨ (Cell (16*k+72) (64*k+293)) ∨ (Cell (16*k+72) (64*k+292)) ∨ (Cell (16*k+72) (8*k+36)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (16*k+72) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+73) ∨ z = (32*k+146) ∨ z = (32*k+147) ∨ z = (64*k+291) ∨ z = (64*k+293) ∨ z = (64*k+292) ∨ z = (8*k+36) := by omega
  rcases options with e | e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))))

private theorem c58 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (8*k+35) (16*k+72)) ∨ (Cell (16*k+71) (16*k+72)) ∨ (Cell (32*k+144) (16*k+72)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (16*k+72) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+35) ∨ z = (16*k+71) ∨ z = (32*k+144) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c59 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (16*k+72) (16*k+73)) ∨ (Cell (32*k+144) (16*k+72)) := by
  classical
  by_cases h : Cell (16*k+72) (16*k+73)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+72) = (32*k+144) := by omega
      have ht : (16*k+73)-1 = (16*k+72) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c60 (k : Nat) : ¬ (Cell (16*k+72) (32*k+146)) ∨ ¬ (Cell (32*k+144) (16*k+72)) := by
  by_cases h : Cell (16*k+72) (32*k+146)
  · right; intro h2
    have ht := half_time (v := (16*k+72)) (t := (32*k+146)) (ch := (32*k+144)) (u := (16*k+72)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c61 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (16*k+72) (32*k+146)) ∨ (Cell (32*k+144) (32*k+145)) := by
  classical
  by_cases h : Cell (16*k+72) (32*k+146)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+72) = (32*k+144) := by omega
      have ht : (32*k+146)-1 = (32*k+145) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c62 (k : Nat) : ¬ (Cell (16*k+72) (64*k+291)) ∨ ¬ (Cell (32*k+144) (32*k+145)) := by
  by_cases h : Cell (16*k+72) (64*k+291)
  · right; intro h2
    have ht := half_time (v := (16*k+72)) (t := (64*k+291)) (ch := (32*k+144)) (u := (32*k+145)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c63 (k : Nat) : ¬ (Cell (16*k+72) (64*k+291)) ∨ ¬ (Cell (32*k+144) (16*k+72)) := by
  by_cases h : Cell (16*k+72) (64*k+291)
  · right; intro h2
    have ht := half_time (v := (16*k+72)) (t := (64*k+291)) (ch := (32*k+144)) (u := (16*k+72)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c64 (k : Nat) : ¬ (Cell (16*k+72) (64*k+291)) ∨ ¬ (Cell (32*k+145) (32*k+146)) := by
  by_cases h : Cell (16*k+72) (64*k+291)
  · right; intro h2
    have ht := half_time (v := (16*k+72)) (t := (64*k+291)) (ch := (32*k+145)) (u := (32*k+146)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c65 (k : Nat) : ¬ (Cell (16*k+72) (64*k+293)) ∨ ¬ (Cell (32*k+144) (32*k+145)) := by
  by_cases h : Cell (16*k+72) (64*k+293)
  · right; intro h2
    have ht := half_time (v := (16*k+72)) (t := (64*k+293)) (ch := (32*k+144)) (u := (32*k+145)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c66 (k : Nat) : ¬ (Cell (16*k+72) (64*k+293)) ∨ ¬ (Cell (32*k+144) (16*k+72)) := by
  by_cases h : Cell (16*k+72) (64*k+293)
  · right; intro h2
    have ht := half_time (v := (16*k+72)) (t := (64*k+293)) (ch := (32*k+144)) (u := (16*k+72)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c67 (k : Nat) : ¬ (Cell (16*k+72) (64*k+293)) ∨ ¬ (Cell (32*k+145) (32*k+146)) := by
  by_cases h : Cell (16*k+72) (64*k+293)
  · right; intro h2
    have ht := half_time (v := (16*k+72)) (t := (64*k+293)) (ch := (32*k+145)) (u := (32*k+146)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c68 (k : Nat) : ¬ (Cell (16*k+72) (64*k+292)) ∨ ¬ (Cell (32*k+144) (32*k+145)) := by
  by_cases h : Cell (16*k+72) (64*k+292)
  · right; intro h2
    have ht := half_time (v := (16*k+72)) (t := (64*k+292)) (ch := (32*k+144)) (u := (32*k+145)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c69 (k : Nat) : ¬ (Cell (16*k+72) (64*k+292)) ∨ ¬ (Cell (32*k+144) (16*k+72)) := by
  by_cases h : Cell (16*k+72) (64*k+292)
  · right; intro h2
    have ht := half_time (v := (16*k+72)) (t := (64*k+292)) (ch := (32*k+144)) (u := (16*k+72)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c70 (k : Nat) : ¬ (Cell (16*k+72) (64*k+292)) ∨ ¬ (Cell (32*k+145) (32*k+146)) := by
  by_cases h : Cell (16*k+72) (64*k+292)
  · right; intro h2
    have ht := half_time (v := (16*k+72)) (t := (64*k+292)) (ch := (32*k+145)) (u := (32*k+146)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c71 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+73) (16*k+74)) ∨ (Cell (16*k+73) (32*k+148)) ∨ (Cell (16*k+73) (32*k+149)) ∨ (Cell (16*k+73) (64*k+295)) ∨ (Cell (16*k+73) (64*k+297)) ∨ (Cell (16*k+73) (64*k+296)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (16*k+73) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+74) ∨ z = (32*k+148) ∨ z = (32*k+149) ∨ z = (64*k+295) ∨ z = (64*k+297) ∨ z = (64*k+296) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c72 (k : Nat) : ¬ (Cell (16*k+73) (16*k+74)) ∨ ¬ (Cell (16*k+73) (32*k+148)) := by
  by_cases h : Cell (16*k+73) (16*k+74)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c73 (k : Nat) : ¬ (Cell (16*k+72) (16*k+73)) ∨ ¬ (Cell (32*k+146) (16*k+73)) := by
  by_cases h : Cell (16*k+72) (16*k+73)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c74 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (16*k+73) (16*k+74)) ∨ (Cell (32*k+146) (16*k+73)) := by
  classical
  by_cases h : Cell (16*k+73) (16*k+74)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+73) = (32*k+146) := by omega
      have ht : (16*k+74)-1 = (16*k+73) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c75 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (16*k+73) (32*k+148)) ∨ (Cell (32*k+146) (32*k+147)) := by
  classical
  by_cases h : Cell (16*k+73) (32*k+148)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+73) = (32*k+146) := by omega
      have ht : (32*k+148)-1 = (32*k+147) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c76 (k : Nat) : ¬ (Cell (16*k+73) (64*k+295)) ∨ ¬ (Cell (32*k+147) (32*k+148)) := by
  by_cases h : Cell (16*k+73) (64*k+295)
  · right; intro h2
    have ht := half_time (v := (16*k+73)) (t := (64*k+295)) (ch := (32*k+147)) (u := (32*k+148)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c77 (k : Nat) : ¬ (Cell (16*k+73) (64*k+297)) ∨ ¬ (Cell (32*k+147) (32*k+148)) := by
  by_cases h : Cell (16*k+73) (64*k+297)
  · right; intro h2
    have ht := half_time (v := (16*k+73)) (t := (64*k+297)) (ch := (32*k+147)) (u := (32*k+148)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c78 (k : Nat) : ¬ (Cell (16*k+73) (64*k+296)) ∨ ¬ (Cell (32*k+147) (32*k+148)) := by
  by_cases h : Cell (16*k+73) (64*k+296)
  · right; intro h2
    have ht := half_time (v := (16*k+73)) (t := (64*k+296)) (ch := (32*k+147)) (u := (32*k+148)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c79 (k : Nat) : ¬ (Cell (16*k+74) (32*k+151)) ∨ ¬ (Cell (16*k+74) (64*k+300)) := by
  by_cases h : Cell (16*k+74) (32*k+151)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c80 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (8*k+36) (16*k+74)) ∨ (Cell (16*k+73) (16*k+74)) ∨ (Cell (32*k+148) (16*k+74)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (16*k+74) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+36) ∨ z = (16*k+73) ∨ z = (32*k+148) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c81 (k : Nat) : ¬ (Cell (8*k+36) (16*k+74)) ∨ ¬ (Cell (16*k+73) (16*k+74)) := by
  by_cases h : Cell (8*k+36) (16*k+74)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c82 (k : Nat) : ¬ (Cell (16*k+74) (32*k+151)) ∨ ¬ (Cell (32*k+148) (32*k+149)) := by
  by_cases h : Cell (16*k+74) (32*k+151)
  · right; intro h2
    have ht := half_time (v := (16*k+74)) (t := (32*k+151)) (ch := (32*k+148)) (u := (32*k+149)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c83 (k : Nat) : ¬ (Cell (16*k+74) (32*k+151)) ∨ ¬ (Cell (32*k+148) (16*k+74)) := by
  by_cases h : Cell (16*k+74) (32*k+151)
  · right; intro h2
    have ht := half_time (v := (16*k+74)) (t := (32*k+151)) (ch := (32*k+148)) (u := (16*k+74)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c84 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (16*k+74) (32*k+151)) ∨ (Cell (32*k+149) (32*k+150)) := by
  classical
  by_cases h : Cell (16*k+74) (32*k+151)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(16*k+74)+1 = (32*k+149) := by omega
      have ht : (32*k+151)-1 = (32*k+150) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c85 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+75) (16*k+76)) ∨ (Cell (16*k+75) (32*k+152)) ∨ (Cell (16*k+75) (32*k+153)) ∨ (Cell (16*k+75) (64*k+303)) ∨ (Cell (16*k+75) (64*k+305)) ∨ (Cell (16*k+75) (64*k+304)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (16*k+75) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+76) ∨ z = (32*k+152) ∨ z = (32*k+153) ∨ z = (64*k+303) ∨ z = (64*k+305) ∨ z = (64*k+304) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c86 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (4*k+18) (16*k+75)) ∨ (Cell (8*k+36) (16*k+75)) ∨ (Cell (16*k+74) (16*k+75)) ∨ (Cell (32*k+150) (16*k+75)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (16*k+75) g (by omega)
  unfold Allowed at ha
  have options : z = (4*k+18) ∨ z = (8*k+36) ∨ z = (16*k+74) ∨ z = (32*k+150) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c87 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (16*k+75) (32*k+153)) ∨ (Cell (32*k+151) (32*k+152)) := by
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

private theorem c88 (k : Nat) : ¬ (Cell (16*k+75) (64*k+303)) ∨ ¬ (Cell (32*k+150) (16*k+75)) := by
  by_cases h : Cell (16*k+75) (64*k+303)
  · right; intro h2
    have ht := half_time (v := (16*k+75)) (t := (64*k+303)) (ch := (32*k+150)) (u := (16*k+75)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c89 (k : Nat) : ¬ (Cell (16*k+75) (64*k+305)) ∨ ¬ (Cell (32*k+150) (16*k+75)) := by
  by_cases h : Cell (16*k+75) (64*k+305)
  · right; intro h2
    have ht := half_time (v := (16*k+75)) (t := (64*k+305)) (ch := (32*k+150)) (u := (16*k+75)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c90 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (16*k+75) (64*k+304)) ∨ (Cell (32*k+150) (64*k+303)) := by
  classical
  by_cases h : Cell (16*k+75) (64*k+304)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(16*k+75) = (32*k+150) := by omega
      have ht : (64*k+304)-1 = (64*k+303) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c91 (k : Nat) : ¬ (Cell (32*k+134) (32*k+135)) ∨ ¬ (Cell (32*k+134) (16*k+67)) := by
  by_cases h : Cell (32*k+134) (32*k+135)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c92 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (32*k+135) (32*k+136)) ∨ (Cell (32*k+135) (64*k+272)) ∨ (Cell (32*k+135) (64*k+273)) ∨ (Cell (32*k+135) (128*k+543)) ∨ (Cell (32*k+135) (128*k+545)) ∨ (Cell (32*k+135) (128*k+544)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (32*k+135) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+136) ∨ z = (64*k+272) ∨ z = (64*k+273) ∨ z = (128*k+543) ∨ z = (128*k+545) ∨ z = (128*k+544) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c93 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (8*k+33) (32*k+135)) ∨ (Cell (16*k+66) (32*k+135)) ∨ (Cell (32*k+134) (32*k+135)) ∨ (Cell (64*k+270) (32*k+135)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (32*k+135) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+33) ∨ z = (16*k+66) ∨ z = (32*k+134) ∨ z = (64*k+270) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c94 (k : Nat) : ¬ (Cell (32*k+135) (64*k+272)) ∨ ¬ (Cell (64*k+270) (32*k+135)) := by
  by_cases h : Cell (32*k+135) (64*k+272)
  · right; intro h2
    have ht := half_time (v := (32*k+135)) (t := (64*k+272)) (ch := (64*k+270)) (u := (32*k+135)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c95 (k : Nat) : ¬ (Cell (32*k+135) (64*k+273)) ∨ ¬ (Cell (64*k+270) (32*k+135)) := by
  by_cases h : Cell (32*k+135) (64*k+273)
  · right; intro h2
    have ht := half_time (v := (32*k+135)) (t := (64*k+273)) (ch := (64*k+270)) (u := (32*k+135)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c96 (k : Nat) : ¬ (Cell (32*k+135) (128*k+543)) ∨ ¬ (Cell (64*k+270) (32*k+135)) := by
  by_cases h : Cell (32*k+135) (128*k+543)
  · right; intro h2
    have ht := half_time (v := (32*k+135)) (t := (128*k+543)) (ch := (64*k+270)) (u := (32*k+135)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c97 (k : Nat) : ¬ (Cell (32*k+135) (128*k+545)) ∨ ¬ (Cell (64*k+270) (32*k+135)) := by
  by_cases h : Cell (32*k+135) (128*k+545)
  · right; intro h2
    have ht := half_time (v := (32*k+135)) (t := (128*k+545)) (ch := (64*k+270)) (u := (32*k+135)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c98 (k : Nat) : ¬ (Cell (32*k+135) (128*k+544)) ∨ ¬ (Cell (64*k+270) (32*k+135)) := by
  by_cases h : Cell (32*k+135) (128*k+544)
  · right; intro h2
    have ht := half_time (v := (32*k+135)) (t := (128*k+544)) (ch := (64*k+270)) (u := (32*k+135)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c99 (k : Nat) : ¬ (Cell (32*k+135) (32*k+136)) ∨ ¬ (Cell (64*k+272) (32*k+136)) := by
  by_cases h : Cell (32*k+135) (32*k+136)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c100 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (32*k+136) (32*k+137)) ∨ (Cell (64*k+272) (32*k+136)) := by
  classical
  by_cases h : Cell (32*k+136) (32*k+137)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+136) = (64*k+272) := by omega
      have ht : (32*k+137)-1 = (32*k+136) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c101 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (32*k+137) (32*k+138)) ∨ (Cell (32*k+137) (64*k+276)) ∨ (Cell (32*k+137) (64*k+277)) ∨ (Cell (32*k+137) (128*k+551)) ∨ (Cell (32*k+137) (128*k+553)) ∨ (Cell (32*k+137) (128*k+552)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (32*k+137) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+138) ∨ z = (64*k+276) ∨ z = (64*k+277) ∨ z = (128*k+551) ∨ z = (128*k+553) ∨ z = (128*k+552) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c102 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (8*k+33) (32*k+137)) ∨ (Cell (16*k+67) (32*k+137)) ∨ (Cell (32*k+136) (32*k+137)) ∨ (Cell (64*k+274) (32*k+137)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (32*k+137) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+33) ∨ z = (16*k+67) ∨ z = (32*k+136) ∨ z = (64*k+274) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c103 (k : Nat) : ¬ (Cell (32*k+137) (64*k+276)) ∨ ¬ (Cell (64*k+274) (32*k+137)) := by
  by_cases h : Cell (32*k+137) (64*k+276)
  · right; intro h2
    have ht := half_time (v := (32*k+137)) (t := (64*k+276)) (ch := (64*k+274)) (u := (32*k+137)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c104 (k : Nat) : ¬ (Cell (32*k+137) (64*k+277)) ∨ ¬ (Cell (64*k+274) (32*k+137)) := by
  by_cases h : Cell (32*k+137) (64*k+277)
  · right; intro h2
    have ht := half_time (v := (32*k+137)) (t := (64*k+277)) (ch := (64*k+274)) (u := (32*k+137)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c105 (k : Nat) : ¬ (Cell (32*k+137) (128*k+551)) ∨ ¬ (Cell (64*k+274) (32*k+137)) := by
  by_cases h : Cell (32*k+137) (128*k+551)
  · right; intro h2
    have ht := half_time (v := (32*k+137)) (t := (128*k+551)) (ch := (64*k+274)) (u := (32*k+137)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c106 (k : Nat) : ¬ (Cell (32*k+137) (128*k+553)) ∨ ¬ (Cell (64*k+274) (32*k+137)) := by
  by_cases h : Cell (32*k+137) (128*k+553)
  · right; intro h2
    have ht := half_time (v := (32*k+137)) (t := (128*k+553)) (ch := (64*k+274)) (u := (32*k+137)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c107 (k : Nat) : ¬ (Cell (32*k+137) (128*k+552)) ∨ ¬ (Cell (64*k+274) (32*k+137)) := by
  by_cases h : Cell (32*k+137) (128*k+552)
  · right; intro h2
    have ht := half_time (v := (32*k+137)) (t := (128*k+552)) (ch := (64*k+274)) (u := (32*k+137)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c108 (k : Nat) : ¬ (Cell (16*k+68) (32*k+139)) ∨ ¬ (Cell (64*k+278) (32*k+139)) := by
  by_cases h : Cell (16*k+68) (32*k+139)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c109 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (32*k+139) (32*k+140)) ∨ (Cell (64*k+278) (32*k+139)) := by
  classical
  by_cases h : Cell (32*k+139) (32*k+140)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+139) = (64*k+278) := by omega
      have ht : (32*k+140)-1 = (32*k+139) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c110 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (32*k+140) (32*k+141)) ∨ (Cell (32*k+140) (64*k+282)) ∨ (Cell (32*k+140) (64*k+283)) ∨ (Cell (32*k+140) (128*k+563)) ∨ (Cell (32*k+140) (128*k+565)) ∨ (Cell (32*k+140) (128*k+564)) ∨ (Cell (32*k+140) (16*k+70)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (32*k+140) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+141) ∨ z = (64*k+282) ∨ z = (64*k+283) ∨ z = (128*k+563) ∨ z = (128*k+565) ∨ z = (128*k+564) ∨ z = (16*k+70) := by omega
  rcases options with e | e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))))

private theorem c111 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+69) (32*k+140)) ∨ (Cell (32*k+139) (32*k+140)) ∨ (Cell (64*k+280) (32*k+140)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (32*k+140) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+69) ∨ z = (32*k+139) ∨ z = (64*k+280) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c112 (k : Nat) : ¬ (Cell (32*k+140) (64*k+282)) ∨ ¬ (Cell (64*k+280) (32*k+140)) := by
  by_cases h : Cell (32*k+140) (64*k+282)
  · right; intro h2
    have ht := half_time (v := (32*k+140)) (t := (64*k+282)) (ch := (64*k+280)) (u := (32*k+140)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c113 (k : Nat) : ¬ (Cell (32*k+140) (64*k+283)) ∨ ¬ (Cell (64*k+280) (32*k+140)) := by
  by_cases h : Cell (32*k+140) (64*k+283)
  · right; intro h2
    have ht := half_time (v := (32*k+140)) (t := (64*k+283)) (ch := (64*k+280)) (u := (32*k+140)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c114 (k : Nat) : ¬ (Cell (32*k+140) (128*k+563)) ∨ ¬ (Cell (64*k+280) (32*k+140)) := by
  by_cases h : Cell (32*k+140) (128*k+563)
  · right; intro h2
    have ht := half_time (v := (32*k+140)) (t := (128*k+563)) (ch := (64*k+280)) (u := (32*k+140)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c115 (k : Nat) : ¬ (Cell (32*k+140) (128*k+565)) ∨ ¬ (Cell (64*k+280) (32*k+140)) := by
  by_cases h : Cell (32*k+140) (128*k+565)
  · right; intro h2
    have ht := half_time (v := (32*k+140)) (t := (128*k+565)) (ch := (64*k+280)) (u := (32*k+140)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c116 (k : Nat) : ¬ (Cell (32*k+140) (128*k+564)) ∨ ¬ (Cell (64*k+280) (32*k+140)) := by
  by_cases h : Cell (32*k+140) (128*k+564)
  · right; intro h2
    have ht := half_time (v := (32*k+140)) (t := (128*k+564)) (ch := (64*k+280)) (u := (32*k+140)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c117 (k : Nat) : ¬ (Cell (32*k+140) (32*k+141)) ∨ ¬ (Cell (64*k+282) (32*k+141)) := by
  by_cases h : Cell (32*k+140) (32*k+141)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c118 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (32*k+141) (32*k+142)) ∨ (Cell (64*k+282) (32*k+141)) := by
  classical
  by_cases h : Cell (32*k+141) (32*k+142)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+141) = (64*k+282) := by omega
      have ht : (32*k+142)-1 = (32*k+141) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c119 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (32*k+142) (32*k+143)) ∨ (Cell (32*k+142) (64*k+286)) ∨ (Cell (32*k+142) (64*k+287)) ∨ (Cell (32*k+142) (128*k+571)) ∨ (Cell (32*k+142) (128*k+573)) ∨ (Cell (32*k+142) (128*k+572)) ∨ (Cell (32*k+142) (16*k+71)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (32*k+142) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+143) ∨ z = (64*k+286) ∨ z = (64*k+287) ∨ z = (128*k+571) ∨ z = (128*k+573) ∨ z = (128*k+572) ∨ z = (16*k+71) := by omega
  rcases options with e | e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))))

private theorem c120 (k : Nat) : ¬ (Cell (32*k+142) (32*k+143)) ∨ ¬ (Cell (32*k+142) (16*k+71)) := by
  by_cases h : Cell (32*k+142) (32*k+143)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c121 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+70) (32*k+142)) ∨ (Cell (32*k+141) (32*k+142)) ∨ (Cell (64*k+284) (32*k+142)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (32*k+142) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+70) ∨ z = (32*k+141) ∨ z = (64*k+284) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c122 (k : Nat) : ¬ (Cell (32*k+142) (64*k+286)) ∨ ¬ (Cell (64*k+284) (32*k+142)) := by
  by_cases h : Cell (32*k+142) (64*k+286)
  · right; intro h2
    have ht := half_time (v := (32*k+142)) (t := (64*k+286)) (ch := (64*k+284)) (u := (32*k+142)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c123 (k : Nat) : ¬ (Cell (32*k+142) (64*k+287)) ∨ ¬ (Cell (64*k+284) (32*k+142)) := by
  by_cases h : Cell (32*k+142) (64*k+287)
  · right; intro h2
    have ht := half_time (v := (32*k+142)) (t := (64*k+287)) (ch := (64*k+284)) (u := (32*k+142)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c124 (k : Nat) : ¬ (Cell (32*k+142) (128*k+571)) ∨ ¬ (Cell (64*k+284) (32*k+142)) := by
  by_cases h : Cell (32*k+142) (128*k+571)
  · right; intro h2
    have ht := half_time (v := (32*k+142)) (t := (128*k+571)) (ch := (64*k+284)) (u := (32*k+142)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c125 (k : Nat) : ¬ (Cell (32*k+142) (128*k+573)) ∨ ¬ (Cell (64*k+284) (32*k+142)) := by
  by_cases h : Cell (32*k+142) (128*k+573)
  · right; intro h2
    have ht := half_time (v := (32*k+142)) (t := (128*k+573)) (ch := (64*k+284)) (u := (32*k+142)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c126 (k : Nat) : ¬ (Cell (32*k+142) (128*k+572)) ∨ ¬ (Cell (64*k+284) (32*k+142)) := by
  by_cases h : Cell (32*k+142) (128*k+572)
  · right; intro h2
    have ht := half_time (v := (32*k+142)) (t := (128*k+572)) (ch := (64*k+284)) (u := (32*k+142)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c127 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (32*k+143) (32*k+144)) ∨ (Cell (32*k+143) (64*k+288)) ∨ (Cell (32*k+143) (64*k+289)) ∨ (Cell (32*k+143) (128*k+575)) ∨ (Cell (32*k+143) (128*k+577)) ∨ (Cell (32*k+143) (128*k+576)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (32*k+143) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+144) ∨ z = (64*k+288) ∨ z = (64*k+289) ∨ z = (128*k+575) ∨ z = (128*k+577) ∨ z = (128*k+576) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c128 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (8*k+35) (32*k+143)) ∨ (Cell (16*k+70) (32*k+143)) ∨ (Cell (32*k+142) (32*k+143)) ∨ (Cell (64*k+286) (32*k+143)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (32*k+143) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+35) ∨ z = (16*k+70) ∨ z = (32*k+142) ∨ z = (64*k+286) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c129 (k : Nat) : ¬ (Cell (32*k+143) (64*k+288)) ∨ ¬ (Cell (64*k+286) (32*k+143)) := by
  by_cases h : Cell (32*k+143) (64*k+288)
  · right; intro h2
    have ht := half_time (v := (32*k+143)) (t := (64*k+288)) (ch := (64*k+286)) (u := (32*k+143)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c130 (k : Nat) : ¬ (Cell (32*k+143) (64*k+289)) ∨ ¬ (Cell (64*k+286) (32*k+143)) := by
  by_cases h : Cell (32*k+143) (64*k+289)
  · right; intro h2
    have ht := half_time (v := (32*k+143)) (t := (64*k+289)) (ch := (64*k+286)) (u := (32*k+143)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c131 (k : Nat) : ¬ (Cell (32*k+143) (128*k+575)) ∨ ¬ (Cell (64*k+286) (32*k+143)) := by
  by_cases h : Cell (32*k+143) (128*k+575)
  · right; intro h2
    have ht := half_time (v := (32*k+143)) (t := (128*k+575)) (ch := (64*k+286)) (u := (32*k+143)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c132 (k : Nat) : ¬ (Cell (32*k+143) (128*k+577)) ∨ ¬ (Cell (64*k+286) (32*k+143)) := by
  by_cases h : Cell (32*k+143) (128*k+577)
  · right; intro h2
    have ht := half_time (v := (32*k+143)) (t := (128*k+577)) (ch := (64*k+286)) (u := (32*k+143)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c133 (k : Nat) : ¬ (Cell (32*k+143) (128*k+576)) ∨ ¬ (Cell (64*k+286) (32*k+143)) := by
  by_cases h : Cell (32*k+143) (128*k+576)
  · right; intro h2
    have ht := half_time (v := (32*k+143)) (t := (128*k+576)) (ch := (64*k+286)) (u := (32*k+143)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c134 (k : Nat) : ¬ (Cell (32*k+144) (32*k+145)) ∨ ¬ (Cell (32*k+144) (16*k+72)) := by
  by_cases h : Cell (32*k+144) (32*k+145)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c135 (k : Nat) : ¬ (Cell (32*k+143) (32*k+144)) ∨ ¬ (Cell (64*k+288) (32*k+144)) := by
  by_cases h : Cell (32*k+143) (32*k+144)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c136 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (32*k+144) (32*k+145)) ∨ (Cell (64*k+288) (32*k+144)) := by
  classical
  by_cases h : Cell (32*k+144) (32*k+145)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+144) = (64*k+288) := by omega
      have ht : (32*k+145)-1 = (32*k+144) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c137 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (32*k+145) (32*k+146)) ∨ (Cell (32*k+145) (64*k+292)) ∨ (Cell (32*k+145) (64*k+293)) ∨ (Cell (32*k+145) (128*k+583)) ∨ (Cell (32*k+145) (128*k+585)) ∨ (Cell (32*k+145) (128*k+584)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (32*k+145) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+146) ∨ z = (64*k+292) ∨ z = (64*k+293) ∨ z = (128*k+583) ∨ z = (128*k+585) ∨ z = (128*k+584) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c138 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (8*k+35) (32*k+145)) ∨ (Cell (16*k+71) (32*k+145)) ∨ (Cell (32*k+144) (32*k+145)) ∨ (Cell (64*k+290) (32*k+145)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (32*k+145) g (by omega)
  unfold Allowed at ha
  have options : z = (8*k+35) ∨ z = (16*k+71) ∨ z = (32*k+144) ∨ z = (64*k+290) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c139 (k : Nat) : ¬ (Cell (32*k+145) (64*k+292)) ∨ ¬ (Cell (64*k+290) (32*k+145)) := by
  by_cases h : Cell (32*k+145) (64*k+292)
  · right; intro h2
    have ht := half_time (v := (32*k+145)) (t := (64*k+292)) (ch := (64*k+290)) (u := (32*k+145)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c140 (k : Nat) : ¬ (Cell (32*k+145) (64*k+293)) ∨ ¬ (Cell (64*k+290) (32*k+145)) := by
  by_cases h : Cell (32*k+145) (64*k+293)
  · right; intro h2
    have ht := half_time (v := (32*k+145)) (t := (64*k+293)) (ch := (64*k+290)) (u := (32*k+145)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c141 (k : Nat) : ¬ (Cell (32*k+145) (128*k+583)) ∨ ¬ (Cell (64*k+290) (32*k+145)) := by
  by_cases h : Cell (32*k+145) (128*k+583)
  · right; intro h2
    have ht := half_time (v := (32*k+145)) (t := (128*k+583)) (ch := (64*k+290)) (u := (32*k+145)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c142 (k : Nat) : ¬ (Cell (32*k+145) (128*k+585)) ∨ ¬ (Cell (64*k+290) (32*k+145)) := by
  by_cases h : Cell (32*k+145) (128*k+585)
  · right; intro h2
    have ht := half_time (v := (32*k+145)) (t := (128*k+585)) (ch := (64*k+290)) (u := (32*k+145)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c143 (k : Nat) : ¬ (Cell (32*k+145) (128*k+584)) ∨ ¬ (Cell (64*k+290) (32*k+145)) := by
  by_cases h : Cell (32*k+145) (128*k+584)
  · right; intro h2
    have ht := half_time (v := (32*k+145)) (t := (128*k+584)) (ch := (64*k+290)) (u := (32*k+145)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c144 (k : Nat) : ¬ (Cell (32*k+146) (64*k+295)) ∨ ¬ (Cell (32*k+146) (16*k+73)) := by
  by_cases h : Cell (32*k+146) (64*k+295)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c145 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+72) (32*k+146)) ∨ (Cell (32*k+145) (32*k+146)) ∨ (Cell (64*k+292) (32*k+146)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (32*k+146) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+72) ∨ z = (32*k+145) ∨ z = (64*k+292) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c146 (k : Nat) : ¬ (Cell (16*k+72) (32*k+146)) ∨ ¬ (Cell (64*k+292) (32*k+146)) := by
  by_cases h : Cell (16*k+72) (32*k+146)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c147 (k : Nat) : ¬ (Cell (32*k+145) (32*k+146)) ∨ ¬ (Cell (64*k+292) (32*k+146)) := by
  by_cases h : Cell (32*k+145) (32*k+146)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c148 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (32*k+146) (32*k+147)) ∨ (Cell (64*k+292) (32*k+146)) := by
  classical
  by_cases h : Cell (32*k+146) (32*k+147)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+146) = (64*k+292) := by omega
      have ht : (32*k+147)-1 = (32*k+146) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c149 (k : Nat) : ¬ (Cell (32*k+147) (32*k+148)) ∨ ¬ (Cell (32*k+147) (64*k+297)) := by
  by_cases h : Cell (32*k+147) (32*k+148)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c150 (k : Nat) : ¬ (Cell (16*k+72) (32*k+147)) ∨ ¬ (Cell (64*k+294) (32*k+147)) := by
  by_cases h : Cell (16*k+72) (32*k+147)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c151 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (32*k+147) (32*k+148)) ∨ (Cell (64*k+294) (32*k+147)) := by
  classical
  by_cases h : Cell (32*k+147) (32*k+148)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+147) = (64*k+294) := by omega
      have ht : (32*k+148)-1 = (32*k+147) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c152 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (32*k+148) (32*k+149)) ∨ (Cell (32*k+148) (64*k+298)) ∨ (Cell (32*k+148) (64*k+299)) ∨ (Cell (32*k+148) (128*k+595)) ∨ (Cell (32*k+148) (128*k+597)) ∨ (Cell (32*k+148) (128*k+596)) ∨ (Cell (32*k+148) (16*k+74)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (32*k+148) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+149) ∨ z = (64*k+298) ∨ z = (64*k+299) ∨ z = (128*k+595) ∨ z = (128*k+597) ∨ z = (128*k+596) ∨ z = (16*k+74) := by omega
  rcases options with e | e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))))

private theorem c153 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+73) (32*k+148)) ∨ (Cell (32*k+147) (32*k+148)) ∨ (Cell (64*k+296) (32*k+148)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (32*k+148) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+73) ∨ z = (32*k+147) ∨ z = (64*k+296) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c154 (k : Nat) : ¬ (Cell (32*k+148) (64*k+298)) ∨ ¬ (Cell (64*k+296) (32*k+148)) := by
  by_cases h : Cell (32*k+148) (64*k+298)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (64*k+298)) (ch := (64*k+296)) (u := (32*k+148)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c155 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (32*k+148) (64*k+298)) ∨ (Cell (64*k+296) (64*k+297)) := by
  classical
  by_cases h : Cell (32*k+148) (64*k+298)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+148) = (64*k+296) := by omega
      have ht : (64*k+298)-1 = (64*k+297) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c156 (k : Nat) : ¬ (Cell (32*k+148) (64*k+299)) ∨ ¬ (Cell (64*k+296) (32*k+148)) := by
  by_cases h : Cell (32*k+148) (64*k+299)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (64*k+299)) (ch := (64*k+296)) (u := (32*k+148)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c157 (k : Nat) : ¬ (Cell (32*k+148) (128*k+595)) ∨ ¬ (Cell (64*k+296) (64*k+297)) := by
  by_cases h : Cell (32*k+148) (128*k+595)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (128*k+595)) (ch := (64*k+296)) (u := (64*k+297)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c158 (k : Nat) : ¬ (Cell (32*k+148) (128*k+595)) ∨ ¬ (Cell (64*k+296) (32*k+148)) := by
  by_cases h : Cell (32*k+148) (128*k+595)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (128*k+595)) (ch := (64*k+296)) (u := (32*k+148)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c159 (k : Nat) : ¬ (Cell (32*k+148) (128*k+595)) ∨ ¬ (Cell (64*k+297) (64*k+298)) := by
  by_cases h : Cell (32*k+148) (128*k+595)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (128*k+595)) (ch := (64*k+297)) (u := (64*k+298)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c160 (k : Nat) : ¬ (Cell (32*k+148) (128*k+597)) ∨ ¬ (Cell (64*k+296) (64*k+297)) := by
  by_cases h : Cell (32*k+148) (128*k+597)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (128*k+597)) (ch := (64*k+296)) (u := (64*k+297)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c161 (k : Nat) : ¬ (Cell (32*k+148) (128*k+597)) ∨ ¬ (Cell (64*k+296) (128*k+595)) := by
  by_cases h : Cell (32*k+148) (128*k+597)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (128*k+597)) (ch := (64*k+296)) (u := (128*k+595)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c162 (k : Nat) : ¬ (Cell (32*k+148) (128*k+597)) ∨ ¬ (Cell (64*k+296) (32*k+148)) := by
  by_cases h : Cell (32*k+148) (128*k+597)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (128*k+597)) (ch := (64*k+296)) (u := (32*k+148)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c163 (k : Nat) : ¬ (Cell (32*k+148) (128*k+597)) ∨ ¬ (Cell (64*k+297) (64*k+298)) := by
  by_cases h : Cell (32*k+148) (128*k+597)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (128*k+597)) (ch := (64*k+297)) (u := (64*k+298)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c164 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (32*k+148) (128*k+597)) ∨ (Cell (64*k+297) (128*k+596)) := by
  classical
  by_cases h : Cell (32*k+148) (128*k+597)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(32*k+148)+1 = (64*k+297) := by omega
      have ht : (128*k+597)-1 = (128*k+596) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c165 (k : Nat) : ¬ (Cell (32*k+148) (128*k+596)) ∨ ¬ (Cell (64*k+296) (64*k+297)) := by
  by_cases h : Cell (32*k+148) (128*k+596)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (128*k+596)) (ch := (64*k+296)) (u := (64*k+297)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c166 (k : Nat) : ¬ (Cell (32*k+148) (128*k+596)) ∨ ¬ (Cell (64*k+296) (32*k+148)) := by
  by_cases h : Cell (32*k+148) (128*k+596)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (128*k+596)) (ch := (64*k+296)) (u := (32*k+148)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c167 (k : Nat) : ¬ (Cell (32*k+148) (128*k+596)) ∨ ¬ (Cell (64*k+297) (64*k+298)) := by
  by_cases h : Cell (32*k+148) (128*k+596)
  · right; intro h2
    have ht := half_time (v := (32*k+148)) (t := (128*k+596)) (ch := (64*k+297)) (u := (64*k+298)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c168 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (32*k+148) (128*k+596)) ∨ (Cell (64*k+296) (128*k+595)) := by
  classical
  by_cases h : Cell (32*k+148) (128*k+596)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+148) = (64*k+296) := by omega
      have ht : (128*k+596)-1 = (128*k+595) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c169 (k : Nat) : ¬ (Cell (32*k+149) (32*k+150)) ∨ ¬ (Cell (32*k+149) (64*k+300)) := by
  by_cases h : Cell (32*k+149) (32*k+150)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c170 (k : Nat) : ¬ (Cell (16*k+73) (32*k+149)) ∨ ¬ (Cell (64*k+298) (32*k+149)) := by
  by_cases h : Cell (16*k+73) (32*k+149)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c171 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (32*k+149) (32*k+150)) ∨ (Cell (64*k+298) (32*k+149)) := by
  classical
  by_cases h : Cell (32*k+149) (32*k+150)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(32*k+149) = (64*k+298) := by omega
      have ht : (32*k+150)-1 = (32*k+149) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c172 (k : Nat) : ¬ (Cell (32*k+149) (32*k+150)) ∨ ¬ (Cell (64*k+300) (32*k+150)) := by
  by_cases h : Cell (32*k+149) (32*k+150)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c173 (k : Nat) : ¬ (Cell (32*k+150) (64*k+303)) ∨ ¬ (Cell (64*k+300) (64*k+301)) := by
  by_cases h : Cell (32*k+150) (64*k+303)
  · right; intro h2
    have ht := half_time (v := (32*k+150)) (t := (64*k+303)) (ch := (64*k+300)) (u := (64*k+301)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c174 (k : Nat) : ¬ (Cell (8*k+37) (32*k+152)) ∨ ¬ (Cell (16*k+75) (32*k+152)) := by
  by_cases h : Cell (8*k+37) (32*k+152)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c175 (k : Nat) : ¬ (Cell (8*k+37) (32*k+152)) ∨ ¬ (Cell (32*k+151) (32*k+152)) := by
  by_cases h : Cell (8*k+37) (32*k+152)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c176 (k : Nat) : ¬ (Cell (64*k+294) (64*k+295)) ∨ ¬ (Cell (64*k+294) (32*k+147)) := by
  by_cases h : Cell (64*k+294) (64*k+295)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c177 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (64*k+295) (64*k+296)) ∨ (Cell (64*k+295) (128*k+592)) ∨ (Cell (64*k+295) (128*k+593)) ∨ (Cell (64*k+295) (256*k+1183)) ∨ (Cell (64*k+295) (256*k+1185)) ∨ (Cell (64*k+295) (256*k+1184)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (64*k+295) g (by omega)
  unfold Allowed at ha
  have options : z = (64*k+296) ∨ z = (128*k+592) ∨ z = (128*k+593) ∨ z = (256*k+1183) ∨ z = (256*k+1185) ∨ z = (256*k+1184) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c178 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+73) (64*k+295)) ∨ (Cell (32*k+146) (64*k+295)) ∨ (Cell (64*k+294) (64*k+295)) ∨ (Cell (128*k+590) (64*k+295)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (64*k+295) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+73) ∨ z = (32*k+146) ∨ z = (64*k+294) ∨ z = (128*k+590) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c179 (k : Nat) : ¬ (Cell (64*k+295) (128*k+592)) ∨ ¬ (Cell (128*k+590) (64*k+295)) := by
  by_cases h : Cell (64*k+295) (128*k+592)
  · right; intro h2
    have ht := half_time (v := (64*k+295)) (t := (128*k+592)) (ch := (128*k+590)) (u := (64*k+295)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c180 (k : Nat) : ¬ (Cell (64*k+295) (128*k+593)) ∨ ¬ (Cell (128*k+590) (64*k+295)) := by
  by_cases h : Cell (64*k+295) (128*k+593)
  · right; intro h2
    have ht := half_time (v := (64*k+295)) (t := (128*k+593)) (ch := (128*k+590)) (u := (64*k+295)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c181 (k : Nat) : ¬ (Cell (64*k+295) (256*k+1183)) ∨ ¬ (Cell (128*k+590) (64*k+295)) := by
  by_cases h : Cell (64*k+295) (256*k+1183)
  · right; intro h2
    have ht := half_time (v := (64*k+295)) (t := (256*k+1183)) (ch := (128*k+590)) (u := (64*k+295)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c182 (k : Nat) : ¬ (Cell (64*k+295) (256*k+1185)) ∨ ¬ (Cell (128*k+590) (64*k+295)) := by
  by_cases h : Cell (64*k+295) (256*k+1185)
  · right; intro h2
    have ht := half_time (v := (64*k+295)) (t := (256*k+1185)) (ch := (128*k+590)) (u := (64*k+295)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c183 (k : Nat) : ¬ (Cell (64*k+295) (256*k+1184)) ∨ ¬ (Cell (128*k+590) (64*k+295)) := by
  by_cases h : Cell (64*k+295) (256*k+1184)
  · right; intro h2
    have ht := half_time (v := (64*k+295)) (t := (256*k+1184)) (ch := (128*k+590)) (u := (64*k+295)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c184 (k : Nat) : ¬ (Cell (64*k+295) (64*k+296)) ∨ ¬ (Cell (128*k+592) (64*k+296)) := by
  by_cases h : Cell (64*k+295) (64*k+296)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c185 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (64*k+296) (64*k+297)) ∨ (Cell (128*k+592) (64*k+296)) := by
  classical
  by_cases h : Cell (64*k+296) (64*k+297)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(64*k+296) = (128*k+592) := by omega
      have ht : (64*k+297)-1 = (64*k+296) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c186 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (64*k+297) (64*k+298)) ∨ (Cell (64*k+297) (128*k+596)) ∨ (Cell (64*k+297) (128*k+597)) ∨ (Cell (64*k+297) (256*k+1191)) ∨ (Cell (64*k+297) (256*k+1193)) ∨ (Cell (64*k+297) (256*k+1192)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (64*k+297) g (by omega)
  unfold Allowed at ha
  have options : z = (64*k+298) ∨ z = (128*k+596) ∨ z = (128*k+597) ∨ z = (256*k+1191) ∨ z = (256*k+1193) ∨ z = (256*k+1192) := by omega
  rcases options with e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz))))))

private theorem c187 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+73) (64*k+297)) ∨ (Cell (32*k+147) (64*k+297)) ∨ (Cell (64*k+296) (64*k+297)) ∨ (Cell (128*k+594) (64*k+297)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (64*k+297) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+73) ∨ z = (32*k+147) ∨ z = (64*k+296) ∨ z = (128*k+594) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c188 (k : Nat) : ¬ (Cell (16*k+73) (64*k+297)) ∨ ¬ (Cell (64*k+296) (64*k+297)) := by
  by_cases h : Cell (16*k+73) (64*k+297)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c189 (k : Nat) : ¬ (Cell (64*k+297) (128*k+596)) ∨ ¬ (Cell (128*k+594) (64*k+297)) := by
  by_cases h : Cell (64*k+297) (128*k+596)
  · right; intro h2
    have ht := half_time (v := (64*k+297)) (t := (128*k+596)) (ch := (128*k+594)) (u := (64*k+297)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c190 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (64*k+297) (128*k+596)) ∨ (Cell (128*k+594) (128*k+595)) := by
  classical
  by_cases h : Cell (64*k+297) (128*k+596)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(64*k+297) = (128*k+594) := by omega
      have ht : (128*k+596)-1 = (128*k+595) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c191 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (64*k+297) (128*k+597)) ∨ (Cell (128*k+595) (128*k+596)) := by
  classical
  by_cases h : Cell (64*k+297) (128*k+597)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega
    · have hv : 2*(64*k+297)+1 = (128*k+595) := by omega
      have ht : (128*k+597)-1 = (128*k+596) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)

private theorem c192 (k : Nat) : ¬ (Cell (64*k+297) (256*k+1191)) ∨ ¬ (Cell (128*k+594) (64*k+297)) := by
  by_cases h : Cell (64*k+297) (256*k+1191)
  · right; intro h2
    have ht := half_time (v := (64*k+297)) (t := (256*k+1191)) (ch := (128*k+594)) (u := (64*k+297)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c193 (k : Nat) : ¬ (Cell (64*k+297) (256*k+1193)) ∨ ¬ (Cell (128*k+594) (64*k+297)) := by
  by_cases h : Cell (64*k+297) (256*k+1193)
  · right; intro h2
    have ht := half_time (v := (64*k+297)) (t := (256*k+1193)) (ch := (128*k+594)) (u := (64*k+297)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c194 (k : Nat) : ¬ (Cell (64*k+297) (256*k+1192)) ∨ ¬ (Cell (128*k+594) (64*k+297)) := by
  by_cases h : Cell (64*k+297) (256*k+1192)
  · right; intro h2
    have ht := half_time (v := (64*k+297)) (t := (256*k+1192)) (ch := (128*k+594)) (u := (64*k+297)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c195 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (32*k+148) (64*k+298)) ∨ (Cell (64*k+297) (64*k+298)) ∨ (Cell (128*k+596) (64*k+298)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (64*k+298) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+148) ∨ z = (64*k+297) ∨ z = (128*k+596) := by omega
  rcases options with e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (e ▸ hz)))

private theorem c196 (k : Nat) : ¬ (Cell (32*k+148) (64*k+299)) ∨ ¬ (Cell (128*k+598) (64*k+299)) := by
  by_cases h : Cell (32*k+148) (64*k+299)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c197 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (64*k+299) (64*k+300)) ∨ (Cell (128*k+598) (64*k+299)) := by
  classical
  by_cases h : Cell (64*k+299) (64*k+300)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(64*k+299) = (128*k+598) := by omega
      have ht : (64*k+300)-1 = (64*k+299) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c198 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (64*k+300) (64*k+301)) ∨ (Cell (64*k+300) (128*k+602)) ∨ (Cell (64*k+300) (128*k+603)) ∨ (Cell (64*k+300) (256*k+1203)) ∨ (Cell (64*k+300) (256*k+1205)) ∨ (Cell (64*k+300) (256*k+1204)) ∨ (Cell (64*k+300) (32*k+150)) := by
  obtain ⟨z, hz, ha⟩ := row (8*k+37) (64*k+300) g (by omega)
  unfold Allowed at ha
  have options : z = (64*k+301) ∨ z = (128*k+602) ∨ z = (128*k+603) ∨ z = (256*k+1203) ∨ z = (256*k+1205) ∨ z = (256*k+1204) ∨ z = (32*k+150) := by omega
  rcases options with e | e | e | e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (e ▸ hz)))))))
  · exact (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (e ▸ hz)))))))

private theorem c199 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (16*k+74) (64*k+300)) ∨ (Cell (32*k+149) (64*k+300)) ∨ (Cell (64*k+299) (64*k+300)) ∨ (Cell (128*k+600) (64*k+300)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (64*k+300) g (by omega)
  unfold Allowed at ha
  have options : z = (16*k+74) ∨ z = (32*k+149) ∨ z = (64*k+299) ∨ z = (128*k+600) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c200 (k : Nat) : ¬ (Cell (64*k+300) (128*k+602)) ∨ ¬ (Cell (128*k+600) (64*k+300)) := by
  by_cases h : Cell (64*k+300) (128*k+602)
  · right; intro h2
    have ht := half_time (v := (64*k+300)) (t := (128*k+602)) (ch := (128*k+600)) (u := (64*k+300)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c201 (k : Nat) : ¬ (Cell (64*k+300) (128*k+603)) ∨ ¬ (Cell (128*k+600) (64*k+300)) := by
  by_cases h : Cell (64*k+300) (128*k+603)
  · right; intro h2
    have ht := half_time (v := (64*k+300)) (t := (128*k+603)) (ch := (128*k+600)) (u := (64*k+300)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c202 (k : Nat) : ¬ (Cell (64*k+300) (256*k+1203)) ∨ ¬ (Cell (128*k+600) (64*k+300)) := by
  by_cases h : Cell (64*k+300) (256*k+1203)
  · right; intro h2
    have ht := half_time (v := (64*k+300)) (t := (256*k+1203)) (ch := (128*k+600)) (u := (64*k+300)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c203 (k : Nat) : ¬ (Cell (64*k+300) (256*k+1205)) ∨ ¬ (Cell (128*k+600) (64*k+300)) := by
  by_cases h : Cell (64*k+300) (256*k+1205)
  · right; intro h2
    have ht := half_time (v := (64*k+300)) (t := (256*k+1205)) (ch := (128*k+600)) (u := (64*k+300)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c204 (k : Nat) : ¬ (Cell (64*k+300) (256*k+1204)) ∨ ¬ (Cell (128*k+600) (64*k+300)) := by
  by_cases h : Cell (64*k+300) (256*k+1204)
  · right; intro h2
    have ht := half_time (v := (64*k+300)) (t := (256*k+1204)) (ch := (128*k+600)) (u := (64*k+300)) h h2 (by omega) (by omega)
    omega
  · exact Or.inl h

private theorem c205 (k : Nat) : ¬ (Cell (32*k+148) (128*k+595)) ∨ ¬ (Cell (128*k+594) (128*k+595)) := by
  by_cases h : Cell (32*k+148) (128*k+595)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c206 (k : Nat) : ¬ (Cell (32*k+148) (128*k+595)) ∨ ¬ (Cell (256*k+1190) (128*k+595)) := by
  by_cases h : Cell (32*k+148) (128*k+595)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c207 (k : Nat) : ¬ (Cell (64*k+296) (128*k+595)) ∨ ¬ (Cell (256*k+1190) (128*k+595)) := by
  by_cases h : Cell (64*k+296) (128*k+595)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c208 (k : Nat) (g : GoodBelow (8*k+37)) : ¬ (Cell (128*k+595) (128*k+596)) ∨ (Cell (256*k+1190) (128*k+595)) := by
  classical
  by_cases h : Cell (128*k+595) (128*k+596)
  case neg => exact Or.inl h
  case pos =>
    rcases parent h (by omega) (by omega) with hp | hp
    · have hv : 2*(128*k+595) = (256*k+1190) := by omega
      have ht : (128*k+596)-1 = (128*k+595) := by omega
      rw [hv, ht] at hp
      exact (Or.inr hp)
    · have ha := allowed_of_cell g (by omega) hp
      unfold Allowed at ha
      omega

private theorem c209 (k : Nat) : ¬ (Cell (128*k+596) (128*k+597)) ∨ ¬ (Cell (128*k+596) (64*k+298)) := by
  by_cases h : Cell (128*k+596) (128*k+597)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

private theorem c210 (k : Nat) : ¬ (Cell (32*k+148) (128*k+596)) ∨ ¬ (Cell (64*k+297) (128*k+596)) := by
  by_cases h : Cell (32*k+148) (128*k+596)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c211 (k : Nat) (g : GoodBelow (8*k+37)) : (Cell (32*k+148) (128*k+597)) ∨ (Cell (64*k+297) (128*k+597)) ∨ (Cell (128*k+596) (128*k+597)) ∨ (Cell (256*k+1194) (128*k+597)) := by
  obtain ⟨z, hz, hv, ha⟩ := col (8*k+37) (128*k+597) g (by omega)
  unfold Allowed at ha
  have options : z = (32*k+148) ∨ z = (64*k+297) ∨ z = (128*k+596) ∨ z = (256*k+1194) := by omega
  rcases options with e | e | e | e
  · exact (Or.inl (e ▸ hz))
  · exact (Or.inr (Or.inl (e ▸ hz)))
  · exact (Or.inr (Or.inr (Or.inl (e ▸ hz))))
  · exact (Or.inr (Or.inr (Or.inr (e ▸ hz))))

private theorem c212 (k : Nat) : ¬ (Cell (64*k+297) (128*k+597)) ∨ ¬ (Cell (256*k+1194) (128*k+597)) := by
  by_cases h : Cell (64*k+297) (128*k+597)
  · right; intro h2
    have ht := col_eq h h2
    omega
  · exact Or.inl h

private theorem c213 (k : Nat) : ¬ (Cell (16*k+71) (16*k+72)) ∨ ¬ (Cell (16*k+71) (32*k+145)) := by
  by_cases h : Cell (16*k+71) (16*k+72)
  · right; intro h2
    have ht := row_eq h h2
    omega
  · exact Or.inl h

theorem exclude (k : Nat) (g : GoodBelow (8*k+37)) (bad : Cell (8*k+37) (4*(8*k+37)+4)) : False := by
  have badNormalized : Cell (8*k+37) (32*k+152) := by
    rw [show (32*k+152) = 4*(8*k+37)+4 by omega]
    exact bad
  exact privateReplay
    (Cell (2*k+8) (4*k+18))
    (Cell (2*k+8) (8*k+37))
    (Cell (4*k+16) (4*k+17))
    (Cell (4*k+17) (8*k+36))
    (Cell (4*k+16) (8*k+34))
    (Cell (4*k+16) (16*k+67))
    (Cell (8*k+32) (4*k+16))
    (Cell (4*k+17) (4*k+18))
    (Cell (4*k+17) (8*k+37))
    (Cell (8*k+35) (8*k+36))
    (Cell (4*k+17) (16*k+71))
    (Cell (8*k+36) (4*k+18))
    (Cell (4*k+18) (16*k+75))
    (Cell (8*k+36) (16*k+74))
    (Cell (8*k+32) (16*k+67))
    (Cell (8*k+33) (8*k+34))
    (Cell (8*k+33) (32*k+135))
    (Cell (8*k+33) (32*k+137))
    (Cell (16*k+66) (8*k+33))
    (Cell (16*k+68) (8*k+34))
    (Cell (8*k+34) (16*k+71))
    (Cell (16*k+68) (16*k+69))
    (Cell (16*k+69) (16*k+70))
    (Cell (8*k+35) (16*k+72))
    (Cell (8*k+35) (32*k+143))
    (Cell (8*k+35) (32*k+145))
    (Cell (16*k+70) (8*k+35))
    (Cell (8*k+36) (8*k+37))
    (Cell (8*k+36) (16*k+75))
    (Cell (16*k+72) (8*k+36))
    (Cell (16*k+72) (16*k+73))
    (Cell (16*k+74) (8*k+37))
    (Cell (8*k+37) (32*k+152))
    (Cell (16*k+74) (16*k+75))
    (Cell (16*k+75) (16*k+76))
    (Cell (16*k+74) (32*k+151))
    (Cell (16*k+66) (16*k+67))
    (Cell (16*k+66) (32*k+135))
    (Cell (32*k+134) (16*k+67))
    (Cell (16*k+67) (32*k+137))
    (Cell (16*k+68) (32*k+138))
    (Cell (16*k+68) (32*k+139))
    (Cell (16*k+68) (64*k+275))
    (Cell (16*k+68) (64*k+277))
    (Cell (16*k+68) (64*k+276))
    (Cell (32*k+136) (32*k+137))
    (Cell (32*k+137) (32*k+138))
    (Cell (32*k+137) (64*k+276))
    (Cell (16*k+69) (32*k+140))
    (Cell (16*k+70) (16*k+71))
    (Cell (16*k+70) (32*k+142))
    (Cell (16*k+70) (32*k+143))
    (Cell (32*k+140) (16*k+70))
    (Cell (16*k+71) (16*k+72))
    (Cell (16*k+71) (32*k+145))
    (Cell (32*k+142) (16*k+71))
    (Cell (32*k+142) (32*k+143))
    (Cell (16*k+72) (32*k+146))
    (Cell (16*k+72) (32*k+147))
    (Cell (16*k+72) (64*k+291))
    (Cell (16*k+72) (64*k+293))
    (Cell (16*k+72) (64*k+292))
    (Cell (32*k+144) (16*k+72))
    (Cell (32*k+144) (32*k+145))
    (Cell (32*k+145) (32*k+146))
    (Cell (16*k+73) (16*k+74))
    (Cell (16*k+73) (32*k+148))
    (Cell (16*k+73) (32*k+149))
    (Cell (16*k+73) (64*k+295))
    (Cell (16*k+73) (64*k+297))
    (Cell (16*k+73) (64*k+296))
    (Cell (32*k+146) (16*k+73))
    (Cell (32*k+146) (32*k+147))
    (Cell (32*k+147) (32*k+148))
    (Cell (16*k+74) (64*k+300))
    (Cell (32*k+148) (16*k+74))
    (Cell (32*k+148) (32*k+149))
    (Cell (32*k+149) (32*k+150))
    (Cell (16*k+75) (32*k+152))
    (Cell (16*k+75) (32*k+153))
    (Cell (16*k+75) (64*k+303))
    (Cell (16*k+75) (64*k+305))
    (Cell (16*k+75) (64*k+304))
    (Cell (32*k+150) (16*k+75))
    (Cell (32*k+151) (32*k+152))
    (Cell (32*k+150) (64*k+303))
    (Cell (32*k+134) (32*k+135))
    (Cell (32*k+135) (32*k+136))
    (Cell (32*k+135) (64*k+272))
    (Cell (32*k+135) (64*k+273))
    (Cell (32*k+135) (128*k+543))
    (Cell (32*k+135) (128*k+545))
    (Cell (32*k+135) (128*k+544))
    (Cell (64*k+270) (32*k+135))
    (Cell (64*k+272) (32*k+136))
    (Cell (32*k+137) (64*k+277))
    (Cell (32*k+137) (128*k+551))
    (Cell (32*k+137) (128*k+553))
    (Cell (32*k+137) (128*k+552))
    (Cell (64*k+274) (32*k+137))
    (Cell (64*k+278) (32*k+139))
    (Cell (32*k+139) (32*k+140))
    (Cell (32*k+140) (32*k+141))
    (Cell (32*k+140) (64*k+282))
    (Cell (32*k+140) (64*k+283))
    (Cell (32*k+140) (128*k+563))
    (Cell (32*k+140) (128*k+565))
    (Cell (32*k+140) (128*k+564))
    (Cell (64*k+280) (32*k+140))
    (Cell (64*k+282) (32*k+141))
    (Cell (32*k+141) (32*k+142))
    (Cell (32*k+142) (64*k+286))
    (Cell (32*k+142) (64*k+287))
    (Cell (32*k+142) (128*k+571))
    (Cell (32*k+142) (128*k+573))
    (Cell (32*k+142) (128*k+572))
    (Cell (64*k+284) (32*k+142))
    (Cell (32*k+143) (32*k+144))
    (Cell (32*k+143) (64*k+288))
    (Cell (32*k+143) (64*k+289))
    (Cell (32*k+143) (128*k+575))
    (Cell (32*k+143) (128*k+577))
    (Cell (32*k+143) (128*k+576))
    (Cell (64*k+286) (32*k+143))
    (Cell (64*k+288) (32*k+144))
    (Cell (32*k+145) (64*k+292))
    (Cell (32*k+145) (64*k+293))
    (Cell (32*k+145) (128*k+583))
    (Cell (32*k+145) (128*k+585))
    (Cell (32*k+145) (128*k+584))
    (Cell (64*k+290) (32*k+145))
    (Cell (32*k+146) (64*k+295))
    (Cell (64*k+292) (32*k+146))
    (Cell (32*k+147) (64*k+297))
    (Cell (64*k+294) (32*k+147))
    (Cell (32*k+148) (64*k+298))
    (Cell (32*k+148) (64*k+299))
    (Cell (32*k+148) (128*k+595))
    (Cell (32*k+148) (128*k+597))
    (Cell (32*k+148) (128*k+596))
    (Cell (64*k+296) (32*k+148))
    (Cell (64*k+296) (64*k+297))
    (Cell (64*k+297) (64*k+298))
    (Cell (64*k+296) (128*k+595))
    (Cell (64*k+297) (128*k+596))
    (Cell (32*k+149) (64*k+300))
    (Cell (64*k+298) (32*k+149))
    (Cell (64*k+300) (32*k+150))
    (Cell (64*k+300) (64*k+301))
    (Cell (64*k+294) (64*k+295))
    (Cell (64*k+295) (64*k+296))
    (Cell (64*k+295) (128*k+592))
    (Cell (64*k+295) (128*k+593))
    (Cell (64*k+295) (256*k+1183))
    (Cell (64*k+295) (256*k+1185))
    (Cell (64*k+295) (256*k+1184))
    (Cell (128*k+590) (64*k+295))
    (Cell (128*k+592) (64*k+296))
    (Cell (64*k+297) (128*k+597))
    (Cell (64*k+297) (256*k+1191))
    (Cell (64*k+297) (256*k+1193))
    (Cell (64*k+297) (256*k+1192))
    (Cell (128*k+594) (64*k+297))
    (Cell (128*k+594) (128*k+595))
    (Cell (128*k+595) (128*k+596))
    (Cell (128*k+596) (64*k+298))
    (Cell (128*k+598) (64*k+299))
    (Cell (64*k+299) (64*k+300))
    (Cell (64*k+300) (128*k+602))
    (Cell (64*k+300) (128*k+603))
    (Cell (64*k+300) (256*k+1203))
    (Cell (64*k+300) (256*k+1205))
    (Cell (64*k+300) (256*k+1204))
    (Cell (128*k+600) (64*k+300))
    (Cell (256*k+1190) (128*k+595))
    (Cell (128*k+596) (128*k+597))
    (Cell (256*k+1194) (128*k+597))
    (c0 k)
    (c1 k g)
    (c2 k g)
    (c3 k)
    (c4 k)
    (c5 k g)
    (c6 k)
    (c7 k)
    (c8 k g)
    (c9 k)
    (c10 k g)
    (c11 k g)
    (c12 k)
    (c13 k)
    (c14 k)
    (c15 k g)
    (c16 k g)
    (c17 k)
    (c18 k)
    (c19 k g)
    (c20 k)
    (c21 k)
    (c22 k)
    (c23 k g)
    (c24 k)
    (c25 k)
    (c26 k)
    (c27 k)
    (c28 k g)
    (c29 k)
    (c30 k)
    (c31 k g)
    (c32 k)
    (c33 k g)
    (c34 k)
    (c35 k)
    (c36 k)
    (c37 k g)
    (c38 k)
    (c39 k)
    (c40 k g)
    (c41 k)
    (c42 k g)
    (c43 k g)
    (c44 k)
    (c45 k g)
    (c46 k)
    (c47 k)
    (c48 k)
    (c49 k)
    (c50 k)
    (c51 k)
    (c52 k)
    (c53 k g)
    (c54 k g)
    (c55 k)
    (c56 k)
    (c57 k g)
    (c58 k g)
    (c59 k g)
    (c60 k)
    (c61 k g)
    (c62 k)
    (c63 k)
    (c64 k)
    (c65 k)
    (c66 k)
    (c67 k)
    (c68 k)
    (c69 k)
    (c70 k)
    (c71 k g)
    (c72 k)
    (c73 k)
    (c74 k g)
    (c75 k g)
    (c76 k)
    (c77 k)
    (c78 k)
    (c79 k)
    (c80 k g)
    (c81 k)
    (c82 k)
    (c83 k)
    (c84 k g)
    (c85 k g)
    (c86 k g)
    (c87 k g)
    (c88 k)
    (c89 k)
    (c90 k g)
    (c91 k)
    (c92 k g)
    (c93 k g)
    (c94 k)
    (c95 k)
    (c96 k)
    (c97 k)
    (c98 k)
    (c99 k)
    (c100 k g)
    (c101 k g)
    (c102 k g)
    (c103 k)
    (c104 k)
    (c105 k)
    (c106 k)
    (c107 k)
    (c108 k)
    (c109 k g)
    (c110 k g)
    (c111 k g)
    (c112 k)
    (c113 k)
    (c114 k)
    (c115 k)
    (c116 k)
    (c117 k)
    (c118 k g)
    (c119 k g)
    (c120 k)
    (c121 k g)
    (c122 k)
    (c123 k)
    (c124 k)
    (c125 k)
    (c126 k)
    (c127 k g)
    (c128 k g)
    (c129 k)
    (c130 k)
    (c131 k)
    (c132 k)
    (c133 k)
    (c134 k)
    (c135 k)
    (c136 k g)
    (c137 k g)
    (c138 k g)
    (c139 k)
    (c140 k)
    (c141 k)
    (c142 k)
    (c143 k)
    (c144 k)
    (c145 k g)
    (c146 k)
    (c147 k)
    (c148 k g)
    (c149 k)
    (c150 k)
    (c151 k g)
    (c152 k g)
    (c153 k g)
    (c154 k)
    (c155 k g)
    (c156 k)
    (c157 k)
    (c158 k)
    (c159 k)
    (c160 k)
    (c161 k)
    (c162 k)
    (c163 k)
    (c164 k g)
    (c165 k)
    (c166 k)
    (c167 k)
    (c168 k g)
    (c169 k)
    (c170 k)
    (c171 k g)
    (c172 k)
    (c173 k)
    (c174 k)
    (c175 k)
    (c176 k)
    (c177 k g)
    (c178 k g)
    (c179 k)
    (c180 k)
    (c181 k)
    (c182 k)
    (c183 k)
    (c184 k)
    (c185 k g)
    (c186 k g)
    (c187 k g)
    (c188 k)
    (c189 k)
    (c190 k g)
    (c191 k g)
    (c192 k)
    (c193 k)
    (c194 k)
    (c195 k g)
    (c196 k)
    (c197 k g)
    (c198 k g)
    (c199 k g)
    (c200 k)
    (c201 k)
    (c202 k)
    (c203 k)
    (c204 k)
    (c205 k)
    (c206 k)
    (c207 k)
    (c208 k g)
    (c209 k)
    (c210 k)
    (c211 k g)
    (c212 k)
    (c213 k)
    badNormalized
end P8R5
end Inverse
