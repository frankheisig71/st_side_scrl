

     section  text

; 4px (2 long) hard shift for machine 1
; need no mask copy mem instead
    ifne machine_t_1

fullscr_st_031_start: macro          ;  0xNop 3xHi 1xMed
    move.b    d7,(a0)                ;  2 / Left border hi rez
    sub.b     d6,(a0)                ;  3 / med rez
    move.w    d7,(a0)                ;  2 / low rez
    endm

fullscr_st_031_del_bak:
    fullscr_st_031_start
    dcb.w     88-85,$4e71            ; 88 / NOPs
    fullscr_del_bak                  ; 85 nops to right bdr
    moveq    #48,d4
    dcb.w    7,$4e71
fullscr_st_031_del_bak_loop:
    dcb.w    1,$4e71
    fullscr_st_031_start
    dcb.w     88-85,$4e71            ; 88 / NOPs
    fullscr_del_bak                  ; 85 nops to right bdr
    dcb.w    5,$4e71
    dbra d4,fullscr_st_031_del_bak_loop
    fullscr_st_031_start
    dcb.w     88-85,$4e71            ; 88 / NOPs
    fullscr_del_bak                  ; 85 nops to right bdr
    rts

fullscr_st_031_prp_bdr:
    fullscr_st_031_start
    dcb.w     88-83,$4e71            ; 88 / NOPs
    fullscr_waste_27n                ; 27 nops
    fullscr_prp_bdr_init             ; 56 Nops to right border, 10 after stabelizer
fullscr_st_031_prp_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_031_start
    dcb.w     88-85,$4e71            ; 88 / NOPs
    fullscr_prp_bdr_loop             ; 85 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_031_prp_bdr_loop  ; 3 / 4
    fullscr_st_031_start
    dcb.w     88-85,$4e71            ; 85 / NOPs
    fullscr_prp_bdr_loop             ; 85 nops to right bdr
    rts

fullscr_st_031_cpy_bdr:
    fullscr_st_031_start
    dcb.w     88-85,$4e71            ; 88 / NOPs
    fullscr_waste_54n                ; 54
    fullscr_cpy_bdr_init             ; 31 Nops to right border, 10 after stabelizer
fullscr_st_031_cpy_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_031_start
    dcb.w     88-84,$4e71            ; 88 / NOPs
    fullscr_cpy                      ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_031_cpy_bdr_loop  ; 3 / 4
    fullscr_st_031_start
    dcb.w     88-84,$4e71            ; 88 / NOPs
    fullscr_cpy                      ; 84 nops to right bdr
    rts

fullscr_st_031_cpy2_bdr: ;this is needed only if bdr_src_offs > 0
    fullscr_st_031_start
    dcb.w     88-83,$4e71            ; 88 / NOPs
    fullscr_cpy2_bdr_init            ; 83 Nops to right border, 10 after stabelizer
fullscr_st_031_cpy2_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_031_start
    dcb.w     88-84,$4e71            ; 88 / NOPs
    fullscr_cpy2                     ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_031_cpy2_bdr_loop  ; 3 / 4
    fullscr_st_031_start
    dcb.w     88-84,$4e71            ; 88 / NOPs
    fullscr_cpy2                     ; 84 nops to right bdr
    rts

fullscr_st_031_bak_bdr:
    fullscr_st_031_start
    dcb.w     88-85,$4e71            ; 88 / NOPs
    fullscr_waste_54n                ; 54
    fullscr_bak_bdr_init             ; 31 Nops to right border, 10 after stabelizer
fullscr_st_031_bak_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_031_start
    dcb.w     88-84,$4e71            ; 88 / NOPs
    fullscr_bak                      ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_031_bak_bdr_loop  ; 3 / 4
    fullscr_st_031_start
    dcb.w     88-84,$4e71            ; 88 / NOPs
    fullscr_bak                      ; 84 nops to right bdr
    rts

fullscr_st_031_bak:                  ;  0xNop 3xHi 1xMed
    fullscr_st_031_start
    dcb.w     88-84,$4e71            ; 88 / NOPs
    fullscr_bak                      ; 84 nops to right bdr
    rts

