; Fullscreen template
; 230 byte linewidth (approx 408 usable pixels per line (8 most-right pixels is trashed on real machines))
; Works on both ST and STe
;
; Double buffered screens
;
; September 3, 2011

    section  text
    include  'fullscr.st/fullscrmcr.s'
    include  'fullscr.st/fullscrjmp.s'
    include  'fullscr.st/fullscr0.s'
    include  'fullscr.st/fullscr6.s'
    include  'fullscr.st/fullscr4.s'
    include  'fullscr.st/fullscr2.s'

fullscr_st_init:
    jsr  black_pal

    ;prepare pointers for border generation source
    ;for this demo, we take it from orig picture
    lea  fullscr_st_picture+32,a2 ; a2 points to left border
    move.l  a2,left_src_boundary
    lea     bdr_src_offs(a2),a3   ; a3 points to right border of src
    move.l  a3,right_src_boundary
    move.l  a2,a4
    adda    #fs_pic_w_b-8,a4      ; a4 points to the right border content source
                                  ; of displayd picture

    ;note: the variable name "..src_lftX" comes from rotating direction
    ;so in case of using "..src_lftX" we rotate to LEFT
    ;in case of using "..src_rgtX" we rotate to RIGHT
    ;remember: for left rotating picture we continuously need new right borders
    ;for right rotating picture we continuously need new left borders

    ;rotating to left... (need new right borders)
    move.l  a4,bdr_src_lft1 ; current right border
    ifeq big_picture        ; no big picture, means: src_pic_w_b = fs_pic_w_b
    move.l  a2,bdr_src_lft2 ; so next right border is the current left border
    endc
    ifne big_picture        ; big picture
    adda    #8,a4
    move.l  a4,bdr_src_lft2 ; just the next right border
    endc

    ;At this (starting) point the new right border is already prepared and
    ;parially copied - see px-tables or doc sheets

    ;okay, if we're going to rotate to right, next left border to be prepared is
    ;always the right border of src picture
    move.l  a3,bdr_src_rgt2
    suba    #8,a3
    move.l  a3,bdr_src_rgt1


    ;determine screen buffer boundaries
    move.l  screen_adr0,d0
    move.l  d0,left_dst_boundary
    move.l  screen_adr4,d1
    move.l  d1,right_dst_boundary
    sub.l   d0,d1
    move.l  d1,dst_boundary_dist

    move.l  screen_adr0,d0
    add.l   #fs_buf_w_b,d0
    move.l  d0,left_dst_cpy_bdry

    move.l  screen_adr4,d0
    sub.l   #fs_buf_w_b,d0
    move.l  d0,right_dst_cpy_bdry

		;load allocated buffer addresses into tables
    lea     scr_buf_sh0,a0
    move.l  screen_adr0,a1
    move.l  a1,(a0)+        ;scr base pointer for hardware
    move.l  a1,(a0)+        ;scr base pointer for mask / paint
    move.l  bdr_buf0,(a0)+  ;buffer for mask
    move.l  bdr_src_lft2,(a0)+ ;pointer to new bdr src
    move.l  bdr_src_lft1,bdr_src_base ;pointer to cur bdr src

    move.l  screen_adr1,a1
    move.l  a1,(a0)+        ;scr base pointer for hardware
    move.l  a1,(a0)+        ;scr base pointer for mask / paint
    move.l  bdr_buf3,(a0)+  ;buffer for mask
    move.l  bdr_prp3,(a0)+  ;buffer for preparing new border

    move.l  screen_adr2,a1
    move.l  a1,(a0)+        ;scr base pointer for hardware
    lea     8(a1),a1        ;mask is already 1 column ahead
    move.l  a1,(a0)+        ;scr base pointer for mask / paint
    move.l  bdr_buf6,(a0)+  ;buffer for mask
    move.l  bdr_prp6,(a0)+  ;buffer for preparing new border

    move.l  screen_adr3,a1
    move.l  a1,(a0)+        ;scr base pointer for hardware
    lea     8(a1),a1        ;mask is already 1 column ahead
    move.l  a1,(a0)+        ;scr base pointer for mask / paint
    move.l  bdr_buf9,(a0)+  ;buffer for mask
    move.l  bdr_prp9,(a0)+  ;buffer for preparing new border

    ;scr_buf_dbl
    move.l  screen_adr3,a1
    move.l  a1,(a0)+        ;scr base pointer for hardware
    lea     8(a1),a1        ;mask is already 1 column ahead
    move.l  a1,(a0)+        ;scr base pointer for mask / paint
    move.l  bdr_buf9,(a0)+  ;buffer for mask
    move.l  bdr_prp9,(a0)+  ;buffer for preparing new border

    ;scr_buf_dbr
    move.l  screen_adr3,a1
    move.l  a1,(a0)+        ;scr base pointer for hardware
    lea     8(a1),a1        ;mask is already 1 column ahead
    move.l  a1,(a0)+        ;scr base pointer for mask / paint
    move.l  bdr_buf9,(a0)+  ;buffer for mask
    move.l  bdr_prp9,(a0)+  ;buffer for preparing new border

    ;scr_buf_dmy
    move.l  screen_adr0,a1
    move.l  a1,(a0)+
    move.l  a1,(a0)+
    move.l  bdr_dmmy,(a0)+
    move.l  bdr_dmmy,(a0)+

    rts

