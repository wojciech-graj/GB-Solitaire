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
	.globl _dynamic_metasprite_deal
	.globl _dynamic_metasprite_deal_callback
	.globl _cursor_adjust_height
	.globl _draw_background
	.globl _draw_card
	.globl _draw_pile
	.globl _init_deck
	.globl _metasprite_2x3_hide
	.globl _rand
	.globl _initrand
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _get_bkg_xy_addr
	.globl _wait_vbl_done
	.globl _joypad
	.globl _cursor
	.globl _dynamic_metasprite
	.globl _score
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
_score::
	.ds 2
_dynamic_metasprite::
	.ds 14
_cursor::
	.ds 11
_input_process_prev_input_65536_182:
	.ds 1
_main_prev_input_327680_236:
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
;src/main.c:378: static UINT8 prev_input = 0;
	ld	hl, #_input_process_prev_input_65536_182
	ld	(hl), #0x00
	ld	hl, #_main_prev_input_327680_236
	ld	(hl), #0x00
;src/main.c:103: UINT16 score = 500;
	ld	hl, #_score
	ld	(hl), #0xf4
	inc	hl
	ld	(hl), #0x01
;src/main.c:105: DynamicMetaSprite dynamic_metasprite = {
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	(hl), #0xff
	ld	hl, #(_dynamic_metasprite + 0x0007)
	ld	(hl), #0x00
;src/main.c:110: Cursor cursor = {
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
	ld	hl, #(_cursor + 0x000a)
	ld	(hl), #0x01
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:121: void metasprite_2x3_hide(UINT8 sprite)
;	---------------------------------
; Function metasprite_2x3_hide
; ---------------------------------
_metasprite_2x3_hide::
;src/main.c:128: );
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
;src/main.c:128: );
;src/main.c:129: }
	ret
;src/main.c:132: void init_deck(void)
;	---------------------------------
; Function init_deck
; ---------------------------------
_init_deck::
	add	sp, #-16
