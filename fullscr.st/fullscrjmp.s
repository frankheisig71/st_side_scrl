
  section	text

  ifne machine_t_1
fn0_sh0_m1:
   move.l  #$000f000f,d0               ;  3 mask
   jsr fullscr_st_fn0_init.l
   jsr fullscr_st_224_msk_del.l         ; 51
   jsr fullscr_st_224_prp_bdr.l         ; 33
   jsr fullscr_st_224_free_128.l        ;128
   rept 7
   jsr fullscr_st_224_free.l            ;  7
   endr
   jsr fullscr_st_224_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_224_free.l            ;  2
   endr
   jsr fullscr_st_224_1st_unmask.l      ;  1
   jsr fullscr_st_224_unmask.l          ; 32
   rts                                  ;256
fn0_sh0_c_m1:
   move.l  #$000f000f,d0               ;  3 mask
   jsr fullscr_st_fn0_init.l
   jsr fullscr_st_224_msk_del.l         ; 51
   jsr fullscr_st_224_cpy_bdr.l         ; 33
   jsr fullscr_st_224_free_128.l        ;128
   rept 7
   jsr fullscr_st_224_free.l            ;  7
   endr
   jsr fullscr_st_224_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_224_free.l            ;  2
   endr
   jsr fullscr_st_224_1st_unmask.l      ;  1
   jsr fullscr_st_224_unmask.l          ; 32
   rts                                  ;256
fn0_sh0_b_m1:
   move.l  #$000f000f,d0               ;  3 mask
   jsr fullscr_st_fn0_init.l
   jsr fullscr_st_224_msk_del.l         ; 51
   jsr fullscr_st_224_bak_bdr.l         ; 33
   jsr fullscr_st_224_free_128.l        ;128
   rept 7
   jsr fullscr_st_224_free.l            ;  7
   endr
   jsr fullscr_st_224_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_224_free.l            ;  2
   endr
   jsr fullscr_st_224_1st_unmask.l      ;  1
   jsr fullscr_st_224_unmask.l          ; 32
   rts                                  ;256

fn1_sh2_m1:
   jsr fullscr_st_fn1_init.l
   jsr fullscr_st_031_del_bak.l         ; 51
   jsr fullscr_st_031_prp_bdr.l         ; 33
   rept 4
   jsr fullscr_st_031_free_32.l         ;128
   endr
   rept 7
   jsr fullscr_st_031_free.l            ;  7
   endr
   jsr fullscr_st_031_lower_free.l      ;  2
   jsr fullscr_st_031_free_32.l         ; 32
   rept 2
   jsr fullscr_st_031_free.l            ; 34
   endr
   jsr fullscr_st_031_last_free.l       ;  1
   rts

fn1_sh2_c_m1:
   jsr fullscr_st_fn1_init.l
   jsr fullscr_st_031_del_bak.l         ; 51
   jsr fullscr_st_031_cpy_bdr.l         ; 33
   rept 4
   jsr fullscr_st_031_free_32.l         ;128
   endr
   rept 7
   jsr fullscr_st_031_free.l            ;  7
   endr
   jsr fullscr_st_031_lower_free.l      ;  2
   jsr fullscr_st_031_free_32.l         ; 32
   rept 2
   jsr fullscr_st_031_free.l            ; 34
   endr
   jsr fullscr_st_031_last_free.l       ;  1
   rts

fn1_sh2_b_m1:
   jsr fullscr_st_fn1_init.l
   jsr fullscr_st_031_del_bak.l         ; 51
   jsr fullscr_st_031_bak_bdr.l         ; 33
   rept 4
   jsr fullscr_st_031_free_32.l         ;128
   endr
   rept 7
   jsr fullscr_st_031_free.l            ;  7
   endr
   jsr fullscr_st_031_lower_free.l      ;  2
   jsr fullscr_st_031_free_32.l         ; 32
   rept 2
   jsr fullscr_st_031_free.l            ; 34
   endr
   jsr fullscr_st_031_last_free.l       ;  1
   rts

fn2_sh4_m1:
   move.l    #$0fff0fff,d0              ;  3 fullscr sh4 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_222_msk.l             ; 32
   jsr fullscr_st_222_prp_bdr.l         ; 33
   rept 4
   jsr fullscr_st_222_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_222_free.l            ; 26
   endr
   jsr fullscr_st_222_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_222_free.l            ;  2
   endr
   jsr fullscr_st_222_1st_unmask.l      ;  1
   jsr fullscr_st_222_unmask.l          ; 32
   rts                                  ;256