fullscr_st_runtime_init:
    run_once        ;Macro to ensure the runtime init only run once
    bsr  fullscr_st_copy_pic
    jsr  sscrl_setup_list        ;first sync-scroll
    rts

fullscr_st_vbl:
    rts

fullscr_st_main:
    rts

fullscr_st_ta:
    do_hardsync_top_border      ;Macro to syncronize into exact cycle and remove top border

    ;do_syncscroll: seven syncscroll scanlines, a0,a3,d7 used
    move.l scr_cur,a6      ;5 current lpx table entry
    move.l (a6),a3         ;3 current screen table pointer
    move.l 4(a3),a4        ;4 current msk screenbuffer pointer
    move.l 8(a3),a5        ;4 current bdr_buf pointer
    move.l 4(a6),a3        ;4 pointer to function set table entry
    move.l (a3),a2         ;3 function set

    move.l a4,fullscr_cur_mask_base    ;5
    move.l a5,fullscr_cur_mask_bufr    ;5

    dcb.w  61-33,$4e71
    lea  sscrl_jumplist,a1 ;3
    move.l  (a1)+,a0       ;3
    moveq  #2,d7           ;1 for overscan
    rept  7
    jsr  (a0)              ;4*7=28
    endr                   ;use sync lines for work later on -> jsr (a3)
                           ;(a3) -> specific 86 nop routine
;   134 nops to 1st overscan
; -   4 jsr (an)
; -   5 jsr xxxx.l
; -  86 init line
; -   4 rts
; -   5 jsr xxxx.l
;    30
    dcb.w   30,$4e71         ; 6 or 7 nops needed for wake state correction
    jsr  (a2)                ; do overscan

    move.l scr_cur,a0
    move.l scr_nxt,a1
    move.l 12(a0),d0
    move.l 12(a1),d1
    cmp.l d0,d1              ; same screen setup?
    beq .no_screen_change    ; nothing to do
    move.l 8(a0),d0          ; 4bit shift offset (byte)
    ;check if there is something to do after last screen
    ;realign hw buffer pointer if needed (post realign: hscrX++)
    cmp.w #6,d0              ; everytime hard shift 6 (12px) was done
    bne .post_realign_end
    move.l 12(a0),d7
		clr.w  d7
		swap   d7                ; direction
    cmp.w  #sc_left,d7       ; only on scrolling to left
    bne .post_realign_end
    move.l (a0),a2
    move.l (a2),d3           ; screen ptr
    move.l 4(a2),d4          ; mask ptr
    jsr bdr_dst_check_rgt    ; increment / check hw screenbuffer pointer, set mask ptr
    move.l d3,(a2)           ; screen ptr
    move.l d4,4(a2)          ; mask ptr
