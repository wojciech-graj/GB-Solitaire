;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module regular_metasprite
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _metasprite_same_2x3
	.globl _metasprite_sequential_2x3
	.globl _metasprite_custom_2x3
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_metasprite_custom_2x3::
	.ds 28
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
;res/regular_metasprite.c:20: metasprite_t metasprite_custom_2x3[] = {
	ld	hl, #_metasprite_custom_2x3
	ld	(hl), #0x10
	ld	hl, #(_metasprite_custom_2x3 + 0x0001)
	ld	(hl), #0x08
	ld	hl, #(_metasprite_custom_2x3 + 0x0002)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0003)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0004)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0005)
	ld	(hl), #0x08
	ld	hl, #(_metasprite_custom_2x3 + 0x0006)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0007)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0008)
	ld	(hl), #0x08
	ld	hl, #(_metasprite_custom_2x3 + 0x0009)
	ld	(hl), #0xf8
	ld	hl, #(_metasprite_custom_2x3 + 0x000a)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x000b)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x000c)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x000d)
	ld	(hl), #0x08
	ld	hl, #(_metasprite_custom_2x3 + 0x000e)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x000f)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0010)
	ld	(hl), #0x08
	ld	hl, #(_metasprite_custom_2x3 + 0x0011)
	ld	(hl), #0xf8
	ld	hl, #(_metasprite_custom_2x3 + 0x0012)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0013)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0014)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0015)
	ld	(hl), #0x08
	ld	hl, #(_metasprite_custom_2x3 + 0x0016)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0017)
	ld	(hl), #0x00
	ld	hl, #(_metasprite_custom_2x3 + 0x0018)
	ld	(hl), #0x80
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
_metasprite_sequential_2x3:
	.db #0x10	;  16
	.db #0x08	;  8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x08	;  8
	.db #0xf8	; -8
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x08	;  8
	.db #0xf8	; -8
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
_metasprite_same_2x3:
	.db #0x10	;  16
	.db #0x08	;  8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	;  8
	.db #0xf8	; -8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	;  8
	.db #0xf8	; -8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; -128
	.db #0x00	;  0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _CABS (ABS)