fn2_sh4_c_m1:
   move.l    #$0fff0fff,d0              ;  3 fullscr sh4 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_222_msk.l             ; 32
   jsr fullscr_st_222_cpy_bdr.l         ; 33
   rept 4
   jsr fullscr_st_222_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_222_free.l            ; 26
   endr
   jsr fullscr_st_222_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_222_free.l            ;  2
   endr
   jsr fullscr_st_222_1st_unmask.l      ;  1
   jsr fullscr_st_222_unmask.l          ; 32
   rts                                  ;256

fn2_sh4_c2_m1:
   move.l    #$0fff0fff,d0              ;  3 fullscr sh4 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_222_msk.l             ; 32
   jsr fullscr_st_222_cpy2_bdr.l        ; 37
   rept 4
   jsr fullscr_st_222_free_32.l         ;128
   endr
   rept 22
   jsr fullscr_st_222_free.l            ; 22
   endr
   jsr fullscr_st_222_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_222_free.l            ;  2
   endr
   jsr fullscr_st_222_1st_unmask.l      ;  1
   jsr fullscr_st_222_unmask.l          ; 32
   rts                                  ;256

fn2_sh4_b_m1:
   move.l    #$0fff0fff,d0              ;  3 fullscr sh4 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_222_msk.l             ; 32
   jsr fullscr_st_222_bak_bdr.l         ; 33
   rept 4
   jsr fullscr_st_222_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_222_free.l            ; 26
   endr
   jsr fullscr_st_222_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_222_free.l            ;  2
   endr
   jsr fullscr_st_222_1st_unmask.l      ;  1
   jsr fullscr_st_222_unmask.l          ; 32
   rts                                  ;256

fn2_sh4_f_m1:
   move.l    #$0fff0fff,d0              ;  3 fullscr sh4 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_222_msk.l             ; 32
   rept 5
   jsr fullscr_st_222_free_32.l         ;160
   endr
   rept 27
   jsr fullscr_st_222_free.l            ; 27
   endr
   jsr fullscr_st_222_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_222_free.l            ;  2
   endr
   jsr fullscr_st_222_1st_unmask.l      ;  1
   jsr fullscr_st_222_unmask.l          ; 32
   rts                                  ;256

fn2_sh6_m1:
   move.l    #$00ff00ff,d0              ;  3 fullscr sh6 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_223_msk.l             ; 32
   jsr fullscr_st_223_prp_bdr.l         ; 33
   rept 4
   jsr fullscr_st_223_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_223_free.l            ; 26
   endr
   jsr fullscr_st_223_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_223_free.l            ;  2
   endr
   jsr fullscr_st_223_1st_unmask.l      ;  1
   jsr fullscr_st_223_unmask.l          ; 32
   rts                                  ;256

fn2_sh6_b_m1:
   move.l    #$00ff00ff,d0              ;  3 fullscr sh6 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_223_msk.l             ; 32
   jsr fullscr_st_223_bak_bdr.l         ; 33
   rept 4
   jsr fullscr_st_223_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_223_free.l            ; 26
   endr
   jsr fullscr_st_223_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_223_free.l            ;  2
   endr
   jsr fullscr_st_223_1st_unmask.l      ;  1
   jsr fullscr_st_223_unmask.l          ; 32
   rts                                  ;256

fn2_sh6_f_m1:
   move.l    #$00ff00ff,d0              ;  3 fullscr sh6 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_223_msk.l             ; 32
   rept 5
   jsr fullscr_st_223_free_32.l         ;160
   endr
   rept 27
   jsr fullscr_st_223_free.l            ; 27
   endr
   jsr fullscr_st_223_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_223_free.l            ;  2
   endr
   jsr fullscr_st_223_1st_unmask.l      ;  1
   jsr fullscr_st_223_unmask.l          ; 32
   rts                                  ;256

fn3_sh2_m1:
   jsr fullscr_st_fn3_init.l
   rept 32
   jsr fullscr_st_031_bak.l             ; 32
   endr
   jsr fullscr_st_031_prp_bdr.l         ; 33
   rept 4
   jsr fullscr_st_031_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_031_free.l            ; 26
   endr
   jsr fullscr_st_031_lower_free.l      ;  2
   jsr fullscr_st_031_free_32.l         ; 32
   rept 2
   jsr fullscr_st_031_free.l            ;  2
   endr
   jsr fullscr_st_031_last_free.l       ;  1
   rts