.post_realign_end:

    ;now check if there is something to do before next screen
    move.l 8(a1),d0          ; 4bit shift offset (byte)
    move.l 12(a1),d1
    moveq  #0,d2
    move.w d1,d2             ; step
    clr.w  d1
    swap   d1                ; direction
    move.l (a1),a2           ; current screen table pointer

    ;realign hw buffer pointer if needed (pre realign: --hscrX)
    cmp.w #6,d0              ; everytime hard shift 6 (12px) is on
    bne .pre_realign_nxt
    cmp.w  #sc_right,d1      ; only on scrolling to right
    bne .pre_realign_end
    move.l (a2),d3           ; screen ptr
    move.l 4(a2),d4          ; mask ptr
    jsr bdr_dst_check_lft    ; decrement / check hw screenbuffer pointer, set mask ptr
    move.l d3,(a2)           ; screen ptr
    move.l d4,4(a2)          ; mask ptr
    bra  .pre_realign_end
.pre_realign_nxt:
    ;realign mask buffer pointer if needed (pre realign: --hscrX)
    cmp.w #2,d0              ; everytime hard shift 2 (4px) is on
    bne .pre_realign_end
    cmp.w  #sc_left,d1       ; on scrolling to left -> ++
    bne .dec_mask_buffer_ptr
    add.l  #8,4(a2)          ; increment mask screenbuffer pointer
    bra .pre_realign_end     ; (no boundary check needed, it never passes hw-pointer)
.dec_mask_buffer_ptr
    sub.l  #8,4(a2)          ; decrement mask screenbuffer pointer
.pre_realign_end:            ; (no boundary check needed, it never passes hw-pointer)

    ;set border src depending on (new) direction
    lea   scr_buf_sh0,a0
    cmp.w #sc_left,d1        ; direction?
    bne .do_bdr_src_rgt
    cmp.w  #4,d2             ; step? (can be another one between 2 preparation blocks)
    beq .cal_bdr_src_lft     ; yes, we need to calculate next bdr src
    cmp.w d1,d7              ; direction change?
    bne .set_bdr_src_lft     ; yes, we need to set other bdr src
    bra .set_bdr_src_end     ; no, nothing to do
.cal_bdr_src_lft:
    ;realign border src for left rotation
    move.l bdr_src_lft1,d3
    jsr bdr_src_check_rgt    ; add 8 and boundary check for right end of orig pic
    move.l d3,bdr_src_lft1
    move.l bdr_src_lft2,d3
    jsr bdr_src_check_rgt
    move.l d3,bdr_src_lft2
    move.l bdr_src_rgt1,d3  ; keep bdr_src for right rotation up to date too
    jsr bdr_src_check_rgt
    move.l d3,bdr_src_rgt1
    move.l bdr_src_rgt2,d3
    jsr bdr_src_check_rgt
    move.l d3,bdr_src_rgt2
.set_bdr_src_lft:
    move.l bdr_src_lft2,12(a0)        ; prep0 = bdr_src_lft2
    move.l bdr_src_lft1,bdr_src_base  ; bdr_src_base = bdr_src_lft1
    bra .set_bdr_src_end
.do_bdr_src_rgt:
    cmp.w  #4,d2             ; step?
    beq .cal_bdr_src_rgt     ; yes, we need to calculate next bdr src
    cmp.w d1,d7              ; direction change?
    bne .set_bdr_src_rgt     ; yes, we need to set other bdr src
    bra .set_bdr_src_end     ; no, nothing to do
.cal_bdr_src_rgt:            ; realign border src for right rotation
    move.l bdr_src_rgt1,d3
    jsr bdr_src_check_lft    ; sub 8 and boundary check for left end of orig pic
    move.l d3,bdr_src_rgt1
    move.l bdr_src_rgt2,d3
    jsr bdr_src_check_lft
    move.l d3,bdr_src_rgt2
    move.l bdr_src_lft1,d3   ; keep bdr_src for left rotation up to date too
    jsr bdr_src_check_lft
    move.l d3,bdr_src_lft1
    move.l bdr_src_lft2,d3
    jsr bdr_src_check_lft
    move.l d3,bdr_src_lft2
.set_bdr_src_rgt:
    move.l bdr_src_rgt2,12(a0)        ; prep0 = bdr_src_2
    move.l bdr_src_rgt1,bdr_src_base  ; bdr_src_base = bdr_src_lft1
