;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
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
	.globl _score
	.globl _settings
	.globl _flags
	.globl _top_card_idx
	.globl _piles
	.globl _deck
	.globl _animation_speeds
	.globl _clear_bkg_2x1
	.globl _draw_card_top
	.globl _draw_card_bottom
	.globl _draw_card
	.globl _draw_sequential_card
	.globl _clear_bkg
	.globl _draw_pile
	.globl _draw_bkg_game
	.globl _metasprite_2x3_hide
	.globl _set_metasprite_card
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
	.globl _cursor_process
	.globl _init_deck
	.globl _is_stack_coherent
	.globl _deal
	.globl _pile_append_cursor_stack
	.globl _start_game
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
_settings::
	.ds 1
_score::
	.ds 2
_dynamic_metasprite::
	.ds 21
_cursor::
	.ds 10
_input_process_prev_input_65536_296:
	.ds 1
_main_prev_input_327681_339:
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
;src/main.c:785: static UINT8 prev_input = 0;
	ld	hl, #_input_process_prev_input_65536_296
	ld	(hl), #0x00
;src/main.c:785: static UINT8 prev_input = 0;
	ld	hl, #_main_prev_input_327681_339
	ld	(hl), #0x00
;src/main.c:136: UINT8 flags = FLAG_GAME_STATE_START;
	ld	hl, #_flags
	ld	(hl), #0x00
;src/main.c:137: UINT8 settings = SETTING_FOUR_SUIT | 0b00000100;
	ld	hl, #_settings
	ld	(hl), #0x07
;src/main.c:139: UINT16 score = 500;
	ld	hl, #_score
	ld	(hl), #0xf4
	inc	hl
	ld	(hl), #0x01
;src/main.c:141: struct DynamicMetaSprite dynamic_metasprite = {
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0xff
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:146: struct Cursor cursor = {
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
;src/main.c:217: inline void clear_bkg_2x1(const UINT8 x, const UINT8 y)
;	---------------------------------
; Function clear_bkg_2x1
; ---------------------------------
_clear_bkg_2x1::
;src/main.c:219: set_bkg_tile_xy(x, y, OFFSET_BKG_NONE);
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
;src/main.c:220: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_NONE);
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
;src/main.c:221: }
	ret
_animation_speeds:
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x04	; 4
	.db #0x08	; 8
;src/main.c:223: void draw_card_top(const UINT8 x, const UINT8 y, const UINT8 card_data)
;	---------------------------------
; Function draw_card_top
; ---------------------------------
_draw_card_top::
;src/main.c:225: if (VISIBLE(card_data)) {
	ldhl	sp,	#4
;src/main.c:227: set_bkg_tile_xy(x + 1u, y, SUIT(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_SUIT);
	ld	a, (hl-)
	ld	c, a
	dec	hl
	ld	b, (hl)
	inc	b
;src/main.c:225: if (VISIBLE(card_data)) {
	bit	6, c
	jr	Z, 00102$
;src/main.c:226: set_bkg_tile_xy(x, y, RANK(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_RANK);
	ld	a, c
	and	a, #0x0f
	add	a, #0x80
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
;src/main.c:227: set_bkg_tile_xy(x + 1u, y, SUIT(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_SUIT);
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
	add	a, #0x8d
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
;src/main.c:229: set_bkg_tile_xy(x, y, OFFSET_BKG_CARD + OFFSET_CARD_BACK);
	ld	a, #0x97
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
;src/main.c:230: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_CARD + OFFSET_CARD_BACK + 1u);
	ld	a, #0x98
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
;src/main.c:232: }
	ret
;src/main.c:234: void draw_card_bottom(const UINT8 x, const UINT8 y, const UINT8 card_data)
;	---------------------------------
; Function draw_card_bottom
; ---------------------------------
_draw_card_bottom::
;src/main.c:236: set_bkg_tile_xy(x, y, OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 2u);
	ld	a, #0x93
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
;src/main.c:237: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 3u);
	ldhl	sp,	#2
	ld	c, (hl)
	inc	c
	ld	a, #0x94
	push	af
	inc	sp
	inc	hl
	ld	b, (hl)
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:238: set_bkg_tile_xy(x, y+ 1u, SUIT(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_SUIT_ROT);
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
	add	a, #0xaa
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
;src/main.c:239: set_bkg_tile_xy(x + 1u, y+ 1u, RANK(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_RANK_ROT);
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x0f
	add	a, #0x9d
	push	af
	inc	sp
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:240: }
	ret
;src/main.c:242: inline void draw_card(const UINT8 x, const UINT8 y, const UINT8 card_data)
;	---------------------------------
; Function draw_card
; ---------------------------------
_draw_card::
;src/main.c:244: draw_card_top(x, y, card_data);
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
;src/main.c:245: draw_card_bottom(x, y + 1u, card_data);
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
;src/main.c:246: }
	ret
;src/main.c:248: void draw_sequential_card(const UINT8 x, const UINT8 y, const UINT8 bkg_offset)
;	---------------------------------
; Function draw_sequential_card
; ---------------------------------
_draw_sequential_card::
;src/main.c:250: set_bkg_tile_xy(x, y, bkg_offset);
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
;src/main.c:251: set_bkg_tile_xy(x + 1u, y, bkg_offset + 1u);
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
;src/main.c:252: set_bkg_tile_xy(x, y + 1u, bkg_offset + 2u);
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
;src/main.c:253: set_bkg_tile_xy(x + 1u, y + 1u, bkg_offset + 3u);
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
;src/main.c:254: set_bkg_tile_xy(x, y + 2u, bkg_offset + 4u);
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
;src/main.c:255: set_bkg_tile_xy(x + 1u, y + 2u, bkg_offset + 5u);
	ldhl	sp,	#4
	ld	a, (hl)
	add	a, #0x05
	push	af
	inc	sp
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:256: }
	ret
;src/main.c:259: void clear_bkg(void)
;	---------------------------------
; Function clear_bkg
; ---------------------------------
_clear_bkg::
;src/main.c:262: for (x = 0; x < 32u; x++)
	ld	c, #0x00
;src/main.c:263: for (y = 0; y < 32u; y++)
00109$:
	ld	b, #0x00
00103$:
;src/main.c:264: set_bkg_tile_xy(x, y, 0);
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
;src/main.c:263: for (y = 0; y < 32u; y++)
	inc	b
	ld	a, b
	sub	a, #0x20
	jr	C, 00103$
;src/main.c:262: for (x = 0; x < 32u; x++)
	inc	c
	ld	a, c
	sub	a, #0x20
	jr	C, 00109$
;src/main.c:265: }
	ret
;src/main.c:267: void draw_pile(Card *card, UINT8 pile_idx, UINT8 height)
;	---------------------------------
; Function draw_pile
; ---------------------------------
_draw_pile::
	add	sp, #-3
;src/main.c:269: pile_idx *= 2u;
	ldhl	sp,	#7
	ld	a, (hl)
	add	a, a
;src/main.c:270: height += 3u;
	ld	(hl+), a
	inc	(hl)
	inc	(hl)
	inc	(hl)
;src/main.c:272: if (!card)
	dec	hl
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
;src/main.c:273: return;
;src/main.c:274: while (1) {
	jr	Z, 00108$
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
00106$:
;src/main.c:275: draw_card_top(pile_idx, height, card->data);
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#1
	ld	(hl+), a
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, (bc)
	push	bc
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	call	_draw_card_top
	add	sp, #3
	pop	bc
;src/main.c:276: if (!card->next_card) {
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/main.c:277: draw_card_bottom(pile_idx, height + 1u, card->data);
	ld	(hl-), a
	dec	hl
	ld	d, (hl)
	inc	d
;src/main.c:276: if (!card->next_card) {
	inc	hl
	inc	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00104$
;src/main.c:277: draw_card_bottom(pile_idx, height + 1u, card->data);
	ld	a, (bc)
	push	af
	inc	sp
	push	de
	inc	sp
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	call	_draw_card_bottom
	add	sp, #3
;src/main.c:278: break;
	jr	00108$
00104$:
;src/main.c:280: height++;
	ldhl	sp,	#0
;src/main.c:281: card = card->next_card;
	ld	a, d
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#5
	ld	(hl+), a
	ld	(hl), e
	jr	00106$
00108$:
;src/main.c:283: }
	add	sp, #3
	ret
;src/main.c:285: void draw_bkg_game(void)
;	---------------------------------
; Function draw_bkg_game
; ---------------------------------
_draw_bkg_game::
	add	sp, #-3
;src/main.c:288: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles+0
;src/main.c:289: for (i = 0; i < 10u; i++) {
	xor	a, a
	ldhl	sp,	#2
	ld	(hl), a
00102$:
;src/main.c:290: draw_pile(pile->base, i, 0);
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	push	bc
	xor	a, a
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_draw_pile
	add	sp, #4
	pop	bc
;src/main.c:291: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:289: for (i = 0; i < 10u; i++) {
	ldhl	sp,	#2
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0a
	jr	C, 00102$
;src/main.c:293: draw_sequential_card(0, 0, OFFSET_BKG_CARD + OFFSET_CARD_BACK);
	ld	a, #0x97
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
;src/main.c:294: }
	add	sp, #3
	ret
;src/main.c:300: void metasprite_2x3_hide(const UINT8 sprite)
;	---------------------------------
; Function metasprite_2x3_hide
; ---------------------------------
_metasprite_2x3_hide::
;src/main.c:307: );
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
;src/main.c:307: );
;src/main.c:308: }
	ret
