; Atari ST/e synclock demosystem
; September 1, 2011
;
; sys/vbl.s


		section	text


vbl:
		movem.l	d0-a6,-(sp)

		;Micro demopart sequencer
		move.l	part_position,a0
		lea	timera_delay,a1
		subq.l	#1,(a0)+
		bne.s	.no_switch
		add.l	#24,part_position  ;no sequencing
.no_switch:
    move.l	(a0)+,(a1)+			;timera_delay
		move.l	(a0)+,(a1)+			;timera_div
		move.l	(a0)+,(a1)+			;vbl_routine
		move.l	(a0)+,(a1)+			;timera_routine
		move.l	(a0)+,(a1)+			;main_routine

		move.b	-17(a1),$fffffa1f.w		;timera_delay+3	delay (data)
		move.b	-13(a1),$fffffa19.w		;timera_div+3	prediv (start Timer-A)

		move.l	-12(a1),a0			;vbl_routine
		jsr	(a0)

		jsr	music_sndh_play			;Call music driver

		moveq  #0,d0
		move.b $fffffc02.w,d0

		cmp.b	  #$39,d0 ;space
		bne 	 .next0
		move.w	#1,exit_demo
		bra .nokey

.next0:

		tst.l vbl_scr_rgt
		bne .next9
		tst.l vbl_scr_lft
		bne .next9
    cmp.w	vbl_last_key,d0
		beq .nokey

.next9:
		cmp.b  #$50,d0 ;arrow down
	  bne   .next1
		move.l #119596,vbl_scr_rgt
		move.l #0,vbl_scr_lft
		bra   .vbl_do_scroll

.next1:
		cmp.b	 #$48,d0 ;arrow up
	  bne   .next2
		move.l #119596,vbl_scr_lft
		move.l #0,vbl_scr_rgt
		bra   .vbl_do_scroll

.next2:
		cmp.b  #$4B,d0 ;arrow left
		bne   .next4
		move.l #1,vbl_scr_lft
		move.l #0,vbl_scr_rgt
		bra   .vbl_do_scroll
.next4:
		cmp.b	 #$4d,d0 ;arrow right
    bne   .vbl_do_scroll
		move.l #1,vbl_scr_rgt
		move.l #0,vbl_scr_lft
		;bra .vbl_do_scroll

.vbl_do_scroll:

		move.l scr_cur,a1
		move.l 12(a1),d1
		moveq  #0,d2
		move.w d1,d2       ;current step
		clr.w  d1
		swap   d1          ;direction

    tst.l  vbl_scr_lft
		beq   .vbl_scr_right
    subq.l #1,vbl_scr_lft
    cmp.w  #sc_left,d1
		beq   .next3
		lea    scrl_rpx_table,a0   ;currently we ar on rpx table
		lea    scrl_lpx_table,a2
		suba.l a0,a1
		adda.l a2,a1              ;switch to lpx table on equal step position
		bra   .scr_nxt_set
.next3:
		cmp.w  #15,d2
		bne   .nxt3_add
		lea    scr00l,a1
		bra   .scr_nxt_set
.nxt3_add:
		adda   #px_table_width,a1
		bra   .scr_nxt_set

.vbl_scr_right:
    tst.l  vbl_scr_rgt
		beq   .nokey
		subq.l #1,vbl_scr_rgt
    cmp.w  #sc_right,d1
		beq   .next5
		lea    scrl_lpx_table,a0    ;currently we ar on lpx table
		lea    scrl_rpx_table,a2
	  suba.l a0,a1
		adda.l a2,a1              ;switch to rpx table on equal step position
		bra   .scr_nxt_set
.next5:
		cmp.w  #0,d2
		bne   .nxt5_sub
		lea    scr15r,a1
		bra   .scr_nxt_set
.nxt5_sub:
		suba   #px_table_width,a1
    ;bra .scr_nxt_set
.scr_nxt_set:
		move.l a1,scr_nxt
.nokey:
    move.w  d0,vbl_last_key
		addq.w	#1,vbl_counter
		addq.w	#1,global_vbl
		movem.l	(sp)+,d0-a6
		rte


		section	data

;--------------	System variables - do not shift order
part_position:	dc.l	partlist
timera_delay:	  dc.l	0
timera_div:	    dc.l	0
vbl_routine:	  dc.l	dummy
timera_routine:	dc.l	dummy
main_routine:	  dc.l	dummy
vbl_counter:	  dc.w	0
global_vbl:	    dc.w	0
exit_demo:	    dc.w	0
vbl_last_key:   dc.w  0
vbl_scr_lft:    dc.l	0
vbl_scr_rgt:    dc.l	0

		section	text