.set_bdr_src_end:

    move.l scr_nxt,scr_cur   ; new screen setup
    jsr sscrl_setup_list     ; calc new sync-scroll

.no_screen_change:
    move.l scr_cur,a0
    move.l (a0),d0
    lea scr_buf_sh0,a1
    move.l a1,d1
    sub.l  d1,d0

    move.l d0,number_buf0
    move.l 12(a0),number_buf1
    move.l screen_adr0,number_buf2
    move.l screen_adr4,number_buf3
    lea scr_buf_sh0,a0
    move.l (a0),number_buf4

    tst.w black_vbls
    beq .use_colors_end
    sub.w #1,black_vbls
    bne .use_colors_end
    movem.l  fullscr_st_picture,d2-d7/a0-a1
    movem.l  d2-d7/a0-a1,fullscr_cur_pal
    ;move.l fullscr_st_picture,fullscr_cur_pal
.use_colors_end:
    move.w  #$2300,sr
    rts

bdr_src_check_rgt: ;add and check against right border overflow
    add.l  #8,d3
    cmp.l  right_src_boundary,d3
    bls .chk_bdr_src_rgt_nxt       ;branch lower or same
    move.l left_src_boundary,d3    ;rotate
.chk_bdr_src_rgt_nxt:
    rts

bdr_src_check_lft: ;sub and check against left border overflow
    sub.l  #8,d3
    cmp.l  left_src_boundary,d3
    bcc .chk_bdr_src_lft_nxt        ;branch higher or same
    move.l right_src_boundary,d3    ;rotate
.chk_bdr_src_lft_nxt:
    rts

bdr_dst_check_rgt: ;add and check against right border overflow
    add.l  #8,d3
    cmp.l  right_dst_boundary,d3
    bcs .chk_bdr_dst_rgt_nxt        ;branch lower
    move.l dst_boundary_dist,d5
    sub.l  d5,d3                    ;point to new screen address
    sub.l  d5,d4                    ;point to new mask address
.chk_bdr_dst_rgt_nxt:

    rts

bdr_dst_check_lft: ;sub and check against left border overflow
    sub.l  #8,d3
    cmp.l  left_dst_boundary,d3
    bcc .chk_bdr_dst_lft_nxt        ;branch higher or same
    move.l dst_boundary_dist,d5
    add.l  d5,d3                    ;point to new screen address
    add.l  d5,d4                    ;point to new mask address
.chk_bdr_dst_lft_nxt:
    rts

fullscr_st_copy_pic:
    ;black line
    move.l  scr_buf_sh0,a3
    suba    #160,a3
    move.w  #160/4-1,d6
    moveq   #0,d1
.xy:
    move.l  d1,(a3)+
    dbra    d6,.xy

    ;now start copying plane picture
    move.l  screen_adr0,a3
    ifeq mem_512_k
    move.l  screen_adr4,a4         ;copy screen 5
    endc
		ifne mem_512_k
    move.l  screen_adr0,a4         ;no screen 5 !!!
    endc
    lea  fullscr_st_picture+32,a2
    ; not shifted pic first (incl. right outer border)
    move.w  #fs_pic_h-1,d7
.y1:
    move.w  #fs_pic_w_b/4-1,d6
    ifeq big_picture  ;no big picture
    move.l  (a2),d0   ;save 1st column
    move.l  4(a2),d1  ;save 1st column
    endc
.x1:
    move.l  (a2),(a3)+
    move.l  (a2)+,(a4)+
    dbra  d6,.x1
    ifeq big_picture   ;no big picture
    move.l  d0,(a3)+   ;copy left border to right
    move.l  d0,(a4)+   ;new right border = current left border (rotating pic [rgt1 = lft0])
    move.l  d1,(a3)+
    move.l  d1,(a4)+
    endc
    ifne big_picture   ;big picture
    move.l  (a2),(a3)+ ;copy right border
    move.l  (a2)+,(a4)+
    move.l  (a2),(a3)+
    move.l  (a2)+,(a4)+
    adda    #bdr_src_ds-fs_pic_w_b-8,a2
    endc
    lea     14(a3),a3  ;208+8+14=230
    lea     14(a4),a4
    dbra    d7,.y1

    lea  fullscr_st_picture+32,a2
    move.l  screen_adr1,a4
    move.l  screen_adr2,a5
    move.l  screen_adr3,a6
    move.l  a2,a1
    adda    #bdr_src_offs,a1    ;new left border = right border (rotating pic)
    move.w  #fs_pic_h-1,d7      ;means here: values shifted in left, comes from right border