;src/main.c:310: void set_metasprite_card(const UINT8 card_data)
;	---------------------------------
; Function set_metasprite_card
; ---------------------------------
_set_metasprite_card::
;src/main.c:312: metasprite_t *iter = IDX_PTR(metasprite_custom_2x3, 0);
;src/main.c:313: (iter++)->dtile = OFFSET_CARD_RANK + RANK(card_data);
	ldhl	sp,	#2
	ld	b, (hl)
	ld	a, b
	and	a, #0x0f
	ld	c, a
	ld	hl, #(_metasprite_custom_2x3 + 0x0002)
	ld	(hl), c
;src/main.c:314: (iter++)->dtile = OFFSET_CARD_SUIT + SUIT(card_data);
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
;src/main.c:315: (iter++)->dtile = OFFSET_CARD_BLANK + 2u;
	ld	hl, #(_metasprite_custom_2x3 + 0x000a)
	ld	(hl), #0x13
;src/main.c:316: (iter++)->dtile = OFFSET_CARD_BLANK + 3u;
	ld	hl, #(_metasprite_custom_2x3 + 0x000e)
	ld	(hl), #0x14
;src/main.c:317: (iter++)->dtile = OFFSET_CARD_SUIT_ROT + SUIT(card_data);
	ld	de, #(_metasprite_custom_2x3 + 0x0010) + 2
	ld	a, b
	add	a, #0x2a
	ld	(de), a
;src/main.c:318: (iter++)->dtile = OFFSET_CARD_RANK_ROT + RANK(card_data);
	ld	de, #(_metasprite_custom_2x3 + 0x0014) + 2
	ld	a, c
	add	a, #0x1d
	ld	(de), a
;src/main.c:319: }
	ret
;src/main.c:334: void dynamic_metasprite_end_animation(void)
;	---------------------------------
; Function dynamic_metasprite_end_animation
; ---------------------------------
_dynamic_metasprite_end_animation::
;src/main.c:336: metasprite_2x3_hide(SPRITE_DYNAMIC);
	xor	a, a
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:337: flags &= ~FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfb
	ld	(hl), a
;src/main.c:338: dynamic_metasprite.target_frames = -1;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0xff
;src/main.c:339: }
	ret
;src/main.c:341: void dynamic_metasprite_splash_screen_callback(void)
;	---------------------------------
; Function dynamic_metasprite_splash_screen_callback
; ---------------------------------
_dynamic_metasprite_splash_screen_callback::
	add	sp, #-14
;src/main.c:343: const UINT8 offsets[] = {
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
;src/main.c:354: draw_sequential_card(1u + dynamic_metasprite.data[0] * 2u, 2u, OFFSET_BKG_TITLE + offsets[dynamic_metasprite.data[0]]);
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	l, (hl)
	ld	a, c
	add	a, l
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	add	a, #0xb4
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
;src/main.c:355: if (dynamic_metasprite.data[0] == 8u) {
	ld	a, (#(_dynamic_metasprite + 0x000d) + 0)
	cp	a, #0x08
	jr	NZ, 00102$
;src/main.c:356: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
;src/main.c:357: return;
	jr	00103$
00102$:
;src/main.c:359: dynamic_metasprite.data[0]++;
	inc	a
	ldhl	sp,	#9
	ld	(hl), a
	ld	de, #(_dynamic_metasprite + 0x000d)
	ld	a, (hl)
	ld	(de), a
;src/main.c:360: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:361: dynamic_metasprite.dist[0] += 16;
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
;src/main.c:362: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_TITLE + offsets[dynamic_metasprite.data[0]];
	ldhl	sp,	#9
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	add	a, #0xb4
	ld	(#(_dynamic_metasprite + 0x000c)),a
00103$:
;src/main.c:363: }
	add	sp, #14
	ret
;src/main.c:365: inline void dynamic_metasprite_splash_screen(void)
;	---------------------------------
; Function dynamic_metasprite_splash_screen
; ---------------------------------
_dynamic_metasprite_splash_screen::
;src/main.c:367: dynamic_metasprite.src[0] = 72;
	ld	hl, #_dynamic_metasprite
	ld	(hl), #0x48
	inc	hl
	ld	(hl), #0x00
;src/main.c:368: dynamic_metasprite.src[1] = -24;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	(hl), #0xe8
	inc	hl
	ld	(hl), #0xff
;src/main.c:369: dynamic_metasprite.dist[0] = -64;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	(hl), #0xc0
	inc	hl
	ld	(hl), #0xff
;src/main.c:370: dynamic_metasprite.dist[1] = 40;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	(hl), #0x28
	inc	hl
	ld	(hl), #0x00
;src/main.c:371: dynamic_metasprite.target_frames = TARGET_FRAMES_SPLASH_SCREEN;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0x20
;src/main.c:372: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:373: dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;src/main.c:374: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_TITLE + OFFSET_TITLE_S;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #0xb4
;src/main.c:375: dynamic_metasprite.data[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), #0x00
;src/main.c:376: dynamic_metasprite.callback = &dynamic_metasprite_splash_screen_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_splash_screen_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_splash_screen_callback)
;src/main.c:377: flags |= FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x04
	ld	(hl), a
;src/main.c:378: }
	ret
;src/main.c:380: void dynamic_metasprite_fold_pile(void)
;	---------------------------------
; Function dynamic_metasprite_fold_pile
; ---------------------------------
_dynamic_metasprite_fold_pile::
	add	sp, #-12
;src/main.c:382: UINT8 pile_idx = dynamic_metasprite.data[3] & 0xF;
	ld	a, (#(_dynamic_metasprite + 0x0010) + 0)
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	and	a, #0x0f
	dec	hl
;src/main.c:383: if (!pile_idx) {
	ld	(hl), a
	or	a, a
	jr	NZ, 00102$
;src/main.c:384: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
;src/main.c:385: return;
	jp	00103$
00102$:
;src/main.c:388: Pile *pile = IDX_PTR(piles, pile_idx);
	ldhl	sp,	#10
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
;c
	ld	de, #_piles
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), e
;src/main.c:389: UINT8 x = pile_idx * 16u;
	ldhl	sp,	#10
	ld	a, (hl)
	swap	a
	and	a, #0xf0
	ldhl	sp,	#4
	ld	(hl), a
;src/main.c:398: dynamic_metasprite.data[3] >> 4u
	ldhl	sp,	#11
	ld	a, (hl)
	swap	a
	and	a, #0x0f
	ldhl	sp,	#5
;src/main.c:396: pile->base,
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:390: dynamic_metasprite_fold(pile->top->data,
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;c
	pop	de
	push	de
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
	ld	(hl), a
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
	ld	d, (hl)
	ld	e,#0x78
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#20
	ld	a, (hl)
	push	af
	inc	sp
	call	_dynamic_metasprite_fold
	add	sp, #10
;src/main.c:400: pile->base = NULL;
	pop	bc
	pop	hl
	push	hl
	push	bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:401: pile->top = NULL;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:402: pile->height = 0;
;c
	ldhl	sp,#2
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
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/main.c:403: cursor_adjust_height();
	call	_cursor_adjust_height
00103$:
;src/main.c:404: }
	add	sp, #12
	ret
;src/main.c:406: void dynamic_metasprite_unfold_callback(void)
;	---------------------------------
; Function dynamic_metasprite_unfold_callback
; ---------------------------------
_dynamic_metasprite_unfold_callback::
	add	sp, #-4
;src/main.c:408: Card const *card = dynamic_metasprite.data_ptr;
	ld	hl, #(_dynamic_metasprite + 0x0011)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:409: if (!card->next_card) {
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:410: draw_card(dynamic_metasprite.data[1] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 1u, card->data);
	inc	bc
	inc	bc
	inc	hl
	ld	a, c
	ld	(hl+), a
;src/main.c:409: if (!card->next_card) {
	ld	a, b
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
;src/main.c:410: draw_card(dynamic_metasprite.data[1] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 1u, card->data);
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
;src/main.c:244: draw_card_top(x, y, card_data);
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
;src/main.c:245: draw_card_bottom(x, y + 1u, card_data);
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
;src/main.c:411: dynamic_metasprite_fold_pile();
	call	_dynamic_metasprite_fold_pile
;src/main.c:412: return;
	jr	00104$
00102$:
;src/main.c:414: dynamic_metasprite.data_ptr = card->next_card;
	pop	bc
	push	bc
	ld	hl, #(_dynamic_metasprite + 0x0011)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:415: dynamic_metasprite.src[1] += 8;
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
;src/main.c:416: draw_card_top(dynamic_metasprite.data[1] / 8u, dynamic_metasprite.src[1] / 8u, card->data);
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
;src/main.c:417: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
00104$:
;src/main.c:418: }
	add	sp, #4
	ret
;src/main.c:420: void dynamic_metasprite_move_stack_callback(void)
;	---------------------------------
; Function dynamic_metasprite_move_stack_callback
; ---------------------------------
_dynamic_metasprite_move_stack_callback::
;src/main.c:422: if (dynamic_metasprite.data[0] & BITMASK_DYNAMIC_METASPRITE_UNFOLD) {
	ld	a, (#(_dynamic_metasprite + 0x000d) + 0)
	rlca
	jp	NC,_dynamic_metasprite_fold_pile
;src/main.c:423: dynamic_metasprite.src[0] = dynamic_metasprite.data[1];
	ld	a, (#(_dynamic_metasprite + 0x000e) + 0)
	ld	c, a
	ld	b, #0x00
	ld	hl, #_dynamic_metasprite
	ld	a, c
	ld	(hl+), a
;src/main.c:424: dynamic_metasprite.src[1] = dynamic_metasprite.data[2] - 8u;
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
;src/main.c:425: dynamic_metasprite.dist[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:426: dynamic_metasprite.dist[1] = 8;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	a, #0x08
	ld	(hl+), a
	ld	(hl), #0x00
;src/main.c:427: dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].fold_target_frames;
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
;src/main.c:428: dynamic_metasprite.callback = &dynamic_metasprite_unfold_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_unfold_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_unfold_callback)
;src/main.c:429: dynamic_metasprite_unfold_callback();
;src/main.c:431: dynamic_metasprite_fold_pile();
;src/main.c:433: }
	jp	_dynamic_metasprite_unfold_callback
;src/main.c:435: void dynamic_metasprite_fold_callback(void)
;	---------------------------------
; Function dynamic_metasprite_fold_callback
; ---------------------------------
_dynamic_metasprite_fold_callback::
	add	sp, #-4
;src/main.c:437: dynamic_metasprite.src[1] -= 8;
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
;src/main.c:438: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:439: clear_bkg_2x1((UINT8)dynamic_metasprite.src[0] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 2u);
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
;src/main.c:219: set_bkg_tile_xy(x, y, OFFSET_BKG_NONE);
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
;src/main.c:220: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_NONE);
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
;src/main.c:440: if (dynamic_metasprite.data[0] & ~BITMASK_DYNAMIC_METASPRITE_UNFOLD) {
	ld	bc, #_dynamic_metasprite + 13
	ld	a, (bc)
	ld	e, a
	and	a, #0x7f
	jr	Z, 00105$
;src/main.c:441: dynamic_metasprite.data[0]--;
	ld	a, e
	dec	a
	ld	(bc), a
	jp	00109$
00105$:
;src/main.c:443: if (cursor.card_to_show) {
	ld	hl, #(_cursor + 0x0002)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:439: clear_bkg_2x1((UINT8)dynamic_metasprite.src[0] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 2u);
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
;src/main.c:444: draw_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u - 1u, cursor.card_to_show->data);
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
;src/main.c:443: if (cursor.card_to_show) {
	ld	a, b
	or	a, c
	jr	Z, 00102$
;src/main.c:444: draw_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u - 1u, cursor.card_to_show->data);
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	b, a
	ld	d, l
	dec	d
;src/main.c:244: draw_card_top(x, y, card_data);
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
;src/main.c:245: draw_card_bottom(x, y + 1u, card_data);
	ld	a, d
	inc	a
	push	bc
	inc	sp
	ld	d,a
	push	de
	call	_draw_card_bottom
	add	sp, #3
;src/main.c:445: cursor.card_to_show = NULL;
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00103$
00102$:
;src/main.c:447: draw_sequential_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u, OFFSET_BKG_CARD + OFFSET_CARD_OUTLINE);
	ld	a, #0xae
	push	af
	ld	a, l
	inc	sp
	ld	d,a
	push	de
	call	_draw_sequential_card
	add	sp, #3
00103$:
;src/main.c:449: dynamic_metasprite.dist[0] = (INT16)dynamic_metasprite.data[1] - dynamic_metasprite.src[0];
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
;src/main.c:450: dynamic_metasprite.dist[1] = (INT16)dynamic_metasprite.data[2] - dynamic_metasprite.src[1];
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
;src/main.c:451: dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].move_target_frames;
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
;src/main.c:452: dynamic_metasprite.callback = &dynamic_metasprite_move_stack_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_move_stack_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_move_stack_callback)
00109$:
;src/main.c:455: }
	add	sp, #4
	ret
