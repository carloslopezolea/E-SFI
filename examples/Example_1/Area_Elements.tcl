set m_fibers 8;
set c_rot 0.4;
set db [expr 228.6*$mm];    # Wall boundary length discretization
set dw [expr 127.133*$mm];  # Wall web length discretization
set tw [expr 152.4*$mm];    # Wall thickness
set tb [expr 304.8*$mm];    # Loading tranfer beam thickness

element E_SFI 1 1 2 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 2 2 3 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 3 3 4 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 4 4 5 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 5 5 6 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 6 6 7 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 7 7 8 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 8 8 9 $m_fibers $c_rot -thick $tb $tb $tb $tb $tb $tb $tb $tb -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 9 9 10 $m_fibers $c_rot -thick $tb $tb $tb $tb $tb $tb $tb $tb -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;