fullscr_st_031_free:                 ;  0xNop 3xHi 1xMed
    fullscr_st_031_start
    fullscr_waste_85n
    dcb.w    88-85,$4e71             ; 88 / NOPs
    fullscr_right_bdr
    dcb.w    13,$4e71                ; 13 / NOPs
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOPs
    rts                              ;  9 / jsr xxx.l (5) + rts (4)

fullscr_st_031_free_32:
    fullscr_st_031_start
    fullscr_waste_85n
    dcb.w    88-85,$4e71             ; 88 / NOPs
    fullscr_right_bdr
    dcb.w     11,$4e71               ;  2 / NOP
    moveq    #30,d4
.fscr_st_031_fr_128_l:
    dcb.w     1,$4e71                ;  2 / NOP
    fullscr_stabilizer
    dcb.w     11,$4e71               ;  9 / NOP
    fullscr_st_031_start
    fullscr_waste_85n
    dcb.w    88-85,$4e71             ; 88 / NOPs
    fullscr_right_bdr
    dcb.w     9,$4e71                ;  9 / NOP
    dbra  d4,.fscr_st_031_fr_128_l
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    rts                              ;  9 / jsr (5) + rts (4)


fullscr_st_031_lower_free:
    fullscr_st_031_start
    fullscr_waste_85n
    dcb.w    88-85,$4e71             ; 88 / NOPs
    fullscr_right_bdr
    fullscr_waste_13n                ; 13
    fullscr_stabilizer
    dcb.w  7,$4e71                   ;  7
    move.w  d7,(a1)                  ;  2 lower border
    dcb.w  2,$4e71                   ;  2
    ;-------------------------------------------
    fullscr_st_031_start
    move.b    d7,(a1)                ;  2 / 50 Hz from low border switch
    fullscr_waste_85n
    dcb.w     86-85,$4e71            ; 86
    fullscr_right_bdr
    fullscr_waste_13n                ; 13
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOPs
    rts                              ;  9 / jsr xxx.l (5) + rts (4)

fullscr_st_031_last_free:            ;  0xNop 3xHi 1xMed
    fullscr_st_031_start
    fullscr_waste_85n
    dcb.w    88-85,$4e71             ; 88 / NOPs
    fullscr_right_bdr
    lea  $ffff8240.w,a3              ;  2 / 24 black pal
    moveq      #0,d0                 ;  1
    dcb.w     13-3,$4e71             ; 13 / NOPs
    fullscr_stabilizer
    rept  8
    move.l    d0,(a3)+               ; 24 black pal
    endr
    rts                              ;  4 rts (4)

    endc


; 4px (2 long) hard shift for machine 2
; need no mask copy mem instead
    ifne machine_t_2

fullscr_st_143_start: macro          ;  1xNop 4xHi 3xMed
    dcb.w     1,$4e71                ;  1
    move.b    d7,(a0)                ;  2 / Left border hi rez
    dcb.w     2,$4e71                ;  2
    move.b    d6,(a0)                ;  2 / Left border med rez
    dcb.w     1,$4e71                ;  1
    move.w    d7,(a0)                ;  2 / low rez
    endm

fullscr_st_143_del_bak:
    fullscr_st_143_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_del_bak                  ; 85 nops to right bdr
    moveq    #48,d4
    dcb.w    7,$4e71
fullscr_st_143_del_bak_loop:
    dcb.w    1,$4e71
    fullscr_st_143_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_del_bak                  ; 85 nops to right bdr
    dcb.w    5,$4e71
    dbra d4,fullscr_st_143_del_bak_loop
    fullscr_st_143_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_del_bak                  ; 85 nops to right bdr
    rts

fullscr_st_143_prp_bdr:
    fullscr_st_143_start
    dcb.w     85-83,$4e71            ; 85 / NOPs
    fullscr_waste_27n                ; 27 nops
    fullscr_prp_bdr_init             ; 56 Nops to right border, 10 after stabelizer
fullscr_st_143_prp_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_143_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_prp_bdr_loop             ; 85 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_143_prp_bdr_loop  ; 3 / 4
    fullscr_st_143_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_prp_bdr_loop             ; 85 nops to right bdr
    rts

fullscr_st_143_cpy_bdr:
    fullscr_st_143_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_waste_54n                ; 54
    fullscr_cpy_bdr_init             ; 31 Nops to right border, 10 after stabelizer
