;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _pile_append_cursor_stack
	.globl _dynamic_metasprite_fold
	.globl _dynamic_metasprite_fold_callback
	.globl _dynamic_metasprite_move_stack_callback
	.globl _dynamic_metasprite_unfold_callback
	.globl _set_metasprite_card
	.globl _dynamic_metasprite_deal
	.globl _dynamic_metasprite_deal_callback
	.globl _cursor_adjust_height
	.globl _draw_background
	.globl _draw_sequential_card
	.globl _draw_pile
	.globl _draw_card_bottom
	.globl _draw_card_top
	.globl _init_deck
	.globl _metasprite_2x3_hide
	.globl _rand
	.globl _initrand
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _cursor
	.globl _dynamic_metasprite
	.globl _score
	.globl _flags
	.globl _top_card_idx
	.globl _piles
	.globl _deck
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
_score::
	.ds 2
_dynamic_metasprite::
	.ds 20
_cursor::
	.ds 10
_input_process_prev_input_65536_215:
	.ds 1
_main_prev_input_327680_269:
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
;src/main.c:505: static UINT8 prev_input = 0;
	ld	hl, #_input_process_prev_input_65536_215
	ld	(hl), #0x00
	ld	hl, #_main_prev_input_327680_269
	ld	(hl), #0x00
;src/main.c:115: UINT8 flags = 0;
	ld	hl, #_flags
	ld	(hl), #0x00
;src/main.c:117: UINT16 score = 500;
	ld	hl, #_score
	ld	(hl), #0xf4
	inc	hl
	ld	(hl), #0x01
;src/main.c:119: DynamicMetaSprite dynamic_metasprite = {
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0xff
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:124: Cursor cursor = {
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
;src/main.c:134: void metasprite_2x3_hide(UINT8 sprite)
;	---------------------------------
; Function metasprite_2x3_hide
; ---------------------------------
_metasprite_2x3_hide::
;src/main.c:141: );
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
;src/main.c:141: );
;src/main.c:142: }
	ret
;src/main.c:145: void init_deck(void)
;	---------------------------------
; Function init_deck
; ---------------------------------
_init_deck::
	add	sp, #-16