fn3_sh2_c_m1:
   jsr fullscr_st_fn3_init.l
   rept 32
   jsr fullscr_st_031_bak.l             ; 32
   endr
   jsr fullscr_st_031_cpy_bdr.l         ; 33
   rept 4
   jsr fullscr_st_031_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_031_free.l            ; 26
   endr
   jsr fullscr_st_031_lower_free.l      ;  2
   jsr fullscr_st_031_free_32.l         ; 32
   rept 2
   jsr fullscr_st_031_free.l            ;  2
   endr
   jsr fullscr_st_031_last_free.l       ;  1
   rts                                  ;256
fn3_sh2_b_m1:
   jsr fullscr_st_fn3_init.l
   rept 32
   jsr fullscr_st_031_bak.l             ; 32
   endr
   jsr fullscr_st_031_bak_bdr.l         ; 33
   rept 4
   jsr fullscr_st_031_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_031_free.l            ; 26
   endr
   jsr fullscr_st_031_lower_free.l      ;  2
   jsr fullscr_st_031_free_32.l         ; 32
   rept 2
   jsr fullscr_st_031_free.l            ;  2
   endr
   jsr fullscr_st_031_last_free.l       ;  1
   rts                                  ;256

fn4_sh6_m1:
   move.l  #$00ff00ff,d0                ;  3 fullscr sh6 mask
   jsr fullscr_st_fn4_init.l
   jsr fullscr_st_223_msk_del.l         ; 51
   jsr fullscr_st_223_prp_bdr.l         ; 33
   rept 4
   jsr fullscr_st_223_free_32.l         ;128
   endr
   rept 7
   jsr fullscr_st_223_free.l            ;  7
   endr
   jsr fullscr_st_223_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_223_free.l            ;  2
   endr
   jsr fullscr_st_223_1st_unmask.l      ;  1
   jsr fullscr_st_223_unmask.l          ; 32
   rts                                  ;256
fn4_sh6_c_m1:
   move.l  #$00ff00ff,d0                ;  3 fullscr sh6 mask
   jsr fullscr_st_fn4_init.l
   jsr fullscr_st_223_msk_del.l         ; 51
   jsr fullscr_st_223_cpy_bdr.l         ; 33
   rept 4
   jsr fullscr_st_223_free_32.l         ;128
   endr
   rept 7
   jsr fullscr_st_223_free.l            ;  7
   endr
   jsr fullscr_st_223_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_223_free.l            ;  2
   endr
   jsr fullscr_st_223_1st_unmask.l      ;  1
   jsr fullscr_st_223_unmask.l          ; 32
   rts                                  ;256
fn4_sh6_c2_m1:
   move.l  #$00ff00ff,d0                ;  3 fullscr sh6 mask
   jsr fullscr_st_fn4_init.l
   jsr fullscr_st_223_msk_del.l         ; 51
   jsr fullscr_st_223_cpy2_bdr.l        ; 37
   rept 4
   jsr fullscr_st_223_free_32.l         ;128
   endr
   rept 3
   jsr fullscr_st_223_free.l            ;  3
   endr
   jsr fullscr_st_223_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_223_free.l            ;  2
   endr
   jsr fullscr_st_223_1st_unmask.l      ;  1
   jsr fullscr_st_223_unmask.l          ; 32
   rts                                  ;256
   endc   ;machine_t_1

  ifne machine_t_2
fn0_sh0_m2:
   move.l  #$000f000f,d0                ;  3 mask
   jsr fullscr_st_fn0_init.l
   jsr fullscr_st_220_msk_del.l         ; 51
   jsr fullscr_st_220_prp_bdr.l         ; 33
   jsr fullscr_st_220_free_128.l        ;128
   rept 7
   jsr fullscr_st_220_free.l            ;  7
   endr
   jsr fullscr_st_220_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_220_free.l            ;  2
   endr
   jsr fullscr_st_220_1st_unmask.l      ;  1
   jsr fullscr_st_220_unmask.l          ; 32
   rts                                  ;256
