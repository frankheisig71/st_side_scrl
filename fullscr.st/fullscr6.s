

     section	text

; 12px (6 long) hard shift for machine 1
; need to mask 8 px on 2nd column
    ifne machine_t_1

fullscr_st_223_start: macro          ;  2xNop 2xHi 3xMed
    dcb.w     2,$4e71                ;  2
    move.b    d7,(a0)                ;  2 / Left border hi rez
    move.b    d6,(a0)                ;  2 / med rez
    dcb.w     1,$4e71                ;  1
    move.w    d7,(a0)                ;  2 / low rez
    endm

fullscr_st_223_msk:
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs (to right border)
    fullscr_msk
    moveq    #29,d4
    dcb.w    7,$4e71
fullscr_st_223_msk_loop:
    dcb.w    1,$4e71
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs (to right border)
    fullscr_msk
    dcb.w    5,$4e71
    dbra d4,fullscr_st_223_msk_loop
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs (to right border)
    fullscr_msk
    rts

fullscr_st_223_msk_del:
    fullscr_st_223_start
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_msk_del                  ; 85 nops to right bdr
    moveq    #48,d4
    dcb.w    7,$4e71
fullscr_st_223_msk_del_loop:
    dcb.w    1,$4e71
    fullscr_st_223_start
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_msk_del                  ; 85 nops to right bdr
    dcb.w    5,$4e71
    dbra d4,fullscr_st_223_msk_del_loop
    fullscr_st_223_start
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_msk_del                  ; 85 nops to right bdr
    rts

fullscr_st_223_prp_bdr:
    fullscr_st_223_start
    dcb.w     86-83,$4e71            ; 86 / NOPs
    fullscr_waste_27n
    fullscr_prp_bdr_init             ; 56 Nops to right border, 10 after stabelizer
fullscr_st_223_prp_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_223_start
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_prp_bdr_loop             ; 85 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_223_prp_bdr_loop  ; 3 / 4
    fullscr_st_223_start
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_prp_bdr_loop             ; 85 nops to right bdr
    rts

fullscr_st_223_cpy_bdr:
    fullscr_st_223_start
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_waste_54n                ; 54
    fullscr_cpy_bdr_init             ; 31 Nops to right border, 10 after stabelizer
fullscr_st_223_cpy_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs
    fullscr_cpy                      ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_223_cpy_bdr_loop  ; 3 / 4
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs
    fullscr_cpy                      ; 84 nops to right bdr
    rts

fullscr_st_223_cpy2_bdr: ;this is needed only if bdr_src_offs > 0
    fullscr_st_223_start
    dcb.w     86-83,$4e71            ; 86 / NOPs
    fullscr_cpy2_bdr_init            ; 83 Nops to right border, 10 after stabelizer
fullscr_st_223_cpy2_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs
    fullscr_cpy2                     ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_223_cpy2_bdr_loop  ; 3 / 4
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs
    fullscr_cpy2                     ; 84 nops to right bdr
    rts

fullscr_st_223_bak_bdr:
    fullscr_st_223_start
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_waste_54n                ; 54
    fullscr_bak_bdr_init             ; 31 Nops to right border, 10 after stabelizer
fullscr_st_223_bak_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs
    fullscr_bak                      ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_223_bak_bdr_loop  ; 3 / 4
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs
    fullscr_bak                      ; 84 nops to right bdr
    rts

fullscr_st_223_free:                 ;  2xNop 2xHi 3xMed
    fullscr_st_223_start
    fullscr_waste_85n
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_right_bdr
    fullscr_waste_13n                ; 13
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    rts                              ;  9 / jsr (5) + rts (4)

fullscr_st_223_free_32:
    fullscr_st_223_start
    fullscr_waste_85n
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_right_bdr
    dcb.w     11,$4e71               ;  2 / NOP
    moveq    #30,d4
.fscr_st_223_fr_128_l:
    dcb.w     1,$4e71                ;  2 / NOP
    fullscr_stabilizer
    dcb.w     11,$4e71               ;  9 / NOP
    fullscr_st_223_start
    fullscr_waste_85n
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_right_bdr
    dcb.w     9,$4e71                ;  9 / NOP
    dbra  d4,.fscr_st_223_fr_128_l
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    rts

