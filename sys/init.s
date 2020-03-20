; Atari ST/e synclock demosystem
; September 2, 2011
;
; sys/init.s

		section	text
init:

		move.l	4(sp),a5			;address to basepage
		move.l	$0c(a5),d0			;length of text segment
		add.l	$14(a5),d0			;length of data segment
		add.l	$1c(a5),d0			;length of bss segment
		add.l	#$100,d0			;length of basepage
		add.l	#$1000,d0			;length of stackpointer
		move.l	a5,d1				;address to basepage
		add.l	d0,d1				;end of program
		and.l	#-2,d1				;make address even
		move.l	d1,sp				;new stackspace

		move.l	d0,-(sp)			;mshrink()
		move.l	a5,-(sp)			;
		move.w	d0,-(sp)			;
		move.w	#$4a,-(sp)			;
		trap	#1				;
		lea	12(sp),sp			;

	ifne	show_infos				;
		move.l	#text_demosys,d0		;
		jsr	print				;
	endc

		move.l	#bdrbufsize*7,-(sp)		;Reserve screen backup buffers
		move.w	#$48,-(sp)			;Malloc()
		trap	#1				;
		tst.l	d0				;
		beq	exit_pterm			;Not enough memory
		move.l	d0,bdr_buf0
		add.l	  #bdrbufsize,d0
		move.l	d0,bdr_buf3
		add.l	  #bdrbufsize,d0
		move.l	d0,bdr_buf6
		add.l	  #bdrbufsize,d0
		move.l	d0,bdr_buf9
		add.l	  #bdrbufsize,d0
		move.l	d0,bdr_prp3
		add.l	  #bdrbufsize,d0
		move.l	d0,bdr_prp6
		add.l	  #bdrbufsize,d0
		move.l	d0,bdr_prp9
		;add.l	  #bdrbufsize,d0
		move.l	d0,bdr_dmmy             ;test - take care for clear_buffers if remove!!
    jsr clear_buffers

		ifeq mem_512_k
	  move.l	#screensize*5+160,-(sp)	;Reserve screen memory (+160 for black line)
    endc
		ifne mem_512_k
	  move.l	#screensize*4+1600,-(sp)	;only for tests
    endc
		move.w	#$48,-(sp)			;Malloc()
		trap	#1				;
		tst.l	d0				;
		beq	exit_pterm			;Not enough memory
		;since we use sync-scroll technique, be do`nt need to align to 256
    add.l   #160,d0
		add.l	  #screenspace,d0
		move.l	d0,screen_adr0
		add.l	  #screensize,d0
		move.l	d0,screen_adr1
		add.l	  #screensize,d0
		move.l	d0,screen_adr2
		add.l	  #screensize,d0
		move.l	d0,screen_adr3
		add.l  	#screensize,d0
		move.l	d0,screen_adr4
		move.l	d0,right_dst_boundary
		jsr	clear_screens			;Clear workscreens

		clr.l	-(sp)				;Enter supervisor mode
		move.w	#32,-(sp)			;
		trap	#1				;
		addq.l	#6,sp				;
		move.l	d0,save_stack			;

		jsr	cookie_check			;Check _MCH and CT60

		cmp.l	#"TT  ",computer_type		;Check for TT and exit if true
		bne.s	.not_tt				;
	ifne	show_infos
		move.l	#text_tt,d0			;
		jsr	print				;
	endc
		bra	exit_super			;
.not_tt:						;

.st_setup:
    move.b	$ffff820a.w,save_refresh	;Save and set refreshrate
		or.b	#%00000010,$ffff820a.w		;

		bsr	xbios_vsync			;Save and set resolution
		move.b	$ffff8260.w,save_res		;
		clr.b	$ffff8260.w			;
.st_done:

    lea     $ffff8240.w,a0
		movem.l	(a0),d0-d7	  	;Save palette
		movem.l	d0-d7,save_pal	;

		lea	save_screenadr,a0		;Save screenaddress
		move.b	$ffff8201.w,(a0)+		;
		move.b	$ffff8203.w,(a0)+		;
		move.b	$ffff820d.w,(a0)+		;

		move.l  screen_adr0,d0			;Set screenaddress
    sub.l 1440,d0               ;9 lines without displayed content
		lsr.w	#8,d0				;
		move.l	d0,$ffff8200.w			;big endian: $AABBCCDD
																;AA->8200
																;BB->8201 = screen base high byte
																;CC->8202
																;DD->8203 = screen base mid byte

    jsr black_pal

		cmp.l	#"MSTe",computer_type		;Check for Mega STe
		bne.s	.not_mste			;
		move.b	$ffff8e21.w,save_mste		;Save MSTe speed
		clr.b	$ffff8e21.w			;Set MSTe to 8 MHz no cache
.not_mste:

		move.b	$484.w,save_keymode		;Save and turn keyclick off
		bclr	#0,$484				;

		move.b	#$12,$fffffc02.w		;Kill mouse


;-------------- User + music init

		jsr	initlist			    ;Run user inits
		jsr	music_sndh_init		;Init music player

;	ifne	show_infos
;		move.l	#text_init,d0
;		jsr	print
;	endc


;--------------	Save vectors, MFP and start the demosystem
		move.w	#$2700,sr			;Stop interrupts

		move.l	usp,a0				;USP
		move.l	a0,save_usp			;

		move.l	$68.w,save_hbl			;HBL
		move.l	$70.w,save_vbl			;VBL
		move.l	$134.w,save_timer_a		;Timer-A
		move.l	$120.w,save_timer_b		;Timer-B
		move.l	$114.w,save_timer_c		;Timer-C
		move.l	$110.w,save_timer_d		;Timer-D
		move.l	$118.w,save_acia		;ACIA

		lea	save_mfp,a0			;Restore vectors and mfp
		move.b	$fffffa01.w,(a0)+		;// datareg
		move.b	$fffffa03.w,(a0)+		;Active edge
		move.b	$fffffa05.w,(a0)+		;Data direction
		move.b	$fffffa07.w,(a0)+		;Interrupt enable A
		move.b	$fffffa13.w,(a0)+		;Interupt Mask A
		move.b	$fffffa09.w,(a0)+		;Interrupt enable B
		move.b	$fffffa15.w,(a0)+		;Interrupt mask B
		move.b	$fffffa17.w,(a0)+		;Automatic/software end of interupt
		move.b	$fffffa19.w,(a0)+		;Timer A control
		move.b	$fffffa1b.w,(a0)+		;Timer B control
		move.b	$fffffa1d.w,(a0)+		;Timer C & D control
		move.b	$fffffa27.w,(a0)+		;Sync character
		move.b	$fffffa29.w,(a0)+		;USART control
		move.b	$fffffa2b.w,(a0)+		;Receiver status
		move.b	$fffffa2d.w,(a0)+		;Transmitter status
		move.b	$fffffa2f.w,(a0)+		;USART data

		move.l	#vbl,$70.w 			;Set VBL
		move.l	#timer_a,$134.w			;Set Timer-A
		move.l	#timer_b,$120.w			;Set Timer-B
		move.l	#timer_c,$114.w			;Set Timer-C
		move.l	#timer_d,$110.w			;Set Timer-D
		move.l	#acia,$118.w			;Set ACIA

		move.l	#hbl,$68.w 			;Set HBL

		clr.b	$fffffa07.w			;Interrupt enable A (Timer-A & B)
		clr.b	$fffffa13.w			;Interrupt mask A (Timer-A & B)
		clr.b	$fffffa09.w			;Interrupt enable B (Timer-C & D)
		clr.b	$fffffa15.w			;Interrupt mask B (Timer-C & D)

		clr.b	$fffffa19.w			;Timer-A control (stop)
		clr.b	$fffffa1b.w			;Timer-B control (stop)
		clr.b	$fffffa1d.w			;Timer-C & D control (stop)

		bclr	#3,$fffffa17.w			;Automatic end of interrupt
		bset	#5,$fffffa07.w			;Interrupt enable A (Timer-A)
		bset	#5,$fffffa13.w			;Interrupt mask A

		move.w	#$2300,sr			;Enable interrupts

		section	text
