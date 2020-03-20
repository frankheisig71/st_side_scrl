; Atari ST/e synclock demosystem
; September 1, 2011
;
; sys/common.s
;
; Generic common routines and buffers that can be used by all demo parts

run_once:  macro
  subq.w  #1,.once
  beq.s  .run_it
  rts
.once:    dc.w  1
.run_it:
  endm

remove_top_border:  macro
  move.w  #$2100,sr      ;Enable HBL
  stop  #$2100        ;Wait for HBL
  move.w  #$2700,sr      ;Stop all interrupts
  clr.b  $fffffa19.w      ;Stop Timer A

  dcb.w   84,$4e71      ;Have fun for a bit

  move.b  #0,$ffff820a.w      ;Remove the top border
  dcb.w   9,$4e71        ;
  move.b  #2,$ffff820a.w      ;
  move.w  #$2300,sr      ;
  endm

do_hardsync_top_border:  macro
  move.w  #$2100,sr      ;Enable HBL
  stop  #$2100        ;Wait for HBL
  move.w  #$2700,sr      ;Stop all interrupts
  clr.b  $fffffa19.w      ;Stop Timer A

  dcb.w   84,$4e71      ;Have fun for a bit

  move.b  #0,$ffff820a.w      ;Remove the top border
  dcb.w   9,$4e71        ;
  move.b  #2,$ffff820a.w      ;
  move.w  #$2300,sr      ;

  lea  $ffff8209.w,a0      ;Hardsync
  moveq  #127,d1        ;
.sync:    tst.b  (a0)        ;
  beq.s  .sync        ;
  move.b  (a0),d2        ;
  sub.b  d2,d1        ;
  lsr.l  d1,d1        ;
  endm

dummy:    rts


clear_screens:
  move.l  screen_adr0,a0
  suba.w  #screenspace,a0
  move.l  screen_adr1,a1
  suba.w  #screenspace,a1
  move.l  screen_adr2,a2
  suba.w  #screenspace,a2
  move.l  screen_adr3,a3
  suba.w  #screenspace,a3
  move.l  screen_adr4,a4
  suba.w  #screenspace,a4
  moveq  #0,d0
  move.w  #screensize/4-1,d7
.clr:
  move.l  d0,(a0)+
  move.l  d0,(a1)+
  move.l  d0,(a2)+
  move.l  d0,(a3)+
  move.l  d0,(a4)+
  dbra  d7,.clr
  rts

clear_buffers:
  move.l  bdr_buf0,a0
  moveq  #0,d0
  move.w  #bdrbufsize*2-1,d7
.clr:
  move.l  d0,(a0)+
  dbra  d7,.clr
  rts


black_pal:  lea  $ffff8240.w,a0
  moveq  #0,d0
  rept  8
  move.l  d0,(a0)+
  endr
  rts

print:
;d0.l address to null terminated string
  move.l  d0,-(sp)      ;cconws()
  move.w  #$9,-(sp)      ;
  trap  #1        ;
  addq.l  #6,sp        ;
  rts

make_hex:
  move.l  #9,d2
  moveq   #7,d3
.hexloop:
  move.l  d0,d1;
  and.w  #$0F,d1;
    lea text_hex_table,a1
  adda.w  d1,a1
  move.b (a1),(0,a0,d2)
  lsr.l   #4,d0
  subq.l  #1,d2
    dbeq d3,.hexloop
  rts

make_hex_b:
  move.l  #3,d2
  moveq   #1,d3
.hexloop_b:
  move.l  d0,d1;
  and.w    #$0F,d1;
  lea text_hex_table,a1
  adda.w  d1,a1
  move.b  (a1),(0,a0,d2)
  lsr.l   #4,d0
  subq    #1,d2
  dbeq    d3,.hexloop_b
  rts

waitkey:
    move.w  #7,-(sp)      ;crawcin()
  trap  #1        ;
  addq.l  #2,sp        ;
  rts ;

xbios_vsync:  move.w  #37,-(sp)      ;vsync()
  trap  #14        ;
  addq.l  #2,sp        ;
  rts          ;

clear_kbd:  move.w  #2,-(sp)      ;bconstat()
  move.w  #1,-(sp)      ;
  trap    #13        ;
  addq.l  #4,sp        ;
  tst.l   d0        ;
  beq.s   .ok        ;
  move.w  #2,-(sp)      ;bconin()
  move.w  #2,-(sp)      ;
  trap    #13        ;
  addq.l  #4,sp        ;
  bra.s   clear_kbd      ;
.ok:            rts          ;


  section  data

code_copy_offset:  dc.l  0


  ifne  show_infos

text_demosys:    dc.b  "Dead Hackers Society",13,10,13,10,0
  even

text_init:    dc.b  "- Init done, starting demo",13,10,0
  even