.y2:
    ifeq big_picture   ;no big picture
    move.w  #fs_pic_w_b/8-2,d6   ;one loop less, because right outer border  = left boder
    endc
    ifne big_picture   ;big picture
    move.w  #fs_pic_w_b/8-1,d6
    endc
    movem.w (a1),d0-d3
    swap    d0
    swap    d1
    swap    d2
    swap    d3
    move.w  (a2)+,d0
    move.w  (a2)+,d1
    move.w  (a2)+,d2
    move.w  (a2)+,d3
    shift_369_p0
    shift_369_p1
    shift_369_p2
    shift_369_p3
.x2:
    suba  #8,a2                    ;load last and next column
    shift_scr_load                 ;(only a2 is used for the rest of line)
    shift_369_p0
    shift_369_p1
    shift_369_p2
    shift_369_p3
    dbra  d6,.x2
    ifeq big_picture                ;no big picture
    move.l  -fs_pic_w_b(a4),(a4)+   ;copy first column to right (rotating pic [rgt1 = lft0])
    move.l  -fs_pic_w_b(a4),(a4)+
    move.l  -fs_pic_w_b(a5),(a5)+
    move.l  -fs_pic_w_b(a5),(a5)+
    move.l  -fs_pic_w_b(a6),(a6)+
    move.l  -fs_pic_w_b(a6),(a6)+
    ;adda    #src_pic_w_b-fs_pic_w_b,a2  ;in this case #src_pic_w_b-fs_pic_w_b = 0
    endc
    ifne big_picture   ;big picture
    adda    #src_pic_w_b-fs_pic_w_b-8,a2
    endc
    adda    #src_pic_w_b,a1
    adda    #14,a4
    adda    #14,a5
    adda    #14,a6
    dbra    d7,.y2

    ;now prepare left border buffers, needed for masking
    lea scr_buf_sh0,a4
    lea scr_buf_sh3,a5
    move.l  4(a4),a0
    move.l  4(a5),a1
    move.l  8(a4),a2
    move.l  8(a5),a3
    move.w  #fs_pic_h-1,d7
.z1:
    move.l  (a0)+,(a2)+
    move.l  (a0)+,(a2)+
    move.l  (a1)+,(a3)+
    move.l  (a1)+,(a3)+
    adda    #222,a0
    adda    #222,a1
    dbra    d7,.z1

    lea scr_buf_sh6,a4
    lea scr_buf_sh9,a5
    move.l  4(a4),a0
    move.l  4(a5),a1
    move.l  8(a4),a2
    move.l  8(a5),a3
    move.w  #fs_pic_h-1,d7
.z2:
    move.l  (a0)+,(a2)+
    move.l  (a0)+,(a2)+
    move.l  (a1)+,(a3)+
    move.l  (a1)+,(a3)+
    adda    #222,a0
    adda    #222,a1
    dbra    d7,.z2

    ;now fill prep buffers with content (= right outer Border [rgt1])
    move.l  bdr_prp3,a1
    move.l  bdr_prp6,a2
    move.l  bdr_prp9,a3
    move.l  screen_adr1,a4 ;sh3
    adda    #fs_pic_w_b,a4
    move.l  screen_adr2,a5 ;sh6
    adda    #fs_pic_w_b,a5
    move.l  screen_adr3,a6 ;sh9
    adda    #fs_pic_w_b,a6
    move.w  #fs_pic_h-1,d7  ;#fs_pic_h-1,d7
.z3:
    move.l  (a4)+,(a1)+
    move.l  (a4)+,(a1)+
    move.l  (a5)+,(a2)+
    move.l  (a5)+,(a2)+
    move.l  (a6)+,(a3)+
    move.l  (a6)+,(a3)+
    adda    #222,a4
    adda    #222,a5
    adda    #222,a6
    dbra    d7,.z3
    rts


    section  data