fn0_sh0_c_m2:
   move.l  #$000f000f,d0                ;  3 mask
   jsr fullscr_st_fn0_init.l
   jsr fullscr_st_220_msk_del.l         ; 51
   jsr fullscr_st_220_cpy_bdr.l         ; 33
   jsr fullscr_st_220_free_128.l        ;128
   rept 7
   jsr fullscr_st_220_free.l            ;  7
   endr
   jsr fullscr_st_220_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_220_free.l            ;  2
   endr
   jsr fullscr_st_220_1st_unmask.l      ;  1
   jsr fullscr_st_220_unmask.l          ; 32
   rts                                  ;256
fn0_sh0_b_m2:
   move.l  #$000f000f,d0                ;  3 mask
   jsr fullscr_st_fn0_init.l
   jsr fullscr_st_220_msk_del.l         ; 51
   jsr fullscr_st_220_bak_bdr.l         ; 33
   jsr fullscr_st_220_free_128.l        ;128
   rept 7
   jsr fullscr_st_220_free.l            ;  7
   endr
   jsr fullscr_st_220_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_220_free.l            ;  2
   endr
   jsr fullscr_st_220_1st_unmask.l      ;  1
   jsr fullscr_st_220_unmask.l          ; 32
   rts                                  ;256

fn1_sh2_m2:
   jsr fullscr_st_fn1_init.l
   jsr fullscr_st_143_del_bak.l         ; 51
   jsr fullscr_st_143_prp_bdr.l         ; 33
   rept 4
   jsr fullscr_st_143_free_32.l         ;128
   endr
   rept 7
   jsr fullscr_st_143_free.l            ;  7
   endr
   jsr fullscr_st_143_lower_free.l      ;  2
   jsr fullscr_st_143_free_32.l         ; 32
   rept 2
   jsr fullscr_st_143_free.l            ; 34
   endr
   jsr fullscr_st_143_last_free.l       ;  1
   rts

fn1_sh2_c_m2:
   jsr fullscr_st_fn1_init.l
   jsr fullscr_st_143_del_bak.l         ; 51
   jsr fullscr_st_143_cpy_bdr.l         ; 33
   rept 4
   jsr fullscr_st_143_free_32.l         ;128
   endr
   rept 7
   jsr fullscr_st_143_free.l            ;  7
   endr
   jsr fullscr_st_143_lower_free.l      ;  2
   jsr fullscr_st_143_free_32.l         ; 32
   rept 2
   jsr fullscr_st_143_free.l            ; 34
   endr
   jsr fullscr_st_143_last_free.l       ;  1
   rts

fn1_sh2_b_m2:
   jsr fullscr_st_fn1_init.l
   jsr fullscr_st_143_del_bak.l         ; 51
   jsr fullscr_st_143_bak_bdr.l         ; 33
   rept 4
   jsr fullscr_st_143_free_32.l         ;128
   endr
   rept 7
   jsr fullscr_st_143_free.l            ;  7
   endr
   jsr fullscr_st_143_lower_free.l      ;  2
   jsr fullscr_st_143_free_32.l         ; 32
   rept 2
   jsr fullscr_st_143_free.l            ; 34
   endr
   jsr fullscr_st_143_last_free.l       ;  1
   rts

fn2_sh4_m2:
   move.l    #$0fff0fff,d0              ;  3 fullscr sh4 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_231_msk.l             ; 32
   jsr fullscr_st_231_prp_bdr.l         ; 33
   rept 4
   jsr fullscr_st_231_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_231_free.l            ; 26
   endr
   jsr fullscr_st_231_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_231_free.l            ;  2
   endr
   jsr fullscr_st_231_1st_unmask.l      ;  1
   jsr fullscr_st_231_unmask.l          ; 32
   rts                                  ;256

fn2_sh4_c_m2:
   move.l    #$0fff0fff,d0              ;  3 fullscr sh4 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_231_msk.l             ; 32
   jsr fullscr_st_231_cpy_bdr.l         ; 33
   rept 4
   jsr fullscr_st_231_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_231_free.l            ; 26
   endr
   jsr fullscr_st_231_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_231_free.l            ;  2
   endr
   jsr fullscr_st_231_1st_unmask.l      ;  1
   jsr fullscr_st_231_unmask.l          ; 32
   rts                                  ;256

fn2_sh4_c2_m2:
   move.l    #$0fff0fff,d0              ;  3 fullscr sh4 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_231_msk.l             ; 32
   jsr fullscr_st_231_cpy2_bdr.l        ; 37
   rept 4
   jsr fullscr_st_231_free_32.l         ;128
   endr
   rept 22
   jsr fullscr_st_231_free.l            ; 22
   endr
   jsr fullscr_st_231_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_231_free.l            ;  2
   endr
   jsr fullscr_st_231_1st_unmask.l      ;  1
   jsr fullscr_st_231_unmask.l          ; 32
   rts                                  ;256