text_sndh:    dc.b  "- SNDH music initialized",13,10,0
  even

text_ym:    dc.b  "- YM3 music initialized",13,10,0
  even

text_ymdigi:    dc.b  "- YM-DIGI music initialized",13,10,0
  even

text_dma:    dc.b  "- DMA music initialized",13,10,0
  even

text_mod:    dc.b  "- Protracker music initialized",13,10
  dc.b  "  (Lance, 50 kHz STe)",13,10,0
  even

text_code_dump:    dc.b  "- Code memory dumped to file",13,10,0
  even

text_st:    dc.b  "- Exiting: Needs STe hardware",13,10,0
  even

text_tt:    dc.b  "- Exiting: TT incompatible",13,10,0
  even

text_falcon:    dc.b  "- Exiting: Falcon incompatible",13,10,0
  even

text_falcon_mode:  dc.b  "- Falcon video setup",13,10,0
  even

text_term:
      dc.b  13,10,0
  even

text_screen1:
       dc.b  "number  00: "
text_number_screen1:
  dc.b  "0x00000000, "
text_screen2:
       dc.b  "number  01: "
text_number_screen2:
  dc.b  "0x00000000  ",13,10,0
  even

text_screen3:
       dc.b  "number  02: "
text_number_screen3:
  dc.b  "0x00000000, "
text_screen4:
       dc.b  "number  03: "
text_number_screen4:
  dc.b  "0x00000000  ",13,10,0
  even

text_buf1:
       dc.b  "number  04: "
text_number_buf1:
  dc.b  "0x00000000, "
text_buf2:
       dc.b  "number  05: "
text_number_buf2:
  dc.b  "0x00000000  ",13,10,0
  even
text_buf3:
       dc.b  "number  06: "
text_number_buf3:
  dc.b  "0x00000000, "
text_buf4:
       dc.b  "number  07: "
text_number_buf4:
  dc.b  "0x00000000  ",13,10,0
  even


text_addr1:
       dc.b  "ScrCur addr: "
text_number_addr1:
  dc.b  "0x00000000, "
text_addr2:
       dc.b  "ScrPtr addr: "
text_number_addr2:
  dc.b  "0x00000000",13,10,0
  even

reg_addr:
       dc.b  13,10,"Register:  "
reg_number_addr_1:
  dc.b  "0x00, "
reg_number_addr_2:
  dc.b  "0x00, "
reg_number_addr_3:
  dc.b  "0x00, "
reg_number_addr_4:
      dc.b  "0x00",13,10,0
      even

text_waitkey:
  dc.b  13,10,"Press any key to continue",13,10,0
  even
text_hex_table:
      dc.b "0123456789ABCDEF"
  even

  endc

fullscr_pic_start_buffer:
  dcb.l    1,$00000000       ;addresses

fullscr_address_buffer:
  dcb.l    273,$00000000       ;addresses


  section  bss

save_hbl:         ds.l  1      ;HBL vector
save_vbl:         ds.l  1      ;VBL vector
save_timer_a:     ds.l  1      ;Timer-A vector
save_timer_b:     ds.l  1      ;Timer-B vector
save_timer_c:     ds.l  1      ;Timer-C vector
save_timer_d:     ds.l  1      ;Timer-D vector
save_acia:        ds.l  1      ;ACIA vector
save_usp:         ds.l  1      ;USP
save_mfp:         ds.b  16     ;MFP
save_res:         ds.w  1      ;Resolution
save_refresh:     ds.w  1      ;Refreshrate
save_screenadr:   ds.l  1      ;Screen address
save_keymode:     ds.w  1      ;Keyclick
save_stack:       ds.l  1      ;User stack
save_pal:         ds.w  16     ;Palette
save_hscroll:     ds.w  1      ;Hscroll
save_lw:          ds.w  1      ;Linewidth
save_mste:        ds.w  1      ;Mega STe speed
screen_adr0:      ds.l  1      ;Screen 1
screen_adr1:      ds.l  1      ;Screen 2
screen_adr2:      ds.l  1      ;Screen 3
screen_adr3:      ds.l  1      ;Screen 4
screen_adr4:      ds.l  1      ;Screen 5
bdr_buf0:         ds.l  1      ;Address to border buffer0
bdr_buf3:         ds.l  1      ;Address to border buffer3
bdr_buf6:         ds.l  1      ;Address to border buffer6
bdr_buf9:         ds.l  1      ;Address to border buffer9
bdr_dmmy:         ds.l  1      ;Address to border buffer0
bdr_prp3:         ds.l  1      ;Address to border buffer3
bdr_prp6:         ds.l  1      ;Address to border buffer6
bdr_prp9:         ds.l  1      ;Address to border buffer9
  section  text