fullscr_cur_pal:      dcb.w  16,$0000

bdr_src_base: dc.l 0
bdr_src_off:  dc.l 0

scr_nxt:  dc.l scr00l
scr_cur:  dc.l scr00l


  ifne machine_t_1
fn0_sh0:    dc.l fn0_sh0_m1
fn0_sh0_c:  dc.l fn0_sh0_c_m1
fn0_sh0_b:  dc.l fn0_sh0_b_m1
fn1_sh2:    dc.l fn1_sh2_m1
fn1_sh2_c:  dc.l fn1_sh2_c_m1
fn1_sh2_b:  dc.l fn1_sh2_b_m1
fn2_sh4:    dc.l fn2_sh4_m1
fn2_sh4_c:  dc.l fn2_sh4_c_m1
fn2_sh4_c2: dc.l fn2_sh4_c2_m1
fn2_sh4_b:  dc.l fn2_sh4_b_m1
fn2_sh4_f:  dc.l fn2_sh4_f_m1
fn2_sh6:    dc.l fn2_sh6_m1
fn2_sh6_b:  dc.l fn2_sh6_b_m1
fn2_sh6_f:  dc.l fn2_sh6_f_m1
fn3_sh2:    dc.l fn3_sh2_m1
fn3_sh2_c:  dc.l fn3_sh2_c_m1
fn3_sh2_b:  dc.l fn3_sh2_b_m1
fn4_sh6:    dc.l fn4_sh6_m1
fn4_sh6_c:  dc.l fn4_sh6_c_m1
fn4_sh6_c2: dc.l fn4_sh6_c2_m1
  endc

  ifne machine_t_2
fn0_sh0:    dc.l fn0_sh0_m2
fn0_sh0_c:  dc.l fn0_sh0_c_m2
fn0_sh0_b:  dc.l fn0_sh0_b_m2
fn1_sh2:    dc.l fn1_sh2_m2
fn1_sh2_c:  dc.l fn1_sh2_c_m2
fn1_sh2_b:  dc.l fn1_sh2_b_m2
fn2_sh4:    dc.l fn2_sh4_m2
fn2_sh4_c:  dc.l fn2_sh4_c_m2
fn2_sh4_c2: dc.l fn2_sh4_c2_m2
fn2_sh4_b:  dc.l fn2_sh4_b_m2
fn2_sh4_f:  dc.l fn2_sh4_f_m2
fn2_sh6:    dc.l fn2_sh6_m2
fn2_sh6_b:  dc.l fn2_sh6_b_m2
fn2_sh6_f:  dc.l fn2_sh6_f_m2
fn3_sh2:    dc.l fn3_sh2_m2
fn3_sh2_c:  dc.l fn3_sh2_c_m2
fn3_sh2_b:  dc.l fn3_sh2_b_m2
fn4_sh6:    dc.l fn4_sh6_m2
fn4_sh6_c:  dc.l fn4_sh6_c_m2
fn4_sh6_c2: dc.l fn4_sh6_c2_m2
  endc

  ifne enable_tests
tst_sh0:    dc.l tst_sh0_m1
tst_sh2:    dc.l tst_sh2_m1
tst_sh4:    dc.l tst_sh4_m1
tst_sh6:    dc.l tst_sh6_m1
fn2_sh6_x:  dc.l fn2_sh6_x_m1
fn2_sh4_x:  dc.l fn2_sh4_x_m1
  endc

;screen tables
;scr_buf_hw  = screen address for hardware registers
;scr_buf_msk = screen address for masking functions (left border)
;bdr_buf     = backup buffer for masking function
;prp_bdr     = (sh3..sh9) - buffer for preparing next shifted column
;              (sh0) - points to related column of unshifted picture src
;scr_buf_hw, scr_buf_msk, bdr_buf, prp_bdr
scr_buf_sh0: ds.l 4
scr_buf_sh3: ds.l 4
scr_buf_sh6: ds.l 4
scr_buf_sh9: ds.l 4
;next buffers are used for preparing screen buffer wrap around
;dst_col_adr = dst column, changed after each column copy
;cur_scr_tbl = src screen (wrapped next), changed after each completed screen
;cur_prp_bdr = src buffer for column to copy
;dst_col_adr, cur_scr_tbl, n.c., cur_prp_bdr
scr_buf_dbl: ds.l 4
scr_buf_dbr: ds.l 4
;dummy for testing purposes
scr_buf_dmy: ds.l 4