;src/main.c:147: Card *card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:152: for (suit = 0; suit < 4u; suit++) {
	xor	a, a
	ldhl	sp,	#11
	ld	(hl), a
;src/main.c:153: for (rank = 0; rank < 13u; rank++) {
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
;src/main.c:154: for (i = 0; i < 2u; i++) {
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
;src/main.c:155: card->data = rank | (suit << BIT_OFFSET_DATA_SUIT);
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
;src/main.c:156: card++;
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
;src/main.c:154: for (i = 0; i < 2u; i++) {
	dec	(hl)
	jr	NZ, 00113$
;src/main.c:153: for (rank = 0; rank < 13u; rank++) {
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
;src/main.c:152: for (suit = 0; suit < 4u; suit++) {
	dec	hl
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00131$
;src/main.c:161: card = IDX_PTR(deck, 103u);
	inc	hl
	inc	hl
	ld	a, #<((_deck + 0x0135))
	ld	(hl+), a
	ld	(hl), #>((_deck + 0x0135))
;src/main.c:162: for (i = 103u; i; i--) {
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
;src/main.c:163: Card *swap = IDX_PTR(deck, (UINT8)rand() % i);
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
;src/main.c:165: temp = *card;
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
;src/main.c:166: *card = *swap;
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
;src/main.c:167: *swap = temp;
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
;src/main.c:168: card--;
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
;src/main.c:162: for (i = 103u; i; i--) {
	ld	a, e
	ld	(hl+), a
	inc	hl
	dec	(hl)
	jr	NZ, 00118$
;src/main.c:171: card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:172: for (i = 0; i < 44u; i++) {
	xor	a, a
	ld	(hl), a
00120$:
;src/main.c:173: card->next_card = IDX_PTR(deck, i + 10u);
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
;src/main.c:174: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:172: for (i = 0; i < 44u; i++) {
	ldhl	sp,	#15
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x2c
	jr	C, 00120$
	ld	e, (hl)
00123$:
;src/main.c:176: for (; i < 104u; i++) {
	ld	a, e
	sub	a, #0x68
	jr	NC, 00106$
;src/main.c:177: card->data |= BITMASK_DATA_VISIBLE;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	set	6, (hl)
;src/main.c:178: card->next_card = NULL;
	ld	l, c
	ld	h, b
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:179: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:176: for (; i < 104u; i++) {
	inc	e
	jr	00123$
00106$:
;src/main.c:182: card = IDX_PTR(deck, 0);
	ldhl	sp,	#11
	ld	a, #<(_deck)
	ld	(hl+), a
;src/main.c:183: Pile *pile = IDX_PTR(piles, 0);
	ld	a, #>(_deck)
	ld	(hl+), a
	ld	a, #<(_piles)
	ld	(hl+), a
	ld	(hl), #>(_piles)
;src/main.c:184: for (i = 0; i < 10; i++) {
	xor	a, a
	inc	hl
	ld	(hl), a
00125$:
;src/main.c:185: pile->base = card;
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
;src/main.c:187: pile->top = IDX_PTR(deck, 50u + i);
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
;src/main.c:188: pile->height = 5u;
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
;src/main.c:186: if (i < 4u) {
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00108$
;src/main.c:187: pile->top = IDX_PTR(deck, 50u + i);
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
;src/main.c:188: pile->height = 5u;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x05
	jr	00109$
00108$:
;src/main.c:190: pile->top = IDX_PTR(deck, 40u + i);
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
;src/main.c:191: pile->height = 4u;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x04
00109$:
;src/main.c:194: card++;
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
;src/main.c:195: pile++;
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
;src/main.c:184: for (i = 0; i < 10; i++) {
	ld	(hl+), a
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0a
	jp	C, 00125$
;src/main.c:198: top_card_idx = 54u;
	ld	hl, #_top_card_idx
	ld	(hl), #0x36
;src/main.c:199: }
	add	sp, #16
	ret
;src/main.c:207: void draw_card_top(const UINT8 x, const UINT8 y, const UINT8 card_data)
;	---------------------------------
; Function draw_card_top
; ---------------------------------
_draw_card_top::
;src/main.c:209: if (VISIBLE(card_data)) {
	ldhl	sp,	#4
;src/main.c:211: set_bkg_tile_xy(x + 1u, y, SUIT(card_data) + OFFSET_BKG_SUIT);
	ld	a, (hl-)
	ld	c, a
	dec	hl
	ld	b, (hl)
	inc	b
;src/main.c:209: if (VISIBLE(card_data)) {
	bit	6, c
	jr	Z, 00102$
;src/main.c:210: set_bkg_tile_xy(x, y, RANK(card_data) + OFFSET_BKG_RANK);
	ld	a, c
	and	a, #0x0f
	inc	a
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
;src/main.c:211: set_bkg_tile_xy(x + 1u, y, SUIT(card_data) + OFFSET_BKG_SUIT);
	ld	a, c
	ld	c, #0x00
	and	a, #0x30
	ld	e, a
	ld	d, #0x00
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ld	a, e
	add	a, #0x0e
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
;src/main.c:213: set_bkg_tile_xy(x, y, OFFSET_BKG_BACK);
	ld	a, #0x18
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
;src/main.c:214: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_BACK + 1u);
	ld	a, #0x19
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
;src/main.c:216: }
	ret
;src/main.c:218: void draw_card_bottom(const UINT8 x, const UINT8 y, const UINT8 card_data)
;	---------------------------------
; Function draw_card_bottom
; ---------------------------------
_draw_card_bottom::
;src/main.c:220: set_bkg_tile_xy(x, y, OFFSET_BKG_BLANK + 2u);
	ld	a, #0x14
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
;src/main.c:221: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_BLANK + 3u);
	ldhl	sp,	#2
	ld	c, (hl)
	inc	c
	ld	a, #0x15
	push	af
	inc	sp
	inc	hl
	ld	b, (hl)
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:222: set_bkg_tile_xy(x, y+ 1u, SUIT(card_data) + OFFSET_BKG_SUIT_ROT);
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x30
	ld	e, a
	ld	d, #0x00
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ld	a, e
	add	a, #0x2b
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
;src/main.c:223: set_bkg_tile_xy(x + 1u, y+ 1u, RANK(card_data) + OFFSET_BKG_RANK_ROT);
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x0f
	add	a, #0x1e
	push	af
	inc	sp
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:224: }
	ret
;src/main.c:232: void draw_pile(Card *card, UINT8 pile_idx, UINT8 height)
;	---------------------------------
; Function draw_pile
; ---------------------------------
_draw_pile::
	add	sp, #-3
;src/main.c:234: pile_idx <<= 1;
	ldhl	sp,	#7
	ld	a, (hl)
	add	a, a
;src/main.c:235: height += SCOREBAR_HEIGHT;
	ld	(hl+), a
	inc	(hl)
	inc	(hl)
	inc	(hl)
;src/main.c:236: while (1) {
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
00104$:
;src/main.c:237: draw_card_top(pile_idx, height, card->data);
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
;src/main.c:238: if (!card->next_card) {
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/main.c:239: draw_card_bottom(pile_idx, height + 1u, card->data);
	ld	(hl-), a
	dec	hl
	ld	d, (hl)
	inc	d
;src/main.c:238: if (!card->next_card) {
	inc	hl
	inc	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
;src/main.c:239: draw_card_bottom(pile_idx, height + 1u, card->data);
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
;src/main.c:240: break;
	jr	00106$
00102$:
;src/main.c:242: height++;
	ldhl	sp,	#0
;src/main.c:243: card = card->next_card;
	ld	a, d
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#5
	ld	(hl+), a
	ld	(hl), e
	jr	00104$
;src/main.c:246: height += 2u;
00106$:
;src/main.c:247: }
	add	sp, #3
	ret
;src/main.c:249: void draw_sequential_card(const UINT8 x, const UINT8 y, const UINT8 bkg_offset)
;	---------------------------------
; Function draw_sequential_card
; ---------------------------------
_draw_sequential_card::
;src/main.c:251: set_bkg_tile_xy(x, y, bkg_offset);
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
;src/main.c:252: set_bkg_tile_xy(x + 1u, y, bkg_offset + 1u);
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
;src/main.c:253: set_bkg_tile_xy(x, y + 1u, bkg_offset + 2u);
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
;src/main.c:254: set_bkg_tile_xy(x + 1u, y + 1u, bkg_offset + 3u);
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
;src/main.c:255: set_bkg_tile_xy(x, y + 2u, bkg_offset + 4u);
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
;src/main.c:256: set_bkg_tile_xy(x + 1u, y + 2u, bkg_offset + 5u);
	ldhl	sp,	#4
	ld	a, (hl)
	add	a, #0x05
	push	af
	inc	sp
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:257: }
	ret
;src/main.c:259: void draw_background(void)
;	---------------------------------
; Function draw_background
; ---------------------------------
_draw_background::
	add	sp, #-3
;src/main.c:262: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles+0
;src/main.c:263: for (i = 0; i < 10u; i++) {
	xor	a, a
	ldhl	sp,	#2
	ld	(hl), a
00102$:
;src/main.c:264: draw_pile(pile->base, i, 0);
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
;src/main.c:265: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:263: for (i = 0; i < 10u; i++) {
	ldhl	sp,	#2
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0a
	jr	C, 00102$
;src/main.c:267: draw_sequential_card(0, 0, OFFSET_BKG_BACK);
	ld	a, #0x18
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
;src/main.c:268: }
	add	sp, #3
	ret
;src/main.c:270: void cursor_adjust_height(void)
;	---------------------------------
; Function cursor_adjust_height
; ---------------------------------
_cursor_adjust_height::
;src/main.c:272: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
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
;src/main.c:273: if (cursor.height > pile->height)
	ld	bc, #_cursor + 7
	ld	a, (bc)
	ld	d, a
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
;src/main.c:274: cursor.height = pile->height;
	ld	a,e
	cp	a,d
	ret	NC
	ld	(bc), a
;src/main.c:275: }
	ret
;src/main.c:311: void dynamic_metasprite_deal_callback(void)
;	---------------------------------
; Function dynamic_metasprite_deal_callback
; ---------------------------------
_dynamic_metasprite_deal_callback::
	add	sp, #-4
;src/main.c:313: Pile *pile = IDX_PTR(piles, dynamic_metasprite.data_0);
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
;src/main.c:314: draw_pile(pile->top, dynamic_metasprite.data_0, pile->height);
;c
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	b, a
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	call	_draw_pile
	add	sp, #4
;src/main.c:315: if (dynamic_metasprite.data_0 == 9u) {
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	c, (hl)
	ld	a, c
	sub	a, #0x09
	jr	NZ, 00102$
;src/main.c:316: metasprite_2x3_hide(SPRITE_DYNAMIC);
	ld	a, #0x0c
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:317: flags &= ~FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfb
	ld	(hl), a
;src/main.c:318: dynamic_metasprite.target_frames = -1;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0xff
;src/main.c:319: return;
	jr	00103$
00102$:
;src/main.c:321: pile++;
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
;src/main.c:322: dynamic_metasprite.data_0++;
	inc	c
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), c
;src/main.c:323: dynamic_metasprite.dist[0] += 16;
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
;src/main.c:324: dynamic_metasprite.dist[1] = (INT16)(SCOREBAR_HEIGHT + pile->height) * 8;
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
;src/main.c:325: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
00103$:
;src/main.c:326: }
	add	sp, #4
	ret
;src/main.c:328: void dynamic_metasprite_deal(void)
;	---------------------------------
; Function dynamic_metasprite_deal
; ---------------------------------
_dynamic_metasprite_deal::
;src/main.c:330: Pile *pile = IDX_PTR(piles, 0);
;src/main.c:331: dynamic_metasprite.src[0] = 0;
	ld	hl, #_dynamic_metasprite
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:332: dynamic_metasprite.src[1] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:333: dynamic_metasprite.dist[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:334: dynamic_metasprite.dist[1] = (INT16)(SCOREBAR_HEIGHT + pile->height) * 8;
	ld	a, (#(_piles + 0x0004) + 0)
	ld	h, #0x00
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	a,h
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	(hl), c
	inc	hl
	ld	(hl), b
;src/main.c:335: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:336: dynamic_metasprite.target_frames = MOVE_TARGET_FRAMES;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0x10
;src/main.c:337: dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;src/main.c:338: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_BACK;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #0x20
;src/main.c:339: dynamic_metasprite.data_0 = 0;
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), #0x00
;src/main.c:340: dynamic_metasprite.callback = &dynamic_metasprite_deal_callback;
	ld	hl, #(_dynamic_metasprite + 0x0012)
	ld	(hl), #<(_dynamic_metasprite_deal_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_deal_callback)
;src/main.c:341: flags |= FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x04
	ld	(hl), a
;src/main.c:342: }
	ret
;src/main.c:371: void set_metasprite_card(const UINT8 card_data)
;	---------------------------------
; Function set_metasprite_card
; ---------------------------------
_set_metasprite_card::
;src/main.c:373: metasprite_t *iter = IDX_PTR(metasprite_custom_2x3, 0);
;src/main.c:374: (iter++)->dtile = OFFSET_CARD_RANK + RANK(card_data);
	ldhl	sp,	#2
	ld	a, (hl)
	and	a, #0x0f
	ld	c, a
	ld	hl, #(_metasprite_custom_2x3 + 0x0002)
	ld	(hl), c
;src/main.c:375: (iter++)->dtile = OFFSET_CARD_SUIT + SUIT(card_data);
	ld	de, #(_metasprite_custom_2x3 + 0x0004) + 2
	ldhl	sp,	#2
	ld	a, (hl)
	and	a, #0x30
	ld	l, a
	ld	h, #0x00
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	b, l
	ld	a, b
	add	a, #0x0d
	ld	(de), a
;src/main.c:376: (iter++)->dtile = OFFSET_CARD_BLANK + 2u;
	ld	hl, #(_metasprite_custom_2x3 + 0x000a)
	ld	(hl), #0x13
;src/main.c:377: (iter++)->dtile = OFFSET_CARD_BLANK + 3u;
	ld	hl, #(_metasprite_custom_2x3 + 0x000e)
	ld	(hl), #0x14
;src/main.c:378: (iter++)->dtile = OFFSET_CARD_SUIT_ROT + SUIT(card_data);
	ld	de, #(_metasprite_custom_2x3 + 0x0010) + 2
	ld	a, b
	add	a, #0x2a
	ld	(de), a
;src/main.c:379: (iter++)->dtile = OFFSET_CARD_RANK_ROT + RANK(card_data);
	ld	de, #(_metasprite_custom_2x3 + 0x0014) + 2
	ld	a, c
	add	a, #0x1d
	ld	(de), a
;src/main.c:380: }
	ret
;src/main.c:382: void dynamic_metasprite_unfold_callback(void)
;	---------------------------------
; Function dynamic_metasprite_unfold_callback
; ---------------------------------
_dynamic_metasprite_unfold_callback::
	add	sp, #-4
;src/main.c:384: Card *card = dynamic_metasprite.data_ptr;
	ld	hl, #(_dynamic_metasprite + 0x0010)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:385: if (!card->next_card) {
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:386: draw_card(dynamic_metasprite.data_1 / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 1u, card->data);
	inc	bc
	inc	bc
	inc	hl
	ld	a, c
	ld	(hl+), a
;src/main.c:385: if (!card->next_card) {
	ld	a, b
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jp	NZ, 00102$
;src/main.c:386: draw_card(dynamic_metasprite.data_1 / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 1u, card->data);
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
;src/main.c:228: draw_card_top(x, y, card_data);
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
;src/main.c:229: draw_card_bottom(x, y + 1u, card_data);
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
;src/main.c:387: metasprite_2x3_hide(SPRITE_DYNAMIC);
	ld	a, #0x0c
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:388: flags &= ~FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfb
	ld	(hl), a
;src/main.c:389: dynamic_metasprite.target_frames = -1;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0xff
;src/main.c:390: return;
	jr	00104$
00102$:
;src/main.c:392: dynamic_metasprite.data_ptr = card->next_card;
	pop	bc
	push	bc
	ld	hl, #(_dynamic_metasprite + 0x0010)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:393: dynamic_metasprite.src[1] += 8;
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
;src/main.c:394: draw_card_top(dynamic_metasprite.data_1 / 8u, dynamic_metasprite.src[1] / 8u, card->data);
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
;src/main.c:395: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
00104$:
;src/main.c:396: }
	add	sp, #4
	ret
;src/main.c:398: void dynamic_metasprite_move_stack_callback(void)
;	---------------------------------
; Function dynamic_metasprite_move_stack_callback
; ---------------------------------
_dynamic_metasprite_move_stack_callback::
;src/main.c:400: if (dynamic_metasprite.data_0 & BITMASK_DYNAMIC_METASPRITE_UNFOLD) {
	ld	bc, #_dynamic_metasprite+0
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	h, (hl)
;src/main.c:405: dynamic_metasprite.target_frames = FOLD_TARGET_FRAMES;
;src/main.c:400: if (dynamic_metasprite.data_0 & BITMASK_DYNAMIC_METASPRITE_UNFOLD) {
	add	hl, hl
	jr	NC, 00102$
;src/main.c:401: dynamic_metasprite.src[0] = dynamic_metasprite.data_1;
	ld	a, (#(_dynamic_metasprite + 0x000e) + 0)
	ld	e, a
	ld	d, #0x00
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:402: dynamic_metasprite.src[1] = dynamic_metasprite.data_2 - 8u;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, c
	add	a, #0x0f
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ld	e, a
	ld	d, #0x00
	ld	a, e
	add	a, #0xf8
	ld	e, a
	ld	a, d
	adc	a, #0xff
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/main.c:403: dynamic_metasprite.dist[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:404: dynamic_metasprite.dist[1] = 8;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	(hl), #0x08
	inc	hl
	ld	(hl), #0x00
;src/main.c:405: dynamic_metasprite.target_frames = FOLD_TARGET_FRAMES;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0x10
;src/main.c:406: dynamic_metasprite.callback = &dynamic_metasprite_unfold_callback;
	ld	hl, #(_dynamic_metasprite + 0x0012)
	ld	(hl), #<(_dynamic_metasprite_unfold_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_unfold_callback)
;src/main.c:407: dynamic_metasprite_unfold_callback();
	jp  _dynamic_metasprite_unfold_callback
00102$:
;src/main.c:409: flags &= ~FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfb
	ld	(hl), a
;src/main.c:410: dynamic_metasprite.target_frames = -1;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0xff
;src/main.c:412: }
	ret
;src/main.c:414: void dynamic_metasprite_fold_callback(void)
;	---------------------------------
; Function dynamic_metasprite_fold_callback
; ---------------------------------
_dynamic_metasprite_fold_callback::
;src/main.c:416: dynamic_metasprite.src[1] -= 8;
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
;src/main.c:417: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0009)
	ld	(hl), #0x00
;src/main.c:418: clear_bkg_2x1((UINT8)dynamic_metasprite.src[0] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 2u);
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
	ld	b, e
	srl	d
	rr	b
	srl	d
	rr	b
	srl	d
	rr	b
;src/main.c:203: set_bkg_tile_xy(x, y, OFFSET_BKG_NONE);
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
;src/main.c:204: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_NONE);
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
;src/main.c:419: if (dynamic_metasprite.data_0 & ~BITMASK_DYNAMIC_METASPRITE_UNFOLD) {
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	c, (hl)
	ld	a, c
	and	a, #0x7f
	jr	Z, 00104$
;src/main.c:420: dynamic_metasprite.data_0--;
	dec	c
	ld	hl, #(_dynamic_metasprite + 0x000d)
	ld	(hl), c
	ret
00104$:
;src/main.c:422: if (cursor.card_to_show)
	ld	hl, #(_cursor + 0x0002)
	ld	a, (hl+)
	ld	h, (hl)
	ld	l,a
	or	a,h
	jr	Z, 00102$
;src/main.c:423: draw_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u - 1u, cursor.card_to_show->data);
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	ld	b, l
	dec	b
	ld	hl, #_dynamic_metasprite
	ld	a, (hl+)
	ld	h, (hl)
	ld	d, a
	srl	h
	rr	d
	srl	h
	rr	d
	srl	h
	rr	d
;src/main.c:228: draw_card_top(x, y, card_data);
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ld	c, d
	push	bc
	call	_draw_card_top
	add	sp, #3
	pop	de
	pop	bc
;src/main.c:229: draw_card_bottom(x, y + 1u, card_data);
	inc	b
	ld	a, c
	push	af
	inc	sp
	ld	c, d
	push	bc
	call	_draw_card_bottom
	add	sp, #3
;src/main.c:423: draw_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u - 1u, cursor.card_to_show->data);
00102$:
;src/main.c:424: dynamic_metasprite.dist[0] = (INT16)dynamic_metasprite.data_1 - dynamic_metasprite.src[0];
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
;src/main.c:425: dynamic_metasprite.dist[1] = (INT16)dynamic_metasprite.data_2 - dynamic_metasprite.src[1];
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
	ld	(hl), c
	inc	hl
	ld	(hl), b
;src/main.c:426: dynamic_metasprite.target_frames = MOVE_TARGET_FRAMES;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0x10
;src/main.c:427: dynamic_metasprite.callback = &dynamic_metasprite_move_stack_callback;
	ld	hl, #(_dynamic_metasprite + 0x0012)
	ld	(hl), #<(_dynamic_metasprite_move_stack_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_move_stack_callback)
;src/main.c:430: }
	ret
;src/main.c:432: void dynamic_metasprite_fold(const UINT8 top_card_data, const UINT8 src_x, const UINT8 src_y, const UINT8 dest_x, const UINT8 dest_y, const UINT8 stack_height, const Card *base_card, const UINT8 unfold)
;	---------------------------------
; Function dynamic_metasprite_fold
; ---------------------------------
_dynamic_metasprite_fold::
;src/main.c:434: set_metasprite_card(top_card_data);
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_metasprite_card
	inc	sp
;src/main.c:436: dynamic_metasprite.metasprite = metasprite_custom_2x3;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #<(_metasprite_custom_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_custom_2x3)
;src/main.c:437: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_CARD;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #0x09
;src/main.c:439: dynamic_metasprite.data_1 = dest_x;
	ld	de, #(_dynamic_metasprite + 0x000e)
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;src/main.c:440: dynamic_metasprite.data_2 = dest_y;
	ld	de, #(_dynamic_metasprite + 0x000f)
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:441: dynamic_metasprite.data_ptr = base_card;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #(_dynamic_metasprite + 0x0010)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:443: dynamic_metasprite.src[0] = src_x;
	ldhl	sp,	#3
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #_dynamic_metasprite
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:444: dynamic_metasprite.src[1] = src_y + 8u;
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
;src/main.c:446: dynamic_metasprite.data_0 = (stack_height - 1u) | unfold;
	ld	bc, #_dynamic_metasprite + 13
	ldhl	sp,	#7
	ld	a, (hl)
	dec	a
	ldhl	sp,	#10
	or	a, (hl)
	ld	(bc), a
;src/main.c:448: flags |= FLAG_PLAYING_ANIMATION;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x04
	ld	(hl), a
;src/main.c:450: if (stack_height > 1) {
	ld	a, #0x01
	ldhl	sp,	#7
	sub	a, (hl)
	jp	NC,_dynamic_metasprite_fold_callback
;src/main.c:451: dynamic_metasprite.dist[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0004)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:452: dynamic_metasprite.dist[1] = -8;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	(hl), #0xf8
	inc	hl
	ld	(hl), #0xff
;src/main.c:453: dynamic_metasprite.target_frames = FOLD_TARGET_FRAMES;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #0x10
;src/main.c:454: dynamic_metasprite.callback = &dynamic_metasprite_fold_callback;
	ld	hl, #(_dynamic_metasprite + 0x0012)
	ld	(hl), #<(_dynamic_metasprite_fold_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_fold_callback)
;src/main.c:456: dynamic_metasprite_fold_callback();
;src/main.c:457: }
	jp  _dynamic_metasprite_fold_callback
;src/main.c:459: void pile_append_cursor_stack(Pile *pile)
;	---------------------------------
; Function pile_append_cursor_stack
; ---------------------------------
_pile_append_cursor_stack::
	add	sp, #-10
;src/main.c:461: if (pile->height)
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
;c
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
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
	ld	c, a
;src/main.c:462: pile->top->next_card = cursor.held_card;
;c
	ldhl	sp,#6
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
	ld	(hl), a
;src/main.c:461: if (pile->height)
	ld	a, c
	or	a, a
	jr	Z, 00102$
;src/main.c:462: pile->top->next_card = cursor.held_card;
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
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00103$
00102$:
;src/main.c:464: pile->base = cursor.held_card;
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00103$:
;src/main.c:466: Pile *src_pile = IDX_PTR(piles, cursor.pile_idx);
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
	ldhl	sp,	#0
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/main.c:467: Card *top_card = cursor.held_card;
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:468: while (top_card->next_card)
00104$:
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	h, (hl)
	ld	l,a
	or	a,h
	jr	Z, 00106$
;src/main.c:469: top_card = top_card->next_card;
	ld	c, l
	ld	b, h
	jr	00104$
00106$:
;src/main.c:470: pile->top = top_card;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:471: if (cursor.hand_pile_idx != cursor.pile_idx) {
	ld	a, (#(_cursor + 0x0005) + 0)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#(_cursor + 0x0006) + 0)
	ldhl	sp,	#9
	ld	(hl), a
;src/main.c:478: cursor.held_stack_size,
;src/main.c:471: if (cursor.hand_pile_idx != cursor.pile_idx) {
	ldhl	sp,	#8
	ld	a, (hl+)
	sub	a, (hl)
	jr	Z, 00110$
;src/main.c:472: if (cursor.card_to_show)
	ld	hl, #_cursor + 2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l,a
	or	a,h
	jr	Z, 00108$
;src/main.c:473: cursor.card_to_show->data |= BITMASK_DATA_VISIBLE;
	inc	hl
	inc	hl
	set	6, (hl)
00108$:
;src/main.c:479: cursor.held_card,
	ld	de, #_cursor
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:478: cursor.held_stack_size,
	ld	a, (#(_cursor + 0x0004) + 0)
	ldhl	sp,	#6
	ld	(hl), a
;src/main.c:477: (pile->height + SCOREBAR_HEIGHT + 1u) * 8u,
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x04
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	ld	(hl), a
;src/main.c:476: (src_pile->height + SCOREBAR_HEIGHT + cursor.held_stack_size) * 8u, cursor.hand_pile_idx * 16u,
	ld	a, (#(_cursor + 0x0005) + 0)
	swap	a
	and	a, #0xf0
	inc	hl
	ld	(hl), a
;c
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, #0x03
	ldhl	sp,	#6
	add	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#9
	ld	(hl), a
;src/main.c:475: cursor.pile_idx * 16u,
	ld	a, (#(_cursor + 0x0006) + 0)
	swap	a
	and	a, #0xf0
	ld	e, a
;src/main.c:474: dynamic_metasprite_fold(top_card->data,
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	c, a
	ld	a, #0x80
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	d, (hl)
	push	de
	ld	a, c
	push	af
	inc	sp
	call	_dynamic_metasprite_fold
	add	sp, #9
00110$:
;src/main.c:484: pile->height += cursor.held_stack_size;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	hl, #(_cursor + 0x0004)
	ld	c, (hl)
	add	a, c
	ld	c, a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;src/main.c:485: cursor.held_card = NULL;
	ld	hl, #_cursor
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:486: cursor.pile_idx = cursor.hand_pile_idx;
	ld	a, (#(_cursor + 0x0005) + 0)
	ld	(#(_cursor + 0x0006)),a
;src/main.c:487: cursor.height = pile->height;
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), c
;src/main.c:488: flags |= FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x01
	ld	(hl), a
;src/main.c:489: }
	add	sp, #10
	ret
;src/main.c:611: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-8
;src/main.c:613: initrand(DIV_REG);
	ldh	a, (_DIV_REG+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	call	_initrand
	add	sp, #2
;src/main.c:615: set_bkg_data(OFFSET_BKG_CARD, N_CARD, card_textures);
	ld	hl, #_card_textures
	push	hl
	ld	de, #0x2e01
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/main.c:617: init_deck();
	call	_init_deck
;src/main.c:619: draw_background();
	call	_draw_background
;src/main.c:620: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;src/main.c:622: set_sprite_data(OFFSET_SPRITE_CURSOR, N_CURSOR, cursor_textures);
	ld	hl, #_cursor_textures
	push	hl
	ld	de, #0x0801
	push	de
	call	_set_sprite_data
	add	sp, #4
;src/main.c:623: set_sprite_data(OFFSET_SPRITE_CARD, N_CARD, card_textures);
	ld	hl, #_card_textures
	push	hl
	ld	de, #0x2e09
	push	de
	call	_set_sprite_data
	add	sp, #4
;src/main.c:624: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;src/main.c:626: while (1) {
00102$:
;src/main.c:506: UINT8 input = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), e
;src/main.c:507: UINT8 new_input = input & ~prev_input;
	ld	a, (#_main_prev_input_327680_269)
	cpl
	ldhl	sp,	#0
	and	a, (hl)
	inc	hl
	ld	(hl), a
;src/main.c:508: if (cursor.held_card) {
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:509: flags |= FLAG_REDRAW_HAND;
	ld	hl, #_flags
	ld	e, (hl)
;src/main.c:511: && cursor.hand_pile_idx != 0) {
	ldhl	sp,	#1
	ld	a, (hl)
	and	a, #0x02
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
;src/main.c:514: && cursor.hand_pile_idx < 9) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	and	a, #0x01
	ldhl	sp,	#4
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:518: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#1
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:508: if (cursor.held_card) {
	ld	a, b
	or	a, c
	jp	Z, 00170$
;src/main.c:509: flags |= FLAG_REDRAW_HAND;
	ld	a, e
	or	a, #0x02
	ld	(#_flags),a
;src/main.c:511: && cursor.hand_pile_idx != 0) {
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00109$
	ld	bc, #_cursor+5
	ld	a, (bc)
	or	a, a
	jr	Z, 00109$
;src/main.c:512: cursor.hand_pile_idx--;
	dec	a
	ld	(bc), a
	jr	00110$
00109$:
;src/main.c:514: && cursor.hand_pile_idx < 9) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00110$
	ld	bc, #_cursor+5
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00110$
;src/main.c:515: cursor.hand_pile_idx++;
	inc	a
	ld	(bc), a
00110$:
;src/main.c:518: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00171$
	ld	a, (#_flags)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	bit	2, c
	jp	Z,00171$
;src/main.c:493: Pile *pile = IDX_PTR(piles, cursor.hand_pile_idx);
	ld	hl, #_cursor + 5
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
	ldhl	sp,	#6
	ld	(hl), b
	inc	hl
	ld	(hl), a
;src/main.c:494: if (cursor.hand_pile_idx == cursor.pile_idx) {
	ld	a, (#(_cursor + 0x0006) + 0)
	sub	a, c
	jr	NZ, 00116$
;src/main.c:495: pile_append_cursor_stack(pile);
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_pile_append_cursor_stack
	add	sp, #2
	jp	00171$
00116$:
;src/main.c:496: } else if (!pile->height
;c
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00114$
;src/main.c:497: || RANK(pile->top->data) == RANK(cursor.held_card->data) + 1u) {
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, (bc)
	and	a, #0x0f
	ld	c, a
	ld	b, #0x00
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
	ld	a, c
	sub	a, e
	jp	NZ,00171$
	ld	a, b
	sub	a, d
	jp	NZ,00171$
00114$:
;src/main.c:498: pile_append_cursor_stack(pile);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_pile_append_cursor_stack
	add	sp, #2
;src/main.c:499: score--;
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
;src/main.c:519: cursor_place_stack();
	jp	00171$
00170$:
;src/main.c:522: flags |= FLAG_REDRAW_CURSOR;
	ld	a, e
	or	a, #0x01
	ld	(#_flags),a
;src/main.c:523: if (new_input & J_DOWN) {
	ldhl	sp,	#1
	bit	3, (hl)
	jr	Z, 00142$
;src/main.c:524: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	hl, #_cursor + 6
	ld	b, (hl)
	ld	a, b
;src/main.c:525: cursor.pile_idx = 0;
	sub	a,#0x0a
	jr	NZ, 00125$
	ld	(hl),a
	jr	00143$
00125$:
;src/main.c:526: else if (cursor.height < piles[cursor.pile_idx].height)
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
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
	ld	b, (hl)
	ld	a, c
	sub	a, b
	jr	NC, 00143$
;src/main.c:527: cursor.height++;
	inc	c
	ld	hl, #(_cursor + 0x0007)
	ld	(hl), c
	jr	00143$
00142$:
;src/main.c:528: } else if (new_input & J_UP) {
	ldhl	sp,	#1
	bit	2, (hl)
	jr	Z, 00140$
;src/main.c:529: if (cursor.height == 0)
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	or	a, a
	jr	NZ, 00129$
;src/main.c:530: cursor.pile_idx = PILE_IDX_DECK;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x0a
	jr	00143$
00129$:
;src/main.c:532: cursor.height--;
	ldhl	sp,	#5
	ld	a, (hl)
	dec	a
	ld	(#(_cursor + 0x0007)),a
	jr	00143$
00140$:
;src/main.c:534: && cursor.pile_idx != 0
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00138$
	ld	bc, #_cursor+6
	ld	a, (bc)
	or	a, a
	jr	Z, 00138$
;src/main.c:535: && cursor.pile_idx != PILE_IDX_DECK) {
	cp	a, #0x0a
	jr	Z, 00138$
;src/main.c:536: cursor.pile_idx--;
	dec	a
	ld	(bc), a
;src/main.c:537: cursor_adjust_height();
	call	_cursor_adjust_height
	jr	00143$
00138$:
;src/main.c:539: && cursor.pile_idx < 9) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00143$
	ld	bc, #_cursor+6
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00143$
;src/main.c:540: cursor.pile_idx++;
	inc	a
	ld	(bc), a
;src/main.c:541: cursor_adjust_height();
	call	_cursor_adjust_height
00143$:
;src/main.c:544: && ~flags & FLAG_PLAYING_ANIMATION) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00171$
	ld	a, (#_flags)
	ld	b, #0x00
	cpl
	ld	c, a
	ld	a, b
	cpl
	bit	2, c
	jp	Z,00171$
;src/main.c:545: if (cursor.pile_idx == PILE_IDX_DECK && top_card_idx != 104u)
	ld	hl, #(_cursor + 0x0006)
	ld	c, (hl)
	ld	a, c
	sub	a, #0x0a
	jp	NZ,00166$
	ld	a, (#_top_card_idx)
	sub	a, #0x68
	jp	Z,00166$
;src/main.c:347: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles
;src/main.c:348: for (i = 0; i < 10u; i++) {
	ld	e, #0x00
00196$:
;src/main.c:349: if (!pile->height)
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00171$
;src/main.c:351: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:348: for (i = 0; i < 10u; i++) {
	inc	e
	ld	a, e
	sub	a, #0x0a
	jr	C, 00196$
;src/main.c:354: pile = IDX_PTR(piles, 0);
	ldhl	sp,	#5
	ld	(hl), #<(_piles)
	inc	hl
	ld	(hl), #>(_piles)
;src/main.c:355: Card *deck_top = IDX_PTR(deck, top_card_idx);
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
;src/main.c:356: for (i = 0; i < 10u; i++) {
	ldhl	sp,	#7
	ld	(hl), #0x0a
00200$:
;src/main.c:357: pile->top->next_card = deck_top;
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
;src/main.c:358: pile->top = deck_top;
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:359: pile->height++;
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
;src/main.c:360: deck_top++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:361: pile++;
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
;src/main.c:356: for (i = 0; i < 10u; i++) {
	dec	(hl)
	ld	a, (hl)
	jr	NZ, 00200$
;src/main.c:363: top_card_idx += 10u;
	ld	hl, #_top_card_idx
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
;src/main.c:365: if (top_card_idx == 104u)
	ld	a, (hl)
	sub	a, #0x68
	jr	NZ, 00151$
;src/main.c:366: draw_sequential_card(0, 0, OFFSET_BKG_BLANK);
	ld	a, #0x12
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
00151$:
;src/main.c:368: dynamic_metasprite_deal();
	call	_dynamic_metasprite_deal
;src/main.c:546: deal();
	jp	00171$
00166$:
;src/main.c:280: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
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
;src/main.c:281: Card *top = pile->base;
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
;src/main.c:282: for (i = 1; i < cursor.height; i++)
	ld	b, #0x01
00202$:
	ld	hl, #(_cursor + 0x0007)
	ld	c, (hl)
	ld	a, b
	sub	a, c
	jr	NC, 00154$
;src/main.c:283: top = top->next_card;
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
;src/main.c:282: for (i = 1; i < cursor.height; i++)
	inc	b
	jr	00202$
00154$:
;src/main.c:284: Card *stack = cursor.height ? top->next_card : top;
	ld	a, c
	or	a, a
	jr	Z, 00206$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	jr	00207$
00206$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00207$:
	ldhl	sp,	#1
	ld	a, c
	ld	(hl+), a
;src/main.c:285: if (!VISIBLE(stack->data))
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	bit	6, (hl)
	jp	Z,00171$
;src/main.c:288: Card *card = stack;
	ldhl	sp,#1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:289: while (card->next_card) {
00157$:
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	h, (hl)
	ld	l,a
	or	a,h
	jr	Z, 00161$
;src/main.c:290: UINT8 prev_data = card->data;
	inc	bc
	inc	bc
	ld	a, (bc)
;src/main.c:291: card = card->next_card;
;src/main.c:292: if (prev_data != card->data + 1u)
	ld	c,l
	ld	b,h
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	inc	de
	ld	l, a
	ld	h, #0x00
	ld	a, l
	sub	a, e
	jp	NZ,00171$
	ld	a, h
	sub	a, d
	jr	Z, 00157$
;src/main.c:293: return;
	jp	00171$
00161$:
;src/main.c:296: cursor.held_card = stack;
	ld	de, #_cursor
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:297: cursor.hand_pile_idx = cursor.pile_idx;
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	(#(_cursor + 0x0005)),a
;src/main.c:298: cursor.held_stack_size = pile->height - cursor.height + !!cursor.height;//NOTE: this is somewhat jank and may cause problems
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
	ld	e, a
	ld	a, l
	sub	a,#0x01
	ld	a, #0x00
	rla
	xor	a, #0x01
	add	a, e
	ld	(#(_cursor + 0x0004)),a
;src/main.c:299: pile->height = cursor.height - !!cursor.height;
	ld	hl, #(_cursor + 0x0007)
	ld	l, (hl)
	ld	a, l
	sub	a,#0x01
	ld	a, #0x00
	rla
	xor	a, #0x01
	ld	e, a
	ld	a, l
	sub	a, e
	ld	(bc), a
;src/main.c:300: if (cursor.height) {
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#5
	ld	(hl), a
;src/main.c:301: pile->top = top;
	ldhl	sp,#3
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
;src/main.c:303: cursor.card_to_show = top;
;src/main.c:300: if (cursor.height) {
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00163$
;src/main.c:301: pile->top = top;
	inc	hl
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/main.c:302: top->next_card = NULL;
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:303: cursor.card_to_show = top;
	ld	de, #(_cursor + 0x0002)
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
	jr	00171$
00163$:
;src/main.c:305: pile->base = NULL;
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:306: pile->top = NULL;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/main.c:307: cursor.card_to_show = NULL;
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:548: cursor_grab_stack();
00171$:
;src/main.c:551: prev_input = input;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_main_prev_input_327680_269),a
;src/main.c:556: cursor.anim_ctr++;
	ld	hl, #_cursor + 8
	ld	c, (hl)
	inc	c
	ld	(hl), c
;src/main.c:557: cursor.anim_ctr &= (1u << (CURSOR_PERIOD + 1u)) - 1u;
	res	7, c
	ld	(hl), c
;src/main.c:558: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	a, (#(_cursor + 0x0009) + 0)
;src/main.c:559: cursor.anim_frame = cursor.anim_ctr >> CURSOR_PERIOD;
	push	af
	ld	a, c
	rlca
	rlca
	and	a, #0x03
	ld	c, a
	pop	af
	ld	hl, #(_cursor + 0x0009)
	ld	(hl), c
;src/main.c:560: if (cursor.anim_frame != prev_anim_frame)
	sub	a, c
	jr	Z, 00174$
;src/main.c:561: flags |= FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	or	a, #0x01
	ld	(hl), a
00174$:
;src/main.c:563: if (flags & FLAG_REDRAW_CURSOR) {
	ld	a, (#_flags)
	rrca
	jr	NC, 00181$
;src/main.c:564: flags &= ~FLAG_REDRAW_CURSOR;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfe
	ld	(hl), a
;src/main.c:565: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	hl, #_cursor + 6
	ld	c, (hl)
;src/main.c:558: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	a, (#(_cursor + 0x0009) + 0)
;src/main.c:566: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	ld	e, l
	ld	d, h
;src/main.c:565: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	a, c
	sub	a, #0x0a
	jr	NZ, 00178$
;src/main.c:566: move_metasprite(cursor_metasprites[cursor.anim_frame],
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
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:571: );
	jr	00181$
00178$:
;src/main.c:577: SCOREBAR_HEIGHT * 8u  + (cursor.height << 3u)
	ld	a, (#_cursor + 7)
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x18
	ld	b, a
;src/main.c:576: cursor.pile_idx << 4u,
	ld	a, c
	swap	a
	and	a, #0xf0
	ld	c, a
;src/main.c:573: move_metasprite(cursor_metasprites[cursor.anim_frame],
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
	xor	a, a
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:578: );
00181$:
;src/main.c:580: if (flags & FLAG_REDRAW_HAND) {
	ld	a, (#_flags)
	bit	1, a
	jr	Z, 00188$
;src/main.c:581: flags &= ~FLAG_REDRAW_HAND;
	ld	hl, #_flags
	ld	a, (hl)
	and	a, #0xfd
	ld	(hl), a
;src/main.c:582: if (cursor.held_card)
	ld	hl, #_cursor
	ld	a, (hl+)
	or	a,(hl)
	jr	Z, 00184$
;src/main.c:587: SCOREBAR_HEIGHT * 8u + (piles[cursor.hand_pile_idx].height << 3u)
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
	ld	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x18
	ld	d, a
;src/main.c:586: cursor.hand_pile_idx << 4u,
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
;src/main.c:588: );
	jr	00188$
00184$:
;src/main.c:590: metasprite_2x3_hide(SPRITE_HAND);
	ld	a, #0x06
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:629: cursor_process();
00188$:
;src/main.c:596: if (dynamic_metasprite.elapsed_frames >= dynamic_metasprite.target_frames)
	ld	a, (#(_dynamic_metasprite + 0x0009) + 0)
	ldhl	sp,	#7
	ld	(hl), a
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	c, (hl)
	ld	e, c
	ldhl	sp,	#7
	ld	d, (hl)
	ld	a, (hl)
	sub	a, c
	bit	7, e
	jr	Z, 00463$
	bit	7, d
	jr	NZ, 00464$
	cp	a, a
	jr	00464$
00463$:
	bit	7, d
	jr	Z, 00464$
	scf
00464$:
	jp	NC, 00195$
;src/main.c:599: dynamic_metasprite.elapsed_frames++;
	ldhl	sp,	#7
	ld	a, (hl)
	inc	a
	dec	hl
	ld	(hl), a
	ld	de, #(_dynamic_metasprite + 0x0009)
	ld	a, (hl)
	ld	(de), a
;src/main.c:604: dynamic_metasprite.src[1] + (dynamic_metasprite.dist[1] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames)
	ld	a, (#(_dynamic_metasprite + 0x0002) + 0)
	ldhl	sp,	#7
	ld	(hl), a
	ld	hl, #_dynamic_metasprite + 6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	__mulint
	add	sp, #4
	ld	c, e
	ld	b, d
	ld	a, (#(_dynamic_metasprite + 0x0008) + 0)
	ldhl	sp,	#4
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	__divsint
	add	sp, #4
	ld	a, e
	ldhl	sp,	#7
	add	a, (hl)
	dec	hl
	ld	(hl), a
;src/main.c:603: dynamic_metasprite.src[0] + (dynamic_metasprite.dist[0] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames),
	ld	a, (#_dynamic_metasprite + 0)
	ldhl	sp,	#7
	ld	(hl), a
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	__mulint
	add	sp, #4
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	ld	a, e
	ldhl	sp,	#7
	add	a, (hl)
	ld	b, a
;src/main.c:601: dynamic_metasprite.metasprite_offset,
	ld	a, (#(_dynamic_metasprite + 0x000c) + 0)
	ld	(#___current_base_tile),a
;src/main.c:600: move_metasprite(dynamic_metasprite.metasprite,
	ld	hl, #_dynamic_metasprite + 10
	ld	a, (hl+)
	ld	c, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), c
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ld	c, #0x0c
	push	bc
	call	___move_metasprite
	add	sp, #3
;src/main.c:606: if (dynamic_metasprite.elapsed_frames == dynamic_metasprite.target_frames
	ld	a, (#(_dynamic_metasprite + 0x0009) + 0)
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	c, (hl)
	sub	a, c
	jr	NZ, 00195$
;src/main.c:607: && dynamic_metasprite.callback)
	ld	hl, #_dynamic_metasprite + 18
	ld	a, (hl+)
	ld	c, a
	ld	h, (hl)
	ld	a, h
	or	a, c
	jr	Z, 00195$
;src/main.c:608: dynamic_metasprite.callback();
	ld	l, c
	call	___sdcc_call_hl
;src/main.c:631: dynamic_metasprite_process();
00195$:
;src/main.c:633: wait_vbl_done();
	call	_wait_vbl_done
	jp	00102$
;src/main.c:635: }
	add	sp, #8
	ret
	.area _CODE
	.area _CABS (ABS)