;src/main.c:457: void dynamic_metasprite_fold(const UINT8 top_card_data, const UINT8 src_x, const UINT8 src_y, const UINT8 dest_x, const UINT8 dest_y, const UINT8 stack_height, const Card *base_card, const UINT8 unfold, const UINT8 piles_to_clear)
;	---------------------------------
; Function dynamic_metasprite_fold
; ---------------------------------
_dynamic_metasprite_fold::
;src/main.c:459: set_metasprite_card(top_card_data);
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_metasprite_card
	inc	sp
;src/main.c:461: dynamic_metasprite.metasprite = metasprite_custom_2x3;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #<(_metasprite_custom_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_custom_2x3)
;src/main.c:462: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_CARD;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #0x80
;src/main.c:464: dynamic_metasprite.data[0] = (stack_height - 1u) | unfold;
	ld	bc, #_dynamic_metasprite + 13
	ldhl	sp,	#7
	ld	a, (hl)
	dec	a
	ldhl	sp,	#10
	or	a, (hl)
	ld	(bc), a
;src/main.c:465: dynamic_metasprite.data[1] = dest_x;
	ld	de, #(_dynamic_metasprite + 0x000e)
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;src/main.c:466: dynamic_metasprite.data[2] = dest_y;
	ld	de, #(_dynamic_metasprite + 0x000f)
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:467: dynamic_metasprite.data[3] = piles_to_clear;
	ld	de, #(_dynamic_metasprite + 0x0010)
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(de), a
;src/main.c:468: dynamic_metasprite.data_ptr = base_card;
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
;src/main.c:470: dynamic_metasprite.src[0] = src_x;
	ldhl	sp,	#3
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #_dynamic_metasprite
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:471: dynamic_metasprite.src[1] = src_y + 8u;
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
;src/main.c:473: flags |= FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x04
	ld	(hl), a
;src/main.c:475: if (stack_height > 1) {
	ld	a, #0x01
	ldhl	sp,	#7
	sub	a, (hl)
	jp	NC,_dynamic_metasprite_fold_callback
;src/main.c:476: dynamic_metasprite.dist[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:477: dynamic_metasprite.dist[1] = -8;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	a, #0xf8
	ld	(hl+), a
	ld	(hl), #0xff
;src/main.c:478: dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].fold_target_frames;
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
;src/main.c:479: dynamic_metasprite.callback = &dynamic_metasprite_fold_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_fold_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_fold_callback)
;src/main.c:481: dynamic_metasprite_fold_callback();
;src/main.c:482: }
	jp  _dynamic_metasprite_fold_callback
;src/main.c:484: void dynamic_metasprite_deal_callback(void)
;	---------------------------------
; Function dynamic_metasprite_deal_callback
; ---------------------------------
_dynamic_metasprite_deal_callback::
	add	sp, #-4
;src/main.c:486: Pile *pile = IDX_PTR(piles, dynamic_metasprite.data[0]);
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
;src/main.c:487: draw_card(dynamic_metasprite.data[0] * 2u, 2u + pile->height, pile->top->data);
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
;src/main.c:244: draw_card_top(x, y, card_data);
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
;src/main.c:245: draw_card_bottom(x, y + 1u, card_data);
	inc	d
	push	bc
	inc	sp
	ld	e, c
	push	de
	call	_draw_card_bottom
	add	sp, #3
;src/main.c:488: if (dynamic_metasprite.data[0] == 9u) {
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	c, (hl)
	ld	a, c
	sub	a, #0x09
	jr	NZ, 00104$
;src/main.c:489: if (top_card_idx == 104u)
	ld	a, (#_top_card_idx)
	sub	a, #0x68
	jr	NZ, 00102$
;src/main.c:490: draw_sequential_card(0, 0, OFFSET_BKG_CARD + OFFSET_CARD_OUTLINE);
	ld	a, #0xae
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
;src/main.c:491: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
;src/main.c:492: return;
	jr	00106$
00104$:
;src/main.c:494: pile++;
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
;src/main.c:495: dynamic_metasprite.data[0]++;
	inc	c
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), c
;src/main.c:496: dynamic_metasprite.dist[0] += 16;
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
;src/main.c:497: dynamic_metasprite.dist[1] = (INT16)(2u + pile->height) * 8;
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
;src/main.c:498: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
00106$:
;src/main.c:499: }
	add	sp, #4
	ret
;src/main.c:501: void dynamic_metasprite_deal(void)
;	---------------------------------
; Function dynamic_metasprite_deal
; ---------------------------------
_dynamic_metasprite_deal::
;src/main.c:503: Pile *pile = IDX_PTR(piles, 0);
;src/main.c:504: dynamic_metasprite.src[0] = 0;
	ld	hl, #_dynamic_metasprite
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:505: dynamic_metasprite.src[1] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:506: dynamic_metasprite.dist[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:507: dynamic_metasprite.dist[1] = (INT16)(2u + pile->height) * 8;
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
;src/main.c:508: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:509: dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].move_target_frames;
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
;src/main.c:510: dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;src/main.c:511: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_CARD + OFFSET_CARD_BACK;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #0x97
;src/main.c:512: dynamic_metasprite.data[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), #0x00
;src/main.c:513: dynamic_metasprite.callback = &dynamic_metasprite_deal_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_deal_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_deal_callback)
;src/main.c:514: flags |= FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x04
	ld	(hl), a
;src/main.c:515: }
	ret
;src/main.c:517: inline void dynamic_metasprite_process(void)
;	---------------------------------
; Function dynamic_metasprite_process
; ---------------------------------
_dynamic_metasprite_process::
	add	sp, #-5
;src/main.c:519: if (dynamic_metasprite.elapsed_frames >= dynamic_metasprite.target_frames)
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
;src/main.c:520: return;
	jp	NC,00107$