px_table_width: equ	24
scrl_lpx_table: ;tab 1: screen buffer table
                ;tab 2: function set
                ;tab 3: 4bit-scroll offset
                ;tab 4: pixel movement
                ;tab 5: block 2 function
                ;tab 5: param1
                ;tab 6: param2

scr00l: dc.l scr_buf_sh0,fn0_sh0_c, 0,$000000,scr_buf_sh6,208                ; 0  + 0  - 0 =  0
scr01l: dc.l scr_buf_sh3,fn1_sh2_c, 2,$000001,scr_buf_sh3,208                ; 0  + 4  - 3 =  1
scr02l: dc.l scr_buf_sh6,fn2_sh4_c2,4,$000002,scr_buf_sh0,208                ; 0  + 8  - 6 =  2
scr03l: dc.l scr_buf_sh9,fn2_sh6_b, 6,$000003,scr_buf_sh9,0                  ; 0  + 12 - 9 =  3
scr04l: dc.l scr_buf_sh0,fn1_sh2_b, 2,$000004,scr_buf_sh6,0                  ; 0  + 4  - 0 =  4
scr05l: dc.l scr_buf_sh3,fn2_sh4_b, 4,$000005,scr_buf_sh3,0                  ; 0  + 8  - 3 =  5
scr06l: dc.l scr_buf_sh6,fn2_sh6_f, 6,$000006,scr_buf_dmy,0                  ; 0  + 12 - 6 =  6
scr07l: dc.l scr_buf_sh9,fn0_sh0,   0,$000007,bdr_src_ds*000,bdr_dst_ds*000  ; 16 + 0  - 9 =  7
scr08l: dc.l scr_buf_sh0,fn2_sh4,   4,$000008,bdr_src_ds*032,bdr_dst_ds*032  ; 0  + 8  - 0 =  8
scr09l: dc.l scr_buf_sh3,fn2_sh6,   6,$000009,bdr_src_ds*064,bdr_dst_ds*064  ; 0  + 12 - 3 =  9
scr10l: dc.l scr_buf_sh6,fn0_sh0,   0,$00000a,bdr_src_ds*096,bdr_dst_ds*096  ; 16 + 0  - 6 = 10
scr11l: dc.l scr_buf_sh9,fn1_sh2,   2,$00000b,bdr_src_ds*128,bdr_dst_ds*128  ; 16 + 4  - 9 = 11
scr12l: dc.l scr_buf_sh0,fn2_sh6,   6,$00000c,bdr_src_ds*160,bdr_dst_ds*160  ; 0  + 12 - 0 = 12
scr13l: dc.l scr_buf_sh3,fn0_sh0,   0,$00000d,bdr_src_ds*192,bdr_dst_ds*192  ; 16 + 0  - 3 = 13
scr14l: dc.l scr_buf_sh6,fn1_sh2,   2,$00000e,bdr_src_ds*224,bdr_dst_ds*224  ; 16 + 4  - 6 = 14
scr15l: dc.l scr_buf_sh9,fn2_sh4_c, 4,$00000f,scr_buf_sh9,208                ; 16 + 8  - 9 = 15

scrl_rpx_table:

scr00r: dc.l scr_buf_sh0,fn0_sh0_b, 0,$010000,scr_buf_sh6,208                ; 0  + 0  - 0 =  0
scr01r: dc.l scr_buf_sh3,fn3_sh2_b, 2,$010001,scr_buf_sh3,208                ; 0  + 4  - 3 =  1
scr02r: dc.l scr_buf_sh6,fn2_sh4_f, 4,$010002,scr_buf_dmy,208                ; 0  + 8  - 6 =  2
scr03r: dc.l scr_buf_sh9,fn4_sh6_c, 6,$010003,scr_buf_sh9,0                  ; 0  + 12 - 9 =  3
scr04r: dc.l scr_buf_sh0,fn3_sh2_c, 2,$010004,scr_buf_sh6,0                  ; 0  + 4  - 0 =  4
scr05r: dc.l scr_buf_sh3,fn2_sh4_c, 4,$010005,scr_buf_sh3,0                  ; 0  + 8  - 3 =  5
scr06r: dc.l scr_buf_sh6,fn4_sh6_c2,6,$010006,scr_buf_sh0,0                  ; 0  + 12 - 6 =  6
scr07r: dc.l scr_buf_sh9,fn0_sh0,   0,$010007,bdr_src_ds*000,bdr_dst_ds*000  ; 16 + 0  - 9 =  7
scr08r: dc.l scr_buf_sh0,fn2_sh4,   4,$010008,bdr_src_ds*032,bdr_dst_ds*032  ; 0  + 8  - 0 =  8
scr09r: dc.l scr_buf_sh3,fn4_sh6,   6,$010009,bdr_src_ds*064,bdr_dst_ds*064  ; 0  + 12 - 3 =  9
scr10r: dc.l scr_buf_sh6,fn0_sh0,   0,$01000a,bdr_src_ds*096,bdr_dst_ds*096  ; 16 + 0  - 6 = 10
scr11r: dc.l scr_buf_sh9,fn3_sh2,   2,$01000b,bdr_src_ds*128,bdr_dst_ds*128  ; 16 + 4  - 9 = 11
scr12r: dc.l scr_buf_sh0,fn4_sh6,   6,$01000c,bdr_src_ds*160,bdr_dst_ds*160  ; 0  + 12 - 0 = 12
scr13r: dc.l scr_buf_sh3,fn0_sh0,   0,$01000d,bdr_src_ds*192,bdr_dst_ds*192  ; 16 + 0  - 3 = 13
scr14r: dc.l scr_buf_sh6,fn3_sh2,   2,$01000e,bdr_src_ds*224,bdr_dst_ds*224  ; 16 + 4  - 6 = 14
scr15r: dc.l scr_buf_sh9,fn2_sh4_b, 4,$01000f,scr_buf_sh9,208                ; 16 + 8  - 9 = 15


bdr_src_lft1:   dc.l 0
bdr_src_lft2:   dc.l 0
bdr_src_rgt1:   dc.l 0
bdr_src_rgt2:   dc.l 0
left_src_boundary:  dc.l 0  ;source picture boundaries
right_src_boundary: dc.l 0
left_dst_boundary:  dc.l 0  ;buffer boundaries for screen wrap around
right_dst_boundary: dc.l 0
left_dst_cpy_bdry:  dc.l 0  ;buffer boundaries for praparing screen wrap
right_dst_cpy_bdry: dc.l 0
dst_boundary_dist:  dc.l 0
black_vbls:         dc.w 1

  ifeq big_picture   ;no big picture
src_pic_w:      equ  416
src_pic_w_b:    equ  208
  endc
  ifne big_picture   ;big picture
src_pic_w:      equ  1936
src_pic_w_b:    equ  968
  endc
src_pic_h:      equ  256
fs_pic_w:       equ  416 ;416
fs_pic_w_b:     equ  208  ;208 byte length
fs_pic_h:       equ  256
fs_buf_w_b:     equ  230
fs_buf_h:       equ  260
fs_pic_buf_size_b:   equ 58880  ;230*256
fs_pic_buf_dist_b:   equ 239200 ;4*230*260 = 4*screensize

bdr_src_offs:   equ src_pic_w_b-8
bdr_src_ds:     equ src_pic_w_b   ;distance from left to right of scr picture = width
bdr_dst_offs:   equ 0
bdr_dst_ds:     equ (bdr_dst_offs+8)
sc_left:        equ 0
sc_right:       equ 1



fullscr_st_picture:
    ifeq big_picture   ;no big picture
    incbin  'fullscr.st/pic2.4pl'    ;416x273 four bitplanes and 32 byte palette at the start
    endc
    ifne big_picture   ;big picture
    incbin  'fullscr.st/pan.4pl'     ;1936x256 four bitplanes and 32 byte palette at the start
    endc
    even

    section  text