fullscr_st_223_lower_free:
    fullscr_st_223_start
    fullscr_waste_85n
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_right_bdr
    fullscr_waste_13n                ; 13
    fullscr_stabilizer
		dcb.w	7,$4e71				             ;  7
		move.w	d7,(a1)			             ;  2 lower border
		dcb.w	2,$4e71				             ;  2
		;-------------------------------------------
    fullscr_st_223_start
		move.b	  d7,(a1)				         ;  2 / 50 Hz from low border switch
    fullscr_waste_54n
    fullscr_waste_27n
    dcb.w	  84-81,$4e71			         ; 84
    fullscr_right_bdr
    fullscr_waste_13n                ; 13
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    rts                              ;  9 / jsr (5) + rts (4)

fullscr_st_223_1st_unmask:           ;  2xNop 2xHi 3xMed
    fullscr_st_223_start
    fullscr_waste_85n
    dcb.w     86-85,$4e71            ; 86 / NOPs
    fullscr_right_bdr
    move.l fullscr_cur_mask_base.l,a4 ;  5 point to screen dest.
    move.l fullscr_cur_mask_bufr.l,a5 ;  5 point to backup buffer
    move.l  #222,d2                   ;  3 not to save time, but memory
    ;dcb.w     13-13,$4e71           ; 13 / NOPs
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    rts                              ;  9 / jsr (5) + rts (4)

fullscr_st_223_unmask:              ;  2xNop 2xHi 4xMed
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs
    fullscr_cpy                      ; 84 nops to rihgt bdr
    moveq    #29,d4
    dcb.w    7,$4e71
fullscr_st_223_unmask_loop:
    dcb.w    1,$4e71
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs
    fullscr_cpy                      ; 84 nops to rihgt bdr
    dcb.w    5,$4e71
    dbra d4,fullscr_st_223_unmask_loop
    fullscr_st_223_start
    dcb.w     86-84,$4e71            ; 86 / NOPs
    fullscr_cpy                      ; 84 nops to rihgt bdr
    fullscr_blackpal
    rts

    ifne enable_tests
fullscr_st_223_last_free:            ;  0xNop 3xHi 1xMed
    fullscr_st_223_start
    fullscr_waste_85n
    dcb.w     86-85,$4e71            ; 86 / NOPs
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

    endc ; machine_t_1

; 12px (6 long) hard shift for machine 2
; need to mask 8 px on 2nd column
    ifne machine_t_2

fullscr_st_242_start: macro          ;  2xNop 4xHi 2xMed
    dcb.w     2,$4e71                ;  2
    move.b    d7,(a0)                ;  2 / Left border hi rez
    dcb.w     2,$4e71                ;  2
    move.b    d6,(a0)                ;  2 / med rez
    move.w    d7,(a0)                ;  2 / low rez
    endm

fullscr_st_242_msk:
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs (to right border)
    fullscr_msk
    moveq    #29,d4
    dcb.w    7,$4e71
fullscr_st_242_msk_loop:
    dcb.w    1,$4e71
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs (to right border)
    fullscr_msk
    dcb.w    5,$4e71
    dbra d4,fullscr_st_242_msk_loop
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs (to right border)
    fullscr_msk
    rts

fullscr_st_242_msk_del:
    fullscr_st_242_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_msk_del                  ; 85 nops to right bdr
    moveq    #48,d4
    dcb.w    7,$4e71
fullscr_st_242_msk_del_loop:
    dcb.w    1,$4e71
    fullscr_st_242_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_msk_del                  ; 85 nops to right bdr
    dcb.w    5,$4e71
    dbra d4,fullscr_st_242_msk_del_loop
    fullscr_st_242_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_msk_del                  ; 85 nops to right bdr
    rts

fullscr_st_242_prp_bdr:
    fullscr_st_242_start
    dcb.w     85-83,$4e71            ; 85 / NOPs
    fullscr_waste_27n
    fullscr_prp_bdr_init             ; 56 Nops to right border, 10 after stabelizer
fullscr_st_242_prp_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_242_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_prp_bdr_loop             ; 85 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_242_prp_bdr_loop  ; 3 / 4
    fullscr_st_242_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_prp_bdr_loop             ; 85 nops to right bdr
    rts

fullscr_st_242_cpy_bdr:
    fullscr_st_242_start
    ;dcb.w     85-85,$4e71           ; 86 / NOPs
    fullscr_waste_54n                ; 54
    fullscr_cpy_bdr_init             ; 31 Nops to right border, 10 after stabelizer
