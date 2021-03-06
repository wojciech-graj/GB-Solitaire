;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _draw_bkg_leaderboard
	.globl _rand
	.globl _initrand
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _cursor
	.globl _dynamic_metasprite
	.globl _selected_leaderboard
	.globl _score
	.globl _num_folded_piles
	.globl _settings
	.globl _scroll
	.globl _flags
	.globl _top_card_idx
	.globl _piles
	.globl _deck
	.globl _setting_pile_heights
	.globl _menu_card_tiles
	.globl _animation_speeds
	.globl _clear_bkg_2x1
	.globl _draw_card_top
	.globl _draw_card_bottom
	.globl _draw_card
	.globl _draw_sequential_card
	.globl _clear_bkg
	.globl _draw_bkg_game
	.globl _draw_bkg_splash_screen
	.globl _draw_bkg_settings
	.globl _metasprite_2x3_hide
	.globl _set_metasprite_card
	.globl _draw_setting_frame_metasprites
	.globl _dynamic_metasprite_end_animation
	.globl _dynamic_metasprite_splash_screen_callback
	.globl _dynamic_metasprite_splash_screen
	.globl _dynamic_metasprite_fold_pile
	.globl _dynamic_metasprite_unfold_callback
	.globl _dynamic_metasprite_move_stack_callback
	.globl _dynamic_metasprite_fold_callback
	.globl _dynamic_metasprite_fold
	.globl _dynamic_metasprite_deal_callback
	.globl _dynamic_metasprite_deal
	.globl _dynamic_metasprite_process
	.globl _cursor_adjust_height
	.globl _cursor_grab_stack
	.globl _cursor_place_stack
	.globl _set_cursor_setting
	.globl _change_cursor_height
	.globl _cursor_process
	.globl _init_deck
	.globl _is_stack_coherent
	.globl _deal
	.globl _pile_append_cursor_stack
	.globl _start_game
	.globl _start_settings
	.globl _start_splash_screen
	.globl _start_leaderboard
	.globl _add_leaderboard
	.globl _nvram_check
	.globl _inc_letter
	.globl _input_process
	.globl _main
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_deck::
	.ds 312
_piles::
	.ds 50
_top_card_idx::
	.ds 1
_flags::
	.ds 1
_scroll::
	.ds 1
_settings::
	.ds 1
_num_folded_piles::
	.ds 1
_score::
	.ds 2
_selected_leaderboard::
	.ds 2
_dynamic_metasprite::
	.ds 21
_cursor::
	.ds 10
_input_process_prev_input_65536_387:
	.ds 1
_main_prev_input_327681_450:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;src/main.c:1163: static UINT8 prev_input = 0;
	ld	hl, #_input_process_prev_input_65536_387
	ld	(hl), #0x00
;src/main.c:1163: static UINT8 prev_input = 0;
	ld	hl, #_main_prev_input_327681_450
	ld	(hl), #0x00
;src/main.c:172: UINT8 flags = 0;
	ld	hl, #_flags
	ld	(hl), #0x00
;src/main.c:173: UINT8 scroll = 0;
	ld	hl, #_scroll
	ld	(hl), #0x00
;src/main.c:174: UINT8 settings = SETTING_ONE_SUIT | BITMASK_SETTING_MUSIC;
	ld	hl, #_settings
	ld	(hl), #0x10
;src/main.c:175: UINT8 num_folded_piles = 0;
	ld	hl, #_num_folded_piles
	ld	(hl), #0x00
;src/main.c:176: UINT16 score =  START_SCORE;
	ld	hl, #_score
	ld	(hl), #0xf4
	inc	hl
	ld	(hl), #0x01
;src/main.c:177: LeaderBoard *selected_leaderboard = NULL;
	ld	hl, #_selected_leaderboard
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0x00
;src/main.c:179: struct DynamicMetaSprite dynamic_metasprite = {
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0xff
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:184: struct Cursor cursor = {
	ld	hl, #_cursor
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	ld	hl, #(_cursor + 0x0005)
	ld	(hl), #0x00
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x0a
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
	ld	hl, #(_cursor + 0x0008)
	ld	(hl), #0x00
	ld	hl, #(_cursor + 0x0009)
	ld	(hl), #0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:348: inline void clear_bkg_2x1(const UINT8 x, const UINT8 y)
;	---------------------------------
; Function clear_bkg_2x1
; ---------------------------------
_clear_bkg_2x1::
;src/main.c:350: set_bkg_tile_xy(x, y, OFFSET_BKG_NONE);
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:351: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_NONE);
	ldhl	sp,	#2
	ld	a, (hl)
	inc	a
	ld	h, #0x00
	push	hl
	inc	sp
	ldhl	sp,	#4
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:352: }
	ret
_animation_speeds:
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x04	; 4
	.db #0x08	; 8
_menu_card_tiles:
	.db #0xc1	; 193
	.db #0xbd	; 189
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0xc5	; 197
	.db #0xc6	; 198
	.db #0xc1	; 193
	.db #0xbd	; 189
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0xdc	; 220
	.db #0xc6	; 198
	.db #0x26	; 38
	.db #0xbd	; 189
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0xdc	; 220
	.db #0x27	; 39
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x2e	; 46
	.db #0x34	; 52	'4'
	.db #0x30	; 48	'0'
	.db #0x35	; 53	'5'
	.db #0x32	; 50	'2'
	.db #0x36	; 54	'6'
	.db #0xc1	; 193
	.db #0xc2	; 194
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0xc5	; 197
	.db #0xc6	; 198
	.db #0xc1	; 193
	.db #0xc2	; 194
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0xc5	; 197
	.db #0xc6	; 198
	.db #0xc1	; 193
	.db #0xc2	; 194
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0xc5	; 197
	.db #0xc6	; 198
_setting_pile_heights:
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
;src/main.c:354: void draw_card_top(const UINT8 x, const UINT8 y, const UINT8 card_data)
;	---------------------------------
; Function draw_card_top
; ---------------------------------
_draw_card_top::
;src/main.c:356: if (VISIBLE(card_data)) {
	ldhl	sp,	#4
;src/main.c:358: set_bkg_tile_xy(x + 1u, y, SUIT(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_SUIT);
	ld	a, (hl-)
	ld	c, a
	dec	hl
	ld	b, (hl)
	inc	b
;src/main.c:356: if (VISIBLE(card_data)) {
	bit	6, c
	jr	Z, 00102$
;src/main.c:357: set_bkg_tile_xy(x, y, RANK(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_RANK);
	ld	a, c
	and	a, #0x0f
	add	a, #0xb0
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:358: set_bkg_tile_xy(x + 1u, y, SUIT(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_SUIT);
	ld	a, c
	ld	c, #0x00
	and	a, #0x30
	ld	e, a
	ld	d, #0x00
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, e
	add	a, #0xbd
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
	ret
00102$:
;src/main.c:360: set_bkg_tile_xy(x, y, OFFSET_BKG_CARD + OFFSET_CARD_BACK);
	ld	a, #0xc7
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:361: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_CARD + OFFSET_CARD_BACK + 1u);
	ld	a, #0xc8
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:363: }
	ret
;src/main.c:365: void draw_card_bottom(const UINT8 x, const UINT8 y, const UINT8 card_data)
;	---------------------------------
; Function draw_card_bottom
; ---------------------------------
_draw_card_bottom::
;src/main.c:367: set_bkg_tile_xy(x, y, OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 2u);
	ld	a, #0xc3
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:368: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 3u);
	ldhl	sp,	#2
	ld	c, (hl)
	inc	c
	ld	a, #0xc4
	push	af
	inc	sp
	inc	hl
	ld	b, (hl)
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:369: set_bkg_tile_xy(x, y+ 1u, SUIT(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_SUIT_ROT);
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x30
	ld	e, a
	ld	d, #0x00
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, e
	add	a, #0xda
	dec	hl
	ld	b, (hl)
	inc	b
	push	af
	inc	sp
	push	bc
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:370: set_bkg_tile_xy(x + 1u, y+ 1u, RANK(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_RANK_ROT);
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x0f
	add	a, #0xcd
	push	af
	inc	sp
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:371: }
	ret
;src/main.c:373: inline void draw_card(const UINT8 x, const UINT8 y, const UINT8 card_data)
;	---------------------------------
; Function draw_card
; ---------------------------------
_draw_card::
;src/main.c:375: draw_card_top(x, y, card_data);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_draw_card_top
	add	sp, #3
;src/main.c:376: draw_card_bottom(x, y + 1u, card_data);
	ldhl	sp,	#3
	ld	a, (hl)
	inc	a
	inc	hl
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_draw_card_bottom
	add	sp, #3
;src/main.c:377: }
	ret
;src/main.c:379: void draw_sequential_card(const UINT8 x, const UINT8 y, const UINT8 bkg_offset)
;	---------------------------------
; Function draw_sequential_card
; ---------------------------------
_draw_sequential_card::
;src/main.c:381: set_bkg_tile_xy(x, y, bkg_offset);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:382: set_bkg_tile_xy(x + 1u, y, bkg_offset + 1u);
	ldhl	sp,	#4
	ld	a, (hl)
	inc	a
	dec	hl
	dec	hl
	ld	c, (hl)
	inc	c
	push	af
	inc	sp
	inc	hl
	ld	b, (hl)
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:383: set_bkg_tile_xy(x, y + 1u, bkg_offset + 2u);
	ldhl	sp,	#4
	ld	a, (hl)
	inc	a
	inc	a
	dec	hl
	ld	b, (hl)
	inc	b
	push	af
	inc	sp
	push	bc
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:384: set_bkg_tile_xy(x + 1u, y + 1u, bkg_offset + 3u);
	ldhl	sp,	#4
	ld	a, (hl)
	inc	a
	inc	a
	inc	a
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	a, c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:385: set_bkg_tile_xy(x, y + 2u, bkg_offset + 4u);
	ldhl	sp,	#4
	ld	a, (hl)
	inc	a
	inc	a
	inc	a
	inc	a
	dec	hl
	ld	b, (hl)
	inc	b
	inc	b
	push	af
	inc	sp
	push	bc
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:386: set_bkg_tile_xy(x + 1u, y + 2u, bkg_offset + 5u);
	ldhl	sp,	#4
	ld	a, (hl)
	add	a, #0x05
	push	af
	inc	sp
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:387: }
	ret
;src/main.c:390: void clear_bkg(void)
;	---------------------------------
; Function clear_bkg
; ---------------------------------
_clear_bkg::
;src/main.c:393: for (x = 0; x < 32u; x++)
	ld	c, #0x00
;src/main.c:394: for (y = 0; y < 32u; y++)
00109$:
	ld	b, #0x00
00103$:
;src/main.c:395: set_bkg_tile_xy(x, y, 0);
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	a, c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:394: for (y = 0; y < 32u; y++)
	inc	b
	ld	a, b
	sub	a, #0x20
	jr	C, 00103$
;src/main.c:393: for (x = 0; x < 32u; x++)
	inc	c
	ld	a, c
	sub	a, #0x20
	jr	C, 00109$
;src/main.c:396: }
	ret
;src/main.c:398: void draw_bkg_game(void)
;	---------------------------------
; Function draw_bkg_game
; ---------------------------------
_draw_bkg_game::
	add	sp, #-7