fullscr_st_143_cpy_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_143_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy                      ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_143_cpy_bdr_loop  ; 3 / 4
    fullscr_st_143_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy                      ; 84 nops to right bdr
    rts

fullscr_st_143_cpy2_bdr: ;this is needed only if bdr_src_offs > 0
    fullscr_st_143_start
    dcb.w     85-83,$4e71            ; 85 / NOPs
    fullscr_cpy2_bdr_init            ; 83 Nops to right border, 10 after stabelizer
fullscr_st_143_cpy2_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_143_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy2                     ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_143_cpy2_bdr_loop  ; 3 / 4
    fullscr_st_143_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy2                     ; 84 nops to right bdr
    rts

fullscr_st_143_bak_bdr:
    fullscr_st_143_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_waste_54n                ; 54
    fullscr_bak_bdr_init             ; 31 Nops to right border, 10 after stabelizer
fullscr_st_143_bak_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_143_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_bak                      ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_143_bak_bdr_loop  ; 3 / 4
    fullscr_st_143_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_bak                      ; 84 nops to right bdr
    rts

fullscr_st_143_bak:                  ;  0xNop 3xHi 1xMed
    fullscr_st_143_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_bak                      ; 84 nops to right bdr
    rts

fullscr_st_143_free:                 ;  0xNop 3xHi 1xMed
    fullscr_st_143_start
    fullscr_waste_85n
    ;dcb.w    85-85,$4e71            ; 85 / NOPs
    fullscr_right_bdr
    dcb.w    13,$4e71                ; 13 / NOPs
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOPs
    rts                              ;  9 / jsr xxx.l (5) + rts (4)

fullscr_st_143_free_32:
    fullscr_st_143_start
    fullscr_waste_85n
    ;dcb.w    85-85,$4e71            ; 85 / NOPs
    fullscr_right_bdr
    dcb.w     11,$4e71               ;  2 / NOP
    moveq    #30,d4
.fscr_st_143_fr_128_l:
    dcb.w     1,$4e71                ;  2 / NOP
    fullscr_stabilizer
    dcb.w     11,$4e71               ;  9 / NOP
    fullscr_st_143_start
    fullscr_waste_85n
    ;dcb.w    85-85,$4e71            ; 85 / NOPs
    fullscr_right_bdr
    dcb.w     9,$4e71                ;  9 / NOP
    dbra  d4,.fscr_st_143_fr_128_l
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    rts                              ;  9 / jsr (5) + rts (4)


fullscr_st_143_lower_free:
    fullscr_st_143_start
    fullscr_waste_85n
    ;dcb.w     85,$4e71               ; 85 / NOPs
    fullscr_right_bdr
    fullscr_waste_13n                ; 13
    fullscr_stabilizer
    dcb.w  7,$4e71                     ;  7
    move.w  d7,(a1)                   ;  2 lower border
    dcb.w  2,$4e71                     ;  2

    ;-------------------------------------------
    dcb.w     1,$4e71                ;  1
    move.b    d7,(a0)                ;  2 / Left border hi rez
    move.b    d7,(a1)                ;  2 / 50 Hz from low border switch
    move.b    d6,(a0)                ;  2 / Left border med rez
    dcb.w     1,$4e71                ;  1
    move.w    d7,(a0)                ;  2 / low rez
    fullscr_waste_85n
    ;dcb.w    85-85,$4e71            ; 85 / NOPs
    fullscr_right_bdr
    fullscr_waste_13n                ; 13
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOPs
    rts                              ;  9 / jsr xxx.l (5) + rts (4)

fullscr_st_143_last_free:            ;
    fullscr_st_143_start
    fullscr_waste_85n
    ;dcb.w    85-85,$4e71            ; 85 / NOPs
    fullscr_right_bdr
    lea  $ffff8240.w,a3              ;  2 / 24 black pal
    moveq      #0,d0                 ;  1
    dcb.w     13-3,$4e71             ; 13 / NOPs
    fullscr_stabilizer
    rept  8
    move.l    d0,(a3)+               ; 24 black pal
    endr
    rts                              ;  4 rts (4)


    endc ;machine_t_2

    section  data

    section  text
