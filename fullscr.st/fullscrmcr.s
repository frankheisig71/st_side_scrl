;macros

  section text

fullscr_msk_del:	macro
    ;mask 16px column from buffer
    ;(a4) -> dst (screen buffer 230 bytes per line)
    ; d0  =  #mask
    ;del 16px column
    ;(a6) -> dst for deleting  (screen buffer 230 bytes per line)
    ; d1  =  #$00000000
    ; d2  =  #222
    ; 5x per call

    rept	4
    and.l     d0,(a4)+               ;  5
    and.l     d0,(a4)+               ;  5
    move.l    d1,(a6)+               ;  3
    move.l    d1,(a6)+               ;  3
    adda.w    d2,a4                  ;  2
    adda.w    d2,a6                  ;  2 sum 20
    endr                             ; 80
    and.l     d0,(a4)+               ;  5
    fullscr_right_bdr
    and.l     d0,(a4)+               ;  5
    move.l    d1,(a6)+               ;  3
    move.l    d1,(a6)+               ;  3
    adda.w    d2,a4                  ;  2 sum 13
    ;dcb.w     13-13,$4e71           ; 13 / NOPs
    fullscr_stabilizer
    adda.w    d2,a6                  ;  2
    ;rts                              ;  9 / jsr xxx.l (5) + rts (4)
    endm

fullscr_del_bak:	macro
    ;del 16px column
    ;backup 16px neighbour column to buffer
    ;(a4) -> src (screen buffer 230 bytes per line)
    ;(a5) -> dst for backup (no line wrap)
    ;(a6) -> del (screen buffer 230 bytes per line)
    ; d1  =  #$00000000
    ; d2  -> #222(.w)
    ; 5x per call

    rept	4
    move.l (a4)+,(a5)+               ;  5 copy border
    move.l (a4)+,(a5)+               ;  5 copy border
    adda.w    d2,a4                  ;  2
    move.l    d1,(a6)+               ;  3 clear
    move.l    d1,(a6)+               ;  3 clear
    adda.w    d2,a6                  ;  2 sum 20
    endr                             ;  80
    move.l (a4)+,(a5)+               ;  5 copy border
    fullscr_right_bdr
    move.l (a4)+,(a5)+               ;  5 copy border
    adda.w    d2,a4                  ;  2
    move.l    d1,(a6)+               ;  3 clear
    move.l    d1,(a6)+               ;  3 clear
    ;dcb.w     13-13,$4e71           ; 13 / NOPs
    fullscr_stabilizer
    adda.w    d2,a6                  ;  2
    endm

fullscr_bak:	macro
    ;restore 16px column from buffer
    ;(a4) -> src (screen buffer 230 bytes per line)
    ;(a5) -> dst for backup (no line wrap)
    ; d2  -> #222
    ; 8x per call

    rept 7
    move.l    (a4)+,(a5)+            ;  5
    move.l    (a4)+,(a5)+            ;  5
    adda.w    d2,a4                  ;  2 sum 12
    endr                             ; 84
    fullscr_right_bdr
    move.l    (a4)+,(a5)+            ;  5
    move.l    (a4)+,(a5)+            ;  5
    adda.w    d2,a4                  ;  2
    dcb.w     13-12,$4e71            ; 13 / NOPs
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    endm

fullscr_cpy:	macro
    ;restore 16px column from buffer
    ;(a5) -> src (no line wrap)
    ;(a4) -> dst (screen buffer 230 bytes per line)
    ; d2  -> #222
    ; 8x per call

    rept 7
    move.l    (a5)+,(a4)+            ;  5
    move.l    (a5)+,(a4)+            ;  5
    adda.w    d2,a4                  ;  2 sum 12
    endr                             ; 84
    fullscr_right_bdr
    move.l    (a5)+,(a4)+            ;  5
    move.l    (a5)+,(a4)+            ;  5
    adda.w    d2,a4                  ;  2
    dcb.w     13-12,$4e71            ; 13 / NOPs
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    endm

fullscr_cpy2:	macro ;this is needed only if bdr_src_offs > 0 (copy from a static picture)
    ;restore 16px column from buffer
    ;(a5) -> src (no line wrap)
    ;(a4) -> dst (screen buffer 230 bytes per line)
    ; d2  -> #222
    ; 7x per call

    rept 6
    move.l    (a5)+,(a4)+            ;  5
    move.l    (a5)+,(a4)+            ;  5
    adda.w    d2,a4                  ;  2
    adda.w    #bdr_src_offs,a5       ;  2 sum 14
    endr                             ; 84
    fullscr_right_bdr
    move.l    (a5)+,(a4)+            ;  5
    move.l    (a5)+,(a4)+            ;  5
    adda.w    d2,a4                  ;  2
    dcb.w     13-12,$4e71            ; 13 / NOPs
    fullscr_stabilizer
    adda.w    #bdr_src_offs,a5       ;  2 / NOP
    endm


fullscr_msk:	macro
    ;mask 16px column from buffer
    ;(a4) -> dst (screen buffer 230 bytes per line)
    ; d0  =  #mask
    ; d2  -> #222
    ; 8x per call

    rept	7
    and.l     d0,(a4)+               ;  5
    and.l     d0,(a4)+               ;  5
    adda.w    d2,a4                  ;  2 sum 12
    endr                             ; 84
    fullscr_right_bdr
    and.l     d0,(a4)+               ;  5
    and.l     d0,(a4)+               ;  5
    adda.w    d2,a4                  ;  2 sum 12
    dcb.w     13-12,$4e71            ; 13 / NOPs
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOPs
    endm

fullscr_msk_begin: macro
    dcb.w     107,$4e71
    rts
    endm