;src/main.c:401: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles+0
;src/main.c:402: for (x = 0; x < 20u; x += 2) {
	xor	a, a
	ldhl	sp,	#0
	ld	(hl), a
00106$:
;src/main.c:403: Card *card = pile->base;
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:405: while (card->next_card) {
	ldhl	sp,	#1
	ld	(hl), #0x03
00101$:
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:406: draw_card_top(x, y, card->data);
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
;src/main.c:407: y++;
	ldhl	sp,	#1
	ld	a, (hl)
	inc	a
	ldhl	sp,	#4
	ld	(hl), a
;src/main.c:406: draw_card_top(x, y, card->data);
	ld	a, (de)
	ld	d, a
;src/main.c:405: while (card->next_card) {
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00103$
;src/main.c:406: draw_card_top(x, y, card->data);
	push	bc
	push	de
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_draw_card_top
	add	sp, #3
	pop	bc
;src/main.c:407: y++;
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/main.c:408: card = card->next_card;
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	jr	00101$
00103$:
;src/main.c:410: draw_card(x, y, card->data);
;src/main.c:375: draw_card_top(x, y, card_data);
	push	bc
	push	de
	push	de
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_draw_card_top
	add	sp, #3
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_draw_card_bottom
	add	sp, #3
	pop	bc
;src/main.c:411: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:402: for (x = 0; x < 20u; x += 2) {
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0x02
	ld	(hl), a
	sub	a, #0x14
	jp	C, 00106$
;src/main.c:413: draw_sequential_card(0, 0, OFFSET_BKG_CARD + OFFSET_CARD_BACK);
	ld	a, #0xc7
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_draw_sequential_card
	add	sp, #3
;src/main.c:414: }
	add	sp, #7
	ret
;src/main.c:416: void draw_bkg_splash_screen(void)
;	---------------------------------
; Function draw_bkg_splash_screen
; ---------------------------------
_draw_bkg_splash_screen::
;src/main.c:418: set_bkg_tile_xy(2u, 9u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_SYMBOL);
	ld	de, #0x3d09
	push	de
	ld	a, #0x02
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:419: set_bkg_tile_xy(3u, 9u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_START);
	ld	de, #0x3e09
	push	de
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:420: set_bkg_tile_xy(4u, 9u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_START + 1u);
	ld	de, #0x3f09
	push	de
	ld	a, #0x04
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:421: set_bkg_tile_xy(5u, 9u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_START + 2u);
	ld	de, #0x4009
	push	de
	ld	a, #0x05
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:422: set_bkg_tiles(7u, 9u, START_TEXT_LEN, 1u, start_text);
	ld	hl, #_start_text
	push	hl
	ld	de, #0x0105
	push	de
	ld	de, #0x0907
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:424: set_bkg_tile_xy(2u, 10u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_SYMBOL);
	ld	de, #0x3d0a
	push	de
	ld	a, #0x02
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:425: set_bkg_tile_xy(3u, 10u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_SELECT);
	ld	de, #0x410a
	push	de
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:426: set_bkg_tile_xy(4u, 10u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_SELECT + 1u);
	ld	de, #0x420a
	push	de
	ld	a, #0x04
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:427: set_bkg_tile_xy(5u, 10u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_SELECT + 2u);
	ld	de, #0x430a
	push	de
	ld	a, #0x05
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:428: set_bkg_tiles(7u, 10u, LEADERBOARD_TEXT_LEN, 1u, leaderboard_text);
	ld	hl, #_leaderboard_text
	push	hl
	ld	de, #0x010b
	push	de
	ld	de, #0x0a07
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:430: set_bkg_tiles(0, 15u, COPYRIGHT_TEXT_LEN, 1u, copyright_text);
	ld	hl, #_copyright_text
	push	hl
	ld	de, #0x0114
	push	de
	ld	a, #0x0f
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:431: }
	ret
;src/main.c:433: void draw_bkg_settings(void)
;	---------------------------------
; Function draw_bkg_settings
; ---------------------------------
_draw_bkg_settings::
;src/main.c:435: set_bkg_tiles(SETTINGS_SPLIT_X - SUITS_TEXT_LEN, SETTINGS_PAD_Y + 1u, SUITS_TEXT_LEN, 1u, suits_text);
	ld	hl, #_suits_text
	push	hl
	ld	de, #0x0105
	push	de
	ld	de, #0x0205
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:436: set_bkg_tiles(SETTINGS_SPLIT_X, SETTINGS_PAD_Y, 2u, 3u, menu_card_tiles[MENU_CARD_ONE_SUIT]);
	ld	hl, #_menu_card_tiles
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x010a
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:437: set_bkg_tiles(SETTINGS_SPLIT_X + 2u, SETTINGS_PAD_Y, 2u, 3u, menu_card_tiles[MENU_CARD_TWO_SUIT]);
	ld	hl, #(_menu_card_tiles + 0x0006)
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x010c
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:438: set_bkg_tiles(SETTINGS_SPLIT_X + 4u, SETTINGS_PAD_Y, 2u, 3u, menu_card_tiles[MENU_CARD_FOUR_SUIT]);
	ld	hl, #(_menu_card_tiles + 0x000c)
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x010e
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:440: set_bkg_tiles(SETTINGS_SPLIT_X - MUSIC_TEXT_LEN, SETTINGS_PAD_Y + 5u, MUSIC_TEXT_LEN, 1u, music_text);
	ld	hl, #_music_text
	push	hl
	ld	de, #0x0105
	push	de
	ld	de, #0x0605
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:441: set_bkg_tiles(SETTINGS_SPLIT_X, SETTINGS_PAD_Y + 4u, 2u, 3u, menu_card_tiles[MENU_CARD_MUSIC]);
	ld	hl, #(_menu_card_tiles + 0x0012)
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x050a
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:442: set_bkg_tiles(SETTINGS_SPLIT_X + 2u, SETTINGS_PAD_Y + 4u, 2u, 3u, menu_card_tiles[MENU_CARD_NO_MUSIC]);
	ld	hl, #(_menu_card_tiles + 0x0018)
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x050c
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:444: set_bkg_tiles(SETTINGS_SPLIT_X - SPEED_TEXT_LEN, SETTINGS_PAD_Y + 9u, SPEED_TEXT_LEN, 1u, speed_text);
	ld	hl, #_speed_text
	push	hl
	ld	de, #0x0105
	push	de
	ld	de, #0x0a05
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:445: set_bkg_tiles(SETTINGS_SPLIT_X, SETTINGS_PAD_Y + 8u, 2u, 3u, menu_card_tiles[MENU_CARD_ANIMATION_SLOW]);
	ld	hl, #(_menu_card_tiles + 0x001e)
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x090a
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:446: set_bkg_tiles(SETTINGS_SPLIT_X + 2u, SETTINGS_PAD_Y + 8u, 2u, 3u, menu_card_tiles[MENU_CARD_ANIMATION_MEDIUM]);
	ld	hl, #(_menu_card_tiles + 0x0024)
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x090c
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:447: set_bkg_tiles(SETTINGS_SPLIT_X + 4u, SETTINGS_PAD_Y + 8u, 2u, 3u, menu_card_tiles[MENU_CARD_ANIMATION_FAST]);
	ld	hl, #(_menu_card_tiles + 0x002a)
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x090e
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:449: set_bkg_tiles(SETTINGS_SPLIT_X - START_TEXT_LEN, SETTINGS_PAD_Y + 13u, START_TEXT_LEN, 1u, start_text);
	ld	hl, #_start_text
	push	hl
	ld	de, #0x0105
	push	de
	ld	de, #0x0e05
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:450: draw_sequential_card(SETTINGS_SPLIT_X, SETTINGS_PAD_Y + 12u, OFFSET_BKG_CARD + OFFSET_CARD_BACK);
	ld	de, #0xc70d
	push	de
	ld	a, #0x0a
	push	af
	inc	sp
	call	_draw_sequential_card
	add	sp, #3
;src/main.c:451: }
	ret
;src/main.c:464: void draw_bkg_leaderboard(void)
;	---------------------------------
; Function draw_bkg_leaderboard
; ---------------------------------
_draw_bkg_leaderboard::
	add	sp, #-13
;src/main.c:466: set_bkg_tiles(4u, 1u, LEADERBOARD_TEXT_LEN, 1u, leaderboard_text);
	ld	hl, #_leaderboard_text
	push	hl
	ld	de, #0x010b
	push	de
	ld	de, #0x0104
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:468: set_bkg_tiles(LEADERBOARD_CARD_X, LEADERBOARD_PAD_Y, 2u, 3u, menu_card_tiles[MENU_CARD_ONE_SUIT]);
	ld	hl, #_menu_card_tiles
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x0404
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:469: set_bkg_tiles(LEADERBOARD_CARD_X, LEADERBOARD_PAD_Y + 4u, 2u, 3u, menu_card_tiles[MENU_CARD_TWO_SUIT]);
	ld	hl, #(_menu_card_tiles + 0x0006)
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x0804
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:470: set_bkg_tiles(LEADERBOARD_CARD_X, LEADERBOARD_PAD_Y + 8u, 2u, 3u, menu_card_tiles[MENU_CARD_FOUR_SUIT]);
	ld	hl, #(_menu_card_tiles + 0x000c)
	push	hl
	ld	de, #0x0302
	push	de
	ld	de, #0x0c04
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:472: LeaderBoard *iter = IDX_PTR(leaderboard[0], 0);
	ld	bc, #_leaderboard+0
;src/main.c:474: for (i = 0; i < 3; i++) {
	xor	a, a
	ldhl	sp,	#11
	ld	(hl), a
;src/main.c:475: for (j = 0; j < 3; j++) {
00110$:
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, a
	add	a, a
	add	a, #0x04
	ldhl	sp,	#3
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#12
	ld	(hl), a
00104$:
;src/main.c:476: UINT8 y = LEADERBOARD_PAD_Y + i * 4u + j;
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#12
	add	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
;src/main.c:477: set_bkg_tiles(LEADERBOARD_NAME_X, y, 3u, 1u, iter->name);
	push	bc
	ld	de, #0x0103
	push	de
	ld	d, (hl)
	ld	e,#0x08
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:478: draw_bkg_leaderboard_score(LEADERBOARD_SCORE_X, y, iter->score);
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:455: UINT8 score_tiles[3] = {
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#7
	ld	(hl+), a
	ld	(hl), d
	push	bc
	ld	hl, #0x0064
	push	hl
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	pop	bc
	ld	a, e
	inc	a
	ldhl	sp,	#7
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;c
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
	push	bc
	ld	hl, #0x0064
	push	hl
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__moduint
	add	sp, #4
	ld	hl, #0x000a
	push	hl
	push	de
	call	__divuint
	add	sp, #4
	pop	bc
	ld	a, e
	inc	a
	ldhl	sp,	#9
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	push	bc
	push	de
	ld	hl, #0x000a
	push	hl
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__moduint
	add	sp, #4
	push	hl
	ldhl	sp,	#15
	ld	(hl), e
	ldhl	sp,	#16
	ld	(hl), d
	pop	hl
	pop	de
	pop	bc
	ldhl	sp,	#9
	ld	a, (hl)
	inc	a
	ld	(de), a
;src/main.c:460: set_bkg_tiles(x, y, 3u, 1u, score_tiles);
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #0x0103
	push	de
	ldhl	sp,	#8
	ld	d, (hl)
	ld	e,#0x0c
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:479: iter++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:475: for (j = 0; j < 3; j++) {
	ldhl	sp,	#12
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x03
	jp	C, 00104$
;src/main.c:474: for (i = 0; i < 3; i++) {
	dec	hl
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x03
	jp	C, 00110$
;src/main.c:482: }
	add	sp, #13
	ret
;src/main.c:488: void metasprite_2x3_hide(const UINT8 sprite)
;	---------------------------------
; Function metasprite_2x3_hide
; ---------------------------------
_metasprite_2x3_hide::
;src/main.c:495: );
	ldhl	sp,	#2
	ld	b, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl), #<(_metasprite_same_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_same_2x3)
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:495: );
;src/main.c:496: }
	ret
;src/main.c:498: void set_metasprite_card(const UINT8 card_data)
;	---------------------------------
; Function set_metasprite_card
; ---------------------------------
_set_metasprite_card::
;src/main.c:500: metasprite_t *iter = IDX_PTR(metasprite_custom_2x3, 0);
;src/main.c:501: (iter++)->dtile = OFFSET_CARD_RANK + RANK(card_data);
	ldhl	sp,	#2
	ld	b, (hl)
	ld	a, b
	and	a, #0x0f
	ld	c, a
	ld	hl, #(_metasprite_custom_2x3 + 0x0002)
	ld	(hl), c
;src/main.c:502: (iter++)->dtile = OFFSET_CARD_SUIT + SUIT(card_data);
	ld	de, #(_metasprite_custom_2x3 + 0x0004) + 2
	ld	a, b
	and	a, #0x30
	ld	l, a
	ld	h, #0x00
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	ld	b, l
	ld	a, b
	add	a, #0x0d
	ld	(de), a
;src/main.c:503: (iter++)->dtile = OFFSET_CARD_BLANK + 2u;
	ld	hl, #(_metasprite_custom_2x3 + 0x000a)
	ld	(hl), #0x13
;src/main.c:504: (iter++)->dtile = OFFSET_CARD_BLANK + 3u;
	ld	hl, #(_metasprite_custom_2x3 + 0x000e)
	ld	(hl), #0x14
;src/main.c:505: (iter++)->dtile = OFFSET_CARD_SUIT_ROT + SUIT(card_data);
	ld	de, #(_metasprite_custom_2x3 + 0x0010) + 2
	ld	a, b
	add	a, #0x2a
	ld	(de), a
;src/main.c:506: (iter++)->dtile = OFFSET_CARD_RANK_ROT + RANK(card_data);
	ld	de, #(_metasprite_custom_2x3 + 0x0014) + 2
	ld	a, c
	add	a, #0x1d
	ld	(de), a
;src/main.c:507: }
	ret
;src/main.c:509: void draw_setting_frame_metasprites(void)
;	---------------------------------
; Function draw_setting_frame_metasprites
; ---------------------------------
_draw_setting_frame_metasprites::
;src/main.c:514: NUM_SUITS(settings) * 16u + SETTINGS_SPLIT_X * 8u,
	ld	a, (#_settings)
	and	a, #0x03
	swap	a
	and	a, #0xf0
	add	a, #0x50
	ld	b, a
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0xe4
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ld	a, #0x08
	push	af
	inc	sp
	ld	c, #0x12
	push	bc
	call	___move_metasprite
	add	sp, #3
;src/main.c:520: !MUSIC(settings) * 16u + SETTINGS_SPLIT_X * 8u,
	ld	a, (#_settings)
	and	a, #0x10
	or	a,#0x00
	sub	a,#0x01
	ld	a, #0x00
	rla
	swap	a
	and	a, #0xf0
	add	a, #0x50
	ld	b, a
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0xe4
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ld	a, #0x28
	push	af
	inc	sp
	ld	c, #0x18
	push	bc
	call	___move_metasprite
	add	sp, #3
;src/main.c:526: ANIMATION_SPEED(settings) * 16u + SETTINGS_SPLIT_X * 8u,
	ld	a, (#_settings)
	and	a, #0x0c
	ld	c, a
	ld	b, #0x00
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, c
	swap	a
	and	a, #0xf0
	add	a, #0x50
	ld	b, a
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0xe4
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ld	a, #0x48
	push	af
	inc	sp
	ld	c, #0x1e
	push	bc
	call	___move_metasprite
	add	sp, #3
;src/main.c:528: );
;src/main.c:529: }
	ret
;src/main.c:544: void dynamic_metasprite_end_animation(void)
;	---------------------------------
; Function dynamic_metasprite_end_animation
; ---------------------------------
_dynamic_metasprite_end_animation::
;src/main.c:546: metasprite_2x3_hide(SPRITE_DYNAMIC);
	xor	a, a
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:547: flags &= ~FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfb
	ld	(hl), a
;src/main.c:548: dynamic_metasprite.target_frames = -1;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0xff
;src/main.c:549: }
	ret
;src/main.c:551: void dynamic_metasprite_splash_screen_callback(void)
;	---------------------------------
; Function dynamic_metasprite_splash_screen_callback
; ---------------------------------
_dynamic_metasprite_splash_screen_callback::
	add	sp, #-14
;src/main.c:553: const UINT8 offsets[] = {
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl), #0x06
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x0c
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x12
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x18
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x1e
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x12
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x24
	ld	hl, #0x0008
	add	hl, bc
	ld	(hl), #0x2a
;src/main.c:564: draw_sequential_card(1u + dynamic_metasprite.data[0] * 2u, 2u, OFFSET_BKG_TITLE + offsets[dynamic_metasprite.data[0]]);
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	l, (hl)
	ld	a, c
	add	a, l
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	add	a, #0x80
	add	hl, hl
	inc	l
	push	bc
	ld	d,a
	ld	e,#0x02
	push	de
	ld	a, l
	push	af
	inc	sp
	call	_draw_sequential_card
	add	sp, #3
	pop	bc
;src/main.c:565: if (dynamic_metasprite.data[0] == 8u) {
	ld	a, (#(_dynamic_metasprite + 0x000d) + 0)
	cp	a, #0x08
	jr	NZ, 00102$
;src/main.c:566: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
;src/main.c:567: return;
	jr	00103$
00102$:
;src/main.c:569: dynamic_metasprite.data[0]++;
	inc	a
	ldhl	sp,	#9
	ld	(hl), a
	ld	de, #(_dynamic_metasprite + 0x000d)
	ld	a, (hl)
	ld	(de), a
;src/main.c:570: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:571: dynamic_metasprite.dist[0] += 16;
	ld	de, #(_dynamic_metasprite + 0x0004)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
;c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
	ld	de, #(_dynamic_metasprite + 0x0004)
	dec	hl
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:572: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_TITLE + offsets[dynamic_metasprite.data[0]];
	ldhl	sp,	#9
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	add	a, #0x80
	ld	(#(_dynamic_metasprite + 0x000c)),a
00103$:
;src/main.c:573: }
	add	sp, #14
	ret
;src/main.c:575: inline void dynamic_metasprite_splash_screen(void)
;	---------------------------------
; Function dynamic_metasprite_splash_screen
; ---------------------------------
_dynamic_metasprite_splash_screen::
;src/main.c:577: dynamic_metasprite.src[0] = 72;
	ld	hl, #_dynamic_metasprite
	ld	(hl), #0x48
	inc	hl
	ld	(hl), #0x00
;src/main.c:578: dynamic_metasprite.src[1] = -24;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	(hl), #0xe8
	inc	hl
	ld	(hl), #0xff
;src/main.c:579: dynamic_metasprite.dist[0] = -64;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	(hl), #0xc0
	inc	hl
	ld	(hl), #0xff
;src/main.c:580: dynamic_metasprite.dist[1] = 40;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	(hl), #0x28
	inc	hl
	ld	(hl), #0x00
;src/main.c:581: dynamic_metasprite.target_frames = TARGET_FRAMES_SPLASH_SCREEN;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0x20
;src/main.c:582: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:583: dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;src/main.c:584: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_TITLE + OFFSET_TITLE_S;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #0x80
;src/main.c:585: dynamic_metasprite.data[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), #0x00
;src/main.c:586: dynamic_metasprite.callback = &dynamic_metasprite_splash_screen_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_splash_screen_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_splash_screen_callback)
;src/main.c:587: flags |= FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x04
	ld	(hl), a
;src/main.c:588: }
	ret
;src/main.c:590: void dynamic_metasprite_fold_pile(void)
;	---------------------------------
; Function dynamic_metasprite_fold_pile
; ---------------------------------
_dynamic_metasprite_fold_pile::
	add	sp, #-6