fullscr_st_242_cpy_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy                      ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_242_cpy_bdr_loop  ; 3 / 4
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy                      ; 84 nops to right bdr
    rts

fullscr_st_242_cpy2_bdr: ;this is needed only if bdr_src_offs > 0
    fullscr_st_242_start
    dcb.w     85-83,$4e71            ; 85 / NOPs
    fullscr_cpy2_bdr_init            ; 83 Nops to right border, 10 after stabelizer
fullscr_st_242_cpy2_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy2                     ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_242_cpy2_bdr_loop  ; 3 / 4
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy2                     ; 84 nops to right bdr
    rts

fullscr_st_242_bak_bdr:
    fullscr_st_242_start
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_waste_54n                ; 54
    fullscr_bak_bdr_init             ; 31 Nops to right border, 10 after stabelizer
fullscr_st_242_bak_bdr_loop:
    dcb.w     1,$4e71                ;  5 left from macro (dbra)
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_bak                      ; 84 nops to right bdr
    dcb.w     5,$4e71                ;  1 / NOP
    dbra d4,fullscr_st_242_bak_bdr_loop  ; 3 / 4
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_bak                      ; 84 nops to right bdr
    rts

fullscr_st_242_free:                 ;  2xNop 2xHi 3xMed
    fullscr_st_242_start
    fullscr_waste_85n
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_right_bdr
    fullscr_waste_13n                ; 13
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    rts                              ;  9 / jsr (5) + rts (4)

fullscr_st_242_free_32:
    fullscr_st_242_start
    fullscr_waste_85n
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_right_bdr
    dcb.w     11,$4e71               ;  2 / NOP
    moveq    #30,d4
.fscr_st_242_fr_128_l:
    dcb.w     1,$4e71                ;  2 / NOP
    fullscr_stabilizer
    dcb.w     11,$4e71               ;  9 / NOP
    fullscr_st_242_start
    fullscr_waste_85n
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_right_bdr
    dcb.w     9,$4e71                ;  9 / NOP
    dbra  d4,.fscr_st_242_fr_128_l
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    rts

fullscr_st_242_lower_free:
    fullscr_st_242_start
    fullscr_waste_85n
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_right_bdr
    fullscr_waste_13n                ; 13
    fullscr_stabilizer
		dcb.w	7,$4e71				             ;  7
		move.w	d7,(a1)			             ;  2 lower border
		dcb.w	2,$4e71				             ;  2
		;-------------------------------------------
    dcb.w     2,$4e71                ;  2
    move.b    d7,(a0)                ;  2 / Left border hi rez
    move.b	  d7,(a1)				         ;  2 / 50 Hz from low border switch
    move.b    d6,(a0)                ;  2 / med rez
    move.w    d7,(a0)                ;  2 / low rez
    fullscr_waste_85n
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_right_bdr
    fullscr_waste_13n                ; 13
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    rts                              ;  9 / jsr (5) + rts (4)

fullscr_st_242_1st_unmask:           ;  2xNop 2xHi 3xMed
    fullscr_st_242_start
    fullscr_waste_85n
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
    fullscr_right_bdr
    move.l fullscr_cur_mask_base.l,a4 ;  5 point to screen dest.
    move.l fullscr_cur_mask_bufr.l,a5 ;  5 point to backup buffer
    move.l  #222,d2                   ;  3 not to save time, but memory
    ;dcb.w     13-13,$4e71           ; 13 / NOPs
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    rts                              ;  9 / jsr (5) + rts (4)

fullscr_st_242_unmask:              ;  2xNop 2xHi 4xMed
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy                      ; 84 nops to rihgt bdr
    moveq    #29,d4
    dcb.w    7,$4e71
fullscr_st_242_unmask_loop:
    dcb.w    1,$4e71
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy                      ; 84 nops to rihgt bdr
    dcb.w    5,$4e71
    dbra d4,fullscr_st_242_unmask_loop
    fullscr_st_242_start
    dcb.w     85-84,$4e71            ; 85 / NOPs
    fullscr_cpy                      ; 84 nops to rihgt bdr
    fullscr_blackpal
    rts

    ifne enable_tests
fullscr_st_242_last_free:            ;  0xNop 3xHi 1xMed
    fullscr_st_242_start
    fullscr_waste_85n
    ;dcb.w     85-85,$4e71           ; 85 / NOPs
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

    endc ;machine_t_2

    section	data

 		section	text