;src/main.c:522: dynamic_metasprite.elapsed_frames++;
	inc	c
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), c
;src/main.c:527: dynamic_metasprite.src[1] + (dynamic_metasprite.dist[1] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames)
	ld	a, (#(_dynamic_metasprite + 0x0002) + 0)
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
;src/main.c:526: dynamic_metasprite.src[0] + (dynamic_metasprite.dist[0] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames),
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
;src/main.c:524: dynamic_metasprite.metasprite_offset,
	ld	a, (#(_dynamic_metasprite + 0x000c) + 0)
	ld	(#___current_base_tile),a
;src/main.c:523: move_metasprite(dynamic_metasprite.metasprite,
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
;src/main.c:529: if (dynamic_metasprite.elapsed_frames == dynamic_metasprite.target_frames
	ld	a, (#(_dynamic_metasprite + 0x0009) + 0)
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	c, (hl)
	sub	a, c
	jr	NZ, 00107$
;src/main.c:530: && dynamic_metasprite.callback)
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	a, (hl+)
	ld	c, a
	ld	h, (hl)
	ld	a, h
	or	a, c
	jr	Z, 00107$
;src/main.c:531: dynamic_metasprite.callback();
	ld	l, c
	call	___sdcc_call_hl
00107$:
;src/main.c:532: }
	add	sp, #5
	ret
;src/main.c:539: void cursor_adjust_height(void)
;	---------------------------------
; Function cursor_adjust_height
; ---------------------------------
_cursor_adjust_height::
;src/main.c:541: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
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
;src/main.c:542: if (cursor.height >= pile->height)
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
;src/main.c:543: cursor.height = pile->height - !!pile->height;
	ld	a, e
	sub	a,#0x01
	ld	a, #0x00
	rla
	xor	a, #0x01
	ld	d, a
	ld	a, e
	sub	a, d
	ld	(bc), a
;src/main.c:544: }
	ret
;src/main.c:546: inline void cursor_grab_stack(void)
;	---------------------------------
; Function cursor_grab_stack
; ---------------------------------
_cursor_grab_stack::
	add	sp, #-7
;src/main.c:549: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
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
;src/main.c:550: Card *top = pile->base;
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
;src/main.c:551: for (i = 1; i < cursor.height; i++)
	ld	b, #0x01
00109$:
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
	ld	a, b
	sub	a, c
	jr	NC, 00101$
;src/main.c:552: top = top->next_card;
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
;src/main.c:551: for (i = 1; i < cursor.height; i++)
	inc	b
	jr	00109$
00101$:
;src/main.c:553: Card *stack = cursor.height ? top->next_card : top;
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
;src/main.c:554: if (!(VISIBLE(stack->data) && is_stack_coherent(stack)))
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
;src/main.c:555: return;
	jr	Z, 00111$
;src/main.c:557: cursor.held_card = stack;
	ld	hl, #_cursor
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:558: cursor.hand_pile_idx = cursor.pile_idx;
	ld	bc, #_cursor + 5
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	(bc), a
;src/main.c:559: cursor.held_stack_size = pile->height - cursor.height;
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
;src/main.c:560: pile->height = cursor.height;
	ld	a, (#(_cursor + 0x0007) + 0)
	ld	(bc), a
;src/main.c:561: if (cursor.height) {
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#4
	ld	(hl), a
;src/main.c:562: pile->top = top;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
;src/main.c:564: cursor.card_to_show = top;
;src/main.c:561: if (cursor.height) {
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
;src/main.c:562: pile->top = top;
	inc	hl
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/main.c:563: top->next_card = NULL;
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:564: cursor.card_to_show = top;
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
;src/main.c:566: pile->base = NULL;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:567: pile->top = NULL;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/main.c:568: cursor.card_to_show = NULL;
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00111$:
;src/main.c:570: }
	add	sp, #7
	ret
;src/main.c:572: inline void cursor_place_stack(void)
;	---------------------------------
; Function cursor_place_stack
; ---------------------------------
_cursor_place_stack::
	add	sp, #-2
;src/main.c:574: Pile *pile = IDX_PTR(piles, cursor.hand_pile_idx);
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
;src/main.c:575: if (cursor.hand_pile_idx == cursor.pile_idx) {
	ld	hl, #_cursor + 6
	ld	e, (hl)
	ldhl	sp,	#1
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00105$
;src/main.c:576: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
	jr	00107$
00105$:
;src/main.c:577: } else if (!pile->height
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00101$
;src/main.c:578: || RANK(pile->top->data) == RANK(cursor.held_card->data) + 1u) {
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
;src/main.c:579: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
;src/main.c:580: score--;
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
;src/main.c:582: }
	add	sp, #2
	ret
;src/main.c:584: inline void cursor_process(void)
;	---------------------------------
; Function cursor_process
; ---------------------------------
_cursor_process::
;src/main.c:586: cursor.anim_ctr++;
	ld	hl, #_cursor + 8
	ld	b, (hl)
	inc	b
	ld	(hl), b
;src/main.c:587: cursor.anim_ctr &= (1u << (CURSOR_PERIOD_LOGSCALE + 1u)) - 1u;
	res	7, b
	ld	(hl), b
;src/main.c:588: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	de, #_cursor + 9
	ld	a, (de)
	ld	c, a
;src/main.c:589: cursor.anim_frame = cursor.anim_ctr >> CURSOR_PERIOD_LOGSCALE;
	ld	a, b
	rlca
	rlca
	and	a, #0x03
	ld	(de), a
;src/main.c:590: if (cursor.anim_frame != prev_anim_frame)
	sub	a, c
	jr	Z, 00102$
;src/main.c:591: flags |= FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x01
	ld	(hl), a
00102$:
;src/main.c:593: if (flags & FLAG_REDRAW_CURSOR) {
	ld	a, (#_flags)
	rrca
	jr	NC, 00107$
;src/main.c:594: flags &= ~FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfe
	ld	(hl), a
;src/main.c:595: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	hl, #_cursor + 6
	ld	c, (hl)
;src/main.c:588: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	a, (de)
;src/main.c:596: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	ld	e, l
	ld	d, h
;src/main.c:595: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	a, c
	sub	a, #0x0a
	jr	NZ, 00104$
;src/main.c:596: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	hl, #_cursor_metasprites
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
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x22
	push	de
	call	___move_metasprite
	add	sp, #3
;src/main.c:601: );
	jr	00107$
00104$:
;src/main.c:607: (cursor.height + 3u) * 8u
	ld	a, (#_cursor + 7)
	add	a, #0x03
	add	a, a
	add	a, a
	add	a, a
	ld	b, a
;src/main.c:606: cursor.pile_idx * 16u,
	ld	a, c
	swap	a
	and	a, #0xf0
	ld	c, a
;src/main.c:603: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	hl, #_cursor_metasprites
	add	hl, de
	ld	a, (hl+)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	e, (hl)
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), e
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x01
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	push	bc
	inc	sp
	ld	d, c
	ld	e,#0x22
	push	de
	call	___move_metasprite
	add	sp, #3
;src/main.c:608: );
00107$:
;src/main.c:610: if (flags & FLAG_REDRAW_HAND) {
	ld	a, (#_flags)
	bit	1, a
	ret	Z
;src/main.c:611: flags &= ~FLAG_REDRAW_HAND;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfd
	ld	(hl), a
;src/main.c:612: if (cursor.held_card) {
	ld	hl, #_cursor
	ld	a, (hl+)
	or	a,(hl)
	jr	Z, 00109$
;src/main.c:613: UINT8 height = piles[cursor.hand_pile_idx].height;
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
;src/main.c:618: (height + !height + 2u) * 8u
	ld	a, b
	sub	a,#0x01
	ld	a, #0x00
	rla
	add	a, b
	add	a, #0x02
	add	a, a
	add	a, a
	add	a, a
	ld	d, a
;src/main.c:617: cursor.hand_pile_idx * 16u,
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
	ld	a, #0x1c
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:619: );
	ret
00109$:
;src/main.c:621: metasprite_2x3_hide(SPRITE_HAND);
	ld	a, #0x1c
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:624: }
	ret
;src/main.c:630: void init_deck(void)
;	---------------------------------
; Function init_deck
; ---------------------------------
_init_deck::
	add	sp, #-16
;src/main.c:632: Card *card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:639: for (suit = 0; suit < 4u; suit++) {
	xor	a, a
	ldhl	sp,	#11
	ld	(hl), a
;src/main.c:640: for (rank = 0; rank < 13u; rank++) {
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
;src/main.c:641: for (i = 0; i < 2u; i++) {
00129$:
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#7
	or	a, (hl)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	(hl), #0x02
00113$:
;src/main.c:642: card->data = rank | (suit << BIT_OFFSET_CARD_SUIT);
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
;src/main.c:643: card++;
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
	ld	(hl+), a
;src/main.c:641: for (i = 0; i < 2u; i++) {
	dec	(hl)
	jr	NZ, 00113$
;src/main.c:640: for (rank = 0; rank < 13u; rank++) {
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	dec	hl
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0d
	jr	C, 00129$
;src/main.c:639: for (suit = 0; suit < 4u; suit++) {
	dec	hl
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00131$
;src/main.c:649: card = IDX_PTR(deck, 103u);
	inc	hl
	inc	hl
	ld	a, #<((_deck + 0x0135))
	ld	(hl+), a
	ld	(hl), #>((_deck + 0x0135))
;src/main.c:650: for (i = 103u; i; i--) {
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
;src/main.c:651: Card *swap = IDX_PTR(deck, (UINT8)rand() % i);
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
;src/main.c:653: temp = *card;
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
;src/main.c:654: *card = *swap;
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
;src/main.c:655: *swap = temp;
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
;src/main.c:656: card--;
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
;src/main.c:650: for (i = 103u; i; i--) {
	ld	a, e
	ld	(hl+), a
	inc	hl
	dec	(hl)
	jr	NZ, 00118$
;src/main.c:660: card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:661: for (i = 0; i < 44u; i++) {
	xor	a, a
	ld	(hl), a
00120$:
;src/main.c:662: card->next_card = IDX_PTR(deck, i + 10u);
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
;src/main.c:663: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:661: for (i = 0; i < 44u; i++) {
	ldhl	sp,	#15
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x2c
	jr	C, 00120$
	ld	e, (hl)
00123$:
;src/main.c:665: for (; i < 104u; i++) {
	ld	a, e
	sub	a, #0x68
	jr	NC, 00106$
;src/main.c:666: card->data |= BITMASK_CARD_VISIBLE;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	set	6, (hl)
;src/main.c:667: card->next_card = NULL;
	ld	l, c
	ld	h, b
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:668: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:665: for (; i < 104u; i++) {
	inc	e
	jr	00123$
00106$:
;src/main.c:671: card = IDX_PTR(deck, 0);
	ldhl	sp,	#11
	ld	a, #<(_deck)
	ld	(hl+), a
;src/main.c:672: Pile *pile = IDX_PTR(piles, 0);
	ld	a, #>(_deck)
	ld	(hl+), a
	ld	a, #<(_piles)
	ld	(hl+), a
	ld	(hl), #>(_piles)
;src/main.c:673: for (i = 0; i < 10; i++) {
	xor	a, a
	inc	hl
	ld	(hl), a
00125$:
;src/main.c:674: pile->base = card;
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
;src/main.c:676: pile->top = IDX_PTR(deck, 50u + i);
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
;src/main.c:677: pile->height = 6u;
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
;src/main.c:675: if (i < 4u) {
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00108$
;src/main.c:676: pile->top = IDX_PTR(deck, 50u + i);
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
;src/main.c:677: pile->height = 6u;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x06
	jr	00109$
00108$:
;src/main.c:679: pile->top = IDX_PTR(deck, 40u + i);
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
;src/main.c:680: pile->height = 5u;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x05
00109$:
;src/main.c:683: card++;
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
;src/main.c:684: pile++;
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
;src/main.c:673: for (i = 0; i < 10; i++) {
	ld	(hl+), a
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0a
	jp	C, 00125$
;src/main.c:687: top_card_idx = 54u;
	ld	hl, #_top_card_idx
	ld	(hl), #0x36
;src/main.c:688: }
	add	sp, #16
	ret
;src/main.c:690: UINT8 is_stack_coherent(Card *card)
;	---------------------------------
; Function is_stack_coherent
; ---------------------------------
_is_stack_coherent::
	add	sp, #-2
;src/main.c:692: while (card->next_card) {
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
;src/main.c:693: UINT8 prev_data = card->data;
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	c, (hl)
;src/main.c:694: card = card->next_card;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
;src/main.c:695: if (prev_data != card->data + 1u)
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
;src/main.c:696: return 0u;
	ld	e, #0x00
	jr	00106$
00105$:
;src/main.c:698: return 1u;
	ld	e, #0x01
00106$:
;src/main.c:699: }
	add	sp, #2
	ret
;src/main.c:701: inline void deal(void)
;	---------------------------------
; Function deal
; ---------------------------------
_deal::
	add	sp, #-5
;src/main.c:704: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles
;src/main.c:707: for (i = 0; i < 10u; i++) {
	ld	e, #0x00
00105$:
;src/main.c:708: if (!pile->height)
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
;src/main.c:709: return;
	jr	Z, 00110$
;src/main.c:710: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:707: for (i = 0; i < 10u; i++) {
	inc	e
	ld	a, e
	sub	a, #0x0a
	jr	C, 00105$
;src/main.c:713: pile = IDX_PTR(piles, 0);
	ldhl	sp,	#2
	ld	a, #<(_piles)
	ld	(hl+), a
	ld	(hl), #>(_piles)
;src/main.c:714: Card *deck_top = IDX_PTR(deck, top_card_idx);
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
;src/main.c:715: top_card_idx += 10u;
	ld	hl, #_top_card_idx
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
;src/main.c:718: for (i = 0; i < 10u; i++) {
	ldhl	sp,	#4
	ld	(hl), #0x0a
00109$:
;src/main.c:719: pile->top->next_card = deck_top;
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
;src/main.c:720: pile->top = deck_top;
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:721: pile->height++;
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
;src/main.c:722: deck_top++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:723: pile++;
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
;src/main.c:718: for (i = 0; i < 10u; i++) {
	dec	(hl)
	jr	NZ, 00109$
;src/main.c:726: dynamic_metasprite_deal();
	call	_dynamic_metasprite_deal
00110$:
;src/main.c:727: }
	add	sp, #5
	ret
;src/main.c:729: void pile_append_cursor_stack(Pile *pile)
;	---------------------------------
; Function pile_append_cursor_stack
; ---------------------------------
_pile_append_cursor_stack::
	add	sp, #-13
;src/main.c:731: if (pile->height)
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
;src/main.c:732: pile->top->next_card = cursor.held_card;
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
;src/main.c:731: if (pile->height)
	ldhl	sp,	#12
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;src/main.c:732: pile->top->next_card = cursor.held_card;
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
;src/main.c:734: pile->base = cursor.held_card;
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
;src/main.c:736: Pile *src_pile = IDX_PTR(piles, cursor.pile_idx);
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
;src/main.c:737: Card *top_card = cursor.held_card;
	ld	de, #_cursor
	ld	a, (de)
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:738: while (top_card->next_card)
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
;src/main.c:739: top_card = top_card->next_card;
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), e
	jr	00104$
00106$:
;src/main.c:740: pile->top = top_card;
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
;src/main.c:741: cursor.height = pile->height - !!pile->height;
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
;src/main.c:742: pile->height += cursor.held_stack_size;
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
;src/main.c:743: if (cursor.hand_pile_idx != cursor.pile_idx) {
	ld	a, (#(_cursor + 0x0005) + 0)
	ld	hl, #(_cursor + 0x0006)
	ld	c, (hl)
	sub	a, c
	jp	Z,00116$
;src/main.c:744: UINT8 piles_to_clear = 0;
	xor	a, a
	ldhl	sp,	#12
	ld	(hl), a
;src/main.c:745: if (src_pile->height == 13u && is_stack_coherent(src_pile->base)) {
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
;src/main.c:746: piles_to_clear = cursor.pile_idx;
	ld	a, (#(_cursor + 0x0006) + 0)
	ldhl	sp,	#12
	ld	(hl), a
00108$:
;src/main.c:748: if (pile->height == 13u && is_stack_coherent(pile->base)) {
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
;src/main.c:749: cursor.height = 0;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), #0x00
;src/main.c:743: if (cursor.hand_pile_idx != cursor.pile_idx) {
	ld	a, (#(_cursor + 0x0005) + 0)
	ldhl	sp,	#7
	ld	(hl), a
;src/main.c:750: piles_to_clear |= piles_to_clear ? cursor.hand_pile_idx << 4u : cursor.hand_pile_idx;
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
;src/main.c:753: if (cursor.card_to_show)
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
;src/main.c:754: cursor.card_to_show->data |= BITMASK_CARD_VISIBLE;
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	set	6, (hl)
00114$:
;src/main.c:760: cursor.held_card,
	ld	de, #_cursor
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:759: cursor.held_stack_size,
	ld	hl, #(_cursor + 0x0004)
	ld	c, (hl)
;src/main.c:758: (pile->height + 3u - cursor.held_stack_size) * 8u,
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
;src/main.c:757: (src_pile->height + 2u + cursor.held_stack_size) * 8u, cursor.hand_pile_idx * 16u,
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
;src/main.c:756: cursor.pile_idx * 16u,
	ld	a, (#(_cursor + 0x0006) + 0)
	swap	a
	and	a, #0xf0
;src/main.c:755: dynamic_metasprite_fold(top_card->data,
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
;src/main.c:766: cursor.held_card = NULL;
	ld	hl, #_cursor
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:767: cursor.pile_idx = cursor.hand_pile_idx;
	ld	a, (#(_cursor + 0x0005) + 0)
	ld	(#(_cursor + 0x0006)),a
;src/main.c:768: flags |= FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x01
	ld	(hl), a
;src/main.c:769: }
	add	sp, #13
	ret
;src/main.c:775: inline void start_game(void)
;	---------------------------------
; Function start_game
; ---------------------------------
_start_game::
;src/main.c:777: initrand(DIV_REG);
	ldh	a, (_DIV_REG+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	call	_initrand
	add	sp, #2
;src/main.c:778: init_deck();
	call	_init_deck
;src/main.c:779: clear_bkg();
	call	_clear_bkg
;src/main.c:780: draw_bkg_game();
;src/main.c:781: }
	jp  _draw_bkg_game
;src/main.c:783: inline void input_process(void)
;	---------------------------------
; Function input_process
; ---------------------------------
_input_process::
	add	sp, #-8
;src/main.c:786: UINT8 input = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), e
;src/main.c:787: UINT8 new_input = input & ~prev_input;
	ld	a, (#_input_process_prev_input_65536_296)
	cpl
	ldhl	sp,	#0
	and	a, (hl)
	inc	hl
	ld	(hl), a
;src/main.c:788: switch (flags & FLAG_GAME_STATE) {
	ld	a, (#_flags)
	and	a, #0x18
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	inc	hl
	or	a, (hl)
	jr	Z, 00101$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x10
	inc	hl
	or	a, (hl)
	jr	Z, 00106$
	jp	00149$
;src/main.c:789: case FLAG_GAME_STATE_START:
00101$:
;src/main.c:790: if (new_input) {
	ldhl	sp,	#1
	ld	a, (hl)
	or	a, a
	jp	Z, 00149$
;src/main.c:791: flags &= ~FLAG_GAME_STATE;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xe7
	ld	(hl), a
;src/main.c:792: flags |= FLAG_GAME_STATE_INGAME;
	ld	a, (hl)
	or	a, #0x10
	ld	(hl), a
;src/main.c:793: if (flags & FLAG_PLAYING_ANIMATION)
	bit	2, (hl)
	jr	Z, 00103$
;src/main.c:794: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
00103$:
;src/main.c:777: initrand(DIV_REG);
	ldh	a, (_DIV_REG+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	call	_initrand
	add	sp, #2
;src/main.c:778: init_deck();
	call	_init_deck
;src/main.c:779: clear_bkg();
	call	_clear_bkg
;src/main.c:780: draw_bkg_game();
	call	_draw_bkg_game
;src/main.c:797: break;
	jp	00149$
;src/main.c:798: case FLAG_GAME_STATE_INGAME:
00106$:
;src/main.c:799: if (cursor.held_card) {
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:792: flags |= FLAG_GAME_STATE_INGAME;
	ld	hl, #_flags
	ld	e, (hl)
;src/main.c:802: && cursor.hand_pile_idx != 0) {
	ldhl	sp,	#1
	ld	a, (hl)
	and	a, #0x02
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
;src/main.c:805: && cursor.hand_pile_idx < 9) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	and	a, #0x01
	ldhl	sp,	#4
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:809: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#1
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:799: if (cursor.held_card) {
	ld	a, b
	or	a, c
	jp	Z, 00147$
;src/main.c:800: flags |= FLAG_REDRAW_HAND;
	ld	a, e
	or	a, #0x02
	ld	(#_flags),a
;src/main.c:802: && cursor.hand_pile_idx != 0) {
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00111$
	ld	bc, #_cursor+5
	ld	a, (bc)
	or	a, a
	jr	Z, 00111$
;src/main.c:803: cursor.hand_pile_idx--;
	dec	a
	ld	(bc), a
	jr	00112$
00111$:
;src/main.c:805: && cursor.hand_pile_idx < 9) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00112$
	ld	bc, #_cursor+5
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00112$
;src/main.c:806: cursor.hand_pile_idx++;
	inc	a
	ld	(bc), a
00112$:
;src/main.c:809: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00149$
	ld	a, (#_flags)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	bit	2, c
	jp	Z,00149$
;src/main.c:574: Pile *pile = IDX_PTR(piles, cursor.hand_pile_idx);
	ld	bc, #_piles+0
	ld	a, (#(_cursor + 0x0005) + 0)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#7
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
;src/main.c:575: if (cursor.hand_pile_idx == cursor.pile_idx) {
	ld	hl, #_cursor + 6
	ld	e, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00155$
;src/main.c:576: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
	jp	00149$
00155$:
;src/main.c:577: } else if (!pile->height
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00153$
;src/main.c:578: || RANK(pile->top->data) == RANK(cursor.held_card->data) + 1u) {
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
	ldhl	sp,	#6
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
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, e
	jp	NZ,00149$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jp	NZ,00149$
00153$:
;src/main.c:579: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
;src/main.c:580: score--;
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
;src/main.c:810: cursor_place_stack();
	jp	00149$
00147$:
;src/main.c:813: flags |= FLAG_REDRAW_CURSOR;
	ld	a, e
	or	a, #0x01
	ld	(#_flags),a
;src/main.c:814: if (new_input & J_DOWN) {
	ldhl	sp,	#1
	bit	3, (hl)
	jr	Z, 00137$
;src/main.c:815: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	hl, #_cursor + 6
	ld	b, (hl)
	ld	a, b
;src/main.c:816: cursor.pile_idx = 0;
	sub	a,#0x0a
	jr	NZ, 00120$
	ld	(hl),a
	jp	00138$
00120$:
;src/main.c:817: else if (cursor.height + 1u < piles[cursor.pile_idx].height)
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
	ld	e, c
	ld	d, #0x00
	inc	de
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	e, b
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	de, #_piles
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	b, #0x00
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, e
	inc	hl
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00138$
;src/main.c:818: cursor.height++;
	inc	c
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), c
	jr	00138$
00137$:
;src/main.c:819: } else if (new_input & J_UP) {
	ldhl	sp,	#1
	bit	2, (hl)
	jr	Z, 00134$
;src/main.c:820: if (cursor.height == 0)
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	or	a, a
	jr	NZ, 00123$
;src/main.c:821: cursor.pile_idx = PILE_IDX_DECK;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x0a
	jr	00138$
00123$:
;src/main.c:823: cursor.height--;
	ldhl	sp,	#5
	ld	a, (hl)
	dec	a
	ld	(#(_cursor + 0x0007)),a
	jr	00138$
00134$:
;src/main.c:825: && cursor.pile_idx != 0
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00129$
	ld	bc, #_cursor+6
	ld	a, (bc)
	or	a, a
	jr	Z, 00129$
;src/main.c:826: && cursor.pile_idx != PILE_IDX_DECK) {
	cp	a, #0x0a
	jr	Z, 00129$
;src/main.c:827: cursor.pile_idx--;
	dec	a
	ld	(bc), a
;src/main.c:828: cursor_adjust_height();
	call	_cursor_adjust_height
	jr	00138$
00129$:
;src/main.c:830: && cursor.pile_idx < PILE_IDX_DECK - 1u) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00138$
	ld	bc, #_cursor+6
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00138$
;src/main.c:831: cursor.pile_idx++;
	inc	a
	ld	(bc), a
;src/main.c:832: cursor_adjust_height();
	call	_cursor_adjust_height
00138$:
;src/main.c:835: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00149$
	ld	a, (#_flags)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	bit	2, c
	jp	Z,00149$
;src/main.c:836: if (cursor.pile_idx == PILE_IDX_DECK && top_card_idx != 104u)
	ld	hl, #(_cursor + 0x0006)
	ld	c, (hl)
	ld	a, c
	sub	a, #0x0a
	jp	NZ,00140$
	ld	a, (#_top_card_idx)
	sub	a, #0x68
	jp	Z,00140$
;src/main.c:704: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles
;src/main.c:707: for (i = 0; i < 10u; i++) {
	ld	e, #0x00
00171$:
;src/main.c:708: if (!pile->height)
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00149$
;src/main.c:710: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:707: for (i = 0; i < 10u; i++) {
	inc	e
	ld	a, e
	sub	a, #0x0a
	jr	C, 00171$
;src/main.c:713: pile = IDX_PTR(piles, 0);
	ldhl	sp,	#5
	ld	a, #<(_piles)
	ld	(hl+), a
	ld	(hl), #>(_piles)
;src/main.c:714: Card *deck_top = IDX_PTR(deck, top_card_idx);
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
;src/main.c:715: top_card_idx += 10u;
	ld	hl, #_top_card_idx
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
;src/main.c:718: for (i = 0; i < 10u; i++) {
	ldhl	sp,	#7
	ld	(hl), #0x0a
00175$:
;src/main.c:719: pile->top->next_card = deck_top;
;c
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
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
;src/main.c:720: pile->top = deck_top;
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:721: pile->height++;
;c
	ldhl	sp,#5
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
;src/main.c:722: deck_top++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:723: pile++;
;c
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl+), a
;src/main.c:718: for (i = 0; i < 10u; i++) {
	dec	(hl)
	ld	a, (hl)
	jr	NZ, 00175$
;src/main.c:726: dynamic_metasprite_deal();
	call	_dynamic_metasprite_deal
;src/main.c:837: deal();
	jp	00149$
00140$:
;src/main.c:549: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
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
	ldhl	sp,	#3
	ld	(hl), c
	inc	hl
;src/main.c:550: Card *top = pile->base;
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
;src/main.c:551: for (i = 1; i < cursor.height; i++)
	ld	b, #0x01
00177$:
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
	ld	a, b
	sub	a, c
	jr	NC, 00163$
;src/main.c:552: top = top->next_card;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:551: for (i = 1; i < cursor.height; i++)
	inc	b
	jr	00177$
00163$:
;src/main.c:553: Card *stack = cursor.height ? top->next_card : top;
	ld	a, c
	or	a, a
	jr	Z, 00181$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	jr	00182$
00181$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00182$:
;src/main.c:554: if (!(VISIBLE(stack->data) && is_stack_coherent(stack)))
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	bit	6, a
	jr	Z, 00149$
	push	bc
	push	bc
	call	_is_stack_coherent
	add	sp, #2
	ld	a, e
	pop	bc
	or	a, a
	jr	Z, 00149$
;src/main.c:557: cursor.held_card = stack;
	ld	hl, #_cursor
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:558: cursor.hand_pile_idx = cursor.pile_idx;
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	(#(_cursor + 0x0005)),a
;src/main.c:559: cursor.held_stack_size = pile->height - cursor.height;
;c
	ldhl	sp,#3
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
;src/main.c:560: pile->height = cursor.height;
	ld	a, (#(_cursor + 0x0007) + 0)
	ld	(bc), a
;src/main.c:561: if (cursor.height) {
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#5
	ld	(hl), a
;src/main.c:562: pile->top = top;
	ldhl	sp,#3
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
;src/main.c:564: cursor.card_to_show = top;
;src/main.c:561: if (cursor.height) {
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00168$
;src/main.c:562: pile->top = top;
	inc	hl
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/main.c:563: top->next_card = NULL;
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:564: cursor.card_to_show = top;
	ld	de, #(_cursor + 0x0002)
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
	jr	00149$
00168$:
;src/main.c:566: pile->base = NULL;
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:567: pile->top = NULL;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/main.c:568: cursor.card_to_show = NULL;
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:843: }
00149$:
;src/main.c:844: prev_input = input;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_input_process_prev_input_65536_296),a
;src/main.c:845: }
	add	sp, #8
	ret
;src/main.c:847: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-10
;src/main.c:849: font_init();
	call	_font_init
;src/main.c:850: font_t font = font_load(font_min);
	ld	hl, #_font_min
	push	hl
	call	_font_load
	add	sp, #2
;src/main.c:851: font_set(font);
	push	de
	call	_font_set
	add	sp, #2
;src/main.c:852: set_bkg_data(OFFSET_BKG_FONT_ADDON, N_FONT_ADDON, font_addon);
	ld	hl, #_font_addon
	push	hl
	ld	de, #0x0125
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/main.c:854: set_bkg_data(OFFSET_BKG_TITLE, N_TITLE, title_textures);
	ld	hl, #_title_textures
	push	hl
	ld	de, #0x30b4
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/main.c:855: set_bkg_data(OFFSET_BKG_CARD, N_CARD, card_textures);
	ld	hl, #_card_textures
	push	hl
	ld	de, #0x3480
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/main.c:856: set_sprite_data(OFFSET_SPRITE_CURSOR, N_CURSOR, cursor_textures);
	ld	hl, #_cursor_textures
	push	hl
	ld	de, #0x0801
	push	de
	call	_set_sprite_data
	add	sp, #4
;src/main.c:857: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;src/main.c:858: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;src/main.c:860: set_bkg_tiles(0, 14u, COPYRIGHT_LEN, 1u, copyright);
	ld	hl, #_copyright
	push	hl
	ld	de, #0x0114
	push	de
	ld	a, #0x0e
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:367: dynamic_metasprite.src[0] = 72;
	ld	hl, #_dynamic_metasprite
	ld	(hl), #0x48
	inc	hl
	ld	(hl), #0x00
;src/main.c:368: dynamic_metasprite.src[1] = -24;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	(hl), #0xe8
	inc	hl
	ld	(hl), #0xff
;src/main.c:369: dynamic_metasprite.dist[0] = -64;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	(hl), #0xc0
	inc	hl
	ld	(hl), #0xff
;src/main.c:370: dynamic_metasprite.dist[1] = 40;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	(hl), #0x28
	inc	hl
	ld	(hl), #0x00
;src/main.c:371: dynamic_metasprite.target_frames = TARGET_FRAMES_SPLASH_SCREEN;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0x20
;src/main.c:372: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:373: dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;src/main.c:374: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_TITLE + OFFSET_TITLE_S;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #0xb4
;src/main.c:375: dynamic_metasprite.data[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), #0x00
;src/main.c:376: dynamic_metasprite.callback = &dynamic_metasprite_splash_screen_callback;
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	(hl), #<(_dynamic_metasprite_splash_screen_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_splash_screen_callback)
;src/main.c:377: flags |= FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x04
	ld	(hl), a
;src/main.c:864: while (1) {
00104$:
;src/main.c:786: UINT8 input = joypad();
	call	_joypad
	ldhl	sp,	#2
	ld	(hl), e
;src/main.c:787: UINT8 new_input = input & ~prev_input;
	ld	a, (#_main_prev_input_327681_339)
	cpl
	ldhl	sp,	#2
	and	a, (hl)
	dec	hl
	ld	(hl), a
;src/main.c:788: switch (flags & FLAG_GAME_STATE) {
	ld	a, (#_flags)
	and	a, #0x18
	ldhl	sp,	#8
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	inc	hl
	or	a, (hl)
	jr	Z, 00112$
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, #0x10
	inc	hl
	or	a, (hl)
	jr	Z, 00175$
	jp	00176$
;src/main.c:789: case FLAG_GAME_STATE_START:
00112$:
;src/main.c:790: if (new_input) {
	ldhl	sp,	#1
	ld	a, (hl)
	or	a, a
	jp	Z, 00176$
;src/main.c:791: flags &= ~FLAG_GAME_STATE;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xe7
	ld	(hl), a
;src/main.c:792: flags |= FLAG_GAME_STATE_INGAME;
	ld	a, (hl)
	or	a, #0x10
	ld	(hl), a
;src/main.c:793: if (flags & FLAG_PLAYING_ANIMATION)
	bit	2, (hl)
	jr	Z, 00108$
;src/main.c:794: dynamic_metasprite_end_animation();
	call	_dynamic_metasprite_end_animation
00108$:
;src/main.c:777: initrand(DIV_REG);
	ldh	a, (_DIV_REG+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	call	_initrand
	add	sp, #2
;src/main.c:778: init_deck();
	call	_init_deck
;src/main.c:779: clear_bkg();
	call	_clear_bkg
;src/main.c:780: draw_bkg_game();
	call	_draw_bkg_game
;src/main.c:797: break;
	jp	00176$
;src/main.c:798: case FLAG_GAME_STATE_INGAME:
00175$:
;src/main.c:799: if (cursor.held_card) {
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:377: flags |= FLAG_PLAYING_ANIMATION;
	ld	a, (#_flags)
	ldhl	sp,	#5
	ld	(hl), a
;src/main.c:802: && cursor.hand_pile_idx != 0) {
	ldhl	sp,	#1
	ld	a, (hl)
	and	a, #0x02
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:805: && cursor.hand_pile_idx < 9) {
	ldhl	sp,	#1
	ld	a, (hl)
	and	a, #0x01
	ldhl	sp,	#8
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:809: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#1
	ld	a, (hl)
	and	a, #0x10
	inc	hl
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:799: if (cursor.held_card) {
	ld	a, b
	or	a, c
	jp	Z, 00173$
;src/main.c:800: flags |= FLAG_REDRAW_HAND;
	inc	hl
	ld	a, (hl)
	or	a, #0x02
	ld	(#_flags),a
;src/main.c:802: && cursor.hand_pile_idx != 0) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00118$
	ld	bc, #_cursor+5
	ld	a, (bc)
	or	a, a
	jr	Z, 00118$
;src/main.c:803: cursor.hand_pile_idx--;
	dec	a
	ld	(bc), a
	jr	00119$
00118$:
;src/main.c:805: && cursor.hand_pile_idx < 9) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00119$
	ld	bc, #_cursor+5
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00119$
;src/main.c:806: cursor.hand_pile_idx++;
	inc	a
	ld	(bc), a
00119$:
;src/main.c:809: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#4
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00176$
	ld	a, (#_flags)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	bit	2, c
	jp	Z,00176$
;src/main.c:574: Pile *pile = IDX_PTR(piles, cursor.hand_pile_idx);
	ld	bc, #_piles+0
	ld	a, (#(_cursor + 0x0005) + 0)
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#9
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
;src/main.c:575: if (cursor.hand_pile_idx == cursor.pile_idx) {
	ld	hl, #_cursor + 6
	ld	e, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00125$
;src/main.c:576: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
	jp	00176$
00125$:
;src/main.c:577: } else if (!pile->height
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00123$
;src/main.c:578: || RANK(pile->top->data) == RANK(cursor.held_card->data) + 1u) {
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
	ldhl	sp,	#8
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
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, e
	jp	NZ,00176$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jp	NZ,00176$
00123$:
;src/main.c:579: pile_append_cursor_stack(pile);
	push	bc
	call	_pile_append_cursor_stack
	add	sp, #2
;src/main.c:580: score--;
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
;src/main.c:810: cursor_place_stack();
	jp	00176$
00173$:
;src/main.c:813: flags |= FLAG_REDRAW_CURSOR;
	ldhl	sp,	#5
	ld	a, (hl)
	or	a, #0x01
	ld	(#_flags),a
;src/main.c:814: if (new_input & J_DOWN) {
	ldhl	sp,	#1
	bit	3, (hl)
	jp	Z,00151$
;src/main.c:815: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	bc, #_cursor + 6
	ld	a, (bc)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (hl)
	sub	a, #0x0a
	jr	NZ, 00134$
;src/main.c:816: cursor.pile_idx = 0;
	xor	a, a
	ld	(bc), a
	jp	00152$
00134$:
;src/main.c:817: else if (cursor.height + 1u < piles[cursor.pile_idx].height)
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
;c
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl+), a
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
;c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_piles
	add	hl, de
	inc	sp
	inc	sp
;c
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#6
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00152$
;src/main.c:818: cursor.height++;
	ldhl	sp,	#5
	ld	a, (hl)
	inc	a
	ld	(#(_cursor + 0x0007)),a
	jr	00152$
00151$:
;src/main.c:819: } else if (new_input & J_UP) {
	ldhl	sp,	#1
	bit	2, (hl)
	jr	Z, 00149$
;src/main.c:820: if (cursor.height == 0)
	ld	bc, #_cursor + 7
	ld	a, (bc)
	or	a, a
	jr	NZ, 00138$
;src/main.c:821: cursor.pile_idx = PILE_IDX_DECK;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x0a
	jr	00152$
00138$:
;src/main.c:823: cursor.height--;
	dec	a
	ld	(bc), a
	jr	00152$
00149$:
;src/main.c:825: && cursor.pile_idx != 0
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00147$
	ld	bc, #_cursor+6
	ld	a, (bc)
	or	a, a
	jr	Z, 00147$
;src/main.c:826: && cursor.pile_idx != PILE_IDX_DECK) {
	cp	a, #0x0a
	jr	Z, 00147$
;src/main.c:827: cursor.pile_idx--;
	dec	a
	ld	(bc), a
;src/main.c:828: cursor_adjust_height();
	call	_cursor_adjust_height
	jr	00152$
00147$:
;src/main.c:830: && cursor.pile_idx < PILE_IDX_DECK - 1u) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00152$
	ld	bc, #_cursor+6
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00152$
;src/main.c:831: cursor.pile_idx++;
	inc	a
	ld	(bc), a
;src/main.c:832: cursor_adjust_height();
	call	_cursor_adjust_height
00152$:
;src/main.c:835: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#4
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00176$
	ld	a, (#_flags)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	bit	2, c
	jp	Z,00176$
;src/main.c:836: if (cursor.pile_idx == PILE_IDX_DECK && top_card_idx != 104u)
	ld	hl, #(_cursor + 0x0006)
	ld	c, (hl)
	ld	a, c
	sub	a, #0x0a
	jp	NZ,00169$
	ld	a, (#_top_card_idx)
	sub	a, #0x68
	jp	Z,00169$
;src/main.c:704: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles
;src/main.c:707: for (i = 0; i < 10u; i++) {
	ld	e, #0x00
00201$:
;src/main.c:708: if (!pile->height)
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00176$
;src/main.c:710: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:707: for (i = 0; i < 10u; i++) {
	inc	e
	ld	a, e
	sub	a, #0x0a
	jr	C, 00201$
;src/main.c:713: pile = IDX_PTR(piles, 0);
	ldhl	sp,	#7
	ld	a, #<(_piles)
	ld	(hl+), a
	ld	(hl), #>(_piles)
;src/main.c:714: Card *deck_top = IDX_PTR(deck, top_card_idx);
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
;src/main.c:715: top_card_idx += 10u;
	ld	hl, #_top_card_idx
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
;src/main.c:718: for (i = 0; i < 10u; i++) {
	ldhl	sp,	#9
	ld	(hl), #0x0a
00205$:
;src/main.c:719: pile->top->next_card = deck_top;
;c
	ldhl	sp,#7
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
;src/main.c:720: pile->top = deck_top;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:721: pile->height++;
;c
	ldhl	sp,#7
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
;src/main.c:722: deck_top++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:723: pile++;
;c
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl+), a
;src/main.c:718: for (i = 0; i < 10u; i++) {
	dec	(hl)
	ld	a, (hl)
	jr	NZ, 00205$
;src/main.c:726: dynamic_metasprite_deal();
	call	_dynamic_metasprite_deal
;src/main.c:837: deal();
	jp	00176$
00169$:
;src/main.c:549: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
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
	ldhl	sp,	#5
	ld	(hl), c
	inc	hl
;src/main.c:550: Card *top = pile->base;
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
;src/main.c:551: for (i = 1; i < cursor.height; i++)
	ld	b, #0x01
00207$:
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
	ld	a, b
	sub	a, c
	jr	NC, 00161$
;src/main.c:552: top = top->next_card;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:551: for (i = 1; i < cursor.height; i++)
	inc	b
	jr	00207$
00161$:
;src/main.c:553: Card *stack = cursor.height ? top->next_card : top;
	ld	a, c
	or	a, a
	jr	Z, 00211$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	jr	00212$
00211$:
	ldhl	sp,#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00212$:
;src/main.c:554: if (!(VISIBLE(stack->data) && is_stack_coherent(stack)))
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	bit	6, a
	jr	Z, 00176$
	push	bc
	push	bc
	call	_is_stack_coherent
	add	sp, #2
	ld	a, e
	pop	bc
	or	a, a
	jr	Z, 00176$
;src/main.c:557: cursor.held_card = stack;
	ld	hl, #_cursor
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:558: cursor.hand_pile_idx = cursor.pile_idx;
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	(#(_cursor + 0x0005)),a
;src/main.c:559: cursor.held_stack_size = pile->height - cursor.height;
;c
	ldhl	sp,#5
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
;src/main.c:560: pile->height = cursor.height;
	ld	a, (#(_cursor + 0x0007) + 0)
	ld	(bc), a
;src/main.c:561: if (cursor.height) {
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#7
	ld	(hl), a
;src/main.c:562: pile->top = top;
	ldhl	sp,#5
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
;src/main.c:564: cursor.card_to_show = top;
;src/main.c:561: if (cursor.height) {
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00166$
;src/main.c:562: pile->top = top;
	inc	hl
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/main.c:563: top->next_card = NULL;
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:564: cursor.card_to_show = top;
	ld	de, #(_cursor + 0x0002)
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
	jr	00176$
00166$:
;src/main.c:566: pile->base = NULL;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:567: pile->top = NULL;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/main.c:568: cursor.card_to_show = NULL;
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:843: }
00176$:
;src/main.c:844: prev_input = input;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_main_prev_input_327681_339),a
;src/main.c:867: switch (flags & FLAG_GAME_STATE) {
	ld	a, (#_flags)
	and	a, #0x18
	ld	b, a
	ld	c, #0x00
	ld	a, b
	sub	a, #0x10
	or	a, c
	jp	NZ,00102$
;src/main.c:586: cursor.anim_ctr++;
	ld	hl, #_cursor + 8
	ld	d, (hl)
	inc	d
	ld	(hl), d
;src/main.c:587: cursor.anim_ctr &= (1u << (CURSOR_PERIOD_LOGSCALE + 1u)) - 1u;
	res	7, d
	ld	(hl), d
;src/main.c:588: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	bc, #_cursor + 9
	ld	a, (bc)
	ld	e, a
;src/main.c:589: cursor.anim_frame = cursor.anim_ctr >> CURSOR_PERIOD_LOGSCALE;
	ld	a, d
	rlca
	rlca
	and	a, #0x03
	ld	(bc), a
;src/main.c:590: if (cursor.anim_frame != prev_anim_frame)
	sub	a, e
	jr	Z, 00179$
;src/main.c:591: flags |= FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x01
	ld	(hl), a
00179$:
;src/main.c:593: if (flags & FLAG_REDRAW_CURSOR) {
	ld	a, (#_flags)
	rrca
	jr	NC, 00186$
;src/main.c:594: flags &= ~FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfe
	ld	(hl), a
;src/main.c:595: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	hl, #_cursor + 6
	ld	l, (hl)
;src/main.c:588: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	a, (bc)
;src/main.c:596: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	d, #0x00
	ld	e, a
	sla	e
	rl	d
;src/main.c:595: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	a, l
	sub	a, #0x0a
	jr	NZ, 00183$
;src/main.c:596: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	hl, #_cursor_metasprites
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
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x22
	push	de
	call	___move_metasprite
	add	sp, #3
;src/main.c:601: );
	jr	00186$
00183$:
;src/main.c:607: (cursor.height + 3u) * 8u
	ld	bc, #_cursor + 7
	ld	a, (bc)
	add	a, #0x03
	add	a, a
	add	a, a
	add	a, a
	ld	b, a
;src/main.c:606: cursor.pile_idx * 16u,
	ld	a, l
	swap	a
	and	a, #0xf0
	ld	c, a
;src/main.c:603: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	hl, #_cursor_metasprites
	add	hl, de
	ld	a, (hl+)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	e, (hl)
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), e
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x01
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	push	bc
	inc	sp
	ld	d, c
	ld	e,#0x22
	push	de
	call	___move_metasprite
	add	sp, #3
;src/main.c:608: );
00186$:
;src/main.c:610: if (flags & FLAG_REDRAW_HAND) {
	ld	a, (#_flags)
	bit	1, a
	jr	Z, 00102$
;src/main.c:611: flags &= ~FLAG_REDRAW_HAND;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfd
	ld	(hl), a
;src/main.c:612: if (cursor.held_card) {
	ld	hl, #_cursor
	ld	a, (hl+)
	or	a,(hl)
	jr	Z, 00189$
;src/main.c:613: UINT8 height = piles[cursor.hand_pile_idx].height;
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
;src/main.c:618: (height + !height + 2u) * 8u
	ld	a, b
	sub	a,#0x01
	ld	a, #0x00
	rla
	add	a, b
	add	a, #0x02
	add	a, a
	add	a, a
	add	a, a
	ld	d, a
;src/main.c:617: cursor.hand_pile_idx * 16u,
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
	ld	a, #0x1c
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:619: );
	jr	00102$
00189$:
;src/main.c:621: metasprite_2x3_hide(SPRITE_HAND);
	ld	a, #0x1c
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:871: }
00102$:
;src/main.c:519: if (dynamic_metasprite.elapsed_frames >= dynamic_metasprite.target_frames)
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	c, (hl)
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	b, (hl)
	ld	e, b
	ld	a,c
	ld	d,a
	sub	a, b
	bit	7, e
	jr	Z, 00481$
	bit	7, d
	jr	NZ, 00482$
	cp	a, a
	jr	00482$
00481$:
	bit	7, d
	jr	Z, 00482$
	scf
00482$:
	jp	NC, 00200$
;src/main.c:522: dynamic_metasprite.elapsed_frames++;
	inc	c
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), c
;src/main.c:527: dynamic_metasprite.src[1] + (dynamic_metasprite.dist[1] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames)
	ld	a, (#(_dynamic_metasprite + 0x0002) + 0)
	ldhl	sp,	#5
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
;src/main.c:519: if (dynamic_metasprite.elapsed_frames >= dynamic_metasprite.target_frames)
	call	__mulint
	add	sp, #4
	push	hl
	ldhl	sp,	#12
	ld	(hl), e
	ldhl	sp,	#13
	ld	(hl), d
	pop	hl
	pop	bc
	ld	a, (#(_dynamic_metasprite + 0x0008) + 0)
;src/main.c:527: dynamic_metasprite.src[1] + (dynamic_metasprite.dist[1] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames)
	ldhl	sp,	#6
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
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	ldhl	sp,	#5
	add	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
;src/main.c:526: dynamic_metasprite.src[0] + (dynamic_metasprite.dist[0] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames),
	ld	a, (#_dynamic_metasprite + 0)
	ldhl	sp,	#9
	ld	(hl), a
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	call	__mulint
	add	sp, #4
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	ld	a, e
	ldhl	sp,	#9
	add	a, (hl)
	ld	b, a
;src/main.c:524: dynamic_metasprite.metasprite_offset,
	ld	a, (#(_dynamic_metasprite + 0x000c) + 0)
	ld	(#___current_base_tile),a
;src/main.c:523: move_metasprite(dynamic_metasprite.metasprite,
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl), c
	inc	hl
	ld	(hl), a
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ldhl	sp,	#8
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
;src/main.c:529: if (dynamic_metasprite.elapsed_frames == dynamic_metasprite.target_frames
	ld	a, (#(_dynamic_metasprite + 0x0009) + 0)
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	c, (hl)
	sub	a, c
	jr	NZ, 00200$
;src/main.c:530: && dynamic_metasprite.callback)
	ld	hl, #(_dynamic_metasprite + 0x0013)
	ld	a, (hl+)
	ld	c, a
	ld	h, (hl)
	ld	a, h
	or	a, c
	jr	Z, 00200$
;src/main.c:531: dynamic_metasprite.callback();
	ld	l, c
	call	___sdcc_call_hl
;src/main.c:873: dynamic_metasprite_process();
00200$:
;src/main.c:875: wait_vbl_done();
	call	_wait_vbl_done
	jp	00104$
;src/main.c:877: }
	add	sp, #10
	ret
	.area _CODE
	.area _CABS (ABS)