fn2_sh4_b_m2:
   move.l    #$0fff0fff,d0              ;  3 fullscr sh4 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_231_msk.l             ; 32
   jsr fullscr_st_231_bak_bdr.l         ; 33
   rept 4
   jsr fullscr_st_231_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_231_free.l            ; 26
   endr
   jsr fullscr_st_231_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_231_free.l            ;  2
   endr
   jsr fullscr_st_231_1st_unmask.l      ;  1
   jsr fullscr_st_231_unmask.l          ; 32
   rts                                  ;256

fn2_sh4_f_m2:
   move.l    #$0fff0fff,d0              ;  3 fullscr sh4 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_231_msk.l             ; 32
   rept 5
   jsr fullscr_st_231_free_32.l         ;160
   endr
   rept 27
   jsr fullscr_st_231_free.l            ; 27
   endr
   jsr fullscr_st_231_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_231_free.l            ;  2
   endr
   jsr fullscr_st_231_1st_unmask.l      ;  1
   jsr fullscr_st_231_unmask.l          ; 32
   rts                                  ;256

fn2_sh6_m2:
   move.l    #$00ff00ff,d0              ;  3 fullscr sh6 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_242_msk.l             ; 32
   jsr fullscr_st_242_prp_bdr.l         ; 33
   rept 4
   jsr fullscr_st_242_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_242_free.l            ; 26
   endr
   jsr fullscr_st_242_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_242_free.l            ;  2
   endr
   jsr fullscr_st_242_1st_unmask.l      ;  1
   jsr fullscr_st_242_unmask.l          ; 32
   rts                                  ;256

fn2_sh6_b_m2:
   move.l    #$00ff00ff,d0              ;  3 fullscr sh6 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_242_msk.l             ; 32
   jsr fullscr_st_242_bak_bdr.l         ; 33
   rept 4
   jsr fullscr_st_242_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_242_free.l            ; 26
   endr
   jsr fullscr_st_242_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_242_free.l            ;  2
   endr
   jsr fullscr_st_242_1st_unmask.l      ;  1
   jsr fullscr_st_242_unmask.l          ; 32
   rts                                  ;256

fn2_sh6_f_m2:
   move.l    #$00ff00ff,d0              ;  3 fullscr sh6 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_242_msk.l             ; 32
   rept 5
   jsr fullscr_st_242_free_32.l         ;160
   endr
   rept 27
   jsr fullscr_st_242_free.l            ; 27
   endr
   jsr fullscr_st_242_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_242_free.l            ;  2
   endr
   jsr fullscr_st_242_1st_unmask.l      ;  1
   jsr fullscr_st_242_unmask.l          ; 32
   rts                                  ;256

fn3_sh2_m2:
   jsr fullscr_st_fn3_init.l
   rept 32
   jsr fullscr_st_143_bak.l             ; 32
   endr
   jsr fullscr_st_143_prp_bdr.l         ; 33
   rept 4
   jsr fullscr_st_143_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_143_free.l            ; 26
   endr
   jsr fullscr_st_143_lower_free.l      ;  2
   jsr fullscr_st_143_free_32.l         ; 32
   rept 2
   jsr fullscr_st_143_free.l            ;  2
   endr
   jsr fullscr_st_143_last_free.l       ;  1
   rts
fn3_sh2_c_m2:
   jsr fullscr_st_fn3_init.l
   rept 32
   jsr fullscr_st_143_bak.l             ; 32
   endr
   jsr fullscr_st_143_cpy_bdr.l         ; 33
   rept 4
   jsr fullscr_st_143_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_143_free.l            ; 26
   endr
   jsr fullscr_st_143_lower_free.l      ;  2
   jsr fullscr_st_143_free_32.l         ; 32
   rept 2
   jsr fullscr_st_143_free.l            ;  2
   endr
   jsr fullscr_st_143_last_free.l       ;  1
   rts                                  ;256
