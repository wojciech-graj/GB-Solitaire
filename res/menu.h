#ifndef MENU_H
#define MENU_H

#define N_TITLE_LETTER  6u
#define N_TITLE_LETTERS 8u
#define N_TITLE         (N_TITLE_LETTER * N_TITLE_LETTERS)

#define OFFSET_TITLE_S 0u
#define OFFSET_TITLE_O (OFFSET_TITLE_S + N_TITLE_LETTER)
#define OFFSET_TITLE_L (OFFSET_TITLE_O + N_TITLE_LETTER)
#define OFFSET_TITLE_I (OFFSET_TITLE_L + N_TITLE_LETTER)
#define OFFSET_TITLE_T (OFFSET_TITLE_I + N_TITLE_LETTER)
#define OFFSET_TITLE_A (OFFSET_TITLE_T + N_TITLE_LETTER)
#define OFFSET_TITLE_R (OFFSET_TITLE_A + N_TITLE_LETTER)
#define OFFSET_TITLE_E (OFFSET_TITLE_R + N_TITLE_LETTER)

#define N_FONT_ADDON 1u

#define N_CARD_ADDON_SUIT     2u
#define N_CARD_ADDON_NUMBERS  6u
#define N_CARD_ADDON_MUSIC    9u
#define N_CARD_ADDON_SPEED    6u
#define N_CARD_ADDON         (N_CARD_ADDON_SUIT + N_CARD_ADDON_NUMBERS + N_CARD_ADDON_MUSIC + N_CARD_ADDON_SPEED)

#define OFFSET_CARD_ADDON_SUIT    0u
#define OFFSET_CARD_ADDON_NUMBERS (OFFSET_CARD_ADDON_SUIT + N_CARD_ADDON_SUIT)
#define OFFSET_CARD_ADDON_MUSIC   (OFFSET_CARD_ADDON_NUMBERS + N_CARD_ADDON_NUMBERS)
#define OFFSET_CARD_ADDON_SPEED   (OFFSET_CARD_ADDON_MUSIC + N_CARD_ADDON_MUSIC)

#define N_BUTTON_SYMBOL 1u
#define N_BUTTON_START  3u
#define N_BUTTON_SELECT 3u
#define N_BUTTON        (N_BUTTON_SYMBOL + N_BUTTON_START + N_BUTTON_SELECT)

#define OFFSET_BUTTON_SYMBOL 0u
#define OFFSET_BUTTON_START  (OFFSET_BUTTON_SYMBOL + N_BUTTON_SYMBOL)
#define OFFSET_BUTTON_SELECT (OFFSET_BUTTON_START + N_BUTTON_START)

#define COPYRIGHT_TEXT_LEN   20u
#define PUSH_TEXT_LEN        4u
#define START_TEXT_LEN       5u
#define SELECT_TEXT_LEN      6u
#define LEADERBOARD_TEXT_LEN 11u
#define SUITS_TEXT_LEN       5u
#define MUSIC_TEXT_LEN       5u
#define SPEED_TEXT_LEN       5u
#define OR_TEXT_LEN          2u

extern const unsigned char title_textures[];

extern const unsigned char font_addon[];

extern const unsigned char card_addon[];

extern const unsigned char button_textures[];

extern const unsigned char copyright_text[];
extern const unsigned char start_text[];
extern const unsigned char select_text[];
extern const unsigned char leaderboard_text[];
extern const unsigned char suits_text[];
extern const unsigned char music_text[];
extern const unsigned char speed_text[];

#endif