;src/main.c:134: Card *card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:139: for (suit = 0; suit < 4u; suit++) {
	xor	a, a
	ldhl	sp,	#11
	ld	(hl), a
;src/main.c:140: for (rank = 0; rank < 13u; rank++) {
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
;src/main.c:141: for (i = 0; i < 2u; i++) {
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
;src/main.c:142: card->data = rank | (suit << BIT_OFFSET_DATA_SUIT);
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
;src/main.c:143: card++;
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
;src/main.c:141: for (i = 0; i < 2u; i++) {
	dec	(hl)
	jr	NZ, 00113$
;src/main.c:140: for (rank = 0; rank < 13u; rank++) {
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
;src/main.c:139: for (suit = 0; suit < 4u; suit++) {
	dec	hl
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00131$
;src/main.c:148: card = IDX_PTR(deck, 103u);
	inc	hl
	inc	hl
	ld	a, #<((_deck + 0x0135))
	ld	(hl+), a
	ld	(hl), #>((_deck + 0x0135))
;src/main.c:149: for (i = 103u; i; i--) {
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
;src/main.c:150: Card *swap = IDX_PTR(deck, (UINT8)rand() % i);
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
;src/main.c:152: temp = *card;
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
;src/main.c:153: *card = *swap;
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
;src/main.c:154: *swap = temp;
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
;src/main.c:155: card--;
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
;src/main.c:149: for (i = 103u; i; i--) {
	ld	a, e
	ld	(hl+), a
	inc	hl
	dec	(hl)
	jr	NZ, 00118$
;src/main.c:158: card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:159: for (i = 0; i < 44u; i++) {
	xor	a, a
	ld	(hl), a
00120$:
;src/main.c:160: card->next_card = IDX_PTR(deck, i + 10u);
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
;src/main.c:161: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:159: for (i = 0; i < 44u; i++) {
	ldhl	sp,	#15
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x2c
	jr	C, 00120$
	ld	e, (hl)
00123$:
;src/main.c:163: for (; i < 104u; i++) {
	ld	a, e
	sub	a, #0x68
	jr	NC, 00106$
;src/main.c:164: card->data |= BITMASK_DATA_VISIBLE;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	set	6, (hl)
;src/main.c:165: card->next_card = NULL;
	ld	l, c
	ld	h, b
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:166: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:163: for (; i < 104u; i++) {
	inc	e
	jr	00123$
00106$:
;src/main.c:169: card = IDX_PTR(deck, 0);
	ldhl	sp,	#11
	ld	a, #<(_deck)
	ld	(hl+), a
;src/main.c:170: Pile *pile = IDX_PTR(piles, 0);
	ld	a, #>(_deck)
	ld	(hl+), a
	ld	a, #<(_piles)
	ld	(hl+), a
	ld	(hl), #>(_piles)
;src/main.c:171: for (i = 0; i < 10; i++) {
	xor	a, a
	inc	hl
	ld	(hl), a
00125$:
;src/main.c:172: pile->base = card;
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
;src/main.c:174: pile->top = IDX_PTR(deck, 50u + i);
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
;src/main.c:175: pile->height = 5u;
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
;src/main.c:173: if (i < 4u) {
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00108$
;src/main.c:174: pile->top = IDX_PTR(deck, 50u + i);
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
;src/main.c:175: pile->height = 5u;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x05
	jr	00109$
00108$:
;src/main.c:177: pile->top = IDX_PTR(deck, 40u + i);
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
;src/main.c:178: pile->height = 4u;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x04
00109$:
;src/main.c:181: card++;
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
;src/main.c:182: pile++;
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
;src/main.c:171: for (i = 0; i < 10; i++) {
	ld	(hl+), a
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0a
	jp	C, 00125$
;src/main.c:185: top_card_idx = 54u;
	ld	hl, #_top_card_idx
	ld	(hl), #0x36
;src/main.c:186: }
	add	sp, #16
	ret
;src/main.c:188: void draw_pile(Card *card, UINT8 pile_idx, UINT8 height)
;	---------------------------------
; Function draw_pile
; ---------------------------------
_draw_pile::
	add	sp, #-8
;src/main.c:190: pile_idx <<= 1;
	ldhl	sp,	#12
	ld	a, (hl)
	add	a, a
;src/main.c:191: height += SCOREBAR_HEIGHT;
	ld	(hl+), a
	inc	(hl)
	inc	(hl)
	inc	(hl)
;src/main.c:192: while (1) {
	dec	hl
	ld	a, (hl)
	inc	a
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
00107$:
;src/main.c:193: if (VISIBLE(card->data)) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0002
	add	hl, bc
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
	bit	6, a
	jr	Z, 00102$
;src/main.c:194: set_bkg_tile_xy(pile_idx, height, RANK(card->data) + OFFSET_BKG_RANK);
	and	a, #0x0f
	inc	a
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:195: set_bkg_tile_xy(pile_idx + 1u, height, SUIT(card->data) + OFFSET_BKG_SUIT);
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
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
	ld	a, l
	add	a, #0x0e
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
	jr	00103$
00102$:
;src/main.c:197: set_bkg_tile_xy(pile_idx, height, OFFSET_BKG_BACK);
	ld	a, #0x18
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:198: set_bkg_tile_xy(pile_idx + 1u, height, OFFSET_BKG_BACK + 1u);
	ld	a, #0x19
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
00103$:
;src/main.c:200: if (!card->next_card) {
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/main.c:201: set_bkg_tile_xy(pile_idx, ++height, OFFSET_BKG_BLANK + 2u);
	ld	(hl-), a
	dec	hl
	inc	(hl)
;src/main.c:200: if (!card->next_card) {
	inc	hl
	inc	hl
	ld	a, (hl-)
	or	a, (hl)
	jp	NZ, 00105$
;src/main.c:201: set_bkg_tile_xy(pile_idx, ++height, OFFSET_BKG_BLANK + 2u);
	ld	a, #0x14
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:202: set_bkg_tile_xy(pile_idx + 1u, height, OFFSET_BKG_BLANK + 3u);
	ld	a, #0x15
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:203: set_bkg_tile_xy(pile_idx, ++height, SUIT(card->data) + OFFSET_BKG_SUIT_ROT);
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#0
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	and	a, #0x30
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl)
	add	a, #0x2b
	ld	d, a
	dec	hl
	ld	b, (hl)
	inc	b
	ldhl	sp,	#13
	ld	(hl), b
	ld	e, b
	push	de
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:204: set_bkg_tile_xy(pile_idx + 1u, height, RANK(card->data) + OFFSET_BKG_RANK_ROT);
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	and	a, #0x0f
	add	a, #0x1e
	push	af
	inc	sp
	push	bc
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:205: break;
	jr	00118$
00105$:
;src/main.c:208: height++;
;src/main.c:209: card = card->next_card;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), e
	jp	00107$
;src/main.c:213: while (*get_bkg_xy_addr(pile_idx, ++height)) {
00118$:
	ldhl	sp,	#13
	ld	b, (hl)
00109$:
	inc	b
	push	bc
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_get_bkg_xy_addr
	add	sp, #2
	ld	a, (de)
	or	a, a
	jr	Z, 00112$
;src/main.c:214: set_bkg_tile_xy(pile_idx, height, OFFSET_BKG_NONE);
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:215: set_bkg_tile_xy(pile_idx + 1u, height, OFFSET_BKG_NONE);
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
	jr	00109$
00112$:
;src/main.c:217: }
	add	sp, #8
	ret
;src/main.c:219: void draw_card(UINT8 x, UINT8 y, UINT8 bkg_offset)
;	---------------------------------
; Function draw_card
; ---------------------------------
_draw_card::
;src/main.c:221: set_bkg_tile_xy(x, y, bkg_offset);
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
;src/main.c:222: set_bkg_tile_xy(x + 1u, y, bkg_offset + 1u);
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
;src/main.c:223: set_bkg_tile_xy(x, y + 1u, bkg_offset + 2u);
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
;src/main.c:224: set_bkg_tile_xy(x + 1u, y + 1u, bkg_offset + 3u);
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
;src/main.c:225: set_bkg_tile_xy(x, y + 2u, bkg_offset + 4u);
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
;src/main.c:226: set_bkg_tile_xy(x + 1u, y + 2u, bkg_offset + 5u);
	ldhl	sp,	#4
	ld	a, (hl)
	add	a, #0x05
	push	af
	inc	sp
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:227: }
	ret
;src/main.c:229: void draw_background(void)
;	---------------------------------
; Function draw_background
; ---------------------------------
_draw_background::
	add	sp, #-3
;src/main.c:232: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles+0
;src/main.c:233: for (i = 0; i < 10u; i++) {
	xor	a, a
	ldhl	sp,	#2
	ld	(hl), a
00102$:
;src/main.c:234: draw_pile(pile->base, i, 0);
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
;src/main.c:235: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:233: for (i = 0; i < 10u; i++) {
	ldhl	sp,	#2
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0a
	jr	C, 00102$
;src/main.c:237: draw_card(0, 0, OFFSET_BKG_BACK);
	ld	a, #0x18
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_draw_card
	add	sp, #3
;src/main.c:238: }
	add	sp, #3
	ret
;src/main.c:240: void cursor_adjust_height(void)
;	---------------------------------
; Function cursor_adjust_height
; ---------------------------------
_cursor_adjust_height::
;src/main.c:242: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
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
;src/main.c:243: if (cursor.height > pile->height)
	ld	bc, #_cursor + 7
	ld	a, (bc)
	ld	d, a
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
;src/main.c:244: cursor.height = pile->height;
	ld	a,e
	cp	a,d
	ret	NC
	ld	(bc), a
;src/main.c:245: }
	ret
;src/main.c:281: void dynamic_metasprite_deal_callback(void)
;	---------------------------------
; Function dynamic_metasprite_deal_callback
; ---------------------------------
_dynamic_metasprite_deal_callback::
	add	sp, #-4
;src/main.c:283: Pile *pile = IDX_PTR(piles, dynamic_metasprite.data);
	ld	hl, #(_dynamic_metasprite + 0x000b)
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
;src/main.c:284: draw_pile(pile->top, dynamic_metasprite.data, pile->height);
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
;src/main.c:285: if (dynamic_metasprite.data == 9u) {
	ld	hl, #(_dynamic_metasprite + 0x000b)
	ld	c, (hl)
	ld	a, c
	sub	a, #0x09
	jr	NZ, 00102$
;src/main.c:286: dynamic_metasprite.target_frames = -1;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	(hl), #0xff
;src/main.c:287: metasprite_2x3_hide(SPRITE_DYNAMIC);
	ld	a, #0x0c
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:288: return;
	jr	00103$
00102$:
;src/main.c:290: pile++;
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
;src/main.c:291: dynamic_metasprite.data++;
	inc	c
	ld	hl, #(_dynamic_metasprite + 0x000b)
	ld	(hl), c
;src/main.c:292: dynamic_metasprite.dist[0] += 16;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:293: dynamic_metasprite.dist[1] = (INT16)(SCOREBAR_HEIGHT + pile->height) * 8;
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
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:294: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0007)
	ld	(hl), #0x00
00103$:
;src/main.c:295: }
	add	sp, #4
	ret
;src/main.c:297: void dynamic_metasprite_deal(void)
;	---------------------------------
; Function dynamic_metasprite_deal
; ---------------------------------
_dynamic_metasprite_deal::
;src/main.c:299: Pile *pile = IDX_PTR(piles, 0);
;src/main.c:300: dynamic_metasprite.src[0] = 0;
	ld	hl, #_dynamic_metasprite
	ld	(hl), #0x00
;src/main.c:301: dynamic_metasprite.src[1] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0001)
	ld	(hl), #0x00
;src/main.c:302: dynamic_metasprite.dist[0] = 0;
	ld	hl, #(_dynamic_metasprite + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:303: dynamic_metasprite.dist[1] = (INT16)(SCOREBAR_HEIGHT + pile->height) * 8;
	ld	a, (#(_piles + 0x0004) + 0)
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
	ld	hl, #(_dynamic_metasprite + 0x0004)
	ld	(hl), c
	inc	hl
	ld	(hl), b
;src/main.c:304: dynamic_metasprite.elapsed_frames = 0;
	ld	hl, #(_dynamic_metasprite + 0x0007)
	ld	(hl), #0x00
;src/main.c:305: dynamic_metasprite.target_frames = DEAL_TARGET_FRAMES;
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	(hl), #0x0f
;src/main.c:306: dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	ld	hl, #(_dynamic_metasprite + 0x0008)
	ld	(hl), #<(_metasprite_sequential_2x3)
	inc	hl
	ld	(hl), #>(_metasprite_sequential_2x3)
;src/main.c:307: dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_BACK;
	ld	hl, #(_dynamic_metasprite + 0x000a)
	ld	(hl), #0x09
;src/main.c:308: dynamic_metasprite.data = 0;
	ld	hl, #(_dynamic_metasprite + 0x000b)
	ld	(hl), #0x00
;src/main.c:309: dynamic_metasprite.callback = &dynamic_metasprite_deal_callback;
	ld	hl, #(_dynamic_metasprite + 0x000c)
	ld	(hl), #<(_dynamic_metasprite_deal_callback)
	inc	hl
	ld	(hl), #>(_dynamic_metasprite_deal_callback)
;src/main.c:310: }
	ret
;src/main.c:339: void pile_append_cursor_stack(Pile *pile)
;	---------------------------------
; Function pile_append_cursor_stack
; ---------------------------------
_pile_append_cursor_stack::
	add	sp, #-8
;src/main.c:341: if (pile->height)
	ldhl	sp,	#10
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
	ld	c, a
;src/main.c:342: pile->top->next_card = cursor.held_card;
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
;src/main.c:341: if (pile->height)
	ld	a, c
	or	a, a
	jr	Z, 00102$
;src/main.c:342: pile->top->next_card = cursor.held_card;
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
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
;src/main.c:344: pile->base = cursor.held_card;
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00103$:
;src/main.c:346: Card *top_card = cursor.held_card;
	ld	hl, #_cursor
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:347: while (top_card->next_card)
00104$:
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	h, (hl)
	ld	l,a
	or	a,h
	jr	Z, 00106$
;src/main.c:348: top_card = top_card->next_card;
	ld	c, l
	ld	b, h
	jr	00104$
00106$:
;src/main.c:349: pile->top = top_card;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:350: pile->height += cursor.held_stack_size;
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
;src/main.c:351: cursor.held_card = NULL;
	ld	hl, #_cursor
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:352: if (cursor.card_to_show && cursor.hand_pile_idx != cursor.pile_idx)
	ld	hl, #(_cursor + 0x0002)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, b
	or	a, c
	jr	Z, 00108$
	ld	a, (#(_cursor + 0x0005) + 0)
	ld	hl, #(_cursor + 0x0006)
	ld	l, (hl)
	sub	a, l
	jr	Z, 00108$
;src/main.c:353: cursor.card_to_show->data |= BITMASK_DATA_VISIBLE;
	inc	bc
	inc	bc
	ld	a, (bc)
	set	6, a
	ld	(bc), a
00108$:
;src/main.c:354: cursor.card_to_show = NULL;
	ld	hl, #(_cursor + 0x0002)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:355: cursor.height = pile->height;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(#(_cursor + 0x0007)),a
;src/main.c:356: cursor.redraw |= BITMASK_REDRAW_CURSOR;
	ld	bc, #_cursor + 10
	ld	a, (bc)
	set	0, a
	ld	(bc), a
;src/main.c:358: draw_pile(piles[cursor.pile_idx].base, cursor.pile_idx, 0);
	ld	hl, #(_cursor + 0x0006)
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_piles
	add	hl, de
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	b, a
	push	bc
	push	hl
	call	_draw_pile
	add	sp, #4
;src/main.c:359: draw_pile(pile->base, cursor.hand_pile_idx, 0); //TODO: optimize
	ld	hl, #(_cursor + 0x0005)
	ld	b, (hl)
	pop	de
	push	de
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	push	hl
	call	_draw_pile
	add	sp, #4
;src/main.c:361: cursor.pile_idx = cursor.hand_pile_idx;
	ld	a, (#(_cursor + 0x0005) + 0)
	ld	(#(_cursor + 0x0006)),a
;src/main.c:362: }
	add	sp, #8
	ret
;src/main.c:482: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-10
;src/main.c:484: initrand(DIV_REG);
	ldh	a, (_DIV_REG+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	call	_initrand
	add	sp, #2
;src/main.c:486: set_bkg_data(OFFSET_BKG_CARD, N_CARD, card_textures);
	ld	hl, #_card_textures
	push	hl
	ld	de, #0x2e01
	push	de
	call	_set_bkg_data
	add	sp, #4
;src/main.c:488: init_deck();
	call	_init_deck
;src/main.c:490: draw_background();
	call	_draw_background
;src/main.c:491: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;src/main.c:493: set_sprite_data(OFFSET_SPRITE_CURSOR, N_CURSOR, cursor_textures);
	ld	hl, #_cursor_textures
	push	hl
	ld	de, #0x0801
	push	de
	call	_set_sprite_data
	add	sp, #4
;src/main.c:494: set_sprite_data(OFFSET_SPRITE_BACK, N_CARD_BACK, IDX_PTR(card_textures, SIZEOF_TILE * OFFSET_CARD_BACK));
	ld	hl, #(_card_textures + 0x0170)
	push	hl
	ld	de, #0x0609
	push	de
	call	_set_sprite_data
	add	sp, #4
;src/main.c:495: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;src/main.c:497: while (1) {
00102$:
;src/main.c:379: UINT8 input = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), e
;src/main.c:380: UINT8 new_input = input & ~prev_input;
	ld	a, (#_main_prev_input_327680_236)
	cpl
	ldhl	sp,	#0
	and	a, (hl)
	inc	hl
	ld	(hl), a
;src/main.c:381: if (cursor.held_card) {
	ld	de, #_cursor
	ld	a, (de)
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/main.c:384: && cursor.hand_pile_idx != 0) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	and	a, #0x02
	ldhl	sp,	#4
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:387: && cursor.hand_pile_idx < 9) {
	ldhl	sp,	#1
	ld	a, (hl)
	and	a, #0x01
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:390: if (new_input & J_A) {
	ldhl	sp,	#1
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#8
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/main.c:381: if (cursor.held_card) {
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00170$
;src/main.c:382: cursor.redraw |= BITMASK_REDRAW_HAND;
	ld	bc, #_cursor + 10
	ld	a, (bc)
	set	1, a
	ld	(bc), a
;src/main.c:384: && cursor.hand_pile_idx != 0) {
	ld	de, #_cursor + 5
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00109$
	ld	a, (de)
	or	a, a
	jr	Z, 00109$
;src/main.c:385: cursor.hand_pile_idx--;
	dec	a
	ld	(de), a
	jr	00110$
00109$:
;src/main.c:387: && cursor.hand_pile_idx < 9) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00110$
	ld	a, (de)
	cp	a, #0x09
	jr	NC, 00110$
;src/main.c:388: cursor.hand_pile_idx++;
	inc	a
	ld	(de), a
00110$:
;src/main.c:390: if (new_input & J_A) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00171$
;src/main.c:366: Pile *pile = IDX_PTR(piles, cursor.hand_pile_idx);
	ld	a, (de)
	ld	c, a
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
	ldhl	sp,	#8
	ld	(hl), b
	inc	hl
	ld	(hl), a
;src/main.c:367: if (cursor.hand_pile_idx == cursor.pile_idx) {
	ld	a, (#(_cursor + 0x0006) + 0)
	sub	a, c
	jr	NZ, 00115$
;src/main.c:368: pile_append_cursor_stack(pile);
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_pile_append_cursor_stack
	add	sp, #2
	jp	00171$
00115$:
;src/main.c:369: } else if (!pile->height
;c
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00113$
;src/main.c:370: || RANK(pile->top->data) == RANK(cursor.held_card->data) + 1u) {
	ldhl	sp,	#8
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
00113$:
;src/main.c:371: pile_append_cursor_stack(pile);
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_pile_append_cursor_stack
	add	sp, #2
;src/main.c:372: score--;
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
;src/main.c:391: cursor_place_stack();
	jp	00171$
00170$:
;src/main.c:394: cursor.redraw |= BITMASK_REDRAW_CURSOR;
	ld	bc, #_cursor + 10
	ld	a, (bc)
	set	0, a
	ld	(bc), a
;src/main.c:396: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	bc, #_cursor + 6
;src/main.c:398: else if (cursor.height < piles[cursor.pile_idx].height)
;src/main.c:395: if (new_input & J_DOWN) {
	ldhl	sp,	#1
	bit	3, (hl)
	jr	Z, 00141$
;src/main.c:396: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	a, (bc)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (hl)
	sub	a, #0x0a
	jr	NZ, 00124$
;src/main.c:397: cursor.pile_idx = 0;
	xor	a, a
	ld	(bc), a
	jr	00142$
00124$:
;src/main.c:398: else if (cursor.height < piles[cursor.pile_idx].height)
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#6
	ld	e, (hl)
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
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, e
	jr	NC, 00142$
;src/main.c:399: cursor.height++;
	ld	a, (hl)
	inc	a
	ld	(#(_cursor + 0x0007)),a
	jr	00142$
00141$:
;src/main.c:400: } else if (new_input & J_UP) {
	ldhl	sp,	#1
	bit	2, (hl)
	jr	Z, 00139$
;src/main.c:401: if (cursor.height == 0)
	ld	a, (#(_cursor + 0x0007) + 0)
	or	a, a
	jr	NZ, 00128$
;src/main.c:402: cursor.pile_idx = PILE_IDX_DECK;
	ld	a, #0x0a
	ld	(bc), a
	jr	00142$
00128$:
;src/main.c:404: cursor.height--;
	dec	a
	ld	(#(_cursor + 0x0007)),a
	jr	00142$
00139$:
;src/main.c:406: && cursor.pile_idx != 0
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00137$
	ld	a, (bc)
	or	a, a
	jr	Z, 00137$
;src/main.c:407: && cursor.pile_idx != PILE_IDX_DECK) {
	cp	a, #0x0a
	jr	Z, 00137$
;src/main.c:408: cursor.pile_idx--;
	dec	a
	ld	(bc), a
;src/main.c:409: cursor_adjust_height();
	push	bc
	call	_cursor_adjust_height
	pop	bc
	jr	00142$
00137$:
;src/main.c:411: && cursor.pile_idx < 9) {
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00142$
	ld	a, (bc)
	cp	a, #0x09
	jr	NC, 00142$
;src/main.c:412: cursor.pile_idx++;
	inc	a
	ld	(bc), a
;src/main.c:413: cursor_adjust_height();
	push	bc
	call	_cursor_adjust_height
	pop	bc
00142$:
;src/main.c:415: if (new_input & J_A) {
	ldhl	sp,	#9
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00171$
;src/main.c:416: if (cursor.pile_idx == PILE_IDX_DECK && top_card_idx != 104u)
	ld	a, (bc)
	ld	c, a
	sub	a, #0x0a
	jp	NZ,00166$
	ld	a, (#_top_card_idx)
	sub	a, #0x68
	jp	Z,00166$
;src/main.c:315: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles
;src/main.c:316: for (i = 0; i < 10u; i++) {
	ld	e, #0x00
00196$:
;src/main.c:317: if (!pile->height)
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00171$
;src/main.c:319: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
;src/main.c:316: for (i = 0; i < 10u; i++) {
	inc	e
	ld	a, e
	sub	a, #0x0a
	jr	C, 00196$
;src/main.c:322: pile = IDX_PTR(piles, 0);
	ld	bc, #_piles
;src/main.c:323: Card *deck_top = IDX_PTR(deck, top_card_idx);
	ld	hl, #_top_card_idx
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
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
	ld	hl, #_deck
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), e
	inc	hl
;src/main.c:324: for (i = 0; i < 10u; i++) {
	ld	(hl+), a
	ld	(hl), #0x0a
00200$:
;src/main.c:325: pile->top->next_card = deck_top;
	ld	hl, #0x0002
	add	hl, bc
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
	inc	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:326: pile->top = deck_top;
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:327: pile->height++;
	ld	hl, #0x0004
	add	hl, bc
	inc	(hl)
;src/main.c:328: deck_top++;
;c
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
;src/main.c:329: pile++;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	hl
;src/main.c:324: for (i = 0; i < 10u; i++) {
	dec	(hl)
	ld	a, (hl)
	jr	NZ, 00200$
;src/main.c:331: top_card_idx += 10u;
	ld	hl, #_top_card_idx
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
;src/main.c:333: if (top_card_idx == 104u)
	ld	a, (hl)
	sub	a, #0x68
	jr	NZ, 00149$
;src/main.c:334: draw_card(0, 0, OFFSET_BKG_BLANK);
	ld	a, #0x12
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_draw_card
	add	sp, #3
00149$:
;src/main.c:336: dynamic_metasprite_deal();
	call	_dynamic_metasprite_deal
;src/main.c:417: deal();
	jp	00171$
00166$:
;src/main.c:250: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, l
	add	a, #<(_piles)
	ld	c, a
	ld	a, h
	adc	a, #>(_piles)
	ld	b, a
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
;src/main.c:251: Card *top = pile->base;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#8
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/main.c:252: for (i = 1; i < cursor.height; i++)
	ld	(hl-), a
	dec	hl
	ld	(hl), #0x01
00202$:
	ld	a, (#(_cursor + 0x0007) + 0)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	sub	a, (hl)
	jr	NC, 00152$
;src/main.c:253: top = top->next_card;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/main.c:252: for (i = 1; i < cursor.height; i++)
	ld	(hl-), a
	dec	hl
	inc	(hl)
	jr	00202$
00152$:
;src/main.c:254: Card *stack = cursor.height ? top->next_card : top;
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	Z, 00206$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	jr	00207$
00206$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), e
00207$:
;src/main.c:255: if (!VISIBLE(stack->data))
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	bit	6, (hl)
	jp	Z,00171$
;src/main.c:258: Card *card = stack;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/main.c:259: while (card->next_card) {
00155$:
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	h, (hl)
	ld	l,a
	or	a,h
	jr	Z, 00159$
;src/main.c:260: UINT8 prev_data = card->data;
	inc	bc
	inc	bc
	ld	a, (bc)
;src/main.c:261: card = card->next_card;
;src/main.c:262: if (prev_data != card->data + 1u)
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
	jr	Z, 00155$
;src/main.c:263: return;
	jp	00171$
00159$:
;src/main.c:266: cursor.held_card = stack;
	ld	de, #_cursor
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:267: cursor.hand_pile_idx = cursor.pile_idx;
	ld	a, (#(_cursor + 0x0006) + 0)
	ld	(#(_cursor + 0x0005)),a
;src/main.c:268: cursor.held_stack_size = pile->height - cursor.height + !!cursor.height;//NOTE: this is somewhat jank and may cause problems
;c
	ldhl	sp,#4
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
;src/main.c:269: pile->height = cursor.height - !!cursor.height;
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
;src/main.c:270: if (cursor.height) {
	ld	a, (#(_cursor + 0x0007) + 0)
;src/main.c:271: pile->top = top;
	ldhl	sp,#4
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	bc
	inc	bc
;src/main.c:270: if (cursor.height) {
	or	a, a
	jr	Z, 00163$
;src/main.c:271: pile->top = top;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/main.c:272: top->next_card = NULL;
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:273: if (!VISIBLE(top->data))
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	bit	6, (hl)
	jr	NZ, 00171$
;src/main.c:274: cursor.card_to_show = top;
	ld	de, #(_cursor + 0x0002)
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
	jr	00171$
00163$:
;src/main.c:276: pile->base = NULL;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:277: pile->top = NULL;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/main.c:419: cursor_grab_stack();
00171$:
;src/main.c:422: prev_input = input;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_main_prev_input_327680_236),a
;src/main.c:427: cursor.anim_ctr++;
	ld	hl, #_cursor + 8
	ld	c, (hl)
	inc	c
	ld	(hl), c
;src/main.c:428: cursor.anim_ctr &= (1u << (CURSOR_PERIOD + 1u)) - 1u;
	res	7, c
	ld	(hl), c
;src/main.c:429: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	hl, #(_cursor + 0x0009)
	ld	b, (hl)
;src/main.c:430: cursor.anim_frame = cursor.anim_ctr >> CURSOR_PERIOD;
	ld	a, c
	rlca
	rlca
	and	a, #0x03
	ld	c, a
	ld	hl, #(_cursor + 0x0009)
	ld	(hl), c
;src/main.c:432: cursor.redraw |= BITMASK_REDRAW_CURSOR;
;src/main.c:431: if (cursor.anim_frame != prev_anim_frame)
	ld	a, b
	sub	a, c
	jr	Z, 00174$
;src/main.c:432: cursor.redraw |= BITMASK_REDRAW_CURSOR;
	ld	a, (#(_cursor + 0x000a) + 0)
	set	0, a
	ld	(#(_cursor + 0x000a)),a
00174$:
;src/main.c:434: if (cursor.redraw & BITMASK_REDRAW_CURSOR) {
	ld	a, (#(_cursor + 0x000a) + 0)
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#9
	bit	0, (hl)
	jr	Z, 00181$
;src/main.c:435: cursor.redraw &= ~BITMASK_REDRAW_CURSOR;
	ldhl	sp,	#9
	ld	a, (hl)
	res	0, a
	ld	(#(_cursor + 0x000a)),a
;src/main.c:436: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	hl, #_cursor + 6
	ld	c, (hl)
;src/main.c:429: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	a, (#(_cursor + 0x0009) + 0)
;src/main.c:437: move_metasprite(cursor_metasprites[cursor.anim_frame],
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	ld	e, l
	ld	d, h
;src/main.c:436: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	a, c
	sub	a, #0x0a
	jr	NZ, 00178$
;src/main.c:437: move_metasprite(cursor_metasprites[cursor.anim_frame],
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
;src/main.c:442: );
	jr	00181$
00178$:
;src/main.c:448: SCOREBAR_HEIGHT * 8u  + (cursor.height << 3u)
	ld	a, (#_cursor + 7)
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x18
	ld	b, a
;src/main.c:447: cursor.pile_idx << 4u,
	ld	a, c
	swap	a
	and	a, #0xf0
	ld	c, a
;src/main.c:444: move_metasprite(cursor_metasprites[cursor.anim_frame],
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
;src/main.c:449: );
00181$:
;src/main.c:434: if (cursor.redraw & BITMASK_REDRAW_CURSOR) {
	ld	a, (#(_cursor + 0x000a) + 0)
	ldhl	sp,	#9
	ld	(hl), a
;src/main.c:451: if (cursor.redraw & BITMASK_REDRAW_HAND) {
	ldhl	sp,	#9
	bit	1, (hl)
	jr	Z, 00188$
;src/main.c:452: cursor.redraw &= ~BITMASK_REDRAW_HAND;
	ldhl	sp,	#9
	ld	a, (hl)
	res	1, a
	ld	(#(_cursor + 0x000a)),a
;src/main.c:453: if (cursor.held_card)
	ld	hl, #_cursor
	ld	a, (hl+)
	or	a,(hl)
	jr	Z, 00184$
;src/main.c:458: SCOREBAR_HEIGHT * 8u + (piles[cursor.hand_pile_idx].height << 3u)
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
;src/main.c:457: cursor.hand_pile_idx << 4u,
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
;src/main.c:459: );
	jr	00188$
00184$:
;src/main.c:461: metasprite_2x3_hide(SPRITE_HAND);
	ld	a, #0x06
	push	af
	inc	sp
	call	_metasprite_2x3_hide
	inc	sp
;src/main.c:500: cursor_process();
00188$:
;src/main.c:467: if (dynamic_metasprite.elapsed_frames >= dynamic_metasprite.target_frames)
	ld	hl, #(_dynamic_metasprite + 0x0007)
	ld	c, (hl)
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	b, (hl)
	ld	e, b
	ld	a,c
	ld	d,a
	sub	a, b
	bit	7, e
	jr	Z, 00458$
	bit	7, d
	jr	NZ, 00459$
	cp	a, a
	jr	00459$
00458$:
	bit	7, d
	jr	Z, 00459$
	scf
00459$:
	jp	NC, 00195$
;src/main.c:470: dynamic_metasprite.elapsed_frames++;
	inc	c
	ld	hl, #(_dynamic_metasprite + 0x0007)
	ld	(hl), c
;src/main.c:475: dynamic_metasprite.src[1] + (dynamic_metasprite.dist[1] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames)
	ld	hl, #_dynamic_metasprite + 4
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
	ldhl	sp,	#9
	ld	(hl), e
	ldhl	sp,	#10
	ld	(hl), d
	pop	hl
	pop	bc
	ld	a, (#(_dynamic_metasprite + 0x0006) + 0)
	ldhl	sp,	#7
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
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	ld	hl, #(_dynamic_metasprite + 0x0001)
	ld	l, (hl)
	add	a, l
	ldhl	sp,	#9
	ld	(hl), a
;src/main.c:474: dynamic_metasprite.src[0] + (dynamic_metasprite.dist[0] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames),
	ld	hl, #(_dynamic_metasprite + 0x0002)
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	call	__mulint
	add	sp, #4
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	ld	a, e
	ld	hl, #_dynamic_metasprite
	ld	c, (hl)
	add	a, c
	ld	c, a
;src/main.c:472: dynamic_metasprite.metasprite_offset,
	ld	a, (#(_dynamic_metasprite + 0x000a) + 0)
	ld	(#___current_base_tile),a
;src/main.c:471: move_metasprite(dynamic_metasprite.metasprite,
	ld	hl, #_dynamic_metasprite + 8
	ld	a, (hl+)
	ld	b, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), b
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	ld	d, c
	ld	e,#0x0c
	push	de
	call	___move_metasprite
	add	sp, #3
;src/main.c:477: if (dynamic_metasprite.elapsed_frames == dynamic_metasprite.target_frames
	ld	a, (#(_dynamic_metasprite + 0x0007) + 0)
	ld	hl, #(_dynamic_metasprite + 0x0006)
	ld	c, (hl)
	sub	a, c
	jr	NZ, 00195$
;src/main.c:478: && dynamic_metasprite.callback)
	ld	hl, #_dynamic_metasprite + 12
	ld	a, (hl+)
	ld	c, a
	ld	h, (hl)
	ld	a, h
	or	a, c
	jr	Z, 00195$
;src/main.c:479: dynamic_metasprite.callback();
	ld	l, c
	call	___sdcc_call_hl
;src/main.c:502: dynamic_metasprite_process();
00195$:
;src/main.c:504: wait_vbl_done();
	call	_wait_vbl_done
	jp	00102$
;src/main.c:506: }
	add	sp, #10
	ret
	.area _CODE
	.area _CABS (ABS)