fn3_sh2_b_m2:
   jsr fullscr_st_fn3_init.l
   rept 32
   jsr fullscr_st_143_bak.l             ; 32
   endr
   jsr fullscr_st_143_bak_bdr.l         ; 33
   rept 4
   jsr fullscr_st_143_free_32.l         ;128
   endr
   rept 26
   jsr fullscr_st_143_free.l            ; 26
   endr
   jsr fullscr_st_143_lower_free.l      ;  2
   jsr fullscr_st_143_free_32.l         ; 32
   rept 2
   jsr fullscr_st_143_free.l            ;  2
   endr
   jsr fullscr_st_143_last_free.l       ;  1
   rts                                  ;256

fn4_sh6_m2:
   move.l  #$00ff00ff,d0                ;  3 fullscr sh6 mask
   jsr fullscr_st_fn4_init.l
   jsr fullscr_st_242_msk_del.l         ; 51
   jsr fullscr_st_242_prp_bdr.l         ; 33
   rept 4
   jsr fullscr_st_242_free_32.l         ;128
   endr
   rept 7
   jsr fullscr_st_242_free.l            ;  7
   endr
   jsr fullscr_st_242_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_242_free.l            ;  2
   endr
   jsr fullscr_st_242_1st_unmask.l      ;  1
   jsr fullscr_st_242_unmask.l          ; 32
   rts                                  ;256
fn4_sh6_c_m2:
   move.l  #$00ff00ff,d0                ;  3 fullscr sh6 mask
   jsr fullscr_st_fn4_init.l
   jsr fullscr_st_242_msk_del.l         ; 51
   jsr fullscr_st_242_cpy_bdr.l         ; 33
   rept 4
   jsr fullscr_st_242_free_32.l         ;128
   endr
   rept 7
   jsr fullscr_st_242_free.l            ;  7
   endr
   jsr fullscr_st_242_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_242_free.l            ;  2
   endr
   jsr fullscr_st_242_1st_unmask.l      ;  1
   jsr fullscr_st_242_unmask.l          ; 32
   rts                                  ;256
fn4_sh6_c2_m2:
   move.l  #$00ff00ff,d0                ;  3 fullscr sh6 mask
   jsr fullscr_st_fn4_init.l
   jsr fullscr_st_242_msk_del.l         ; 51
   jsr fullscr_st_242_cpy2_bdr.l        ; 37
   rept 4
   jsr fullscr_st_242_free_32.l         ;128
   endr
   rept 3
   jsr fullscr_st_242_free.l            ;  3
   endr
   jsr fullscr_st_242_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_242_free.l            ;  2
   endr
   jsr fullscr_st_242_1st_unmask.l      ;  1
   jsr fullscr_st_242_unmask.l          ; 32
   rts                                  ;256
   endc   ;machine_t_2

   ifne enable_tests
tst_sh0_m1:
   jsr fullscr_st_init_free.l
   rept 219
   jsr fullscr_st_224_free.l            ;106
   endr
   jsr fullscr_st_224_lower_free.l      ;  2
   rept 34
   jsr fullscr_st_224_free.l            ; 34
   endr
   jsr fullscr_st_224_last_free.l       ;  1
   rts                                  ;256

tst_sh2_m1:
   jsr fullscr_st_init_free.l
   rept 219
   jsr fullscr_st_031_free.l            ;106
   endr
   jsr fullscr_st_031_lower_free.l      ;  2
   rept 34
   jsr fullscr_st_031_free.l            ; 34
   endr
   jsr fullscr_st_031_last_free.l       ;  1
   rts                                  ;256

tst_sh4_m1:
   jsr fullscr_st_init_free.l
   rept 219
   jsr fullscr_st_222_free.l            ;106
   endr
   jsr fullscr_st_222_lower_free.l      ;  2
   rept 34
   jsr fullscr_st_222_free.l            ; 34
   endr
   jsr fullscr_st_222_last_free.l       ;  1
   rts                                  ;256

fn2_sh4_x_m1:
   move.l    #$00ff00ff,d0              ;  3 fullscr sh6 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_222_msk.l             ; 32
   jsr fullscr_st_222_cpy2_bdr.l        ; 37
   rept 4
   jsr fullscr_st_222_free_32.l         ;128
   endr
   rept 22
   jsr fullscr_st_222_free.l            ; 26
   endr
   jsr fullscr_st_222_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_222_free.l            ;  2
   endr
   jsr fullscr_st_222_1st_unmask.l      ;  1
   jsr fullscr_st_222_unmask.l          ; 32
   rts                                  ;256

