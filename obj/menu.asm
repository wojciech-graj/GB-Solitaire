;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module menu
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _speed_text
	.globl _music_text
	.globl _suits_text
	.globl _leaderboard_text
	.globl _select_text
	.globl _start_text
	.globl _copyright_text
	.globl _button_textures
	.globl _card_addon
	.globl _font_addon
	.globl _title_textures
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
_title_textures:
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x9e	; 158
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xbc	; 188
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x3d	; 61
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0xa0	; 160
	.db #0xff	; 255
	.db #0xa0	; 160
	.db #0xff	; 255
	.db #0xa0	; 160
	.db #0xff	; 255
	.db #0xa0	; 160
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x79	; 121	'y'
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x81	; 129
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
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
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
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x0d	; 13
	.db #0xff	; 255
	.db #0x0d	; 13
	.db #0xff	; 255
	.db #0x0d	; 13
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xa3	; 163
	.db #0xff	; 255
	.db #0xa3	; 163
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x85	; 133
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x85	; 133
	.db #0xff	; 255
	.db #0x85	; 133
	.db #0xff	; 255
	.db #0x8d	; 141
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xff	; 255
	.db #0x3d	; 61
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9d	; 157
	.db #0xff	; 255
	.db #0x9d	; 157
	.db #0xff	; 255
	.db #0x9d	; 157
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x9e	; 158
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0x79	; 121	'y'
	.db #0xff	; 255
	.db #0x79	; 121	'y'
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x9e	; 158
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x9e	; 158
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
_font_addon:
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
_card_addon:
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0xbe	; 190
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xef	; 239
	.db #0x39	; 57	'9'
	.db #0xc7	; 199
	.db #0x7d	; 125
	.db #0xd7	; 215
	.db #0x7d	; 125
	.db #0xff	; 255
	.db #0x29	; 41
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0x61	; 97	'a'
	.db #0xff	; 255
	.db #0x61	; 97	'a'
	.db #0xff	; 255
	.db #0x61	; 97	'a'
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x61	; 97	'a'
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x82	; 130
	.db #0xff	; 255
	.db #0x82	; 130
	.db #0xff	; 255
	.db #0x84	; 132
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xe1	; 225
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xc1	; 193
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
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x25	; 37
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x81	; 129
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
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x25	; 37
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xff	; 255
	.db #0x09	; 9
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0xfe	; 254
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
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
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
	.db #0xff	; 255
	.db #0x82	; 130
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x82	; 130
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x86	; 134
	.db #0xff	; 255
	.db #0x86	; 134
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0xff	; 255
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0x61	; 97	'a'
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x19	; 25
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x61	; 97	'a'
	.db #0xff	; 255
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0xa2	; 162
	.db #0xff	; 255
	.db #0xb3	; 179
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0xb3	; 179
	.db #0xff	; 255
	.db #0xa2	; 162
	.db #0xff	; 255
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0xcd	; 205
	.db #0xff	; 255
	.db #0xcd	; 205
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x21	; 33
_button_textures:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x77	; 119	'w'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x7b	; 123
	.db #0x7b	; 123
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0xc8	; 200
	.db #0xc8	; 200
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x76	; 118	'v'
	.db #0x76	; 118	'v'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x76	; 118	'v'
	.db #0x76	; 118	'v'
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x76	; 118	'v'
	.db #0x76	; 118	'v'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x4c	; 76	'L'
	.db #0x4c	; 76	'L'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x4d	; 77	'M'
	.db #0x4d	; 77	'M'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xdc	; 220
	.db #0xdc	; 220
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0xc8	; 200
	.db #0xc8	; 200
	.db #0x00	; 0
	.db #0x00	; 0
_copyright_text:
	.db #0x25	; 37
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x19	; 25
	.db #0x14	; 20
	.db #0x0d	; 13
	.db #0x13	; 19
	.db #0x0f	; 15
	.db #0x0d	; 13
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x14	; 20
_start_text:
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x0b	; 11
	.db #0x1c	; 28
	.db #0x1e	; 30
_select_text:
	.db #0x1d	; 29
	.db #0x0f	; 15
	.db #0x16	; 22
	.db #0x0f	; 15
	.db #0x0d	; 13
	.db #0x1e	; 30
_leaderboard_text:
	.db #0x16	; 22
	.db #0x0f	; 15
	.db #0x0b	; 11
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x1c	; 28
	.db #0x0c	; 12
	.db #0x19	; 25
	.db #0x0b	; 11
	.db #0x1c	; 28
	.db #0x0e	; 14
_suits_text:
	.db #0x1d	; 29
	.db #0x1f	; 31
	.db #0x13	; 19
	.db #0x1e	; 30
	.db #0x1d	; 29
_music_text:
	.db #0x17	; 23
	.db #0x1f	; 31
	.db #0x1d	; 29
	.db #0x13	; 19
	.db #0x0d	; 13
_speed_text:
	.db #0x1d	; 29
	.db #0x1a	; 26
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0e	; 14
	.area _CABS (ABS)