;src/main.c:592: UINT8 pile_idx = dynamic_metasprite.data[3] & 0xF;
	ld	a, (#(_dynamic_metasprite + 0x0010) + 0)
	and	a, #0x0f
;src/main.c:593: if (!pile_idx) {
	ld	c, a
	or	a, a
	jr	NZ, 00104$
;src/main.c:594: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
;src/main.c:595: if (num_folded_piles == 8u) {//NOTE: THIS IS WHERE GAME ENDS
	ld	a, (#_num_folded_piles)
	sub	a, #0x08
	jp	NZ,00106$
;src/main.c:596: metasprite_2x3_hide(SPRITE_FRAME);
	ld	a, #0x0c
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;/home/wojtek/gbdk/include/gb/gb.h:826: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCX_REG+0),a
	ld	a, #0x00
	ldh	(_SCY_REG+0),a
;src/main.c:598: scroll = 0u;
	ld	hl, #_scroll
	ld	(hl), #0x00
;src/main.c:599: add_leaderboard();
	call	_add_leaderboard
;src/main.c:600: start_leaderboard();
	call	_start_leaderboard
;src/main.c:601: score = START_SCORE;
	ld	hl, #_score
	ld	a, #0xf4
	ld	(hl+), a
	ld	(hl), #0x01
;src/main.c:603: return;
	jr	00106$
00104$:
;src/main.c:606: num_folded_piles++;
	ld	hl, #_num_folded_piles
	inc	(hl)
;src/main.c:608: Pile *pile = IDX_PTR(piles, pile_idx);
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, #<(_piles)
	add	a, l
	ld	b, a
	ld	a, #>(_piles)
	adc	a, h
	ldhl	sp,	#0
	ld	(hl), b
	inc	hl
	ld	(hl), a
;src/main.c:609: UINT8 x = pile_idx * 16u;
	ld	a, c
	swap	a
	and	a, #0xf0
	inc	hl
	ld	(hl), a
;src/main.c:618: dynamic_metasprite.data[3] >> 4u
	ld	a, (#(_dynamic_metasprite + 0x0010) + 0)
	swap	a
	and	a, #0x0f
	inc	hl
	ld	(hl), a
;src/main.c:616: pile->base,
	pop	de
	push	de
	ld	a, (de)
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:610: dynamic_metasprite_fold(pile->top->data,
	pop	bc
	push	bc
	inc	bc
	inc	bc
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	d, (hl)
	push	bc
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	a, #0x0d
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	b, (hl)
	ld	c, #0x78
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	de
	inc	sp
	call	_dynamic_metasprite_fold
	add	sp, #10
	pop	bc
;src/main.c:620: pile->base = NULL;
	pop	hl
	push	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:621: pile->top = NULL;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/main.c:622: pile->height = 0;
;c
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/main.c:623: cursor_adjust_height();
	call	_cursor_adjust_height
00106$:
;src/main.c:624: }
	add	sp, #6
	ret
;src/main.c:626: void dynamic_metasprite_unfold_callback(void)
;	---------------------------------
; Function dynamic_metasprite_unfold_callback
; ---------------------------------
_dynamic_metasprite_unfold_callback::
	add	sp, #-4
;src/main.c:628: Card const *card = dynamic_metasprite.data_ptr;
	ld	hl, #(_dynamic_metasprite + 0x0011)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:629: if (!card->next_card) {
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:630: draw_card(dynamic_metasprite.data[1] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 1u, card->data);
	inc	bc
	inc	bc
	inc	hl
	ld	a, c
	ld	(hl+), a
;src/main.c:629: if (!card->next_card) {
	ld	a, b
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
;src/main.c:630: draw_card(dynamic_metasprite.data[1] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 1u, card->data);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#(_dynamic_metasprite + 0x0002) + 0)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl+)
	ld	(hl), a
	inc	a
	dec	hl
	dec	hl
	ld	(hl), a
	ld	a, (#(_dynamic_metasprite + 0x000e) + 0)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	ld	b, (hl)
;src/main.c:375: draw_card_top(x, y, card_data);
	push	bc
	dec	hl
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_draw_card_top
	add	sp, #3
	pop	bc
;src/main.c:376: draw_card_bottom(x, y + 1u, card_data);
	ldhl	sp,	#1
	ld	a, (hl)
	inc	a
	dec	hl
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_draw_card_bottom
	add	sp, #3
;src/main.c:631: dynamic_metasprite_fold_pile();
	call	_dynamic_metasprite_fold_pile
;src/main.c:632: return;
	jr	00104$
00102$:
;src/main.c:634: dynamic_metasprite.data_ptr = card->next_card;
	pop	bc
	push	bc
	ld	hl, #(_dynamic_metasprite + 0x0011)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:635: dynamic_metasprite.src[1] += 8;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:636: draw_card_top(dynamic_metasprite.data[1] / 8u, dynamic_metasprite.src[1] / 8u, card->data);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, (#(_dynamic_metasprite + 0x000e) + 0)
	ld	e, a
	ld	d, #0x00
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, (hl)
	push	af
	inc	sp
	ld	d, c
	push	de
	call	_draw_card_top
	add	sp, #3
;src/main.c:637: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
00104$:
;src/main.c:638: }
	add	sp, #4
	ret
;src/main.c:640: void dynamic_metasprite_move_stack_callback(void)
;	---------------------------------
; Function dynamic_metasprite_move_stack_callback
; ---------------------------------
_dynamic_metasprite_move_stack_callback::
;src/main.c:642: if (dynamic_metasprite.data[0] & BITMASK_DYNAMIC_METASPRITE_UNFOLD) {
	ld	a, (#(_dynamic_metasprite + 0x000d) + 0)
	rlca
	jp	NC,_dynamic_metasprite_fold_pile
;src/main.c:643: dynamic_metasprite.src[0] = dynamic_metasprite.data[1];
	ld	a, (#(_dynamic_metasprite + 0x000e) + 0)
	ld	c, a
	ld	b, #0x00
	ld	hl, #_dynamic_metasprite
	ld	a, c
	ld	(hl+), a
;src/main.c:644: dynamic_metasprite.src[1] = dynamic_metasprite.data[2] - 8u;
	ld	a, b
	ld	(hl+), a
	ld	bc, #_dynamic_metasprite + 15
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	ld	a, c
	add	a, #0xf8
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/main.c:645: dynamic_metasprite.dist[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:646: dynamic_metasprite.dist[1] = 8;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	a, #0x08
	ld	(hl+), a
	ld	(hl), #0x00
;src/main.c:647: dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].fold_target_frames;
	ld	bc, #_dynamic_metasprite + 8
	ld	a, (#_settings)
	and	a, #0x0c
	ld	l, a
	ld	h, #0x00
	srl	h
	rr	l
	srl	h
	rr	l
	add	hl, hl
	ld	de, #_animation_speeds
	add	hl, de
	ld	a, (hl)
	ld	(bc), a
;src/main.c:648: dynamic_metasprite.callback = &dynamic_metasprite_unfold_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_unfold_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_unfold_callback)
;src/main.c:649: dynamic_metasprite_unfold_callback();
;src/main.c:651: dynamic_metasprite_fold_pile();
;src/main.c:653: }
	jp	_dynamic_metasprite_unfold_callback
;src/main.c:655: void dynamic_metasprite_fold_callback(void)
;	---------------------------------
; Function dynamic_metasprite_fold_callback
; ---------------------------------
_dynamic_metasprite_fold_callback::
	add	sp, #-4
;src/main.c:657: dynamic_metasprite.src[1] -= 8;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	add	a, #0xf8
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:658: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:659: clear_bkg_2x1((UINT8)dynamic_metasprite.src[0] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 2u);
	ld	a, (#(_dynamic_metasprite + 0x0002) + 0)
	ld	c, a
	ld	b, #0x00
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	inc	c
	inc	c
	ld	a, (#_dynamic_metasprite + 0)
	ld	e, a
	ld	d, #0x00
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	b, e
;src/main.c:350: set_bkg_tile_xy(x, y, OFFSET_BKG_NONE);
	xor	a, a
	push	af
	inc	sp
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:351: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_NONE);
	inc	b
	xor	a, a
	push	af
	inc	sp
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:660: if (dynamic_metasprite.data[0] & ~BITMASK_DYNAMIC_METASPRITE_UNFOLD) {
	ld	bc, #_dynamic_metasprite + 13
	ld	a, (bc)
	ld	e, a
	and	a, #0x7f
	jr	Z, 00105$
;src/main.c:661: dynamic_metasprite.data[0]--;
	ld	a, e
	dec	a
	ld	(bc), a
	jp	00109$
00105$:
;src/main.c:663: if (cursor.card_to_show) {
	ld	hl, #(_cursor + 0x0002)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:659: clear_bkg_2x1((UINT8)dynamic_metasprite.src[0] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 2u);
	ld	de, #(_dynamic_metasprite + 0x0002)
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	de, #_dynamic_metasprite
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:664: draw_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u - 1u, cursor.card_to_show->data);
	pop	de
	push	de
	inc	hl
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	l, (hl)
;src/main.c:663: if (cursor.card_to_show) {
	ld	a, b
	or	a, c
	jr	Z, 00102$
;src/main.c:664: draw_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u - 1u, cursor.card_to_show->data);
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	b, a
	ld	d, l
	dec	d
;src/main.c:375: draw_card_top(x, y, card_data);
	push	bc
	push	de
	ld	c, d
	push	bc
	ld	a, e
	push	af
	inc	sp
	call	_draw_card_top
	add	sp, #3
	pop	de
	pop	bc
;src/main.c:376: draw_card_bottom(x, y + 1u, card_data);
	ld	a, d
	inc	a
	push	bc
	inc	sp
	ld	d,a
	push	de
	call	_draw_card_bottom
	add	sp, #3
;src/main.c:665: cursor.card_to_show = NULL;
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00103$
00102$:
;src/main.c:667: draw_sequential_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u, OFFSET_BKG_CARD + OFFSET_CARD_OUTLINE);
	ld	a, #0xde
	push	af
	ld	a, l
	inc	sp
	ld	d,a
	push	de
	call	_draw_sequential_card
	add	sp, #3
00103$:
;src/main.c:669: dynamic_metasprite.dist[0] = (INT16)dynamic_metasprite.data[1] - dynamic_metasprite.src[0];
	ld	a, (#(_dynamic_metasprite + 0x000e) + 0)
	ld	c, a
	ld	b, #0x00
	ld	hl, #_dynamic_metasprite
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:670: dynamic_metasprite.dist[1] = (INT16)dynamic_metasprite.data[2] - dynamic_metasprite.src[1];
	ld	a, (#(_dynamic_metasprite + 0x000f) + 0)
	ld	c, a
	ld	b, #0x00
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:671: dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].move_target_frames;
	ld	bc, #_dynamic_metasprite + 8
	ld	a, (#_settings)
	and	a, #0x0c
	ld	l, a
	ld	h, #0x00
	srl	h
	rr	l
	srl	h
	rr	l
	add	hl, hl
	ld	de, #_animation_speeds
	add	hl, de
	inc	hl
	ld	a, (hl)
	ld	(bc), a
;src/main.c:672: dynamic_metasprite.callback = &dynamic_metasprite_move_stack_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_move_stack_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_move_stack_callback)
00109$:
;src/main.c:675: }
	add	sp, #4
	ret
;src/main.c:677: void dynamic_metasprite_fold(const UINT8 top_card_data, const UINT8 src_x, const UINT8 src_y, const UINT8 dest_x, const UINT8 dest_y, const UINT8 stack_height, const Card *base_card, const UINT8 unfold, const UINT8 piles_to_clear)
;	---------------------------------
; Function dynamic_metasprite_fold
; ---------------------------------
_dynamic_metasprite_fold::
;src/main.c:679: set_metasprite_card(top_card_data);
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_metasprite_card
	inc	sp
;src/main.c:681: dynamic_metasprite.metasprite = metasprite_custom_2x3;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #<(_metasprite_custom_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_custom_2x3)
;src/main.c:682: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_CARD;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #0xb0
;src/main.c:684: dynamic_metasprite.data[0] = (stack_height - 1u) | unfold;
	ld	bc, #_dynamic_metasprite + 13
	ldhl	sp,	#7
	ld	a, (hl)
	dec	a
	ldhl	sp,	#10
	or	a, (hl)
	ld	(bc), a
;src/main.c:685: dynamic_metasprite.data[1] = dest_x;
	ld	de, #(_dynamic_metasprite + 0x000e)
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;src/main.c:686: dynamic_metasprite.data[2] = dest_y;
	ld	de, #(_dynamic_metasprite + 0x000f)
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:687: dynamic_metasprite.data[3] = piles_to_clear;
	ld	de, #(_dynamic_metasprite + 0x0010)
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(de), a
;src/main.c:688: dynamic_metasprite.data_ptr = base_card;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #(_dynamic_metasprite + 0x0011)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:690: dynamic_metasprite.src[0] = src_x;
	ldhl	sp,	#3
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #_dynamic_metasprite
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:691: dynamic_metasprite.src[1] = src_y + 8u;
	ldhl	sp,	#4
	ld	c, (hl)
	ld	b, #0x00
	ld	a, c
	add	a, #0x08
	ld	c, a
	jr	NC, 00110$
	inc	b
00110$:
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:693: flags |= FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x04
	ld	(hl), a
;src/main.c:695: if (stack_height > 1) {
	ld	a, #0x01
	ldhl	sp,	#7
	sub	a, (hl)
	jp	NC,_dynamic_metasprite_fold_callback
;src/main.c:696: dynamic_metasprite.dist[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:697: dynamic_metasprite.dist[1] = -8;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	a, #0xf8
	ld	(hl+), a
	ld	(hl), #0xff
;src/main.c:698: dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].fold_target_frames;
	ld	bc, #_dynamic_metasprite + 8
	ld	a, (#_settings)
	and	a, #0x0c
	ld	l, a
	ld	h, #0x00
	srl	h
	rr	l
	srl	h
	rr	l
	add	hl, hl
	ld	de, #_animation_speeds
	add	hl, de
	ld	a, (hl)
	ld	(bc), a
;src/main.c:699: dynamic_metasprite.callback = &dynamic_metasprite_fold_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_fold_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_fold_callback)
;src/main.c:701: dynamic_metasprite_fold_callback();
;src/main.c:702: }
	jp  _dynamic_metasprite_fold_callback
;src/main.c:704: void dynamic_metasprite_deal_callback(void)
;	---------------------------------
; Function dynamic_metasprite_deal_callback
; ---------------------------------
_dynamic_metasprite_deal_callback::
	add	sp, #-4
;src/main.c:706: Pile *pile = IDX_PTR(piles, dynamic_metasprite.data[0]);
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, #<(_piles)
	add	a, l
	ld	b, a
	ld	a, #>(_piles)
	adc	a, h
	ldhl	sp,	#0
	ld	(hl), b
	inc	hl
	ld	(hl), a
;src/main.c:707: draw_card(dynamic_metasprite.data[0] * 2u, 2u + pile->height, pile->top->data);
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	b, (hl)
;c
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, #0x02
	ld	d, a
	sla	c
;src/main.c:375: draw_card_top(x, y, card_data);
	push	bc
	push	de
	push	bc
	inc	sp
	ld	e, c
	push	de
	call	_draw_card_top
	add	sp, #3
	pop	de
	pop	bc
;src/main.c:376: draw_card_bottom(x, y + 1u, card_data);
	inc	d
	push	bc
	inc	sp
	ld	e, c
	push	de
	call	_draw_card_bottom
	add	sp, #3
;src/main.c:708: if (dynamic_metasprite.data[0] == 9u) {
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	c, (hl)
	ld	a, c
	sub	a, #0x09
	jr	NZ, 00104$
;src/main.c:709: if (top_card_idx == 104u)
	ld	a, (#_top_card_idx)
	sub	a, #0x68
	jr	NZ, 00102$
;src/main.c:710: draw_sequential_card(0, 0, OFFSET_BKG_CARD + OFFSET_CARD_OUTLINE);
	ld	a, #0xde
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_draw_sequential_card
	add	sp, #3
00102$:
;src/main.c:711: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
;src/main.c:712: return;
	jr	00106$
00104$:
;src/main.c:714: pile++;
;c
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
;src/main.c:715: dynamic_metasprite.data[0]++;
	inc	c
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), c
;src/main.c:716: dynamic_metasprite.dist[0] += 16;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:717: dynamic_metasprite.dist[1] = (INT16)(2u + pile->height) * 8;
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	inc	hl
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:718: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
00106$:
;src/main.c:719: }
	add	sp, #4
	ret
;src/main.c:721: void dynamic_metasprite_deal(void)
;	---------------------------------
; Function dynamic_metasprite_deal
; ---------------------------------
_dynamic_metasprite_deal::
;src/main.c:723: Pile *pile = IDX_PTR(piles, 0);
;src/main.c:724: dynamic_metasprite.src[0] = 0;
	ld	hl, #_dynamic_metasprite
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:725: dynamic_metasprite.src[1] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:726: dynamic_metasprite.dist[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:727: dynamic_metasprite.dist[1] = (INT16)(2u + pile->height) * 8;
	ld	a, (#(_piles + 0x0004) + 0)
	ld	h, #0x00
	ld	l, a
	inc	hl
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:728: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:729: dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].move_target_frames;
	ld	a, (#_settings)
	ld	c, #0x00
	and	a, #0x0c
	ld	l, a
	ld	h, #0x00
	srl	h
	rr	l
	srl	h
	rr	l
	add	hl, hl
	ld	de, #_animation_speeds
	add	hl, de
	inc	hl
	ld	a, (hl)
	ld	(#(_dynamic_metasprite + 0x0008)),a
;src/main.c:730: dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;src/main.c:731: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_CARD + OFFSET_CARD_BACK;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #0xc7
;src/main.c:732: dynamic_metasprite.data[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), #0x00
;src/main.c:733: dynamic_metasprite.callback = &dynamic_metasprite_deal_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_deal_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_deal_callback)
;src/main.c:734: flags |= FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x04
	ld	(hl), a
;src/main.c:735: }
	ret
;src/main.c:737: inline void dynamic_metasprite_process(void)
;	---------------------------------
; Function dynamic_metasprite_process
; ---------------------------------
_dynamic_metasprite_process::
	add	sp, #-5
;src/main.c:739: if (dynamic_metasprite.elapsed_frames >= dynamic_metasprite.target_frames)
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	c, (hl)
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	b, (hl)
	ld	e, b
	ld	a,c
	ld	d,a
	sub	a, b
	bit	7, e
	jr	Z, 00124$
	bit	7, d
	jr	NZ, 00125$
	cp	a, a
	jr	00125$
00124$:
	bit	7, d
	jr	Z, 00125$
	scf
00125$:
;src/main.c:740: return;
	jp	NC,00107$
;src/main.c:742: dynamic_metasprite.elapsed_frames++;
	inc	c
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), c
;src/main.c:747: (INT16)scroll * -8 + dynamic_metasprite.src[1] + (dynamic_metasprite.dist[1] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames)
	ld	a, (#_scroll)
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	ld	hl, #_dynamic_metasprite + 2
	ld	b, (hl)
	add	a, b
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	rla
	sbc	a, a
	ld	b, a
	push	bc
	push	bc
	push	hl
	call	__mulint
	add	sp, #4
	push	hl
	ldhl	sp,	#7
	ld	(hl), e
	ldhl	sp,	#8
	ld	(hl), d
	pop	hl
	pop	bc
	ld	a, (#(_dynamic_metasprite + 0x0008) + 0)
	ldhl	sp,	#1
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl), a
	push	bc
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	ldhl	sp,	#0
	add	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
;src/main.c:746: dynamic_metasprite.src[0] + (dynamic_metasprite.dist[0] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames),
	ld	a, (#_dynamic_metasprite + 0)
	ldhl	sp,	#4
	ld	(hl), a
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	call	__mulint
	add	sp, #4
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	ld	a, e
	ldhl	sp,	#4
	add	a, (hl)
	ld	b, a
;src/main.c:744: dynamic_metasprite.metasprite_offset,
	ld	a, (#(_dynamic_metasprite + 0x000c) + 0)
	ld	(#___current_base_tile),a
;src/main.c:743: move_metasprite(dynamic_metasprite.metasprite,
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	a, (hl+)
	ld	h, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	(___current_metasprite), a
	ld	a, h
	ld	(___current_metasprite + 1), a
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:749: if (dynamic_metasprite.elapsed_frames == dynamic_metasprite.target_frames
	ld	a, (#(_dynamic_metasprite + 0x0009) + 0)
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	c, (hl)
	sub	a, c
	jr	NZ, 00107$
;src/main.c:750: && dynamic_metasprite.callback)
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	a, (hl+)
	ld	c, a
	ld	h, (hl)
	ld	a, h
	or	a, c
	jr	Z, 00107$
;src/main.c:751: dynamic_metasprite.callback();
	ld	l, c
	call	___sdcc_call_hl
00107$:
;src/main.c:752: }
	add	sp, #5
	ret
;src/main.c:759: void cursor_adjust_height(void)
;	---------------------------------
; Function cursor_adjust_height
; ---------------------------------
_cursor_adjust_height::
;src/main.c:761: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	ld	bc, #_piles+0
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	e, a
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, bc
;src/main.c:762: if (cursor.height >= pile->height)
	ld	bc, #_cursor + 7
	ld	a, (bc)
	ld	d, a
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	a, d
	sub	a, e
	ret	C
;src/main.c:763: cursor.height = pile->height - !!pile->height;
	ld	a, e
	sub	a,#0x01
	ld	a, #0x00
	rla
	xor	a, #0x01
	ld	d, a
	ld	a, e
	sub	a, d
	ld	(bc), a
;src/main.c:764: }
	ret
;src/main.c:766: inline void cursor_grab_stack(void)
;	---------------------------------
; Function cursor_grab_stack
; ---------------------------------
_cursor_grab_stack::
	add	sp, #-7
;src/main.c:769: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	ld	bc, #_piles+0
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	e, a
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), c
	inc	hl
;src/main.c:770: Card *top = pile->base;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:771: for (i = 1; i < cursor.height; i++)
	ld	b, #0x01
00109$:
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
	ld	a, b
	sub	a, c
	jr	NC, 00101$
;src/main.c:772: top = top->next_card;
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:771: for (i = 1; i < cursor.height; i++)
	inc	b
	jr	00109$
00101$:
;src/main.c:773: Card *stack = cursor.height ? top->next_card : top;
	ld	a, c
	or	a, a
	jr	Z, 00113$
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	jr	00114$
00113$:
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
00114$:
	pop	bc
	push	bc
;src/main.c:774: if (!(VISIBLE(stack->data) && is_stack_coherent(stack)))
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	bit	6, a
	jr	Z, 00111$
	push	bc
	push	bc
	call	_is_stack_coherent
	add	sp, #2
	ld	a, e
	pop	bc
	or	a, a
;src/main.c:775: return;
	jr	Z, 00111$
;src/main.c:777: cursor.held_card = stack;
	ld	hl, #_cursor
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:778: cursor.hand_pile_idx = cursor.pile_idx;
	ld	bc, #_cursor + 5
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	(bc), a
;src/main.c:779: cursor.held_stack_size = pile->height - cursor.height;
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #(_cursor + 0x0007)
	ld	l, (hl)
	sub	a, l
	ld	(#(_cursor + 0x0004)),a
;src/main.c:780: pile->height = cursor.height;
	ld	a, (#(_cursor + 0x0007) + 0)
	ld	(bc), a
;src/main.c:781: flags |= FLAG_REDRAW_HAND;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x02
	ld	(hl), a
;src/main.c:782: if (cursor.height) {
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#4
	ld	(hl), a
;src/main.c:783: pile->top = top;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
;src/main.c:785: cursor.card_to_show = top;
;src/main.c:782: if (cursor.height) {
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
;src/main.c:783: pile->top = top;
	inc	hl
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/main.c:784: top->next_card = NULL;
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:785: cursor.card_to_show = top;
	ld	de, #(_cursor + 0x0002)
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
	jr	00111$
00106$:
;src/main.c:787: pile->base = NULL;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:788: pile->top = NULL;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/main.c:789: cursor.card_to_show = NULL;
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00111$:
;src/main.c:791: }
	add	sp, #7
	ret
;src/main.c:793: inline void cursor_place_stack(void)
;	---------------------------------
; Function cursor_place_stack
; ---------------------------------
_cursor_place_stack::
	add	sp, #-2
;src/main.c:795: Pile *pile = IDX_PTR(piles, cursor.hand_pile_idx);
	ld	bc, #_piles+0
	ld	a, (#(_cursor + 0x0005) + 0)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#1
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, bc
	ld	c, l
	ld	b, h
;src/main.c:796: if (cursor.hand_pile_idx == cursor.pile_idx) {
	ld	hl, #_cursor + 6
	ld	e, (hl)
	ldhl	sp,	#1
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00105$
;src/main.c:797: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
	jr	00107$
00105$:
;src/main.c:798: } else if (!pile->height
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00101$
;src/main.c:799: || RANK(pile->top->data) == RANK(cursor.held_card->data) + 1u) {
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	and	a, #0x0f
	ldhl	sp,	#0
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	and	a, #0x0f
	ld	d, #0x00
	ld	e, a
	inc	de
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00107$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	NZ, 00107$
00101$:
;src/main.c:800: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
;src/main.c:801: score--;
	ld	hl, #_score + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	dec	de
	dec	hl
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00107$:
;src/main.c:803: }
	add	sp, #2
	ret
;src/main.c:805: void set_cursor_setting(void)
;	---------------------------------
; Function set_cursor_setting
; ---------------------------------
_set_cursor_setting::
;src/main.c:807: switch (cursor.pile_idx) {
	ld	hl, #_cursor + 6
	ld	c, (hl)
;src/main.c:810: settings |= cursor.height;
	ld	de, #_cursor + 7
;src/main.c:807: switch (cursor.pile_idx) {
	ld	a, c
	or	a, a
	jr	Z, 00101$
	ld	a, c
	dec	a
	jr	Z, 00102$
	ld	a,c
	cp	a,#0x02
	jr	Z, 00103$
	sub	a, #0x03
	jp	Z,_start_game
	ret
;src/main.c:808: case 0u:
00101$:
;src/main.c:809: settings &= ~BITMASK_SETTING_NUM_SUITS;
	ld	hl, #_settings
	ld	a, (hl)
	and	a, #0xfc
	ld	(hl), a
;src/main.c:810: settings |= cursor.height;
	ld	a, (de)
	or	a, (hl)
	ld	(hl), a
;src/main.c:811: draw_setting_frame_metasprites();
;src/main.c:812: break;
	jp  _draw_setting_frame_metasprites
;src/main.c:813: case 1u:
00102$:
;src/main.c:814: settings &= ~BITMASK_SETTING_MUSIC;
	ld	hl, #_settings
	ld	a, (hl)
	and	a, #0xef
	ld	(hl), a
;src/main.c:815: settings |= !cursor.height << BIT_OFFSET_SETTING_MUSIC;
	ld	a, (de)
	sub	a,#0x01
	ld	a, #0x00
	rla
	swap	a
	and	a, #0xf0
	or	a, (hl)
	ld	(hl), a
;src/main.c:816: draw_setting_frame_metasprites();
;src/main.c:817: break;
	jp  _draw_setting_frame_metasprites
;src/main.c:818: case 2u:
00103$:
;src/main.c:819: settings &= ~BITMASK_SETTING_ANIMATION_SPEED;
	ld	hl, #_settings
	ld	a, (hl)
	and	a, #0xf3
	ld	(hl), a
;src/main.c:820: settings |= cursor.height << BIT_OFFSET_SETTING_ANIMATION_SPEED;
	ld	a, (de)
	add	a, a
	add	a, a
	or	a, (hl)
	ld	(hl), a
;src/main.c:821: draw_setting_frame_metasprites();
;src/main.c:822: break;
;src/main.c:823: case 3u:
;src/main.c:824: start_game();
;src/main.c:826: }
;src/main.c:827: }
	jp	_draw_setting_frame_metasprites
;src/main.c:829: void change_cursor_height(const INT8 inc)
;	---------------------------------
; Function change_cursor_height
; ---------------------------------
_change_cursor_height::
;src/main.c:831: cursor.height = (INT8)cursor.height + inc;
	ld	bc, #_cursor+7
	ld	a, (bc)
	ldhl	sp,	#2
	add	a, (hl)
	ld	(bc), a
;src/main.c:832: if (cursor.height < scroll) {
	ld	a, (bc)
	ld	c, a
	ld	hl, #_scroll
	sub	a, (hl)
	jr	NC, 00104$
;src/main.c:833: scroll = cursor.height;
	ld	(hl), c
;src/main.c:834: move_bkg(0, scroll * 8u);
	ld	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	ld	c, a
;/home/wojtek/gbdk/include/gb/gb.h:826: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCX_REG+0),a
	ld	a, c
	ldh	(_SCY_REG+0),a
;src/main.c:834: move_bkg(0, scroll * 8u);
	ret
00104$:
;src/main.c:835: } else if (cursor.height > scroll + 9u) {
	ld	hl, #_scroll
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #0x0009
	add	hl, de
	ld	b, c
	ld	e, #0x00
	ld	a, l
	sub	a, b
	ld	a, h
	sbc	a, e
	ret	NC
;src/main.c:836: scroll = cursor.height - 9u;
	ld	a, c
	add	a, #0xf7
	ld	hl, #_scroll
	ld	(hl), a
;src/main.c:837: move_bkg(0, scroll * 8u);
	ld	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	ld	c, a
;/home/wojtek/gbdk/include/gb/gb.h:826: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCX_REG+0),a
	ld	a, c
	ldh	(_SCY_REG+0),a
;src/main.c:837: move_bkg(0, scroll * 8u);
;src/main.c:839: }
	ret
;src/main.c:841: inline void cursor_process(void)
;	---------------------------------
; Function cursor_process
; ---------------------------------
_cursor_process::
	dec	sp
;src/main.c:843: switch (flags & FLAG_GAME_STATE) {
	ld	a, (#_flags)
	and	a, #0x18
	ld	c, a
	ld	b, #0x00
	ld	a, c
	or	a, a
	or	a, b
	jp	Z,00127$
;src/main.c:845: return;
	jr	00102$
;src/main.c:846: }
00102$:
;src/main.c:847: cursor.anim_ctr++;
	ld	hl, #_cursor + 8
	ld	b, (hl)
	inc	b
	ld	(hl), b
;src/main.c:848: cursor.anim_ctr &= (1u << (CURSOR_PERIOD_LOGSCALE + 1u)) - 1u;
	res	7, b
	ld	(hl), b
;src/main.c:849: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	hl, #(_cursor + 0x0009)
	ld	c, (hl)
;src/main.c:850: cursor.anim_frame = cursor.anim_ctr >> CURSOR_PERIOD_LOGSCALE;
	ld	a, b
	rlca
	rlca
	and	a, #0x03
	ld	(#(_cursor + 0x0009)),a
;src/main.c:851: if (cursor.anim_frame != prev_anim_frame)
	sub	a, c
	jr	Z, 00104$
;src/main.c:852: flags |= FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x01
	ld	(hl), a
00104$:
;src/main.c:854: if (flags & FLAG_REDRAW_CURSOR) {
	ld	a, (#_flags)
	rrca
	jp	NC,00115$
;src/main.c:855: flags &= ~FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfe
	ld	(hl), a
;src/main.c:856: switch (flags & FLAG_GAME_STATE) {
	ld	a, (hl)
	and	a, #0x18
	ld	e, a
	ld	d, #0x00
	ld	a, e
	sub	a, #0x08
	or	a, d
	jr	Z, 00106$
;src/main.c:862: SETTINGS_PAD_Y * 8u + cursor.pile_idx * 32u
	ld	hl, #_cursor + 6
;src/main.c:861: cursor.height * 16u + SETTINGS_SPLIT_X * 8u,
	ld	bc, #_cursor + 7
;src/main.c:856: switch (flags & FLAG_GAME_STATE) {
	ld	a, e
	sub	a, #0x10
	or	a, d
	jr	Z, 00109$
	ld	a, e
	sub	a, #0x18
	or	a, d
	jp	NZ,00115$
;src/main.c:862: SETTINGS_PAD_Y * 8u + cursor.pile_idx * 32u
	ld	a, (hl)
	swap	a
	rlca
	and	a, #0xe0
	add	a, #0x08
	ldhl	sp,	#0
	ld	(hl), a
;src/main.c:861: cursor.height * 16u + SETTINGS_SPLIT_X * 8u,
	ld	a, (bc)
	swap	a
	and	a, #0xf0
	add	a, #0x50
	ld	c, a
;src/main.c:858: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	a, (#(_cursor + 0x0009) + 0)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	ld	de, #_cursor_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	h, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	(___current_metasprite), a
	ld	a, h
	ld	(___current_metasprite + 1), a
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x01
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ldhl	sp,	#0
	ld	a, (hl)
	push	af
	inc	sp
	ld	d, c
	ld	e,#0x0c
	push	de
	call	___move_metasprite
	add	sp, #3
;src/main.c:864: break;
	jp	00115$
;src/main.c:865: case FLAG_GAME_STATE_LEADERBOARD:
00106$:
;src/main.c:866: if (selected_leaderboard) {
	ld	hl, #_selected_leaderboard + 1
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00115$
;src/main.c:867: set_sprite_tile(SPRITE_FRAME, OFFSET_SPRITE_CURSOR + OFFSET_CURSOR_UNDERLINE + cursor.anim_frame);
	ld	a, (#(_cursor + 0x0009) + 0)
	add	a, #0x09
	ld	c, a
;/home/wojtek/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0032)
	ld	(hl), c
;src/main.c:868: move_sprite(SPRITE_FRAME, (LEADERBOARD_NAME_X + 1u) * 8u + cursor.pile_idx * 8u, 16u + cursor.height * 8u);
	ld	a, (#(_cursor + 0x0007) + 0)
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x10
	ld	c, a
	ld	a, (#(_cursor + 0x0006) + 0)
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x48
	ld	e, a
;/home/wojtek/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0030)
;/home/wojtek/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), e
;src/main.c:870: break;
	jr	00115$
;src/main.c:871: case FLAG_GAME_STATE_INGAME:
00109$:
;src/main.c:872: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
;src/main.c:849: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	a, (#(_cursor + 0x0009) + 0)
;src/main.c:873: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	ld	e, l
	ld	d, h
;src/main.c:872: if (cursor.pile_idx == PILE_IDX_DECK)
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x0a
	jr	NZ, 00111$
;src/main.c:873: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	hl, #_cursor_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x01
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x0c
	push	de
	call	___move_metasprite
	add	sp, #3
;src/main.c:878: );
	jr	00115$
00111$:
;src/main.c:884: (cursor.height + 3u - scroll) * 8u
	ld	a, (bc)
	add	a, #0x03
	ld	hl, #_scroll
	sub	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	ld	c, a
;src/main.c:883: cursor.pile_idx * 16u,
	ldhl	sp,	#0
	ld	a, (hl)
	swap	a
	and	a, #0xf0
	ld	b, a
;src/main.c:880: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	hl, #_cursor_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	h, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	(___current_metasprite), a
	ld	a, h
	ld	(___current_metasprite + 1), a
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x01
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ld	a, c
	push	af
	inc	sp
	ld	c, #0x0c
	push	bc
	call	___move_metasprite
	add	sp, #3
;src/main.c:887: }
00115$:
;src/main.c:890: if (flags & FLAG_REDRAW_HAND) {
	ld	a, (#_flags)
	bit	1, a
	jr	Z, 00127$
;src/main.c:891: flags &= ~FLAG_REDRAW_HAND;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfd
	ld	(hl), a
;src/main.c:892: if (cursor.held_card) {
	ld	hl, #_cursor
	ld	a, (hl+)
	or	a,(hl)
	jr	Z, 00117$
;src/main.c:893: UINT8 height = piles[cursor.hand_pile_idx].height;
	ld	hl, #(_cursor + 0x0005)
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_piles
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
;src/main.c:898: (height + !height + 2u - scroll) * 8u
	ld	a, e
	sub	a,#0x01
	ld	a, #0x00
	rla
	add	a, e
	add	a, #0x02
	ld	hl, #_scroll
	ld	b, (hl)
	sub	a, b
	add	a, a
	add	a, a
	add	a, a
	ld	b, a
;src/main.c:897: cursor.hand_pile_idx * 16u,
	ld	a, c
	swap	a
	and	a, #0xf0
	ld	d, a
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x03
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ld	c, d
	push	bc
	ld	a, #0x06
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:899: );
	jr	00127$
00117$:
;src/main.c:901: metasprite_2x3_hide(SPRITE_HAND);
	ld	a, #0x06
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
00127$:
;src/main.c:904: }
	inc	sp
	ret
;src/main.c:910: void init_deck(void)
;	---------------------------------
; Function init_deck
; ---------------------------------
_init_deck::
	add	sp, #-16
;src/main.c:912: Card *card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:918: UINT8 suit_increment = 4u >> NUM_SUITS(settings);
	ld	a, (#_settings)
	and	a, #0x03
	ld	l, a
	ld	de, #0x0004
	inc	l
	jr	00210$
00209$:
	srl	d
	rr	e
00210$:
	dec	l
	jr	NZ, 00209$
	ldhl	sp,	#5
	ld	(hl), e
;src/main.c:919: UINT8 i_max = suit_increment * 2u;
	ld	a, (hl)
	add	a, a
	inc	hl
	ld	(hl), a
;src/main.c:920: for (suit = 0; suit < 4u; suit += suit_increment) {
	xor	a, a
	ldhl	sp,	#11
	ld	(hl), a
;src/main.c:921: for (rank = 0; rank < 13u; rank++) {
00131$:
	ldhl	sp,	#11
	ld	a, (hl)
	swap	a
	and	a, #0xf0
	ldhl	sp,	#7
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#12
	ld	(hl), a
;src/main.c:922: for (i = 0; i < i_max; i++) {
00130$:
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#7
	or	a, (hl)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	xor	a, a
	inc	hl
	ld	(hl), a
00112$:
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#6
	sub	a, (hl)
	jr	NC, 00143$
;src/main.c:923: card->data = rank | (suit << BIT_OFFSET_CARD_SUIT);
;c
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:924: card++;
;c
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
;src/main.c:922: for (i = 0; i < i_max; i++) {
	ld	(hl+), a
	inc	(hl)
	jr	00112$
00143$:
	ldhl	sp,#13
	ld	a, (hl+)
	ld	c, a
;src/main.c:921: for (rank = 0; rank < 13u; rank++) {
	ld	a, (hl-)
	ld	b, a
	dec	hl
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0d
	jr	C, 00130$
;src/main.c:920: for (suit = 0; suit < 4u; suit += suit_increment) {
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#5
	add	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	sub	a, #0x04
	jr	C, 00131$
;src/main.c:930: card = IDX_PTR(deck, 103u);
	inc	hl
	inc	hl
	ld	a, #<((_deck + 0x0135))
	ld	(hl+), a
	ld	(hl), #>((_deck + 0x0135))
;src/main.c:931: for (i = 103u; i; i--) {
	ldhl	sp,	#2
	ld	a, l
	ld	d, h
	ldhl	sp,	#7
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	(hl+), a
	ld	(hl), e
	ldhl	sp,	#15
	ld	(hl), #0x67
00118$:
;src/main.c:932: Card *swap = IDX_PTR(deck, (UINT8)rand() % i);
	call	_rand
	ld	a, e
	ldhl	sp,	#15
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	call	__moduchar
	add	sp, #2
	ld	c, e
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	a, l
	add	a, #<(_deck)
	ld	c, a
	ld	a, h
	adc	a, #>(_deck)
	ld	b, a
	ldhl	sp,	#11
	ld	a, c
	ld	(hl+), a
;src/main.c:934: temp = *card;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,#7
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0003
	push	hl
	push	de
	push	bc
	call	___memcpy
	add	sp, #6
;src/main.c:935: *card = *swap;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0003
	push	hl
	push	de
	push	bc
	call	___memcpy
	add	sp, #6
;src/main.c:936: *swap = temp;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0003
	push	hl
	push	de
	push	bc
	call	___memcpy
	add	sp, #6
;src/main.c:937: card--;
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#14
	ld	(hl-), a
;src/main.c:931: for (i = 103u; i; i--) {
	ld	a, e
	ld	(hl+), a
	inc	hl
	dec	(hl)
	jr	NZ, 00118$
;src/main.c:941: card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:942: for (i = 0; i < 44u; i++) {
	xor	a, a
	ld	(hl), a
00120$:
;src/main.c:943: card->next_card = IDX_PTR(deck, i + 10u);
	ldhl	sp,	#15
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	ld	de, #_deck
	add	hl, de
	ld	de, #0x001e
	add	hl, de
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:944: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:942: for (i = 0; i < 44u; i++) {
	ldhl	sp,	#15
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x2c
	jr	C, 00120$
	ld	e, (hl)
00123$:
;src/main.c:946: for (; i < 104u; i++) {
	ld	a, e
	sub	a, #0x68
	jr	NC, 00106$
;src/main.c:947: card->data |= BITMASK_CARD_VISIBLE;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	set	6, (hl)
;src/main.c:948: card->next_card = NULL;
	ld	l, c
	ld	h, b
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:949: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:946: for (; i < 104u; i++) {
	inc	e
	jr	00123$
00106$:
;src/main.c:952: card = IDX_PTR(deck, 0);
	ldhl	sp,	#11
	ld	a, #<(_deck)
	ld	(hl+), a
;src/main.c:953: Pile *pile = IDX_PTR(piles, 0);
	ld	a, #>(_deck)
	ld	(hl+), a
	ld	a, #<(_piles)
	ld	(hl+), a
	ld	(hl), #>(_piles)
;src/main.c:954: for (i = 0; i < 10; i++) {
	xor	a, a
	inc	hl
	ld	(hl), a
00125$:
;src/main.c:955: pile->base = card;
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:957: pile->top = IDX_PTR(deck, 50u + i);
;c
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#15
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
;src/main.c:958: pile->height = 6u;
;c
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
;src/main.c:956: if (i < 4u) {
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00108$
;src/main.c:957: pile->top = IDX_PTR(deck, 50u + i);
;c
	pop	de
	push	de
	ld	hl, #(_deck + 0x0096)
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:958: pile->height = 6u;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x06
	jr	00109$
00108$:
;src/main.c:960: pile->top = IDX_PTR(deck, 40u + i);
;c
	ld	de, #(_deck + 0x0078)
	pop	hl
	push	hl
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:961: pile->height = 5u;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x05
00109$:
;src/main.c:964: card++;
;c
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
;src/main.c:965: pile++;
;c
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
;src/main.c:954: for (i = 0; i < 10; i++) {
	ld	(hl+), a
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0a
	jp	C, 00125$
;src/main.c:968: top_card_idx = 54u;
	ld	hl, #_top_card_idx
	ld	(hl), #0x36
;src/main.c:969: }
	add	sp, #16
	ret
;src/main.c:971: UINT8 is_stack_coherent(Card *card)
;	---------------------------------
; Function is_stack_coherent
; ---------------------------------
_is_stack_coherent::
	add	sp, #-2
;src/main.c:973: while (card->next_card) {
00103$:
	ldhl	sp,#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00105$
;src/main.c:974: UINT8 prev_data = card->data;
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	c, (hl)
;src/main.c:975: card = card->next_card;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
;src/main.c:976: if (prev_data != card->data + 1u)
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
	ld	e, a
	ld	d, #0x00
	inc	de
	ld	b, #0x00
	ld	a, c
	sub	a, e
	jr	NZ, 00123$
	ld	a, b
	sub	a, d
	jr	Z, 00103$
00123$:
;src/main.c:977: return 0u;
	ld	e, #0x00
	jr	00106$
00105$:
;src/main.c:979: return 1u;
	ld	e, #0x01
00106$:
;src/main.c:980: }
	add	sp, #2
	ret
;src/main.c:982: inline void deal(void)
;	---------------------------------
; Function deal
; ---------------------------------
_deal::
	add	sp, #-5
;src/main.c:985: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles
;src/main.c:988: for (i = 0; i < 10u; i++) {
	ld	e, #0x00
00105$:
;src/main.c:989: if (!pile->height)
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
;src/main.c:990: return;
	jr	Z, 00110$
;src/main.c:991: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:988: for (i = 0; i < 10u; i++) {
	inc	e
	ld	a, e
	sub	a, #0x0a
	jr	C, 00105$
;src/main.c:994: pile = IDX_PTR(piles, 0);
	ldhl	sp,	#2
	ld	a, #<(_piles)
	ld	(hl+), a
	ld	(hl), #>(_piles)
;src/main.c:995: Card *deck_top = IDX_PTR(deck, top_card_idx);
	ld	hl, #_top_card_idx
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	bc,#_deck
	add	hl,bc
	ld	c, l
	ld	b, h
;src/main.c:996: top_card_idx += 10u;
	ld	hl, #_top_card_idx
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
;src/main.c:999: for (i = 0; i < 10u; i++) {
	ldhl	sp,	#4
	ld	(hl), #0x0a
00109$:
;src/main.c:1000: pile->top->next_card = deck_top;
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:1001: pile->top = deck_top;
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:1002: pile->height++;
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	inc	a
	ld	(de), a
;src/main.c:1003: deck_top++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:1004: pile++;
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl+), a
;src/main.c:999: for (i = 0; i < 10u; i++) {
	dec	(hl)
	jr	NZ, 00109$
;src/main.c:1007: dynamic_metasprite_deal();
	call	_dynamic_metasprite_deal
00110$:
;src/main.c:1008: }
	add	sp, #5
	ret
;src/main.c:1010: void pile_append_cursor_stack(Pile *pile)
;	---------------------------------
; Function pile_append_cursor_stack
; ---------------------------------
_pile_append_cursor_stack::
	add	sp, #-13
;src/main.c:1012: if (pile->height)
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
;c
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#12
	ld	(hl), a
;src/main.c:1013: pile->top->next_card = cursor.held_card;
;c
	pop	de
	push	de
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;src/main.c:1012: if (pile->height)
	ldhl	sp,	#12
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;src/main.c:1013: pile->top->next_card = cursor.held_card;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#11
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00103$
00102$:
;src/main.c:1015: pile->base = cursor.held_card;
	ld	de, #_cursor
	ld	a, (de)
	ldhl	sp,	#11
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	pop	de
	push	de
	dec	hl
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
00103$:
;src/main.c:1017: Pile *src_pile = IDX_PTR(piles, cursor.pile_idx);
	ld	bc, #_piles+0
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	e, a
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/main.c:1018: Card *top_card = cursor.held_card;
	ld	de, #_cursor
	ld	a, (de)
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:1019: while (top_card->next_card)
00104$:
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00106$
;src/main.c:1020: top_card = top_card->next_card;
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), e
	jr	00104$
00106$:
;src/main.c:1021: pile->top = top_card;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:1022: cursor.height = pile->height - !!pile->height;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	sub	a,#0x01
	ld	a, #0x00
	rla
	xor	a, #0x01
	ld	c, a
	ld	a, b
	sub	a, c
	ld	(#(_cursor + 0x0007)),a
;src/main.c:1023: pile->height += cursor.held_stack_size;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	a, (#(_cursor + 0x0004) + 0)
	add	a, c
	ld	c, a
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;src/main.c:1024: if (cursor.hand_pile_idx != cursor.pile_idx) {
	ld	a, (#(_cursor + 0x0005) + 0)
	ld	hl, #(_cursor + 0x0006)
	ld	c, (hl)
	sub	a, c
	jp	Z,00116$
;src/main.c:1025: UINT8 piles_to_clear = 0;
	xor	a, a
	ldhl	sp,	#12
	ld	(hl), a
;src/main.c:1026: if (src_pile->height == 13u && is_stack_coherent(src_pile->base)) {
;c
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x0d
	jr	NZ, 00108$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	push	bc
	call	_is_stack_coherent
	add	sp, #2
	ld	a, e
	or	a, a
	jr	Z, 00108$
;src/main.c:1027: piles_to_clear = cursor.pile_idx;
	ld	a, (#(_cursor + 0x0006) + 0)
	ldhl	sp,	#12
	ld	(hl), a
00108$:
;src/main.c:1029: if (pile->height == 13u && is_stack_coherent(pile->base)) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x0d
	jr	NZ, 00111$
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	push	bc
	call	_is_stack_coherent
	add	sp, #2
	ld	a, e
	or	a, a
	jr	Z, 00111$
;src/main.c:1030: cursor.height = 0;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
;src/main.c:1024: if (cursor.hand_pile_idx != cursor.pile_idx) {
	ld	a, (#(_cursor + 0x0005) + 0)
	ldhl	sp,	#7
	ld	(hl), a
;src/main.c:1031: piles_to_clear |= piles_to_clear ? cursor.hand_pile_idx << 4u : cursor.hand_pile_idx;
	ldhl	sp,	#12
	ld	a, (hl)
	or	a, a
	jr	Z, 00119$
	ldhl	sp,	#7
	ld	a, (hl)
	swap	a
	and	a, #0xf0
	jr	00120$
00119$:
	ldhl	sp,	#7
	ld	a, (hl)
00120$:
	ldhl	sp,	#12
	or	a, (hl)
	ld	(hl), a
00111$:
;src/main.c:1034: if (cursor.card_to_show)
	ld	de, #(_cursor + 0x0002)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00114$
;src/main.c:1035: cursor.card_to_show->data |= BITMASK_CARD_VISIBLE;
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	set	6, (hl)
00114$:
;src/main.c:1041: cursor.held_card,
	ld	de, #_cursor
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:1040: cursor.held_stack_size,
	ld	hl, #(_cursor + 0x0004)
	ld	c, (hl)
;src/main.c:1039: (pile->height + 3u - cursor.held_stack_size) * 8u,
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x03
	sub	a, c
	add	a, a
	add	a, a
	add	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1038: (src_pile->height + 2u + cursor.held_stack_size) * 8u, cursor.hand_pile_idx * 16u,
	ld	a, (#(_cursor + 0x0005) + 0)
	swap	a
	and	a, #0xf0
	inc	hl
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x02
	add	a, c
	add	a, a
	add	a, a
	add	a, a
	ld	(hl), a
;src/main.c:1037: cursor.pile_idx * 16u,
	ld	a, (#(_cursor + 0x0006) + 0)
	swap	a
	and	a, #0xf0
;src/main.c:1036: dynamic_metasprite_fold(top_card->data,
	ldhl	sp,	#8
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	inc	hl
	inc	hl
	ld	e, (hl)
	ldhl	sp,	#12
	ld	h, (hl)
	push	hl
	inc	sp
	ld	h, #0x80
	push	hl
	inc	sp
	ldhl	sp,	#8
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	push	hl
	ld	h, c
	push	hl
	inc	sp
	ldhl	sp,	#9
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#11
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#18
	ld	h, (hl)
	push	hl
	inc	sp
	ld	d,a
	push	de
	call	_dynamic_metasprite_fold
	add	sp, #10
00116$:
;src/main.c:1047: cursor.held_card = NULL;
	ld	hl, #_cursor
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:1048: cursor.pile_idx = cursor.hand_pile_idx;
	ld	a, (#(_cursor + 0x0005) + 0)
	ld	(#(_cursor + 0x0006)),a
;src/main.c:1049: flags |= FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x01
	ld	(hl), a
;src/main.c:1050: }
	add	sp, #13
	ret
;src/main.c:1056: void start_game(void)
;	---------------------------------
; Function start_game
; ---------------------------------
_start_game::
;src/main.c:1058: flags &= ~FLAG_GAME_STATE;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xe7
;src/main.c:1059: flags |= FLAG_GAME_STATE_INGAME | FLAG_REDRAW_CURSOR;
	ld	(hl), a
	or	a, #0x11
	ld	(hl), a
;src/main.c:1060: cursor.pile_idx = 0;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x00
;src/main.c:1061: cursor.height = 0;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
;src/main.c:1062: metasprite_2x3_hide(SPRITE_FRAME_1);
	ld	a, #0x12
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:1063: metasprite_2x3_hide(SPRITE_FRAME_2);
	ld	a, #0x18
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:1064: metasprite_2x3_hide(SPRITE_FRAME_3);
	ld	a, #0x1e
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:1065: init_deck();
	call	_init_deck
;src/main.c:1066: clear_bkg();
	call	_clear_bkg
;src/main.c:1067: draw_bkg_game();
;src/main.c:1068: }
	jp  _draw_bkg_game
;src/main.c:1070: inline void start_settings(void)
;	---------------------------------
; Function start_settings
; ---------------------------------
_start_settings::
;src/main.c:1072: flags &= ~FLAG_GAME_STATE;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xe7
;src/main.c:1073: flags |= FLAG_GAME_STATE_SETTINGS | FLAG_REDRAW_CURSOR;
	ld	(hl), a
	or	a, #0x19
	ld	(hl), a
;src/main.c:1074: cursor.pile_idx = 0;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x00
;src/main.c:1075: cursor.height = 0;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
;src/main.c:1076: draw_setting_frame_metasprites();
	call	_draw_setting_frame_metasprites
;src/main.c:1077: clear_bkg();
	call	_clear_bkg
;src/main.c:1078: draw_bkg_settings();
;src/main.c:1079: }
	jp  _draw_bkg_settings
;src/main.c:1081: void start_splash_screen(void)
;	---------------------------------
; Function start_splash_screen
; ---------------------------------
_start_splash_screen::
;src/main.c:1083: flags &= ~FLAG_GAME_STATE;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xe7
	ld	(hl), a
;src/main.c:1084: flags |= FLAG_GAME_STATE_SPLASH;
;src/main.c:1085: clear_bkg();
	call	_clear_bkg
;src/main.c:1086: draw_bkg_splash_screen();
	call	_draw_bkg_splash_screen
;src/main.c:577: dynamic_metasprite.src[0] = 72;
	ld	hl, #_dynamic_metasprite
	ld	(hl), #0x48
	inc	hl
	ld	(hl), #0x00
;src/main.c:578: dynamic_metasprite.src[1] = -24;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	(hl), #0xe8
	inc	hl
	ld	(hl), #0xff
;src/main.c:579: dynamic_metasprite.dist[0] = -64;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	(hl), #0xc0
	inc	hl
	ld	(hl), #0xff
;src/main.c:580: dynamic_metasprite.dist[1] = 40;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	(hl), #0x28
	inc	hl
	ld	(hl), #0x00
;src/main.c:581: dynamic_metasprite.target_frames = TARGET_FRAMES_SPLASH_SCREEN;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0x20
;src/main.c:582: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:583: dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;src/main.c:584: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_TITLE + OFFSET_TITLE_S;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #0x80
;src/main.c:585: dynamic_metasprite.data[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), #0x00
;src/main.c:586: dynamic_metasprite.callback = &dynamic_metasprite_splash_screen_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_splash_screen_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_splash_screen_callback)
;src/main.c:587: flags |= FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x04
	ld	(hl), a
;src/main.c:1087: dynamic_metasprite_splash_screen();
;src/main.c:1088: }
	ret
;src/main.c:1090: void start_leaderboard(void)
;	---------------------------------
; Function start_leaderboard
; ---------------------------------
_start_leaderboard::
;src/main.c:1092: ENABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;src/main.c:1093: flags &= ~FLAG_GAME_STATE;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xe7
;src/main.c:1094: flags |= FLAG_GAME_STATE_LEADERBOARD;
	ld	(hl), a
	or	a, #0x08
	ld	(hl), a
;src/main.c:1095: cursor.pile_idx = 0;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x00
;src/main.c:1096: clear_bkg();
	call	_clear_bkg
;src/main.c:1097: draw_bkg_leaderboard();
	call	_draw_bkg_leaderboard
;src/main.c:1098: DISABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x00
;src/main.c:1099: }
	ret
;src/main.c:1101: void add_leaderboard(void)
;	---------------------------------
; Function add_leaderboard
; ---------------------------------
_add_leaderboard::
	add	sp, #-3
;src/main.c:1103: ENABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;src/main.c:1104: LeaderBoard *iter = leaderboard[NUM_SUITS(settings)];
	ld	bc, #_leaderboard+0
	ld	a, (#_settings)
	and	a, #0x03
	ld	l, a
	ld	h, #0x00
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, bc
	ld	c, l
	ld	b, h
;src/main.c:1106: for (i = 0; i < 3u; i++) {
	xor	a, a
	ldhl	sp,	#2
	ld	(hl), a
00106$:
;src/main.c:1107: if (score > iter->score)
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#0
	ld	e, l
	ld	d, h
	ld	hl, #_score
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00103$
;src/main.c:1109: iter++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:1106: for (i = 0; i < 3u; i++) {
	ldhl	sp,	#2
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x03
	jr	C, 00106$
00103$:
;src/main.c:1111: if (i == 3u)
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00108$
;src/main.c:1112: return;
	jr	00105$
00105$:
;src/main.c:1113: iter->score = score;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ld	hl, #_score
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:1114: iter->name[0] = 0x0B;
	ld	a, #0x0b
	ld	(bc), a
;src/main.c:1115: iter->name[1] = 0x0B;
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl), #0x0b
;src/main.c:1116: iter->name[2] = 0x0B;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x0b
;src/main.c:1117: selected_leaderboard = iter;
	ld	hl, #_selected_leaderboard
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:1118: cursor.height = LEADERBOARD_PAD_Y + NUM_SUITS(settings) * 4u + i;
	ld	a, (#_settings)
	and	a, #0x03
	add	a, a
	add	a, a
	add	a, #0x04
	ldhl	sp,	#2
	add	a, (hl)
	ld	(#(_cursor + 0x0007)),a
;src/main.c:1119: flags |= FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x01
	ld	(hl), a
;src/main.c:1120: DISABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x00
00108$:
;src/main.c:1121: }
	add	sp, #3
	ret
;src/main.c:1123: void nvram_check(void)
;	---------------------------------
; Function nvram_check
; ---------------------------------
_nvram_check::
	add	sp, #-5
;src/main.c:1125: ENABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;src/main.c:1126: if (nvram_check_data != NVRAM_SET) {
	ld	hl, #_nvram_check_data
	ld	a, (hl)
	sub	a, #0x37
	jr	NZ, 00134$
	inc	hl
	ld	a, (hl)
	dec	a
	jr	NZ, 00134$
	inc	hl
	ld	a, (hl)
	sub	a, #0x3e
	jr	NZ, 00134$
	inc	hl
	ld	a, (hl)
	sub	a, #0xcd
	jp	Z,00104$
00134$:
;src/main.c:1127: nvram_check_data = NVRAM_SET;
	ld	hl, #_nvram_check_data
	ld	(hl), #0x37
	inc	hl
	ld	(hl), #0x01
	inc	hl
	ld	(hl), #0x3e
	inc	hl
	ld	(hl), #0xcd
;src/main.c:1128: LeaderBoard *iter = IDX_PTR(leaderboard[0], 0u);
	ldhl	sp,	#0
	ld	(hl), #<(_leaderboard)
	inc	hl
	ld	(hl), #>(_leaderboard)
;src/main.c:1130: for (i = 0; i < 3; i++) {
	xor	a, a
	ldhl	sp,	#4
	ld	(hl), a
00108$:
;src/main.c:1131: iter->score = 400u - 100u * (UINT16)i;
	pop	bc
	push	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,	#4
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	ld	a, #0x90
	sub	a, l
	ld	e, a
	ld	a, #0x01
	sbc	a, h
	ld	d, a
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;src/main.c:1132: iter->name[0] = 0x21u;
	pop	hl
	push	hl
	ld	(hl), #0x21
;src/main.c:1133: iter->name[1] = 0x19u;
	pop	hl
	push	hl
	inc	hl
	ld	(hl), #0x19
;src/main.c:1134: iter->name[2] = 0x14u;
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	(hl), #0x14
;src/main.c:1135: iter++;
;c
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
;src/main.c:1136: for (j = 0; j < 2; j++) {
	ld	e, #0x02
00107$:
;src/main.c:1137: iter->score = 0u;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:1138: iter->name[0] = 0u;
	xor	a, a
	ld	(bc), a
;src/main.c:1139: iter->name[1] = 0u;
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl), #0x00
;src/main.c:1140: iter->name[2] = 0u;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x00
;src/main.c:1141: iter++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:1136: for (j = 0; j < 2; j++) {
	dec	e
	jr	NZ, 00107$
;src/main.c:1130: for (i = 0; i < 3; i++) {
	inc	sp
	inc	sp
	push	bc
	ldhl	sp,	#4
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x03
	jr	C, 00108$
00104$:
;src/main.c:1145: DISABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x00
;src/main.c:1146: }
	add	sp, #5
	ret
;src/main.c:1148: void inc_letter(const INT8 inc)
;	---------------------------------
; Function inc_letter
; ---------------------------------
_inc_letter::
;src/main.c:1150: ENABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;src/main.c:1151: UINT8 *letter = &selected_leaderboard->name[cursor.pile_idx];
	ld	hl, #_selected_leaderboard + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (#(_cursor + 0x0006) + 0)
	add	a, c
	ld	c, a
	ld	a, #0x00
	adc	a, b
	ld	b, a
;src/main.c:1152: *letter = (INT8)*letter + inc;
	ld	a, (bc)
	ldhl	sp,	#2
	add	a, (hl)
;src/main.c:1153: if (*letter < 0x0Bu)
	ld	(bc), a
	ld	e, a
	sub	a, #0x0b
	jr	NC, 00104$
;src/main.c:1154: *letter = 0x24u;
	ld	a, #0x24
	ld	(bc), a
	jr	00105$
00104$:
;src/main.c:1155: else if (*letter > 0x24u)
	ld	a, #0x24
	sub	a, e
	jr	NC, 00105$
;src/main.c:1156: *letter = 0x0Bu;
	ld	a, #0x0b
	ld	(bc), a
00105$:
;src/main.c:1157: set_bkg_tile_xy(LEADERBOARD_NAME_X + cursor.pile_idx, cursor.height, *letter);
	ld	a, (bc)
	ld	c, a
	ld	hl, #(_cursor + 0x0007)
	ld	b, (hl)
	ld	a, (#(_cursor + 0x0006) + 0)
	add	a, #0x08
	ld	h, c
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:1158: DISABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x00
;src/main.c:1159: }
	ret
;src/main.c:1161: inline void input_process(void)
;	---------------------------------
; Function input_process
; ---------------------------------
_input_process::
	add	sp, #-15
;src/main.c:1164: UINT8 input = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), e
;src/main.c:1165: UINT8 new_input = input & ~prev_input;
	ld	a, (#_input_process_prev_input_65536_387)
	cpl
	ldhl	sp,	#0
	and	a, (hl)
;src/main.c:1166: if (new_input) {
	ld	c, a
	or	a, a
	jp	Z, 00206$
;src/main.c:1167: switch (flags & FLAG_GAME_STATE) {
	ld	a, (#_flags)
	and	a, #0x18
	ld	b, a
	ld	e, #0x00
;src/main.c:1169: if (new_input & J_START) {
	ld	a, c
	and	a, #0x80
	ldhl	sp,	#1
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1171: if (flags & FLAG_PLAYING_ANIMATION)
	ld	a, (#_flags)
	ldhl	sp,	#3
	ld	(hl), a
;src/main.c:1167: switch (flags & FLAG_GAME_STATE) {
	ld	a, b
	or	a, a
	or	a, e
	jr	Z, 00101$
;src/main.c:1187: } else if (new_input & J_A) {
	ld	a, c
	and	a, #0x10
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1195: && cursor.pile_idx < 2u) {
	ld	a, c
	and	a, #0x01
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1198: && cursor.pile_idx) {
	ld	a, c
	and	a, #0x02
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1200: } else if (new_input & J_UP) {
	ld	a, c
	and	a, #0x04
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1202: } else if (new_input & J_DOWN) {
	ld	a, c
	and	a, #0x08
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1181: flags |= FLAG_REDRAW_CURSOR;
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, #0x01
	ldhl	sp,	#14
	ld	(hl), a
;src/main.c:1167: switch (flags & FLAG_GAME_STATE) {
	ld	a, b
	sub	a, #0x08
	or	a, e
	jr	Z, 00111$
	ld	a, b
	sub	a, #0x10
	or	a, e
	jp	Z,00161$
	ld	a, b
	sub	a, #0x18
	or	a, e
	jp	Z,00140$
	jp	00206$
;src/main.c:1168: case FLAG_GAME_STATE_SPLASH:
00101$:
;src/main.c:1169: if (new_input & J_START) {
	ldhl	sp,	#2
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00109$
;src/main.c:1170: initrand(DIV_REG);
	ldh	a, (_DIV_REG+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	call	_initrand
	add	sp, #2
;src/main.c:1171: if (flags & FLAG_PLAYING_ANIMATION)
	ld	a, (#_flags)
	bit	2, a
	jr	Z, 00103$
;src/main.c:1172: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
00103$:
;src/main.c:1072: flags &= ~FLAG_GAME_STATE;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xe7
	ld	(hl), a
;src/main.c:1073: flags |= FLAG_GAME_STATE_SETTINGS | FLAG_REDRAW_CURSOR;
	ld	a, (hl)
	or	a, #0x19
	ld	(hl), a
;src/main.c:1074: cursor.pile_idx = 0;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x00
;src/main.c:1075: cursor.height = 0;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
;src/main.c:1076: draw_setting_frame_metasprites();
	call	_draw_setting_frame_metasprites
;src/main.c:1077: clear_bkg();
	call	_clear_bkg
;src/main.c:1078: draw_bkg_settings();
	call	_draw_bkg_settings
;src/main.c:1173: start_settings();
	jp	00206$
00109$:
;src/main.c:1174: } else if (new_input & J_SELECT) {
	bit	6, c
	jp	Z,00206$
;src/main.c:1175: if (flags & FLAG_PLAYING_ANIMATION)
	ldhl	sp,	#3
	bit	2, (hl)
	jr	Z, 00105$
;src/main.c:1176: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
00105$:
;src/main.c:1177: start_leaderboard();
	call	_start_leaderboard
;src/main.c:1179: break;
	jp	00206$
;src/main.c:1180: case FLAG_GAME_STATE_LEADERBOARD:
00111$:
;src/main.c:1181: flags |= FLAG_REDRAW_CURSOR;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(#_flags),a
;src/main.c:1182: if (selected_leaderboard) {
	ld	hl, #_selected_leaderboard + 1
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00138$
;src/main.c:1184: && cursor.pile_idx == 2u) {
	ldhl	sp,	#2
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00132$
	ld	a, (#(_cursor + 0x0006) + 0)
	sub	a, #0x02
	jr	NZ, 00132$
;src/main.c:1185: selected_leaderboard = NULL;
	ld	hl, #_selected_leaderboard
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;/home/wojtek/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0032)
	ld	(hl), #0x00
;src/main.c:1186: set_sprite_tile(SPRITE_FRAME, OFFSET_SPRITE_NONE);
	jp	00206$
00132$:
;src/main.c:1187: } else if (new_input & J_A) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00129$
;src/main.c:1188: if (cursor.pile_idx == 2u) {
	ld	bc, #_cursor+6
	ld	a, (bc)
	cp	a, #0x02
	jr	NZ, 00113$
;src/main.c:1189: selected_leaderboard = NULL;
	ld	hl, #_selected_leaderboard
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;/home/wojtek/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0032)
	ld	(hl), #0x00
;src/main.c:1190: set_sprite_tile(SPRITE_FRAME, OFFSET_SPRITE_NONE);
	jp	00206$
00113$:
;src/main.c:1192: cursor.pile_idx++;
	inc	a
	ld	(bc), a
	jp	00206$
00129$:
;src/main.c:1195: && cursor.pile_idx < 2u) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00125$
	ld	bc, #_cursor+6
	ld	a, (bc)
	cp	a, #0x02
	jr	NC, 00125$
;src/main.c:1196: cursor.pile_idx++;
	inc	a
	ld	(bc), a
	jp	00206$
00125$:
;src/main.c:1198: && cursor.pile_idx) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00121$
	ld	bc, #_cursor+6
	ld	a, (bc)
	or	a, a
	jr	Z, 00121$
;src/main.c:1199: cursor.pile_idx--;
	dec	a
	ld	(bc), a
	jp	00206$
00121$:
;src/main.c:1200: } else if (new_input & J_UP) {
	ldhl	sp,	#11
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00118$
;src/main.c:1201: inc_letter(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_inc_letter
	inc	sp
	jp	00206$
00118$:
;src/main.c:1202: } else if (new_input & J_DOWN) {
	ldhl	sp,	#13
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00206$
;src/main.c:1203: inc_letter(-1);
	ld	a, #0xff
	push	af
	inc	sp
	call	_inc_letter
	inc	sp
	jp	00206$
00138$:
;src/main.c:1205: } else if (new_input & (J_START | J_SELECT | J_A | J_B)) {
	ld	a, c
	and	a, #0xf0
	jp	Z,00206$
;src/main.c:1206: start_splash_screen();
	call	_start_splash_screen
;src/main.c:1208: break;
	jp	00206$
;src/main.c:1209: case FLAG_GAME_STATE_SETTINGS:
00140$:
;src/main.c:1210: flags |= FLAG_REDRAW_CURSOR;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(#_flags),a
;src/main.c:1211: if (new_input & J_START) {
	ldhl	sp,	#2
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00157$
;src/main.c:1212: start_game();
	call	_start_game
	jr	00158$
00157$:
;src/main.c:1214: && cursor.height) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00153$
	ld	bc, #_cursor+7
	ld	a, (bc)
	or	a, a
	jr	Z, 00153$
;src/main.c:1215: cursor.height--;
	dec	a
	ld	(bc), a
	jr	00158$
00153$:
;src/main.c:1217: && cursor.height + 1u < setting_pile_heights[cursor.pile_idx]) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00149$
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
	ld	e, c
	ld	d, #0x00
	inc	de
	ld	a, (#_cursor + 6)
	add	a, #<(_setting_pile_heights)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_setting_pile_heights)
	ld	h, a
	ld	l, (hl)
	ld	b, #0x00
	ld	a, e
	sub	a, l
	ld	a, d
	sbc	a, b
	jr	NC, 00149$
;src/main.c:1218: cursor.height++;
	inc	c
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), c
	jr	00158$
00149$:
;src/main.c:1220: && cursor.pile_idx) {
	ldhl	sp,	#11
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00145$
	ld	bc, #_cursor + 6
	ld	a, (bc)
	or	a, a
	jr	Z, 00145$
;src/main.c:1221: cursor.pile_idx--;
	dec	a
	ld	(bc), a
;src/main.c:1222: cursor.height = 0;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
	jr	00158$
00145$:
;src/main.c:1224: && cursor.pile_idx < NUM_SETTING_PILES - 1u) {
	ldhl	sp,	#13
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00158$
	ld	bc, #_cursor + 6
	ld	a, (bc)
	cp	a, #0x03
	jr	NC, 00158$
;src/main.c:1225: cursor.pile_idx++;
	inc	a
	ld	(bc), a
;src/main.c:1226: cursor.height = 0;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
00158$:
;src/main.c:1228: if (new_input & J_A) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00206$
;src/main.c:1229: set_cursor_setting();
	call	_set_cursor_setting
;src/main.c:1231: break;
	jp	00206$
;src/main.c:1232: case FLAG_GAME_STATE_INGAME:
00161$:
;src/main.c:1233: if (cursor.held_card) {
	ld	hl, #_cursor
	ld	a, (hl+)
	or	a,(hl)
	jp	Z, 00202$
;src/main.c:1234: flags |= FLAG_REDRAW_HAND;
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, #0x02
	ld	(#_flags),a
;src/main.c:1236: && cursor.hand_pile_idx != 0) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00166$
	ld	bc, #_cursor+5
	ld	a, (bc)
	or	a, a
	jr	Z, 00166$
;src/main.c:1237: cursor.hand_pile_idx--;
	dec	a
	ld	(bc), a
	jr	00167$
00166$:
;src/main.c:1239: && cursor.hand_pile_idx < 9) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00167$
	ld	bc, #_cursor+5
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00167$
;src/main.c:1240: cursor.hand_pile_idx++;
	inc	a
	ld	(bc), a
00167$:
;src/main.c:1243: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00206$
	ld	a, (#_flags)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	bit	2, c
	jp	Z,00206$
;src/main.c:795: Pile *pile = IDX_PTR(piles, cursor.hand_pile_idx);
	ld	bc, #_piles+0
	ld	a, (#(_cursor + 0x0005) + 0)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#14
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, bc
	ld	c, l
	ld	b, h
;src/main.c:796: if (cursor.hand_pile_idx == cursor.pile_idx) {
	ld	hl, #_cursor + 6
	ld	e, (hl)
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00214$
;src/main.c:797: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
	jp	00206$
00214$:
;src/main.c:798: } else if (!pile->height
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00212$
;src/main.c:799: || RANK(pile->top->data) == RANK(cursor.held_card->data) + 1u) {
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	and	a, #0x0f
	ldhl	sp,	#13
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	and	a, #0x0f
	ld	e, a
	ld	d, #0x00
	inc	de
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, e
	jp	NZ,00206$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jp	NZ,00206$
00212$:
;src/main.c:800: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
;src/main.c:801: score--;
	ld	hl, #_score + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	dec	de
	dec	hl
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:1244: cursor_place_stack();
	jp	00206$
00202$:
;src/main.c:1247: flags |= FLAG_REDRAW_CURSOR;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(#_flags),a
;src/main.c:1248: if (new_input & J_DOWN) {
	ldhl	sp,	#13
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00192$
;src/main.c:1249: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	hl, #_cursor + 6
	ld	c, (hl)
	ld	a, c
;src/main.c:1250: cursor.pile_idx = 0;
	sub	a,#0x0a
	jr	NZ, 00175$
	ld	(hl),a
	jr	00193$
00175$:
;src/main.c:1251: else if (cursor.height + 1u < piles[cursor.pile_idx].height)
	ld	a, (#(_cursor + 0x0007) + 0)
	ld	d, #0x00
	ld	e, a
	inc	de
	ldhl	sp,	#13
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_piles
	add	hl, de
	ld	bc, #0x0004
	add	hl, bc
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00193$
;src/main.c:1252: change_cursor_height(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_change_cursor_height
	inc	sp
	jr	00193$
00192$:
;src/main.c:1253: } else if (new_input & J_UP) {
	ldhl	sp,	#11
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00189$
;src/main.c:1254: if (cursor.height == 0)
	ld	a, (#(_cursor + 0x0007) + 0)
	or	a, a
	jr	NZ, 00178$
;src/main.c:1255: cursor.pile_idx = PILE_IDX_DECK;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x0a
	jr	00193$
00178$:
;src/main.c:1257: change_cursor_height(-1);
	ld	a, #0xff
	push	af
	inc	sp
	call	_change_cursor_height
	inc	sp
	jr	00193$
00189$:
;src/main.c:1259: && cursor.pile_idx != 0
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00184$
	ld	bc, #_cursor+6
	ld	a, (bc)
	or	a, a
	jr	Z, 00184$
;src/main.c:1260: && cursor.pile_idx != PILE_IDX_DECK) {
	cp	a, #0x0a
	jr	Z, 00184$
;src/main.c:1261: cursor.pile_idx--;
	dec	a
	ld	(bc), a
;src/main.c:1262: cursor_adjust_height();
	call	_cursor_adjust_height
	jr	00193$
00184$:
;src/main.c:1264: && cursor.pile_idx < PILE_IDX_DECK - 1u) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00193$
	ld	bc, #_cursor+6
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00193$
;src/main.c:1265: cursor.pile_idx++;
	inc	a
	ld	(bc), a
;src/main.c:1266: cursor_adjust_height();
	call	_cursor_adjust_height
00193$:
;src/main.c:1269: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00206$
	ld	a, (#_flags)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	bit	2, c
	jp	Z,00206$
;src/main.c:1270: if (cursor.pile_idx == PILE_IDX_DECK && top_card_idx != 104u)
	ld	hl, #(_cursor + 0x0006)
	ld	c, (hl)
	ld	a, c
	sub	a, #0x0a
	jp	NZ,00195$
	ld	a, (#_top_card_idx)
	sub	a, #0x68
	jp	Z,00195$
;src/main.c:985: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles
;src/main.c:988: for (i = 0; i < 10u; i++) {
	ld	e, #0x00
00230$:
;src/main.c:989: if (!pile->height)
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00206$
;src/main.c:991: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:988: for (i = 0; i < 10u; i++) {
	inc	e
	ld	a, e
	sub	a, #0x0a
	jr	C, 00230$
;src/main.c:994: pile = IDX_PTR(piles, 0);
	ldhl	sp,	#12
	ld	a, #<(_piles)
	ld	(hl+), a
	ld	(hl), #>(_piles)
;src/main.c:995: Card *deck_top = IDX_PTR(deck, top_card_idx);
	ld	hl, #_top_card_idx
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	bc,#_deck
	add	hl,bc
	ld	c, l
	ld	b, h
;src/main.c:996: top_card_idx += 10u;
	ld	hl, #_top_card_idx
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
;src/main.c:999: for (i = 0; i < 10u; i++) {
	ldhl	sp,	#14
	ld	(hl), #0x0a
00234$:
;src/main.c:1000: pile->top->next_card = deck_top;
;c
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:1001: pile->top = deck_top;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:1002: pile->height++;
;c
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	inc	a
	ld	(de), a
;src/main.c:1003: deck_top++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:1004: pile++;
;c
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl+), a
;src/main.c:999: for (i = 0; i < 10u; i++) {
	dec	(hl)
	ld	a, (hl)
	jr	NZ, 00234$
;src/main.c:1007: dynamic_metasprite_deal();
	call	_dynamic_metasprite_deal
;src/main.c:1271: deal();
	jp	00206$
00195$:
;src/main.c:769: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, #<(_piles)
	add	a, l
	ld	c, a
	ld	a, #>(_piles)
	adc	a, h
	ld	b, a
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
;src/main.c:770: Card *top = pile->base;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:771: for (i = 1; i < cursor.height; i++)
	ld	b, #0x01
00236$:
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
	ld	a, b
	sub	a, c
	jr	NC, 00222$
;src/main.c:772: top = top->next_card;
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:771: for (i = 1; i < cursor.height; i++)
	inc	b
	jr	00236$
00222$:
;src/main.c:773: Card *stack = cursor.height ? top->next_card : top;
	ld	a, c
	or	a, a
	jr	Z, 00240$
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	jr	00241$
00240$:
	ldhl	sp,#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00241$:
;src/main.c:774: if (!(VISIBLE(stack->data) && is_stack_coherent(stack)))
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	bit	6, a
	jr	Z, 00206$
	push	bc
	push	bc
	call	_is_stack_coherent
	add	sp, #2
	ld	a, e
	pop	bc
	or	a, a
	jr	Z, 00206$
;src/main.c:777: cursor.held_card = stack;
	ld	hl, #_cursor
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:778: cursor.hand_pile_idx = cursor.pile_idx;
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	(#(_cursor + 0x0005)),a
;src/main.c:779: cursor.held_stack_size = pile->height - cursor.height;
;c
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #(_cursor + 0x0007)
	ld	l, (hl)
	sub	a, l
	ld	(#(_cursor + 0x0004)),a
;src/main.c:780: pile->height = cursor.height;
	ld	a, (#(_cursor + 0x0007) + 0)
	ld	(bc), a
;src/main.c:781: flags |= FLAG_REDRAW_HAND;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x02
	ld	(hl), a
;src/main.c:782: if (cursor.height) {
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#12
	ld	(hl), a
;src/main.c:783: pile->top = top;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
;src/main.c:785: cursor.card_to_show = top;
;src/main.c:782: if (cursor.height) {
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00227$
;src/main.c:783: pile->top = top;
	inc	hl
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/main.c:784: top->next_card = NULL;
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:785: cursor.card_to_show = top;
	ld	de, #(_cursor + 0x0002)
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
	jr	00206$
00227$:
;src/main.c:787: pile->base = NULL;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:788: pile->top = NULL;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/main.c:789: cursor.card_to_show = NULL;
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:1277: }
00206$:
;src/main.c:1279: prev_input = input;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_input_process_prev_input_65536_387),a
;src/main.c:1280: }
	add	sp, #15
	ret
;src/main.c:1282: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-15
;src/main.c:1284: font_init();
	call	_font_init
;src/main.c:1285: font_t font = font_load(font_min);
	ld	hl, #_font_min
	push	hl
	call	_font_load
	add	sp, #2
;src/main.c:1286: font_set(font);
	push	de
	call	_font_set
	add	sp, #2
;src/main.c:1287: set_bkg_data(OFFSET_BKG_FONT_ADDON, N_FONT_ADDON, font_addon);
	ld	hl, #_font_addon
	push	hl
	ld	de, #0x0125
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/main.c:1289: set_bkg_data(OFFSET_BKG_TITLE, N_TITLE, title_textures);
	ld	hl, #_title_textures
	push	hl
	ld	de, #0x3080
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/main.c:1290: set_bkg_data(OFFSET_BKG_CARD, N_CARD, card_textures);
	ld	hl, #_card_textures
	push	hl
	ld	de, #0x3ab0
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/main.c:1291: set_bkg_data(OFFSET_BKG_CARD_ADDON, N_CARD_ADDON, card_addon);
	ld	hl, #_card_addon
	push	hl
	ld	de, #0x1726
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/main.c:1292: set_bkg_data(OFFSET_BKG_BUTTON, N_BUTTON, button_textures);
	ld	hl, #_button_textures
	push	hl
	ld	de, #0x073d
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/main.c:1293: set_sprite_data(OFFSET_SPRITE_CURSOR, N_CURSOR, cursor_textures);
	ld	hl, #_cursor_textures
	push	hl
	ld	de, #0x0a01
	push	de
	call	_set_sprite_data
	add	sp, #4
;src/main.c:1295: nvram_check();
	call	_nvram_check
;src/main.c:1297: start_splash_screen();
	call	_start_splash_screen
;src/main.c:1299: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;src/main.c:1300: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;src/main.c:1301: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;src/main.c:1303: while (1) {
00102$:
;src/main.c:1164: UINT8 input = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), e
;src/main.c:1165: UINT8 new_input = input & ~prev_input;
	ld	a, (#_main_prev_input_327681_450)
	cpl
	ldhl	sp,	#0
	and	a, (hl)
;src/main.c:1166: if (new_input) {
	ld	c, a
	or	a, a
	jp	Z, 00232$
;src/main.c:1167: switch (flags & FLAG_GAME_STATE) {
	ld	a, (#_flags)
	and	a, #0x18
	ld	b, a
	ld	e, #0x00
;src/main.c:1169: if (new_input & J_START) {
	ld	a, c
	and	a, #0x80
	ldhl	sp,	#1
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1171: if (flags & FLAG_PLAYING_ANIMATION)
	ld	a, (#_flags)
	ldhl	sp,	#3
	ld	(hl), a
;src/main.c:1167: switch (flags & FLAG_GAME_STATE) {
	ld	a, b
	or	a, a
	or	a, e
	jr	Z, 00114$
;src/main.c:1187: } else if (new_input & J_A) {
	ld	a, c
	and	a, #0x10
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1195: && cursor.pile_idx < 2u) {
	ld	a, c
	and	a, #0x01
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1198: && cursor.pile_idx) {
	ld	a, c
	and	a, #0x02
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1200: } else if (new_input & J_UP) {
	ld	a, c
	and	a, #0x04
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1202: } else if (new_input & J_DOWN) {
	ld	a, c
	and	a, #0x08
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:1181: flags |= FLAG_REDRAW_CURSOR;
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, #0x01
	ldhl	sp,	#14
	ld	(hl), a
;src/main.c:1167: switch (flags & FLAG_GAME_STATE) {
	ld	a, b
	sub	a, #0x08
	or	a, e
	jr	Z, 00115$
	ld	a, b
	sub	a, #0x10
	or	a, e
	jp	Z,00229$
	ld	a, b
	sub	a, #0x18
	or	a, e
	jp	Z,00146$
	jp	00232$
;src/main.c:1168: case FLAG_GAME_STATE_SPLASH:
00114$:
;src/main.c:1169: if (new_input & J_START) {
	ldhl	sp,	#2
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00112$
;src/main.c:1170: initrand(DIV_REG);
	ldh	a, (_DIV_REG+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	call	_initrand
	add	sp, #2
;src/main.c:1171: if (flags & FLAG_PLAYING_ANIMATION)
	ld	a, (#_flags)
	bit	2, a
	jr	Z, 00105$
;src/main.c:1172: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
00105$:
;src/main.c:1072: flags &= ~FLAG_GAME_STATE;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xe7
	ld	(hl), a
;src/main.c:1073: flags |= FLAG_GAME_STATE_SETTINGS | FLAG_REDRAW_CURSOR;
	ld	a, (hl)
	or	a, #0x19
	ld	(hl), a
;src/main.c:1074: cursor.pile_idx = 0;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x00
;src/main.c:1075: cursor.height = 0;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
;src/main.c:1076: draw_setting_frame_metasprites();
	call	_draw_setting_frame_metasprites
;src/main.c:1077: clear_bkg();
	call	_clear_bkg
;src/main.c:1078: draw_bkg_settings();
	call	_draw_bkg_settings
;src/main.c:1173: start_settings();
	jp	00232$
00112$:
;src/main.c:1174: } else if (new_input & J_SELECT) {
	bit	6, c
	jp	Z,00232$
;src/main.c:1175: if (flags & FLAG_PLAYING_ANIMATION)
	ldhl	sp,	#3
	bit	2, (hl)
	jr	Z, 00109$
;src/main.c:1176: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
00109$:
;src/main.c:1177: start_leaderboard();
	call	_start_leaderboard
;src/main.c:1179: break;
	jp	00232$
;src/main.c:1180: case FLAG_GAME_STATE_LEADERBOARD:
00115$:
;src/main.c:1181: flags |= FLAG_REDRAW_CURSOR;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(#_flags),a
;src/main.c:1182: if (selected_leaderboard) {
	ld	hl, #_selected_leaderboard + 1
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00144$
;src/main.c:1184: && cursor.pile_idx == 2u) {
	ldhl	sp,	#2
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00139$
	ld	a, (#(_cursor + 0x0006) + 0)
	sub	a, #0x02
	jr	NZ, 00139$
;src/main.c:1185: selected_leaderboard = NULL;
	ld	hl, #_selected_leaderboard
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;/home/wojtek/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0032)
	ld	(hl), #0x00
;src/main.c:1186: set_sprite_tile(SPRITE_FRAME, OFFSET_SPRITE_NONE);
	jp	00232$
00139$:
;src/main.c:1187: } else if (new_input & J_A) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00137$
;src/main.c:1188: if (cursor.pile_idx == 2u) {
	ld	bc, #_cursor+6
	ld	a, (bc)
	cp	a, #0x02
	jr	NZ, 00121$
;src/main.c:1189: selected_leaderboard = NULL;
	ld	hl, #_selected_leaderboard
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;/home/wojtek/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0032)
	ld	(hl), #0x00
;src/main.c:1190: set_sprite_tile(SPRITE_FRAME, OFFSET_SPRITE_NONE);
	jp	00232$
00121$:
;src/main.c:1192: cursor.pile_idx++;
	inc	a
	ld	(bc), a
	jp	00232$
00137$:
;src/main.c:1195: && cursor.pile_idx < 2u) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00135$
	ld	bc, #_cursor+6
	ld	a, (bc)
	cp	a, #0x02
	jr	NC, 00135$
;src/main.c:1196: cursor.pile_idx++;
	inc	a
	ld	(bc), a
	jp	00232$
00135$:
;src/main.c:1198: && cursor.pile_idx) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00133$
	ld	bc, #_cursor+6
	ld	a, (bc)
	or	a, a
	jr	Z, 00133$
;src/main.c:1199: cursor.pile_idx--;
	dec	a
	ld	(bc), a
	jp	00232$
00133$:
;src/main.c:1200: } else if (new_input & J_UP) {
	ldhl	sp,	#11
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00131$
;src/main.c:1201: inc_letter(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_inc_letter
	inc	sp
	jp	00232$
00131$:
;src/main.c:1202: } else if (new_input & J_DOWN) {
	ldhl	sp,	#13
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00232$
;src/main.c:1203: inc_letter(-1);
	ld	a, #0xff
	push	af
	inc	sp
	call	_inc_letter
	inc	sp
	jp	00232$
00144$:
;src/main.c:1205: } else if (new_input & (J_START | J_SELECT | J_A | J_B)) {
	ld	a, c
	and	a, #0xf0
	jp	Z,00232$
;src/main.c:1206: start_splash_screen();
	call	_start_splash_screen
;src/main.c:1208: break;
	jp	00232$
;src/main.c:1209: case FLAG_GAME_STATE_SETTINGS:
00146$:
;src/main.c:1210: flags |= FLAG_REDRAW_CURSOR;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(#_flags),a
;src/main.c:1211: if (new_input & J_START) {
	ldhl	sp,	#2
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00163$
;src/main.c:1212: start_game();
	call	_start_game
	jr	00164$
00163$:
;src/main.c:1214: && cursor.height) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00161$
	ld	bc, #_cursor+7
	ld	a, (bc)
	or	a, a
	jr	Z, 00161$
;src/main.c:1215: cursor.height--;
	dec	a
	ld	(bc), a
	jr	00164$
00161$:
;src/main.c:1217: && cursor.height + 1u < setting_pile_heights[cursor.pile_idx]) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00159$
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
	ld	e, c
	ld	d, #0x00
	inc	de
	ld	a, (#_cursor + 6)
	add	a, #<(_setting_pile_heights)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_setting_pile_heights)
	ld	h, a
	ld	l, (hl)
	ld	b, #0x00
	ld	a, e
	sub	a, l
	ld	a, d
	sbc	a, b
	jr	NC, 00159$
;src/main.c:1218: cursor.height++;
	inc	c
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), c
	jr	00164$
00159$:
;src/main.c:1220: && cursor.pile_idx) {
	ldhl	sp,	#11
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00157$
	ld	bc, #_cursor + 6
	ld	a, (bc)
	or	a, a
	jr	Z, 00157$
;src/main.c:1221: cursor.pile_idx--;
	dec	a
	ld	(bc), a
;src/main.c:1222: cursor.height = 0;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
	jr	00164$
00157$:
;src/main.c:1224: && cursor.pile_idx < NUM_SETTING_PILES - 1u) {
	ldhl	sp,	#13
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00164$
	ld	bc, #_cursor + 6
	ld	a, (bc)
	cp	a, #0x03
	jr	NC, 00164$
;src/main.c:1225: cursor.pile_idx++;
	inc	a
	ld	(bc), a
;src/main.c:1226: cursor.height = 0;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
00164$:
;src/main.c:1228: if (new_input & J_A) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00232$
;src/main.c:1229: set_cursor_setting();
	call	_set_cursor_setting
;src/main.c:1231: break;
	jp	00232$
;src/main.c:1232: case FLAG_GAME_STATE_INGAME:
00229$:
;src/main.c:1233: if (cursor.held_card) {
	ld	hl, #_cursor
	ld	a, (hl+)
	or	a,(hl)
	jp	Z, 00227$
;src/main.c:1234: flags |= FLAG_REDRAW_HAND;
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, #0x02
	ld	(#_flags),a
;src/main.c:1236: && cursor.hand_pile_idx != 0) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00172$
	ld	bc, #_cursor+5
	ld	a, (bc)
	or	a, a
	jr	Z, 00172$
;src/main.c:1237: cursor.hand_pile_idx--;
	dec	a
	ld	(bc), a
	jr	00173$
00172$:
;src/main.c:1239: && cursor.hand_pile_idx < 9) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00173$
	ld	bc, #_cursor+5
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00173$
;src/main.c:1240: cursor.hand_pile_idx++;
	inc	a
	ld	(bc), a
00173$:
;src/main.c:1243: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00232$
	ld	a, (#_flags)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	bit	2, c
	jp	Z,00232$
;src/main.c:795: Pile *pile = IDX_PTR(piles, cursor.hand_pile_idx);
	ld	bc, #_piles+0
	ld	a, (#(_cursor + 0x0005) + 0)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#14
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, bc
	ld	c, l
	ld	b, h
;src/main.c:796: if (cursor.hand_pile_idx == cursor.pile_idx) {
	ld	hl, #_cursor + 6
	ld	e, (hl)
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00179$
;src/main.c:797: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
	jp	00232$
00179$:
;src/main.c:798: } else if (!pile->height
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00177$
;src/main.c:799: || RANK(pile->top->data) == RANK(cursor.held_card->data) + 1u) {
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	and	a, #0x0f
	ldhl	sp,	#13
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl)
	and	a, #0x0f
	ld	e, a
	ld	d, #0x00
	inc	de
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, e
	jp	NZ,00232$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jp	NZ,00232$
00177$:
;src/main.c:800: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
;src/main.c:801: score--;
	ld	hl, #_score + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	dec	de
	dec	hl
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:1244: cursor_place_stack();
	jp	00232$
00227$:
;src/main.c:1247: flags |= FLAG_REDRAW_CURSOR;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(#_flags),a
;src/main.c:1248: if (new_input & J_DOWN) {
	ldhl	sp,	#13
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00205$
;src/main.c:1249: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	hl, #_cursor + 6
	ld	c, (hl)
	ld	a, c
;src/main.c:1250: cursor.pile_idx = 0;
	sub	a,#0x0a
	jr	NZ, 00188$
	ld	(hl),a
	jr	00206$
00188$:
;src/main.c:1251: else if (cursor.height + 1u < piles[cursor.pile_idx].height)
	ld	a, (#(_cursor + 0x0007) + 0)
	ld	d, #0x00
	ld	e, a
	inc	de
	ldhl	sp,	#13
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_piles
	add	hl, de
	ld	bc, #0x0004
	add	hl, bc
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00206$
;src/main.c:1252: change_cursor_height(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_change_cursor_height
	inc	sp
	jr	00206$
00205$:
;src/main.c:1253: } else if (new_input & J_UP) {
	ldhl	sp,	#11
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00203$
;src/main.c:1254: if (cursor.height == 0)
	ld	a, (#(_cursor + 0x0007) + 0)
	or	a, a
	jr	NZ, 00192$
;src/main.c:1255: cursor.pile_idx = PILE_IDX_DECK;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x0a
	jr	00206$
00192$:
;src/main.c:1257: change_cursor_height(-1);
	ld	a, #0xff
	push	af
	inc	sp
	call	_change_cursor_height
	inc	sp
	jr	00206$
00203$:
;src/main.c:1259: && cursor.pile_idx != 0
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00201$
	ld	bc, #_cursor+6
	ld	a, (bc)
	or	a, a
	jr	Z, 00201$
;src/main.c:1260: && cursor.pile_idx != PILE_IDX_DECK) {
	cp	a, #0x0a
	jr	Z, 00201$
;src/main.c:1261: cursor.pile_idx--;
	dec	a
	ld	(bc), a
;src/main.c:1262: cursor_adjust_height();
	call	_cursor_adjust_height
	jr	00206$
00201$:
;src/main.c:1264: && cursor.pile_idx < PILE_IDX_DECK - 1u) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00206$
	ld	bc, #_cursor+6
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00206$
;src/main.c:1265: cursor.pile_idx++;
	inc	a
	ld	(bc), a
;src/main.c:1266: cursor_adjust_height();
	call	_cursor_adjust_height
00206$:
;src/main.c:1269: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00232$
	ld	a, (#_flags)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	bit	2, c
	jp	Z,00232$
;src/main.c:1270: if (cursor.pile_idx == PILE_IDX_DECK && top_card_idx != 104u)
	ld	hl, #(_cursor + 0x0006)
	ld	c, (hl)
	ld	a, c
	sub	a, #0x0a
	jp	NZ,00223$
	ld	a, (#_top_card_idx)
	sub	a, #0x68
	jp	Z,00223$
;src/main.c:985: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles
;src/main.c:988: for (i = 0; i < 10u; i++) {
	ld	e, #0x00
00268$:
;src/main.c:989: if (!pile->height)
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00232$
;src/main.c:991: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:988: for (i = 0; i < 10u; i++) {
	inc	e
	ld	a, e
	sub	a, #0x0a
	jr	C, 00268$
;src/main.c:994: pile = IDX_PTR(piles, 0);
	ldhl	sp,	#12
	ld	a, #<(_piles)
	ld	(hl+), a
	ld	(hl), #>(_piles)
;src/main.c:995: Card *deck_top = IDX_PTR(deck, top_card_idx);
	ld	hl, #_top_card_idx
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	bc,#_deck
	add	hl,bc
	ld	c, l
	ld	b, h
;src/main.c:996: top_card_idx += 10u;
	ld	hl, #_top_card_idx
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
;src/main.c:999: for (i = 0; i < 10u; i++) {
	ldhl	sp,	#14
	ld	(hl), #0x0a
00272$:
;src/main.c:1000: pile->top->next_card = deck_top;
;c
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:1001: pile->top = deck_top;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:1002: pile->height++;
;c
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	inc	a
	ld	(de), a
;src/main.c:1003: deck_top++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:1004: pile++;
;c
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl+), a
;src/main.c:999: for (i = 0; i < 10u; i++) {
	dec	(hl)
	ld	a, (hl)
	jr	NZ, 00272$
;src/main.c:1007: dynamic_metasprite_deal();
	call	_dynamic_metasprite_deal
;src/main.c:1271: deal();
	jp	00232$
00223$:
;src/main.c:769: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, #<(_piles)
	add	a, l
	ld	c, a
	ld	a, #>(_piles)
	adc	a, h
	ld	b, a
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
;src/main.c:770: Card *top = pile->base;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:771: for (i = 1; i < cursor.height; i++)
	ld	b, #0x01
00274$:
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
	ld	a, b
	sub	a, c
	jr	NC, 00215$
;src/main.c:772: top = top->next_card;
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:771: for (i = 1; i < cursor.height; i++)
	inc	b
	jr	00274$
00215$:
;src/main.c:773: Card *stack = cursor.height ? top->next_card : top;
	ld	a, c
	or	a, a
	jr	Z, 00278$
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	jr	00279$
00278$:
	ldhl	sp,#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00279$:
;src/main.c:774: if (!(VISIBLE(stack->data) && is_stack_coherent(stack)))
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	bit	6, a
	jr	Z, 00232$
	push	bc
	push	bc
	call	_is_stack_coherent
	add	sp, #2
	ld	a, e
	pop	bc
	or	a, a
	jr	Z, 00232$
;src/main.c:777: cursor.held_card = stack;
	ld	hl, #_cursor
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:778: cursor.hand_pile_idx = cursor.pile_idx;
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	(#(_cursor + 0x0005)),a
;src/main.c:779: cursor.held_stack_size = pile->height - cursor.height;
;c
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #(_cursor + 0x0007)
	ld	l, (hl)
	sub	a, l
	ld	(#(_cursor + 0x0004)),a
;src/main.c:780: pile->height = cursor.height;
	ld	a, (#(_cursor + 0x0007) + 0)
	ld	(bc), a
;src/main.c:781: flags |= FLAG_REDRAW_HAND;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x02
	ld	(hl), a
;src/main.c:782: if (cursor.height) {
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#12
	ld	(hl), a
;src/main.c:783: pile->top = top;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
;src/main.c:785: cursor.card_to_show = top;
;src/main.c:782: if (cursor.height) {
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00220$
;src/main.c:783: pile->top = top;
	inc	hl
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/main.c:784: top->next_card = NULL;
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:785: cursor.card_to_show = top;
	ld	de, #(_cursor + 0x0002)
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
	jr	00232$
00220$:
;src/main.c:787: pile->base = NULL;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:788: pile->top = NULL;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/main.c:789: cursor.card_to_show = NULL;
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:1277: }
00232$:
;src/main.c:1279: prev_input = input;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_main_prev_input_327681_450),a
;src/main.c:843: switch (flags & FLAG_GAME_STATE) {
	ld	a, (#_flags)
	and	a, #0x18
	ld	b, a
	ld	c, #0x00
	ld	a, b
	or	a, a
	or	a, c
	jp	Z,00260$
;src/main.c:847: cursor.anim_ctr++;
	ld	hl, #_cursor + 8
	ld	d, (hl)
	inc	d
	ld	(hl), d
;src/main.c:848: cursor.anim_ctr &= (1u << (CURSOR_PERIOD_LOGSCALE + 1u)) - 1u;
	res	7, d
	ld	(hl), d
;src/main.c:849: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	bc, #_cursor + 9
	ld	a, (bc)
	ld	e, a
;src/main.c:850: cursor.anim_frame = cursor.anim_ctr >> CURSOR_PERIOD_LOGSCALE;
	ld	a, d
	rlca
	rlca
	and	a, #0x03
	ld	(bc), a
;src/main.c:851: if (cursor.anim_frame != prev_anim_frame)
	sub	a, e
	jr	Z, 00237$
;src/main.c:852: flags |= FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x01
	ld	(hl), a
00237$:
;src/main.c:854: if (flags & FLAG_REDRAW_CURSOR) {
	ld	a, (#_flags)
	rrca
	jp	NC,00253$
;src/main.c:855: flags &= ~FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfe
	ld	(hl), a
;src/main.c:856: switch (flags & FLAG_GAME_STATE) {
	ld	a, (hl)
	and	a, #0x18
	ld	l, a
	ld	h, #0x00
	ld	a, l
	sub	a, #0x08
	or	a, h
	jr	Z, 00244$
;src/main.c:862: SETTINGS_PAD_Y * 8u + cursor.pile_idx * 32u
	ld	de, #_cursor + 6
;src/main.c:861: cursor.height * 16u + SETTINGS_SPLIT_X * 8u,
;src/main.c:856: switch (flags & FLAG_GAME_STATE) {
	ld	a, l
	sub	a, #0x10
	or	a, h
	jr	Z, 00250$
	ld	a, l
	sub	a, #0x18
	or	a, h
	jp	NZ,00253$
;src/main.c:862: SETTINGS_PAD_Y * 8u + cursor.pile_idx * 32u
	ld	a, (de)
	swap	a
	rlca
	and	a, #0xe0
	add	a, #0x08
	ldhl	sp,	#13
	ld	(hl), a
;src/main.c:861: cursor.height * 16u + SETTINGS_SPLIT_X * 8u,
	ld	a, (#(_cursor + 0x0007) + 0)
	swap	a
	and	a, #0xf0
	add	a, #0x50
	inc	hl
	ld	(hl), a
;src/main.c:858: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	de, #_cursor_metasprites+0
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, de
	ld	a, (hl+)
	ld	c, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), c
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x01
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	d, (hl)
	ld	e,#0x0c
	push	de
	call	___move_metasprite
	add	sp, #3
;src/main.c:864: break;
	jp	00253$
;src/main.c:865: case FLAG_GAME_STATE_LEADERBOARD:
00244$:
;src/main.c:866: if (selected_leaderboard) {
	ld	hl, #_selected_leaderboard + 1
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00253$
;src/main.c:867: set_sprite_tile(SPRITE_FRAME, OFFSET_SPRITE_CURSOR + OFFSET_CURSOR_UNDERLINE + cursor.anim_frame);
	ld	a, (bc)
	add	a, #0x09
	ld	c, a
;/home/wojtek/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0032)
	ld	(hl), c
;src/main.c:868: move_sprite(SPRITE_FRAME, (LEADERBOARD_NAME_X + 1u) * 8u + cursor.pile_idx * 8u, 16u + cursor.height * 8u);
	ld	a, (#(_cursor + 0x0007) + 0)
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x10
	ld	c, a
	ld	a, (#(_cursor + 0x0006) + 0)
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x48
	ld	e, a
;/home/wojtek/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0030)
;/home/wojtek/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), e
;src/main.c:870: break;
	jr	00253$
;src/main.c:871: case FLAG_GAME_STATE_INGAME:
00250$:
;src/main.c:872: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	a, (de)
	ldhl	sp,	#14
	ld	(hl), a
;src/main.c:849: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	a, (bc)
;src/main.c:873: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	ld	c, l
	ld	b, h
;src/main.c:872: if (cursor.pile_idx == PILE_IDX_DECK)
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x0a
	jr	NZ, 00248$
;src/main.c:873: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	hl, #_cursor_metasprites
	add	hl, bc
	ld	a, (hl+)
	ld	c, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), c
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x01
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x0c
	push	de
	call	___move_metasprite
	add	sp, #3
;src/main.c:878: );
	jr	00253$
00248$:
;src/main.c:884: (cursor.height + 3u - scroll) * 8u
	ld	a, (#(_cursor + 0x0007) + 0)
	add	a, #0x03
	ld	hl, #_scroll
	sub	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#13
;src/main.c:883: cursor.pile_idx * 16u,
	ld	(hl+), a
	ld	a, (hl)
	swap	a
	and	a, #0xf0
	ld	(hl), a
;src/main.c:880: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	hl, #_cursor_metasprites
	add	hl, bc
	ld	a, (hl+)
	ld	c, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), c
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x01
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	d, (hl)
	ld	e,#0x0c
	push	de
	call	___move_metasprite
	add	sp, #3
;src/main.c:887: }
00253$:
;src/main.c:890: if (flags & FLAG_REDRAW_HAND) {
	ld	a, (#_flags)
	bit	1, a
	jr	Z, 00260$
;src/main.c:891: flags &= ~FLAG_REDRAW_HAND;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfd
	ld	(hl), a
;src/main.c:892: if (cursor.held_card) {
	ld	hl, #_cursor
	ld	a, (hl+)
	or	a,(hl)
	jr	Z, 00256$
;src/main.c:893: UINT8 height = piles[cursor.hand_pile_idx].height;
	ld	hl, #_cursor + 5
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_piles
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	b, (hl)
;src/main.c:898: (height + !height + 2u - scroll) * 8u
	ld	a, b
	sub	a,#0x01
	ld	a, #0x00
	rla
	add	a, b
	add	a, #0x02
	ld	hl, #_scroll
	ld	b, (hl)
	sub	a, b
	add	a, a
	add	a, a
	add	a, a
	ld	d, a
;src/main.c:897: cursor.hand_pile_idx * 16u,
	ld	a, c
	swap	a
	and	a, #0xf0
	ld	b, a
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x03
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ld	e, b
	push	de
	ld	a, #0x06
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:899: );
	jr	00260$
00256$:
;src/main.c:901: metasprite_2x3_hide(SPRITE_HAND);
	ld	a, #0x06
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:1306: cursor_process();
00260$:
;src/main.c:739: if (dynamic_metasprite.elapsed_frames >= dynamic_metasprite.target_frames)
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	c, (hl)
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	b, (hl)
	ld	e, b
	ld	a,c
	ld	d,a
	sub	a, b
	bit	7, e
	jr	Z, 00712$
	bit	7, d
	jr	NZ, 00713$
	cp	a, a
	jr	00713$
00712$:
	bit	7, d
	jr	Z, 00713$
	scf
00713$:
	jp	NC, 00267$
;src/main.c:742: dynamic_metasprite.elapsed_frames++;
	inc	c
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), c
;src/main.c:747: (INT16)scroll * -8 + dynamic_metasprite.src[1] + (dynamic_metasprite.dist[1] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames)
	ld	a, (#_scroll)
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	ld	hl, #_dynamic_metasprite + 2
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#10
	ld	(hl), a
	ld	hl, #_dynamic_metasprite + 6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	rla
	sbc	a, a
	ld	b, a
	push	bc
	push	bc
	push	hl
	call	__mulint
	add	sp, #4
	push	hl
	ldhl	sp,	#17
	ld	(hl), e
	ldhl	sp,	#18
	ld	(hl), d
	pop	hl
	pop	bc
	ld	a, (#(_dynamic_metasprite + 0x0008) + 0)
	ldhl	sp,	#11
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl), a
	push	bc
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	ldhl	sp,	#10
	add	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
;src/main.c:746: dynamic_metasprite.src[0] + (dynamic_metasprite.dist[0] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames),
	ld	a, (#_dynamic_metasprite + 0)
	ldhl	sp,	#14
	ld	(hl), a
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	call	__mulint
	add	sp, #4
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	ld	a, e
	ldhl	sp,	#14
	add	a, (hl)
	ld	c, a
;src/main.c:744: dynamic_metasprite.metasprite_offset,
	ld	a, (#(_dynamic_metasprite + 0x000c) + 0)
	ld	(#___current_base_tile),a
;src/main.c:743: move_metasprite(dynamic_metasprite.metasprite,
	ld	hl, #_dynamic_metasprite + 10
	ld	a, (hl+)
	ld	b, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), b
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ldhl	sp,	#13
	ld	b, (hl)
	push	bc
	xor	a, a
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:749: if (dynamic_metasprite.elapsed_frames == dynamic_metasprite.target_frames
	ld	a, (#(_dynamic_metasprite + 0x0009) + 0)
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	c, (hl)
	sub	a, c
	jr	NZ, 00267$
;src/main.c:750: && dynamic_metasprite.callback)
	ld	hl, #_dynamic_metasprite + 19
	ld	a, (hl+)
	ld	c, a
	ld	h, (hl)
	ld	a, h
	or	a, c
	jr	Z, 00267$
;src/main.c:751: dynamic_metasprite.callback();
	ld	l, c
	call	___sdcc_call_hl
;src/main.c:1308: dynamic_metasprite_process();
00267$:
;src/main.c:1310: wait_vbl_done();
	call	_wait_vbl_done
	jp	00102$
;src/main.c:1312: }
	add	sp, #15
	ret
	.area _CODE
	.area _CABS (ABS)