tst_sh6_m1:
   jsr fullscr_st_init_free.l
   rept 219
   jsr fullscr_st_223_free.l            ;106
   endr
   jsr fullscr_st_223_lower_free.l      ;  2
   rept 34
   jsr fullscr_st_223_free.l            ; 34
   endr
   jsr fullscr_st_223_last_free.l       ;  1
   rts                                  ;256

fn2_sh6_x_m1:
   move.l    #$00ff00ff,d0              ;  3 fullscr sh6 mask
   jsr fullscr_st_fn2_init.l
   jsr fullscr_st_223_msk.l             ; 32
   jsr fullscr_st_223_cpy2_bdr.l        ; 37
   rept 4
   jsr fullscr_st_223_free_32.l         ;128
   endr
   rept 22
   jsr fullscr_st_223_free.l            ; 22
   endr
   jsr fullscr_st_223_lower_free.l      ;  2
   rept 2
   jsr fullscr_st_223_free.l            ;  2
   endr
   jsr fullscr_st_223_1st_unmask.l      ;  1
   jsr fullscr_st_223_unmask.l          ; 32
   rts                                  ;256

   endc ;enable_tests

fullscr_st_init_free:
    fullscr_waste_27n
    dcb.w   10,$4e71                    ;  40
    bra.w  fullscr_st_enable_colors

fullscr_st_fn0_init:
    move.l    a4,a6                     ;  1
    adda.w  #208,a6                     ;  2 point to right border
    moveq     #0,d1                     ;  1
    move.w  #222,d2                     ;  2 not to save time, but memory
    and.l     d0,(a4)+                  ;  5 mask first line
    and.l     d0,(a4)+                  ;  5 mask first line
    move.l    d1,(a6)+                  ;  3 del rgt1 1st line
    move.l    d1,(a6)+                  ;  3 del rgt1 1st line
    adda.w    d2,a4                     ;  2
    adda.w    d2,a6                     ;  2 / sum 27 + 3(mask)
    dcb.w    8,$4e71                    ;  7 / sum + 3(mask) + 3(bra) -> 40
    bra.w  fullscr_st_enable_colors

fullscr_st_fn1_init:
    move.l    a4,a6                     ;  1
    suba     #16,a6                     ;  2 point to left border to clear
    moveq     #0,d1                     ;  1
    move.w  #222,d2                     ;  2

    move.l    d1,(a6)+                  ;  3 clear
    move.l    d1,(a6)+                  ;  3 clear
    move.l (a4)+,(a5)+                  ;  5 copy border
    move.l (a4)+,(a5)+                  ;  5 copy border
    adda.w    d2,a4                     ;  2
    adda.w    d2,a6                     ;  2 / sum 27
    dcb.w     11,$4e71                  ; 10 / sum + 3(bra) -> 40
    bra.w  fullscr_st_enable_colors

fullscr_st_fn2_init:
    move.l  #222,d2                     ;  3 not to save time, but memory
    fullscr_waste_27n
    dcb.w     4,$4e71                  ;  31 / sum + 3(mask) + 3(bra) -> 40
    bra.w  fullscr_st_enable_colors

fullscr_st_fn3_init:
    move.l  #222,d2                     ;  3 not to save time, but memory
    fullscr_waste_27n
    dcb.w    7,$4e71                    ; 34  / sum + 3(bra) -> 40
    bra.w  fullscr_st_enable_colors

fullscr_st_fn4_init:
    move.l    a4,a6                     ;  1
    suba.w   #16,a6                     ;  2 point to left outer border
    moveq     #0,d1                     ;  1
    move.l  #222,d2                     ;  3 not to save time, but memory

    and.l     d0,(a4)+                  ;  5 mask first line
    and.l     d0,(a4)+                  ;  5 mask first line
    move.l    d1,(a6)+                  ;  3 del
    move.l    d1,(a6)+                  ;  3 del
    adda.w    d2,a4                     ;  2
    adda.w    d2,a6                     ;  2 / sum 27 + 3(mask)
    dcb.w     10,$4e71                  ; 10 / sum + 3(mask) -> 40

fullscr_st_enable_colors:
    movem.l  fullscr_cur_pal,d3-d7/a0-a2 ;21 Load colours
    movem.l  d3-d7/a0-a2,$ffff8240.w     ;19 Set palette just before overscan begins
    lea  $ffff8260.w,a0                 ;  2
    lea  $ffff820a.w,a1                 ;  2
    moveq  #2,d7                        ;  1   /D7 used for the overscan code
    moveq  #1,d6                        ;  1   /D6 used for the overscan code
    rts

