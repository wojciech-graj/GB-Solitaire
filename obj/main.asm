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
	.globl _draw_back
	.globl _draw_pile
	.globl _init_deck
	.globl _rand
	.globl _initrand
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _cursor
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
	.ds 30
_top_card_idx::
	.ds 1
_cursor::
	.ds 7
_input_process_prev_input_65536_146:
	.ds 1
_main_prev_input_327680_174:
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
;src/main.c:165: static UINT8 prev_input = 0;
	ld	hl, #_input_process_prev_input_65536_146
	ld	(hl), #0x00
	ld	hl, #_main_prev_input_327680_174
	ld	(hl), #0x00
;src/main.c:51: Cursor cursor = {
	ld	hl, #_cursor
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	ld	hl, #(_cursor + 0x0002)
	ld	(hl), #0x0a
	ld	hl, #(_cursor + 0x0003)
	ld	(hl), #0x00
	ld	hl, #(_cursor + 0x0004)
	ld	(hl), #0x00
	ld	hl, #(_cursor + 0x0005)
	ld	(hl), #0x00
	ld	hl, #(_cursor + 0x0006)
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
;src/main.c:61: void init_deck(void)
;	---------------------------------
; Function init_deck
; ---------------------------------
_init_deck::
	add	sp, #-12
;src/main.c:63: Card *card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:68: for (suit = 0; suit < 4u; suit++) {
	xor	a, a
	ldhl	sp,	#7
	ld	(hl), a
;src/main.c:69: for (rank = 0; rank < 13u; rank++) {
00130$:
	xor	a, a
	ldhl	sp,	#8
	ld	(hl), a
;src/main.c:70: for (i = 0; i < 2u; i++) {
00128$:
	ldhl	sp,	#9
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl+), a
	ld	(hl), #0x02
00110$:
;src/main.c:71: card->rank = rank;
;c
	ldhl	sp,#9
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
;src/main.c:72: card->suit = suit;
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
;src/main.c:73: card->next_card = NULL;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/main.c:74: card++;
;c
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl+), a
;src/main.c:70: for (i = 0; i < 2u; i++) {
	dec	(hl)
	jr	NZ, 00110$
;src/main.c:69: for (rank = 0; rank < 13u; rank++) {
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
	jr	C, 00128$
;src/main.c:68: for (suit = 0; suit < 4u; suit++) {
	dec	hl
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00130$
;src/main.c:79: card = IDX_PTR(deck, 103u);
	inc	hl
	inc	hl
	ld	a, #<((_deck + 0x0135))
	ld	(hl+), a
	ld	(hl), #>((_deck + 0x0135))
;src/main.c:80: for (i = 103u; i; i--) {
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#3
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	(hl+), a
	ld	(hl), e
	ldhl	sp,	#11
	ld	(hl), #0x67
00115$:
;src/main.c:81: Card *swap = IDX_PTR(deck, (UINT8)rand() % i);
	call	_rand
	ld	a, e
	ldhl	sp,	#11
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
	ldhl	sp,	#7
	ld	a, c
	ld	(hl+), a
;src/main.c:83: temp = *card;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,#3
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0003
	push	hl
	push	de
	push	bc
	call	___memcpy
	add	sp, #6
;src/main.c:84: *card = *swap;
	ldhl	sp,#7
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
;src/main.c:85: *swap = temp;
	ldhl	sp,#5
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
;src/main.c:86: card--;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#10
	ld	(hl-), a
;src/main.c:80: for (i = 103u; i; i--) {
	ld	a, e
	ld	(hl+), a
	inc	hl
	dec	(hl)
	jr	NZ, 00115$
;src/main.c:89: card = IDX_PTR(deck, 0);
	ld	bc, #_deck
;src/main.c:90: for (i = 0; i < 44u; i++) {
	xor	a, a
	ld	(hl), a
00117$:
;src/main.c:91: card->visible = 0;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	res	6, (hl)
;src/main.c:92: card->next_card = IDX_PTR(deck, i + 10u);
	ldhl	sp,	#11
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
;src/main.c:93: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:90: for (i = 0; i < 44u; i++) {
	ldhl	sp,	#11
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x2c
	jr	C, 00117$
	ld	e, (hl)
00120$:
;src/main.c:95: for (; i < 54u; i++) {
	ld	a, e
	sub	a, #0x36
	jr	NC, 00106$
;src/main.c:96: card->visible = 1u;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	set	6, (hl)
;src/main.c:97: card++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:95: for (; i < 54u; i++) {
	inc	e
	jr	00120$
00106$:
;src/main.c:100: card = IDX_PTR(deck, 0);
	ldhl	sp,	#9
	ld	a, #<(_deck)
	ld	(hl+), a
	ld	(hl), #>(_deck)
;src/main.c:101: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles+0
;src/main.c:102: for (i = 0; i < 10; i++) {
	xor	a, a
	inc	hl
	ld	(hl), a
00122$:
;src/main.c:103: pile->card = card;
	ld	e, c
	ld	d, b
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/main.c:104: pile->height = (i < 4u) ? 5u : 4u;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	hl
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00126$
	ld	hl, #0x0005
	jr	00127$
00126$:
	ld	hl, #0x0004
00127$:
	ld	a, l
	ld	(de), a
;src/main.c:105: card++;
;c
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
;src/main.c:106: pile++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:102: for (i = 0; i < 10; i++) {
	inc	hl
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0a
	jr	C, 00122$
;src/main.c:109: top_card_idx = 53u;
	ld	hl, #_top_card_idx
	ld	(hl), #0x35
;src/main.c:110: }
	add	sp, #12
	ret
;src/main.c:112: void draw_pile(Card *card, UINT8 x, UINT8 y)
;	---------------------------------
; Function draw_pile
; ---------------------------------
_draw_pile::
	add	sp, #-7
;src/main.c:114: while (1) {
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
00107$:
;src/main.c:115: if (card->visible) {
	ldhl	sp,#9
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
	rlca
	rlca
	jr	NC, 00102$
;src/main.c:116: set_bkg_tile_xy(x, y, card->rank + OFFSET_BKG_RANK);
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	ld	a, (hl)
	and	a, #0x0f
	inc	a
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:117: set_bkg_tile_xy(x + 1u, y, card->suit + OFFSET_BKG_SUIT);
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	ld	a, (hl)
	swap	a
	and	a, #0x03
	add	a, #0x0e
	push	af
	inc	sp
	ldhl	sp,	#7
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
;src/main.c:119: set_bkg_tile_xy(x, y, OFFSET_BKG_BACK);
	ld	a, #0x18
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:120: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_BACK + 1u);
	ld	a, #0x19
	push	af
	inc	sp
	ldhl	sp,	#7
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
;src/main.c:122: if (!card->next_card) {
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/main.c:123: set_bkg_tile_xy(x, ++y, OFFSET_BKG_BLANK + 2u);
	ldhl	sp,	#6
	inc	(hl)
;src/main.c:122: if (!card->next_card) {
	ldhl	sp,	#1
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00105$
;src/main.c:123: set_bkg_tile_xy(x, ++y, OFFSET_BKG_BLANK + 2u);
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ld	a, #0x14
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:124: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_BLANK + 3u);
	ld	a, #0x15
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:125: set_bkg_tile_xy(x, ++y, card->suit + OFFSET_BKG_SUIT_ROT);
	ldhl	sp,#3
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	ld	a, (hl)
	swap	a
	and	a, #0x03
	ldhl	sp,	#5
	ld	(hl), a
	add	a, #0x2b
	ld	(hl+), a
	inc	(hl)
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:126: set_bkg_tile_xy(x + 1u, y, card->rank + OFFSET_BKG_RANK_ROT);
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
	pop	de
	push	de
	ld	a, (de)
	and	a, #0x0f
	ldhl	sp,	#5
	ld	(hl), a
	add	a, #0x1e
	push	af
	inc	sp
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:127: break;
	jr	00109$
00105$:
;src/main.c:130: y++;
;src/main.c:131: card = card->next_card;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#9
	ld	(hl+), a
	ld	(hl), e
	jp	00107$
00109$:
;src/main.c:133: }
	add	sp, #7
	ret
;src/main.c:135: void draw_back(UINT8 x, UINT8 y)
;	---------------------------------
; Function draw_back
; ---------------------------------
_draw_back::
;src/main.c:137: set_bkg_tile_xy(x, y, OFFSET_BKG_BACK);
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
;src/main.c:138: set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_BACK + 1u);
	ldhl	sp,	#2
	ld	c, (hl)
	inc	c
	ld	a, #0x19
	push	af
	inc	sp
	inc	hl
	ld	b, (hl)
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:139: set_bkg_tile_xy(x, y + 1u, OFFSET_BKG_BACK + 2u);
	ldhl	sp,	#3
	ld	b, (hl)
	inc	b
	ld	a, #0x1a
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
;src/main.c:140: set_bkg_tile_xy(x + 1u, y + 1u, OFFSET_BKG_BACK + 3u);
	ld	a, #0x1b
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	a, c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:141: set_bkg_tile_xy(x, y + 2u, OFFSET_BKG_BACK + 4u);
	ldhl	sp,	#3
	ld	b, (hl)
	inc	b
	inc	b
	ld	a, #0x1c
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
;src/main.c:142: set_bkg_tile_xy(x + 1u, y + 2u, OFFSET_BKG_BACK + 5u);
	ld	a, #0x1d
	push	af
	inc	sp
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;src/main.c:143: }
	ret
;src/main.c:145: void draw_background(void)
;	---------------------------------
; Function draw_background
; ---------------------------------
_draw_background::
	add	sp, #-3
;src/main.c:148: Pile *pile = IDX_PTR(piles, 0);
	ld	bc, #_piles+0
;src/main.c:149: for (i = 0; i < 20u; i += 2u) {
	xor	a, a
	ldhl	sp,	#2
	ld	(hl), a
00102$:
;src/main.c:150: draw_pile(pile->card, i, SCOREBAR_HEIGHT);
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	push	bc
	ld	a, #0x03
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
;src/main.c:151: pile++;
	inc	bc
	inc	bc
	inc	bc
;src/main.c:149: for (i = 0; i < 20u; i += 2u) {
	ldhl	sp,	#2
	inc	(hl)
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x14
	jr	C, 00102$
;src/main.c:153: draw_back(0, 0);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_draw_back
	add	sp, #2
;src/main.c:154: }
	add	sp, #3
	ret
;src/main.c:212: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;src/main.c:214: initrand(DIV_REG);
	ldh	a, (_DIV_REG+0)
	ld	c, a
	ld	b, #0x00
	push	bc
	call	_initrand
	add	sp, #2
;src/main.c:216: set_bkg_data(0, 47u, card_textures);
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
;src/main.c:218: init_deck();
	call	_init_deck
;src/main.c:220: draw_background();
	call	_draw_background
;src/main.c:221: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;src/main.c:223: set_sprite_data(0, 8, cursor_textures);
	ld	hl, #_cursor_textures
	push	hl
	ld	a, #0x08
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;src/main.c:224: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;src/main.c:226: while (1) {
00102$:
;src/main.c:166: UINT8 input = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), e
;src/main.c:167: UINT8 new_input = input & ~prev_input;
	ld	a, (#_main_prev_input_327680_174)
	cpl
	ldhl	sp,	#0
	and	a, (hl)
;src/main.c:168: if (new_input)
	ld	c, a
	or	a, a
	jr	Z, 00105$
;src/main.c:169: cursor.redraw = 1u;
	ld	hl, #(_cursor + 0x0006)
	ld	(hl), #0x01
00105$:
;src/main.c:170: if (new_input & J_DOWN) {
	bit	3, c
	jr	Z, 00133$
;src/main.c:171: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	hl, #_cursor + 2
	ld	b, (hl)
	ld	a, b
;src/main.c:172: cursor.pile_idx = 0;
	sub	a,#0x0a
	jr	NZ, 00109$
	ld	(hl),a
	jp	00134$
00109$:
;src/main.c:173: else if (cursor.height < piles[cursor.pile_idx].height)
	ld	hl, #(_cursor + 0x0003)
	ld	c, (hl)
	ld	e, b
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	ld	de, #_piles
	add	hl, de
	inc	hl
	inc	hl
	ld	b, (hl)
	ld	a, c
	sub	a, b
	jr	NC, 00134$
;src/main.c:174: cursor.height++;
	inc	c
	ld	hl, #(_cursor + 0x0003)
	ld	(hl), c
	jr	00134$
00133$:
;src/main.c:175: } else if (new_input & J_UP) {
	bit	2, c
	jr	Z, 00131$
;src/main.c:176: if (cursor.height == 0)
	ld	bc, #_cursor + 3
	ld	a, (bc)
	or	a, a
	jr	NZ, 00113$
;src/main.c:177: cursor.pile_idx = PILE_IDX_DECK;
	ld	hl, #(_cursor + 0x0002)
	ld	(hl), #0x0a
	jr	00134$
00113$:
;src/main.c:179: cursor.height--;
	dec	a
	ld	(bc), a
	jr	00134$
00131$:
;src/main.c:180: } else if (new_input & J_LEFT) {
	bit	1, c
	jr	Z, 00129$
;src/main.c:181: if (cursor.pile_idx != 0) {
	ld	hl, #_cursor + 2
	ld	a, (hl)
	or	a, a
	jr	Z, 00134$
;src/main.c:182: cursor.pile_idx--;
	ld	c, a
	dec	c
	ld	(hl), c
;src/main.c:158: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	de, #_piles
	add	hl, de
;src/main.c:159: if (cursor.height > pile->height)
	ld	bc, #_cursor + 3
	ld	a, (bc)
	ld	d, a
	inc	hl
	inc	hl
;src/main.c:160: cursor.height = pile->height;
	ld	a, (hl)
	cp	a,d
	jr	NC, 00134$
	ld	(bc), a
;src/main.c:183: cursor_adjust_height();
	jr	00134$
00129$:
;src/main.c:185: } else if (new_input & J_RIGHT) {
	bit	0, c
	jr	Z, 00134$
;src/main.c:186: if (cursor.pile_idx < 9) {
	ld	hl, #_cursor + 2
	ld	a, (hl)
	cp	a, #0x09
	jr	NC, 00134$
;src/main.c:187: cursor.pile_idx++;
	ld	c, a
	inc	c
	ld	(hl), c
;src/main.c:158: Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	de, #_piles
	add	hl, de
;src/main.c:159: if (cursor.height > pile->height)
	ld	bc, #_cursor + 3
	ld	a, (bc)
	ld	d, a
	inc	hl
	inc	hl
;src/main.c:160: cursor.height = pile->height;
	ld	a, (hl)
	cp	a,d
	jr	NC, 00134$
	ld	(bc), a
;src/main.c:188: cursor_adjust_height();
00134$:
;src/main.c:191: prev_input = input;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_main_prev_input_327680_174),a
;src/main.c:196: cursor.anim_ctr++;
	ld	hl, #_cursor + 4
	ld	b, (hl)
	inc	b
	ld	(hl), b
;src/main.c:197: cursor.anim_ctr &= (1u << (CURSOR_PERIOD + 1u)) - 1u;
	res	7, b
	ld	(hl), b
;src/main.c:198: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	hl, #(_cursor + 0x0005)
	ld	c, (hl)
;src/main.c:199: cursor.anim_frame = cursor.anim_ctr >> CURSOR_PERIOD;
	ld	a, b
	rlca
	rlca
	and	a, #0x03
	ld	b, a
	ld	hl, #(_cursor + 0x0005)
	ld	(hl), b
;src/main.c:201: cursor.redraw = 1u;
	ld	de, #_cursor + 6
;src/main.c:200: if (cursor.anim_frame != prev_anim_frame)
	ld	a, c
	sub	a, b
	jr	Z, 00137$
;src/main.c:201: cursor.redraw = 1u;
	ld	a, #0x01
	ld	(de), a
00137$:
;src/main.c:203: if (cursor.redraw) {
	ld	a, (de)
	or	a, a
	jr	Z, 00145$
;src/main.c:204: cursor.redraw = 0;
	xor	a, a
	ld	(de), a
;src/main.c:205: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	hl, #_cursor + 2
	ld	c, (hl)
;src/main.c:198: UINT8 prev_anim_frame = cursor.anim_frame;
	ld	a, (#(_cursor + 0x0005) + 0)
;src/main.c:206: move_metasprite(cursor_frames[cursor.anim_frame], 0, 0, 0, 0);
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	ld	e, l
	ld	d, h
;src/main.c:205: if (cursor.pile_idx == PILE_IDX_DECK)
	ld	a, c
	sub	a, #0x0a
	jr	NZ, 00141$
;src/main.c:206: move_metasprite(cursor_frames[cursor.anim_frame], 0, 0, 0, 0);
	ld	hl, #_cursor_frames
	add	hl, de
	ld	a, (hl+)
	ld	c, (hl)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), c
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
	xor	a, a
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:206: move_metasprite(cursor_frames[cursor.anim_frame], 0, 0, 0, 0);
	jr	00145$
00141$:
;src/main.c:208: move_metasprite(cursor_frames[cursor.anim_frame], 0, 0, cursor.pile_idx << 4u, SCOREBAR_HEIGHT * 8u  + (cursor.height << 3u));
	ld	a, (#_cursor + 3)
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x18
	ld	b, a
	ld	a, c
	swap	a
	and	a, #0xf0
	ld	c, a
	ld	hl, #_cursor_frames
	add	hl, de
	ld	a, (hl+)
;/home/wojtek/gbdk/include/gb/metasprites.h:79: __current_metasprite = metasprite; 
	ld	e, (hl)
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), e
;/home/wojtek/gbdk/include/gb/metasprites.h:80: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;/home/wojtek/gbdk/include/gb/metasprites.h:81: return __move_metasprite(base_sprite, x, y); 
	push	bc
	xor	a, a
	push	af
	inc	sp
	call	___move_metasprite
	add	sp, #3
;src/main.c:229: cursor_anim_process();
00145$:
;src/main.c:231: wait_vbl_done();
	call	_wait_vbl_done
	jp	00102$
;src/main.c:233: }
	inc	sp
	ret
	.area _CODE
	.area _CABS (ABS)