shift_scr_load: macro ;load 32 px column from a2
    movem.w   (a2)+,d0-d3            ;  7
    swap      d0                     ;  1
    swap      d1                     ;  1
    swap      d2                     ;  1
    swap      d3                     ;  1
    move.w    (a2)+,d0               ;  2
    move.w    (a2)+,d1               ;  2
    move.w    (a2)+,d2               ;  2
    move.w    (a2)+,d3               ;  2
    endm                             ; 19

shift_scr_load_2p: macro ;load from 32 px 2 different column positions a1, a2
    movem.w   (a2)+,d0-d3            ;  7
    swap      d0                     ;  1
    swap      d1                     ;  1
    swap      d2                     ;  1
    swap      d3                     ;  1
    move.w    (a3)+,d0               ;  2
    move.w    (a3)+,d1               ;  2
    move.w    (a3)+,d2               ;  2
    move.w    (a3)+,d3               ;  2
    endm                             ; 19

shift_369_p0:	macro
    lsr.l	    #3,d0	                 ;  4
    move.w	  d0,(a4)+	             ;  2 / plane 0 SH 3
    lsr.l	    #3,d0	                 ;  4
    move.w    d0,(a5)+               ;  2 / plane 0 SH 6
    lsr.l     #3,d0                  ;  4
    move.w    d0,(a6)+               ;  2 / plane 0 SH 9
		endm                             ; 18

shift_369_p1:	macro
    lsr.l	    #3,d1	                 ;  4
    move.w	  d1,(a4)+	             ;  2 / plane 1 SH 3
    lsr.l	    #3,d1	                 ;  4
    move.w    d1,(a5)+               ;  2 / plane 1 SH 6
    lsr.l     #3,d1                  ;  4
    move.w    d1,(a6)+               ;  2 / plane 1 SH 9
		endm                             ; 18

shift_369_p2:	macro
    lsr.l	    #3,d2	                 ;  4
    move.w	  d2,(a4)+	             ;  2 / plane 2 SH 3
    lsr.l	    #3,d2	                 ;  4
    move.w    d2,(a5)+               ;  2 / plane 2 SH 6
    lsr.l     #3,d2                  ;  4
    move.w    d2,(a6)+               ;  2 / plane 2 SH 9
		endm                             ; 18

shift_369_p3:	macro
    lsr.l	    #3,d3	                 ;  4
    move.w	  d3,(a4)+	             ;  2 / plane 3 SH 3
    lsr.l	    #3,d3	                 ;  4
    move.w    d3,(a5)+               ;  2 / plane 3 SH 6
    lsr.l     #3,d3                  ;  4
    move.w    d3,(a6)+               ;  2 / plane 3 SH 9
		endm                             ; 18

fullscr_cpy_bdr_init: macro
    jsr fullscr_st_cb_bdr_ini.l      ; 31 / 26+5
    endm                             ;  1 Nop left

fullscr_cpy2_bdr_init: macro         ;this is needed only if bdr_src_offs > 0
    jsr fullscr_st_cb2_bdr_ini.l     ; 83 / 78+5
    endm                             ;  1 Nop left

fullscr_bak_bdr_init: macro
    jsr fullscr_st_cb_bdr_ini.l      ; 31 / 26+5
    endm                             ;  1 Nop left

fullscr_prp_bdr_init: macro
    jsr fullscr_st_prp_bdr_ini.l     ; 56 / 51+5
    endm                             ;  1 Nop left

fullscr_prp_bdr_loop: macro
    shift_scr_load_2p                ; 19
    shift_369_p0                     ; 18 / plane 0 / 37
    shift_369_p1                     ; 18 / plane 1 / 55
    shift_369_p2                     ; 18 / plane 2 / 73
    lsr.l	    #3,d3	                 ;  4
    move.w	  d3,(a4)+	             ;  2 / plane 3 SH 3 / 79
    lsr.l	    #3,d3	                 ;  4
    move.w	  d3,(a5)+	             ;  2 / plane 3 SH 6 / 85
                                     ; 85
    fullscr_right_bdr
    lsr.l	    #3,d3	                 ;  4
    move.w	  d3,(a6)+	             ;  2 / plane 3 SH 9
    adda.l    d5,a2                  ;  2
    adda.l    d5,a3                  ;  2
    dcb.w    13-10,$4e71             ; 13 / NOPs
    fullscr_stabilizer
    dcb.w     2,$4e71                ;  2 / NOP
    endm


fullscr_right_bdr: macro
    move.w    d7,(a1)                ;  2 / Right border 60Hz
    move.b    d7,(a1)                ;  2 / 50 hz
    endm

fullscr_stabilizer: macro
    move.b  d7,(a0)                  ;  2 Stabilizer hi rez
    dcb.w  1,$4e71                   ;  1 NOPs
    move.w  d7,(a0)                  ;  2 low rez
    endm

fullscr_blackpal: macro
    lea	$ffff8240.w,a3 		        	 ;  2 / 24 black pal
    moveq	    #0,d0			          	 ;  1
    rept	8
    move.l	  d0,(a3)+			         ; 24 black pal
    endr
    endm

fullscr_waste_85n: macro
    jsr fullscr_waste_85
    endm ;5+1+23*3+1*4+2+4

fullscr_waste_54n: macro
    jsr fullscr_waste_54
    endm ;5+1+13*3+1*4+4

fullscr_waste_27n: macro
    jsr fullscr_waste_27
    endm ;5+1+4*3+1*4+4

fullscr_waste_13n: macro
    jsr fullscr_waste_13
    endm ;5+4+4


    section	data
fullscr_cur_mask_base: dc.l 0
fullscr_cur_mask_bufr: dc.l 0
    section	text