fullscr_st_prp_bdr_ini:
    move.l  scr_cur,a2               ;  5
    move.l  16(a2),d0                ;  4 / border src offs
    move.l  20(a2),d1                ;  4 / border dst offs
    lea     scr_buf_sh0,a2           ;  3
    move.l  12(a2),a3                ;  4 / bdr_prp0 = src1 / 20
    adda.l  d0,a3                    ;  2 / src offset
    move.l  28(a2),a4                ;  4 / bdr_prp3 = dst
    adda.l  d1,a4                    ;  2 / dst offset
    move.l  44(a2),a5                ;  4 / bdr_prp6 = dst
    adda.l  d1,a5                    ;  2 / dst offset
    move.l  60(a2),a6                ;  4 / bdr_prp9 = dst
    adda.l  d1,a6                    ;  2 / dst offset     / 40
    move.l  bdr_src_base.l,a2        ;  5 / src2
    adda.l  d0,a2                    ;  2 / src offset
    move.l  #bdr_src_offs,d5         ;  3
    moveq   #30,d4                   ;  1 / 31 loops
                                     ; 51
    fullscr_right_bdr
    fullscr_waste_13n                ; 13 / NOPs
    fullscr_stabilizer
    dcb.w     6,$4e71                ;  6 + 4 (rts) = 10 / NOP
    rts

fullscr_st_cb_bdr_ini:
    move.l  scr_cur,a2               ;  5
    move.l  16(a2),a3                ;  4 / dst screen table
    move.l  20(a2),d1                ;  4 / dst screen offs
    move.l  (a3),a4                  ;  3 / hw scr addr (dst)
    move.l  12(a3),a5                ;  4 / bdr_prp_buf (src)
    adda.l  d1,a4                    ;  2 / dst offset
    moveq   #30,d4                   ;  1 / 31 loops
    move.l #222,d2                   ;  3
                                     ; 26
    fullscr_right_bdr
    fullscr_waste_13n                ; 13 / NOPs
    fullscr_stabilizer
    dcb.w   6,$4e71                  ;  6 + 4 (rts) = 10 / NOP
    rts

fullscr_st_cb2_bdr_ini: ;this is needed only if bdr_src_offs > 0
    move.l  scr_cur,a2               ;  5
    move.l  16(a2),a3                ;  4 / dst screen table
    move.l  20(a2),d1                ;  4 / dst screen offs
    move.l  (a3),a4                  ;  3 / hw scr addr (dst)
    move.l  12(a3),a5                ;  4 / bdr_prp_buf (src)
    adda.l  d1,a4                    ;  2 / dst offset
    moveq   #34,d4                   ;  1 / 35 loops
    move.l #222,d2                   ;  3
                                     ; 26
    rept 3
    move.l    (a5)+,(a4)+            ;  5
    move.l    (a5)+,(a4)+            ;  5
    adda.l    d2,a4                  ;  2
    adda      #bdr_src_offs,a5       ;  2 sum 14
    endr                             ; 42
    move.l    (a5)+,(a4)+            ;  5
    move.l    (a5)+,(a4)+            ;  5
                                     ; 52 + 26 = 78
    fullscr_right_bdr
    fullscr_waste_13n                ; 13 / NOPs
    fullscr_stabilizer

    adda.l    d2,a4                  ;  2
    adda.l    #bdr_src_offs,a5       ;  2
    dcb.w     2,$4e71                ;  2 / NOP
    rts

fullscr_waste_85:
    moveq    #23,d7         ;1
    dc.w     $51cf          ;dbra d7
    dc.w     $fffe          ;-1 .. 3 / 4 nops
    moveq    #2,d7          ;1 for overscan
    dc.w     $4e71          ;1 / nop
    rts

fullscr_waste_27:
    moveq    #4,d7          ;1
    dc.w     $51cf          ;dbra d7
    dc.w     $fffe          ;-1 .. 3 / 4 nops
    moveq    #2,d7          ;1 for overscan
    rts

fullscr_waste_54:
    moveq    #13,d7          ;1
    dc.w     $51cf          ;dbra d7
    dc.w     $fffe          ;-1 .. 3 / 4 nops
    moveq    #2,d7          ;1 for overscan
    rts

fullscr_waste_13:
    dcb.w     4,$4e71       ; 37
    rts

   section	data
   section	text
