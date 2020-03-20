; DEAD HACKERS SOCIETY
;
; Atari ST/e synclock demosystem v1.0
; September 10, 2011
;
; main.s

show_infos:  	equ	1				;1=Show startup infos 0=Show nothing at startup
enable_tests:	equ	0
screensize:	  equ	58880 ;59800		;Size of one screen buffer
                          ;294 kB!!
screenspace:	equ	0 ;460	  	;2 scan lines space

bdrbufsize:	  equ	2048		  ;Size of border buffer

;-------------- Demo parts to enable/disable
fullscr_st:	  equ	1				  ;Need sys/fade.s included

;"1" if bdr_src_ds > fs_pic_w_b, "0" if equal, less is not allowed yet
big_picture:  equ 0
machine_t_1:  equ 1
machine_t_2:  equ 0
mem_512_k:    equ 0 ;only for tests, 1 screenbuffer less, means no right
                    ;scrolling and only 8 screen rolls to left


		section	text

begin:
    include	'sys/init.s'			;Setup demosystem
		include	'sys/mainloop.s'		;Mainloop
		include	'sys/exit.s'			;Exit demosystem
		include	'sys/cookie.s'			;Check computer type
		include	'sys/vbl.s'			;Demo sequencer
		include	'sys/timers.s'			;Top border sync and placeholders
		include	'sys/sndh.s'			;Music includes
		include	'sys/common.s'			;Common routines

;-------------- Optional includes
		include	'sys/sscrl.s'			;Syncscroller


;-------------- User demopart includes

	include	'fullscr.st/fullscr.s'

;-------------- User demopart inits

initlist:

	ifne	fullscr_st
   	jsr	sscrl_init
		jsr	fullscr_st_init
	endc

	rts

	section	data

;-------------- Demopart sequence list

;format
;dc.l vbls,timer_a_delay,timer_a_div,vbl_routine,timer_a_routine,main_routine
;Timer A delay/div can be left zero for non-synclock screens

partlist:

	ifne	fullscr_st
		dc.l	30,0,0,dummy,dummy,fullscr_st_runtime_init
		dc.l	-1,97,4,fullscr_st_vbl,fullscr_st_ta,fullscr_st_main
	endc

		dc.l	-1,255,4,black_pal,dummy,dummy
		dc.l	-1,255,4,dummy,dummy,exit0815



		section	text
