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
	.globl _draw_background
	.globl _draw_pile
	.globl _init_deck
	.globl _printf
	.globl _rand
	.globl _initrand
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _delay
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
	.ds 20
_top_card_idx::
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
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:30: void init_deck(void)
;	---------------------------------
; Function init_deck
; ---------------------------------
_init_deck::
	add	sp, #-22
;src/main.c:32: Card *card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:37: for (suit = 0; suit < 4u; suit++) {
	xor	a, a
	ldhl	sp,	#17
	ld	(hl), a
;src/main.c:38: for (rank = 0; rank < 13u; rank++) {
00136$:
	xor	a, a
	ldhl	sp,	#18
	ld	(hl), a
;src/main.c:39: for (i = 0; i < 2u; i++) {
00134$:
	ldhl	sp,	#19
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	(hl), #0x02
00114$:
;src/main.c:40: card->rank = rank;
;c
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	inc	hl
	ld	a, (hl)
	and	a, #0x0f
	ld	c, a
	ld	a, (de)
	and	a, #0xf0
	or	a, c
	ld	(de), a
;src/main.c:41: card->suit = suit;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	swap	a
	and	a, #0x30
	ld	l, a
	ld	a, (bc)
	and	a, #0xcf
	or	a, l
	ld	(bc), a
;src/main.c:42: card->next_card = NULL;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:43: card++;
;c
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#21
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#20
	ld	(hl+), a
;src/main.c:39: for (i = 0; i < 2u; i++) {
	dec	(hl)
	jr	NZ, 00114$
;src/main.c:38: for (rank = 0; rank < 13u; rank++) {
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
	jr	C, 00134$
;src/main.c:37: for (suit = 0; suit < 4u; suit++) {
	dec	hl
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00136$
;src/main.c:48: card = IDX_PTR(deck, 103u);
	inc	hl
	inc	hl
	ld	a, #<((_deck + 0x0135))
	ld	(hl+), a
	ld	(hl), #>((_deck + 0x0135))
;src/main.c:49: for (i = 103u; i; i--) {
	ldhl	sp,	#10
	ld	a, l
	ld	d, h
	ldhl	sp,	#13
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	(hl+), a
	ld	(hl), e
	ldhl	sp,	#21
	ld	(hl), #0x67
00119$:
;src/main.c:50: Card *swap = IDX_PTR(deck, (UINT8)rand() % i);
	call	_rand
	ld	a, e
	ldhl	sp,	#21
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
	ldhl	sp,	#17
	ld	a, c
	ld	(hl+), a
;src/main.c:52: temp = *card;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0003
	push	hl
	push	de
	push	bc
	call	___memcpy
	add	sp, #6
;src/main.c:53: *card = *swap;
	ldhl	sp,#17
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
;src/main.c:54: *swap = temp;
	ldhl	sp,#15
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
;src/main.c:55: card--;
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#20
	ld	(hl-), a
;src/main.c:49: for (i = 103u; i; i--) {
	ld	a, e
	ld	(hl+), a
	inc	hl
	dec	(hl)
	jr	NZ, 00119$
;src/main.c:58: UINT8 te[13] = {0};
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
	xor	a, a
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	xor	a, a
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	xor	a, a
	ld	(de), a
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x0008
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x0009
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x000a
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x000b
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x000c
	add	hl, bc
	ld	(hl), #0x00
;src/main.c:59: for (i = 0; i < 104; i++) {
	xor	a, a
	ldhl	sp,	#21
	ld	(hl), a
00121$:
;src/main.c:60: te[deck[i].rank]++;
	ldhl	sp,	#21
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	ld	de, #_deck
	add	hl, de
	inc	hl
	inc	hl
	ld	a, (hl)
	and	a, #0x0f
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	inc	(hl)
;src/main.c:59: for (i = 0; i < 104; i++) {
	ldhl	sp,	#21
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x68
	jr	C, 00121$
;src/main.c:62: for (i = 0; i < 13; i++) {
	ld	e, #0x00
00123$:
;src/main.c:63: if (te[i] != 8)
	ld	l, e
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	cp	a, #0x08
	jr	Z, 00124$
;src/main.c:64: printf("%u\n", te[i]);
	ld	l, a
	ld	h, #0x00
	push	bc
	push	de
	push	hl
	ld	hl, #___str_0
	push	hl
	call	_printf
	add	sp, #4
	pop	de
	pop	bc
00124$:
;src/main.c:62: for (i = 0; i < 13; i++) {
	inc	e
	ld	a, e
	sub	a, #0x0d
	jr	C, 00123$
;src/main.c:67: card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:68: for (i = 0; i < 44u; i++) {
	xor	a, a
	ldhl	sp,	#21
	ld	(hl), a
00125$:
;src/main.c:69: card->visible = 0;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	res	6, (hl)
;src/main.c:70: card->next_card = IDX_PTR(deck, i + 10u);
	ldhl	sp,	#21
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
;src/main.c:71: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:68: for (i = 0; i < 44u; i++) {
	ldhl	sp,	#21
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x2c
	jr	C, 00125$
	ld	e, (hl)
00128$:
;src/main.c:73: for (; i < 54u; i++) {
	ld	a, e
	sub	a, #0x36
	jr	NC, 00110$
;src/main.c:74: card->visible = 1u;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	set	6, (hl)
;src/main.c:75: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:73: for (; i < 54u; i++) {
	inc	e
	jr	00128$
00110$:
;src/main.c:78: card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:79: for (i = 0; i < 10; i++) {
	ld	e, #0x00
00130$:
;src/main.c:80: piles[i] = card;
	ld	a, e
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	push	de
	ld	de, #_piles
	add	hl, de
	pop	de
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/main.c:81: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:79: for (i = 0; i < 10; i++) {
	inc	e
	ld	a, e
	sub	a, #0x0a
	jr	C, 00130$
;src/main.c:84: top_card_idx = 53u;
	ld	hl, #_top_card_idx
	ld	(hl), #0x35
;src/main.c:85: }
	add	sp, #22
	ret
___str_0:
	.ascii "%u"
	.db 0x0a
	.db 0x00
;src/main.c:87: void draw_pile(Card *card, UINT8 x, UINT8 y)
;	---------------------------------
; Function draw_pile
; ---------------------------------
_draw_pile::
	add	sp, #-4
;src/main.c:89: while (1) {
	ldhl	sp,	#8
	ld	a, (hl)
	inc	a
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
00107$:
;src/main.c:90: if (card->visible) {
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	l, c
	ld	h, b
	ld	a, (hl)
	rlca
	rlca
	jr	NC, 00102$
;src/main.c:91: set_bkg_tile_xy(x, y, card->rank + OFFSET_TEX_RANK);
	ld	l, c
	ld	h, b
	ld	a, (hl)
	and	a, #0x0f
	inc	a
	push	af
	inc	sp
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:92: set_bkg_tile_xy(x + 1u, y, card->suit + OFFSET_TEX_SUIT);
	ld	l, c
	ld	h, b
	ld	a, (hl)
	swap	a
	and	a, #0x03
	add	a, #0x0e
	push	af
	inc	sp
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
	jr	00103$
00102$:
;src/main.c:94: set_bkg_tile_xy(x, y, OFFSET_TEX_BACK);
	ld	a, #0x18
	push	af
	inc	sp
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:95: set_bkg_tile_xy(x + 1u, y, OFFSET_TEX_BACK + 1u);
	ld	a, #0x19
	push	af
	inc	sp
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
00103$:
;src/main.c:97: if (!card->next_card) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/main.c:98: set_bkg_tile_xy(x, y + 1u, OFFSET_TEX_BLANK + 2u);
	ld	(hl-), a
	dec	hl
	ld	e, (hl)
	inc	e
;src/main.c:97: if (!card->next_card) {
	inc	hl
	inc	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00105$
;src/main.c:98: set_bkg_tile_xy(x, y + 1u, OFFSET_TEX_BLANK + 2u);
	push	de
	ld	d, #0x14
	push	de
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
	pop	de
;src/main.c:99: set_bkg_tile_xy(x + 1u, y + 1u, OFFSET_TEX_BLANK + 3u);
	ld	d, #0x15
	push	de
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:100: set_bkg_tile_xy(x, y + 2u, card->suit + OFFSET_TEX_INV_SUIT);
	ld	l, c
	ld	h, b
	ld	a, (hl)
	swap	a
	and	a, #0x03
	add	a, #0x2b
	ldhl	sp,	#1
	ld	d, (hl)
	inc	d
	inc	d
	push	de
	push	af
	inc	sp
	push	de
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
	pop	de
;src/main.c:101: set_bkg_tile_xy(x + 1u, y + 2u, card->rank + OFFSET_TEX_INV_RANK);
	ld	l, c
	ld	h, b
	ld	a, (hl)
	and	a, #0x0f
	add	a, #0x1e
	push	af
	inc	sp
	push	de
	inc	sp
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:102: break;
	jr	00109$
00105$:
;src/main.c:105: y++;
	ldhl	sp,	#1
;src/main.c:106: card = card->next_card;
	ld	a, e
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), e
	jp	00107$
00109$:
;src/main.c:108: }
	add	sp, #4
	ret
;src/main.c:111: void draw_background(void)
;	---------------------------------
; Function draw_background
; ---------------------------------
_draw_background::
	add	sp, #-3
;src/main.c:114: Card **pile = IDX_PTR(piles, 0);
	ld	bc, #_piles+0
;src/main.c:115: for (x = 0; x < 20u; x += 2u) {
	xor	a, a
	ldhl	sp,	#2
	ld	(hl), a
00102$:
;src/main.c:116: draw_pile(*pile, x, 0);
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
;src/main.c:117: pile++;
	inc	bc
	inc	bc
;src/main.c:115: for (x = 0; x < 20u; x += 2u) {
	ldhl	sp,	#2
	inc	(hl)
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x14
	jr	C, 00102$
;src/main.c:119: }
	add	sp, #3
	ret
;src/main.c:121: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:123: initrand(DIV_REG);
	ldh	a, (_DIV_REG+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	call	_initrand
	add	sp, #2
;src/main.c:125: set_bkg_data(0, 47u, card_textures);
	ld	hl, #_card_textures
	push	hl
	ld	a, #0x2f
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;src/main.c:127: init_deck();
	call	_init_deck
;src/main.c:129: draw_background();
	call	_draw_background
;src/main.c:130: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;src/main.c:132: while (1) {
00102$:
;src/main.c:133: delay(1000u);
	ld	hl, #0x03e8
	push	hl
	call	_delay
	add	sp, #2
;src/main.c:135: }
	jr	00102$
	.area _CODE
	.area _CABS (ABS)
