;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module card
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _card_textures
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
	.area _CODE
_card_textures:
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0xa4	; 164
	.db #0xff	; 255
	.db #0xbc	; 188
	.db #0xff	; 255
	.db #0xa4	; 164
	.db #0xff	; 255
	.db #0xa4	; 164
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0xa4	; 164
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0xff	; 255
	.db #0xbc	; 188
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0x84	; 132
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x84	; 132
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0xbc	; 188
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xbc	; 188
	.db #0xff	; 255
	.db #0xa0	; 160
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0x84	; 132
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0xa0	; 160
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xa4	; 164
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xae	; 174
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0xae	; 174
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xbc	; 188
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xbc	; 188
	.db #0xff	; 255
	.db #0xa4	; 164
	.db #0xff	; 255
	.db #0xa4	; 164
	.db #0xff	; 255
	.db #0xac	; 172
	.db #0xff	; 255
	.db #0xbc	; 188
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0xb0	; 176
	.db #0xff	; 255
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0xa8	; 168
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xff	; 255
	.db #0x7d	; 125
	.db #0xff	; 255
	.db #0x7d	; 125
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0x7d	; 125
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xef	; 239
	.db #0x39	; 57	'9'
	.db #0xc7	; 199
	.db #0x7d	; 125
	.db #0xef	; 239
	.db #0x39	; 57	'9'
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x29	; 41
	.db #0xd7	; 215
	.db #0x7d	; 125
	.db #0xc7	; 199
	.db #0x7d	; 125
	.db #0xef	; 239
	.db #0x39	; 57	'9'
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x95	; 149
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x95	; 149
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x95	; 149
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x57	; 87	'W'
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0x57	; 87	'W'
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0x57	; 87	'W'
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x95	; 149
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x95	; 149
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x95	; 149
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x95	; 149
	.db #0x57	; 87	'W'
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0x57	; 87	'W'
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0x57	; 87	'W'
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0x57	; 87	'W'
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x95	; 149
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x95	; 149
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xea	; 234
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x57	; 87	'W'
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0x57	; 87	'W'
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0x57	; 87	'W'
	.db #0xa9	; 169
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x25	; 37
	.db #0xff	; 255
	.db #0x25	; 37
	.db #0xff	; 255
	.db #0x3d	; 61
	.db #0xff	; 255
	.db #0x25	; 37
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x3d	; 61
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x25	; 37
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x3d	; 61
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x3d	; 61
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x25	; 37
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x75	; 117	'u'
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0x75	; 117	'u'
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x3d	; 61
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x3d	; 61
	.db #0xff	; 255
	.db #0x35	; 53	'5'
	.db #0xff	; 255
	.db #0x25	; 37
	.db #0xff	; 255
	.db #0x25	; 37
	.db #0xff	; 255
	.db #0x3d	; 61
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x0d	; 13
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x15	; 21
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0xbe	; 190
	.db #0xff	; 255
	.db #0xbe	; 190
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0xbe	; 190
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xf7	; 247
	.db #0x9c	; 156
	.db #0xe3	; 227
	.db #0xbe	; 190
	.db #0xf7	; 247
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xf7	; 247
	.db #0x9c	; 156
	.db #0xe3	; 227
	.db #0xbe	; 190
	.db #0xeb	; 235
	.db #0xbe	; 190
	.db #0xff	; 255
	.db #0x94	; 148
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xfe	; 254
	.area _CABS (ABS)
