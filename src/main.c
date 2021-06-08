/*
* Author: Wojciech Graj
* License: MIT
* Description: Spider solitaire on the gameboy
*/

#include <gb/gb.h>
#include <gb/metasprites.h>
#include <gb/font.h>

#include <rand.h>

#include "../res/cursor.h"
#include "../res/card.h"
#include "../res/regular_metasprite.h"
#include "../res/menu.h"
#include "../res/nvram/nvram.h"

//TODO: music
//TODO: BUGFIX: full piles aren't always folded

/*******************************************************************************
*	MACRO
*******************************************************************************/

#define N_FONT 36u

#define OFFSET_BKG_NONE       0u
#define OFFSET_BKG_FONT       1u
#define OFFSET_BKG_FONT_ADDON (OFFSET_BKG_FONT + N_FONT)
#define OFFSET_BKG_CARD_ADDON (OFFSET_BKG_FONT_ADDON + N_FONT_ADDON)
#define OFFSET_BKG_BUTTON     (OFFSET_BKG_CARD_ADDON + N_CARD_ADDON)

#define OFFSET_BKG_TITLE      128u
#define OFFSET_BKG_CARD       (OFFSET_BKG_TITLE + N_TITLE)

#define OFFSET_SPRITE_NONE   0u
#define OFFSET_SPRITE_CURSOR 1u

#define OFFSET_SPRITE_TITLE  128u
#define OFFSET_SPRITE_CARD   (OFFSET_SPRITE_TITLE + N_TITLE)

#define SPRITE_DYNAMIC 0u
#define SPRITE_HAND    6u
#define SPRITE_FRAME   12u
#define SPRITE_FRAME_1 18u
#define SPRITE_FRAME_2 24u
#define SPRITE_FRAME_3 30u

#define BIT_OFFSET_CARD_RANK    0u
#define BIT_OFFSET_CARD_SUIT    4u
#define BIT_OFFSET_CARD_VISIBLE 6u

#define BITMASK_CARD_RANK    0b00001111u
#define BITMASK_CARD_SUIT    0b00110000u
#define BITMASK_CARD_VISIBLE 0b01000000u

#define RANK(data)    (data & BITMASK_CARD_RANK)
#define SUIT(data)    ((data & BITMASK_CARD_SUIT) >> BIT_OFFSET_CARD_SUIT)
#define VISIBLE(data) (data & BITMASK_CARD_VISIBLE)

#define FLAG_REDRAW_CURSOR          0b00000001u
#define FLAG_REDRAW_HAND            0b00000010u
#define FLAG_PLAYING_ANIMATION      0b00000100u
#define FLAG_GAME_STATE             0b00011000u
#define FLAG_GAME_STATE_SPLASH      0b00000000u
#define FLAG_GAME_STATE_LEADERBOARD 0b00001000u
#define FLAG_GAME_STATE_INGAME      0b00010000u
#define FLAG_GAME_STATE_SETTINGS    0b00011000u

#define BITMASK_DYNAMIC_METASPRITE_UNFOLD 0b10000000u

#define BIT_OFFSET_SETTING_NUM_SUITS       0u
#define BIT_OFFSET_SETTING_ANIMATION_SPEED 2u
#define BIT_OFFSET_SETTING_MUSIC           4u

#define BITMASK_SETTING_NUM_SUITS       0b00000011u
#define SETTING_ONE_SUIT                0b00000000u
#define SETTING_TWO_SUIT                0b00000001u
#define SETTING_FOUR_SUIT               0b00000010u

#define NUM_SUITS(settings) (settings & BITMASK_SETTING_NUM_SUITS)

#define BITMASK_SETTING_ANIMATION_SPEED 0b00001100u

#define ANIMATION_SPEED(settings) ((settings & BITMASK_SETTING_ANIMATION_SPEED) >> BIT_OFFSET_SETTING_ANIMATION_SPEED)

#define BITMASK_SETTING_MUSIC 0b00010000u

#define MUSIC(settings) (settings & BITMASK_SETTING_MUSIC)

#define IDX_PTR(arr, idx) (arr + idx)

//Period is 2 ^ CURSOR_PERIOD_LOGSCALE
#define CURSOR_PERIOD_LOGSCALE 6u

#define PILE_IDX_DECK 10u

#define TARGET_FRAMES_SPLASH_SCREEN 32u

#define NUM_SETTING_PILES 4u

#define SETTINGS_SPLIT_X  10u
#define SETTINGS_PAD_Y    1u

#define LEADERBOARD_CARD_X 4u
#define LEADERBOARD_NAME_X 8u
#define LEADERBOARD_SCORE_X 12u
#define LEADERBOARD_PAD_Y 4u

#define START_SCORE 500u

/*******************************************************************************
*	STRUCTS
*******************************************************************************/

typedef struct Card Card;
typedef struct Card {
	Card *next_card;
	UINT8 data;
} Card;

typedef struct Pile {
	Card *base;
	Card *top;
	UINT8 height;
} Pile;

struct Cursor {
	Card *held_card;
	Card *card_to_show;
	UINT8 held_stack_size;

	UINT8 hand_pile_idx;

	UINT8 pile_idx;
	UINT8 height;

	UINT8 anim_ctr;
	UINT8 anim_frame;
};

struct DynamicMetaSprite {
	INT16 src[2];
	INT16 dist[2];
	INT8 target_frames;
	INT8 elapsed_frames;

	metasprite_t const *metasprite;
	UINT8 metasprite_offset;

	UINT8 data[4];
	void const *data_ptr;

	void (*callback)(void);
};

struct AnimationSpeed {
	UINT8 fold_target_frames;
	UINT8 move_target_frames;
};

/*******************************************************************************
*	GLOBALS
*******************************************************************************/

Card deck[104];
Pile piles[10];
UINT8 top_card_idx;
UINT8 flags = 0;
UINT8 scroll = 0;
UINT8 settings = SETTING_ONE_SUIT | BITMASK_SETTING_MUSIC;
UINT8 num_folded_piles = 0;
UINT16 score =  START_SCORE;
LeaderBoard *selected_leaderboard = NULL;

struct DynamicMetaSprite dynamic_metasprite = {
	.target_frames = -1,
	.elapsed_frames = 0,
};

struct Cursor cursor = {
	.held_card = NULL,
	.card_to_show = NULL,
	.hand_pile_idx = 0,
	.pile_idx = 10,
	.height = 0,
	.anim_ctr = 0,
	.anim_frame = 0,
};

const struct AnimationSpeed animation_speeds[3] = {
	{.fold_target_frames = 16,
	 .move_target_frames = 32},
	{.fold_target_frames = 8,
	 .move_target_frames = 16},
	{.fold_target_frames = 4,
	 .move_target_frames = 8},
};

enum menu_cards {
	MENU_CARD_ONE_SUIT = 0u,
	MENU_CARD_TWO_SUIT,
	MENU_CARD_FOUR_SUIT,
	MENU_CARD_MUSIC,
	MENU_CARD_NO_MUSIC,
	MENU_CARD_ANIMATION_SLOW,
	MENU_CARD_ANIMATION_MEDIUM,
	MENU_CARD_ANIMATION_FAST,
	MENU_NUM_CARDS,
};

const UINT8 menu_card_tiles[MENU_NUM_CARDS][6] = {
	[MENU_CARD_ONE_SUIT] = {
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK,
		OFFSET_BKG_CARD + OFFSET_CARD_SUIT,
		OFFSET_BKG_CARD_ADDON + 2u,
		OFFSET_BKG_CARD_ADDON + 3u,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 4u,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 5u,
	},
	[MENU_CARD_TWO_SUIT] = {
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK,
		OFFSET_BKG_CARD + OFFSET_CARD_SUIT,
		OFFSET_BKG_CARD_ADDON + 4u,
		OFFSET_BKG_CARD_ADDON + 5u,
		OFFSET_BKG_CARD + OFFSET_CARD_SUIT_ROT + 2u,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 5u,
	},
	[MENU_CARD_FOUR_SUIT] = {
		OFFSET_BKG_CARD_ADDON,
		OFFSET_BKG_CARD + OFFSET_CARD_SUIT,
		OFFSET_BKG_CARD_ADDON + 6u,
		OFFSET_BKG_CARD_ADDON + 7u,
		OFFSET_BKG_CARD + OFFSET_CARD_SUIT_ROT + 2u,
		OFFSET_BKG_CARD_ADDON + 1u,
	},
	[MENU_CARD_MUSIC] = {
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC + 1u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC + 2u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC + 3u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC + 4u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC + 5u,
	},
	[MENU_CARD_NO_MUSIC] = {
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC + 6u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC + 2u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC + 7u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC + 4u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_MUSIC + 8u,
	},
	[MENU_CARD_ANIMATION_SLOW] = {
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 1u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_SPEED,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_SPEED + 1u,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 4u,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 5u,
	},
	[MENU_CARD_ANIMATION_MEDIUM] = {
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 1u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_SPEED + 2u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_SPEED + 3u,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 4u,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 5u,
	},
	[MENU_CARD_ANIMATION_FAST] = {
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 1u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_SPEED + 4u,
		OFFSET_BKG_CARD_ADDON + OFFSET_CARD_ADDON_SPEED + 5u,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 4u,
		OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 5u,
	},
};

const UINT8 setting_pile_heights[NUM_SETTING_PILES] = {
	3u, 2u, 3u, 1u
};

/*******************************************************************************
*	FUNCTION PROTOTYPES
*******************************************************************************/

// BKG
void clear_bkg_2x1(const UINT8 x, const UINT8 y);
void draw_card_top(const UINT8 x, const UINT8 y, const UINT8 card_data);
void draw_card_bottom(const UINT8 x, const UINT8 y, const UINT8 card_data);
void draw_card(const UINT8 x, const UINT8 y, const UINT8 card_data);
void draw_sequential_card(const UINT8 x, const UINT8 y, const UINT8 bkg_offset);
void clear_bkg(void);
void draw_bkg_game(void);
void draw_bkg_splash_screen(void);
void draw_bkg_settings(void);

// metasprite
void metasprite_2x3_hide(const UINT8 sprite);
void set_metasprite_card(const UINT8 card_data);
void draw_setting_frame_metasprites(void);

// DynamicMetaSprite
void dynamic_metasprite_end_animation(void);
void dynamic_metasprite_splash_screen_callback(void);
void dynamic_metasprite_splash_screen(void);
void dynamic_metasprite_fold_pile(void);
void dynamic_metasprite_unfold_callback(void);
void dynamic_metasprite_move_stack_callback(void);
void dynamic_metasprite_fold_callback(void);
void dynamic_metasprite_fold(const UINT8 top_card_data, const UINT8 src_x, const UINT8 src_y, const UINT8 dest_x, const UINT8 dest_y, const UINT8 stack_height, const Card *base_card, const UINT8 unfold, const UINT8 piles_to_clear);
void dynamic_metasprite_deal(void);
void dynamic_metasprite_deal_callback(void);
void dynamic_metasprite_process(void);

// Cursor
void cursor_adjust_height(void);
void cursor_grab_stack(void);
void cursor_place_stack(void);
void set_cursor_setting(void);
void change_cursor_height(const INT8 inc);
void cursor_process(void);

// Card
void init_deck(void);
UINT8 is_stack_coherent(Card *card);
void deal(void);
void pile_append_cursor_stack(Pile *pile);

// MISCELLANEOUS
void start_game(void);
void start_settings(void);
void start_splash_screen(void);
void input_process(void);
void start_leaderboard(void);
void add_leaderboard(void);
void nvram_check(void);
void inc_letter(const INT8 inc);
void main(void);

/*******************************************************************************
*	BKG
*******************************************************************************/

inline void clear_bkg_2x1(const UINT8 x, const UINT8 y)
{
	set_bkg_tile_xy(x, y, OFFSET_BKG_NONE);
	set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_NONE);
}

void draw_card_top(const UINT8 x, const UINT8 y, const UINT8 card_data)
{
	if (VISIBLE(card_data)) {
		set_bkg_tile_xy(x, y, RANK(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_RANK);
		set_bkg_tile_xy(x + 1u, y, SUIT(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_SUIT);
	} else {
		set_bkg_tile_xy(x, y, OFFSET_BKG_CARD + OFFSET_CARD_BACK);
		set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_CARD + OFFSET_CARD_BACK + 1u);
	}
}

void draw_card_bottom(const UINT8 x, const UINT8 y, const UINT8 card_data)
{
	set_bkg_tile_xy(x, y, OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 2u);
	set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_CARD + OFFSET_CARD_BLANK + 3u);
	set_bkg_tile_xy(x, y+ 1u, SUIT(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_SUIT_ROT);
	set_bkg_tile_xy(x + 1u, y+ 1u, RANK(card_data) + OFFSET_BKG_CARD + OFFSET_CARD_RANK_ROT);
}

inline void draw_card(const UINT8 x, const UINT8 y, const UINT8 card_data)
{
	draw_card_top(x, y, card_data);
	draw_card_bottom(x, y + 1u, card_data);
}

void draw_sequential_card(const UINT8 x, const UINT8 y, const UINT8 bkg_offset)
{
	set_bkg_tile_xy(x, y, bkg_offset);
	set_bkg_tile_xy(x + 1u, y, bkg_offset + 1u);
	set_bkg_tile_xy(x, y + 1u, bkg_offset + 2u);
	set_bkg_tile_xy(x + 1u, y + 1u, bkg_offset + 3u);
	set_bkg_tile_xy(x, y + 2u, bkg_offset + 4u);
	set_bkg_tile_xy(x + 1u, y + 2u, bkg_offset + 5u);
}

//TODO: this is tremendously inefficient and could probably be done using some sort of memset
void clear_bkg(void)
{
	UINT8 x, y;
	for (x = 0; x < 32u; x++)
		for (y = 0; y < 32u; y++)
			set_bkg_tile_xy(x, y, 0);
}

void draw_bkg_game(void)
{
	UINT8 x;
	Pile *pile = IDX_PTR(piles, 0);
	for (x = 0; x < 20u; x += 2) {
		Card *card = pile->base;
		UINT8 y = 3u;
		while (card->next_card) {
			draw_card_top(x, y, card->data);
			y++;
			card = card->next_card;
		}
		draw_card(x, y, card->data);
		pile++;
	}
	draw_sequential_card(0, 0, OFFSET_BKG_CARD + OFFSET_CARD_BACK);
}

void draw_bkg_splash_screen(void)
{
	set_bkg_tile_xy(2u, 9u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_SYMBOL);
	set_bkg_tile_xy(3u, 9u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_START);
	set_bkg_tile_xy(4u, 9u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_START + 1u);
	set_bkg_tile_xy(5u, 9u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_START + 2u);
	set_bkg_tiles(7u, 9u, START_TEXT_LEN, 1u, start_text);

	set_bkg_tile_xy(2u, 10u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_SYMBOL);
	set_bkg_tile_xy(3u, 10u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_SELECT);
	set_bkg_tile_xy(4u, 10u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_SELECT + 1u);
	set_bkg_tile_xy(5u, 10u, OFFSET_BKG_BUTTON + OFFSET_BUTTON_SELECT + 2u);
	set_bkg_tiles(7u, 10u, LEADERBOARD_TEXT_LEN, 1u, leaderboard_text);

	set_bkg_tiles(0, 15u, COPYRIGHT_TEXT_LEN, 1u, copyright_text);
}

void draw_bkg_settings(void)
{
	set_bkg_tiles(SETTINGS_SPLIT_X - SUITS_TEXT_LEN, SETTINGS_PAD_Y + 1u, SUITS_TEXT_LEN, 1u, suits_text);
	set_bkg_tiles(SETTINGS_SPLIT_X, SETTINGS_PAD_Y, 2u, 3u, menu_card_tiles[MENU_CARD_ONE_SUIT]);
	set_bkg_tiles(SETTINGS_SPLIT_X + 2u, SETTINGS_PAD_Y, 2u, 3u, menu_card_tiles[MENU_CARD_TWO_SUIT]);
	set_bkg_tiles(SETTINGS_SPLIT_X + 4u, SETTINGS_PAD_Y, 2u, 3u, menu_card_tiles[MENU_CARD_FOUR_SUIT]);

	set_bkg_tiles(SETTINGS_SPLIT_X - MUSIC_TEXT_LEN, SETTINGS_PAD_Y + 5u, MUSIC_TEXT_LEN, 1u, music_text);
	set_bkg_tiles(SETTINGS_SPLIT_X, SETTINGS_PAD_Y + 4u, 2u, 3u, menu_card_tiles[MENU_CARD_MUSIC]);
	set_bkg_tiles(SETTINGS_SPLIT_X + 2u, SETTINGS_PAD_Y + 4u, 2u, 3u, menu_card_tiles[MENU_CARD_NO_MUSIC]);

	set_bkg_tiles(SETTINGS_SPLIT_X - SPEED_TEXT_LEN, SETTINGS_PAD_Y + 9u, SPEED_TEXT_LEN, 1u, speed_text);
	set_bkg_tiles(SETTINGS_SPLIT_X, SETTINGS_PAD_Y + 8u, 2u, 3u, menu_card_tiles[MENU_CARD_ANIMATION_SLOW]);
	set_bkg_tiles(SETTINGS_SPLIT_X + 2u, SETTINGS_PAD_Y + 8u, 2u, 3u, menu_card_tiles[MENU_CARD_ANIMATION_MEDIUM]);
	set_bkg_tiles(SETTINGS_SPLIT_X + 4u, SETTINGS_PAD_Y + 8u, 2u, 3u, menu_card_tiles[MENU_CARD_ANIMATION_FAST]);

	set_bkg_tiles(SETTINGS_SPLIT_X - START_TEXT_LEN, SETTINGS_PAD_Y + 13u, START_TEXT_LEN, 1u, start_text);
	draw_sequential_card(SETTINGS_SPLIT_X, SETTINGS_PAD_Y + 12u, OFFSET_BKG_CARD + OFFSET_CARD_BACK);
}

inline void draw_bkg_leaderboard_score(const UINT8 x, const UINT8 y, const UINT16 score)
{
	UINT8 score_tiles[3] = {
		OFFSET_BKG_FONT + (score / 100),
		OFFSET_BKG_FONT + ((score % 100) / 10),
		OFFSET_BKG_FONT + (score % 10),
	};
	set_bkg_tiles(x, y, 3u, 1u, score_tiles);
}

//RAM_MBC1 must be enabled
void draw_bkg_leaderboard(void)
{
	set_bkg_tiles(4u, 1u, LEADERBOARD_TEXT_LEN, 1u, leaderboard_text);

	set_bkg_tiles(LEADERBOARD_CARD_X, LEADERBOARD_PAD_Y, 2u, 3u, menu_card_tiles[MENU_CARD_ONE_SUIT]);
	set_bkg_tiles(LEADERBOARD_CARD_X, LEADERBOARD_PAD_Y + 4u, 2u, 3u, menu_card_tiles[MENU_CARD_TWO_SUIT]);
	set_bkg_tiles(LEADERBOARD_CARD_X, LEADERBOARD_PAD_Y + 8u, 2u, 3u, menu_card_tiles[MENU_CARD_FOUR_SUIT]);

	LeaderBoard *iter = IDX_PTR(leaderboard[0], 0);
	UINT8 i, j;
	for (i = 0; i < 3; i++) {
		for (j = 0; j < 3; j++) {
			UINT8 y = LEADERBOARD_PAD_Y + i * 4u + j;
			set_bkg_tiles(LEADERBOARD_NAME_X, y, 3u, 1u, iter->name);
			draw_bkg_leaderboard_score(LEADERBOARD_SCORE_X, y, iter->score);
			iter++;
		}
	}
}

/*******************************************************************************
*	metasprite
*******************************************************************************/

void metasprite_2x3_hide(const UINT8 sprite)
{
	move_metasprite(metasprite_same_2x3,
		OFFSET_SPRITE_NONE,
		sprite,
		0,
		0
	);
}

void set_metasprite_card(const UINT8 card_data)
{
	metasprite_t *iter = IDX_PTR(metasprite_custom_2x3, 0);
	(iter++)->dtile = OFFSET_CARD_RANK + RANK(card_data);
	(iter++)->dtile = OFFSET_CARD_SUIT + SUIT(card_data);
	(iter++)->dtile = OFFSET_CARD_BLANK + 2u;
	(iter++)->dtile = OFFSET_CARD_BLANK + 3u;
	(iter++)->dtile = OFFSET_CARD_SUIT_ROT + SUIT(card_data);
	(iter++)->dtile = OFFSET_CARD_RANK_ROT + RANK(card_data);
}

void draw_setting_frame_metasprites(void)
{
	move_metasprite(metasprite_sequential_2x3,
		OFFSET_SPRITE_CARD + OFFSET_CARD_LIGHT_OUTLINE,
		SPRITE_FRAME_1,
		NUM_SUITS(settings) * 16u + SETTINGS_SPLIT_X * 8u,
		SETTINGS_PAD_Y * 8u
	);
	move_metasprite(metasprite_sequential_2x3,
		OFFSET_SPRITE_CARD + OFFSET_CARD_LIGHT_OUTLINE,
		SPRITE_FRAME_2,
		!MUSIC(settings) * 16u + SETTINGS_SPLIT_X * 8u,
		(SETTINGS_PAD_Y + 4u) * 8u
	);
	move_metasprite(metasprite_sequential_2x3,
		OFFSET_SPRITE_CARD + OFFSET_CARD_LIGHT_OUTLINE,
		SPRITE_FRAME_3,
		ANIMATION_SPEED(settings) * 16u + SETTINGS_SPLIT_X * 8u,
		(SETTINGS_PAD_Y + 8u) * 8u
	);
}

/*******************************************************************************
*	DynamicMetaSprite
*******************************************************************************/
/*
 * Functions which can be called by other code:
 *   dynamic_metasprite_end_animation
 *   dynamic_metasprite_splash_screen
 *   dynamic_metasprite_fold
 *   dynamic_metasprite_deal
 * The rest of the functions are used internally and rely on various members of
 * dynamic_metasprite being set.
 */

void dynamic_metasprite_end_animation(void)
{
	metasprite_2x3_hide(SPRITE_DYNAMIC);
	flags &= ~FLAG_PLAYING_ANIMATION;
	dynamic_metasprite.target_frames = -1;
}

void dynamic_metasprite_splash_screen_callback(void)
{
	const UINT8 offsets[] = {
		OFFSET_TITLE_S,
		OFFSET_TITLE_O,
		OFFSET_TITLE_L,
		OFFSET_TITLE_I,
		OFFSET_TITLE_T,
		OFFSET_TITLE_A,
		OFFSET_TITLE_I,
		OFFSET_TITLE_R,
		OFFSET_TITLE_E,
	};
	draw_sequential_card(1u + dynamic_metasprite.data[0] * 2u, 2u, OFFSET_BKG_TITLE + offsets[dynamic_metasprite.data[0]]);
	if (dynamic_metasprite.data[0] == 8u) {
		dynamic_metasprite_end_animation();
		return;
	}
	dynamic_metasprite.data[0]++;
	dynamic_metasprite.elapsed_frames = 0;
	dynamic_metasprite.dist[0] += 16;
	dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_TITLE + offsets[dynamic_metasprite.data[0]];
}

inline void dynamic_metasprite_splash_screen(void)
{
	dynamic_metasprite.src[0] = 72;
	dynamic_metasprite.src[1] = -24;
	dynamic_metasprite.dist[0] = -64;
	dynamic_metasprite.dist[1] = 40;
	dynamic_metasprite.target_frames = TARGET_FRAMES_SPLASH_SCREEN;
	dynamic_metasprite.elapsed_frames = 0;
	dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_TITLE + OFFSET_TITLE_S;
	dynamic_metasprite.data[0] = 0;
	dynamic_metasprite.callback = &dynamic_metasprite_splash_screen_callback;
	flags |= FLAG_PLAYING_ANIMATION;
}

void dynamic_metasprite_fold_pile(void)
{
	UINT8 pile_idx = dynamic_metasprite.data[3] & 0xF;
	if (!pile_idx) {
		dynamic_metasprite_end_animation();
		if (num_folded_piles == 8u) {//NOTE: THIS IS WHERE GAME ENDS
			metasprite_2x3_hide(SPRITE_FRAME);
			move_bkg(0, 0);
			scroll = 0u;
			add_leaderboard();
			start_leaderboard();
			score = START_SCORE;
		}
		return;
	}

	num_folded_piles++;

	Pile *pile = IDX_PTR(piles, pile_idx);
	UINT8 x = pile_idx * 16u;
	dynamic_metasprite_fold(pile->top->data,
		x,
		8u * 15u,
		x,
		0,
		13u,
		pile->base,
		0,
		dynamic_metasprite.data[3] >> 4u
	);
	pile->base = NULL;
	pile->top = NULL;
	pile->height = 0;
	cursor_adjust_height();
}

void dynamic_metasprite_unfold_callback(void)
{
	Card const *card = dynamic_metasprite.data_ptr;
	if (!card->next_card) {
		draw_card(dynamic_metasprite.data[1] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 1u, card->data);
		dynamic_metasprite_fold_pile();
		return;
	}
	dynamic_metasprite.data_ptr = card->next_card;
	dynamic_metasprite.src[1] += 8;
	draw_card_top(dynamic_metasprite.data[1] / 8u, dynamic_metasprite.src[1] / 8u, card->data);
	dynamic_metasprite.elapsed_frames = 0;
}

void dynamic_metasprite_move_stack_callback(void)
{
	if (dynamic_metasprite.data[0] & BITMASK_DYNAMIC_METASPRITE_UNFOLD) {
		dynamic_metasprite.src[0] = dynamic_metasprite.data[1];
		dynamic_metasprite.src[1] = dynamic_metasprite.data[2] - 8u;
		dynamic_metasprite.dist[0] = 0;
		dynamic_metasprite.dist[1] = 8;
		dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].fold_target_frames;
		dynamic_metasprite.callback = &dynamic_metasprite_unfold_callback;
		dynamic_metasprite_unfold_callback();
	} else {
		dynamic_metasprite_fold_pile();
	}
}

void dynamic_metasprite_fold_callback(void)
{
	dynamic_metasprite.src[1] -= 8;
	dynamic_metasprite.elapsed_frames = 0;
	clear_bkg_2x1((UINT8)dynamic_metasprite.src[0] / 8u, (UINT8)dynamic_metasprite.src[1] / 8u + 2u);
	if (dynamic_metasprite.data[0] & ~BITMASK_DYNAMIC_METASPRITE_UNFOLD) {
		dynamic_metasprite.data[0]--;
	} else {
		if (cursor.card_to_show) {
			draw_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u - 1u, cursor.card_to_show->data);
			cursor.card_to_show = NULL;
		} else {
			draw_sequential_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u, OFFSET_BKG_CARD + OFFSET_CARD_OUTLINE);
		}
		dynamic_metasprite.dist[0] = (INT16)dynamic_metasprite.data[1] - dynamic_metasprite.src[0];
		dynamic_metasprite.dist[1] = (INT16)dynamic_metasprite.data[2] - dynamic_metasprite.src[1];
		dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].move_target_frames;
		dynamic_metasprite.callback = &dynamic_metasprite_move_stack_callback;
	}

}

void dynamic_metasprite_fold(const UINT8 top_card_data, const UINT8 src_x, const UINT8 src_y, const UINT8 dest_x, const UINT8 dest_y, const UINT8 stack_height, const Card *base_card, const UINT8 unfold, const UINT8 piles_to_clear)
{
	set_metasprite_card(top_card_data);

	dynamic_metasprite.metasprite = metasprite_custom_2x3;
	dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_CARD;

	dynamic_metasprite.data[0] = (stack_height - 1u) | unfold;
	dynamic_metasprite.data[1] = dest_x;
	dynamic_metasprite.data[2] = dest_y;
	dynamic_metasprite.data[3] = piles_to_clear;
	dynamic_metasprite.data_ptr = base_card;

	dynamic_metasprite.src[0] = src_x;
	dynamic_metasprite.src[1] = src_y + 8u;

	flags |= FLAG_PLAYING_ANIMATION;

	if (stack_height > 1) {
		dynamic_metasprite.dist[0] = 0;
		dynamic_metasprite.dist[1] = -8;
		dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].fold_target_frames;
		dynamic_metasprite.callback = &dynamic_metasprite_fold_callback;
	}
	dynamic_metasprite_fold_callback();
}

void dynamic_metasprite_deal_callback(void)
{
	Pile *pile = IDX_PTR(piles, dynamic_metasprite.data[0]);
	draw_card(dynamic_metasprite.data[0] * 2u, 2u + pile->height, pile->top->data);
	if (dynamic_metasprite.data[0] == 9u) {
		if (top_card_idx == 104u)
			draw_sequential_card(0, 0, OFFSET_BKG_CARD + OFFSET_CARD_OUTLINE);
		dynamic_metasprite_end_animation();
		return;
	}
	pile++;
	dynamic_metasprite.data[0]++;
	dynamic_metasprite.dist[0] += 16;
	dynamic_metasprite.dist[1] = (INT16)(2u + pile->height) * 8;
	dynamic_metasprite.elapsed_frames = 0;
}

void dynamic_metasprite_deal(void)
{
	Pile *pile = IDX_PTR(piles, 0);
	dynamic_metasprite.src[0] = 0;
	dynamic_metasprite.src[1] = 0;
	dynamic_metasprite.dist[0] = 0;
	dynamic_metasprite.dist[1] = (INT16)(2u + pile->height) * 8;
	dynamic_metasprite.elapsed_frames = 0;
	dynamic_metasprite.target_frames = animation_speeds[ANIMATION_SPEED(settings)].move_target_frames;
	dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_CARD + OFFSET_CARD_BACK;
	dynamic_metasprite.data[0] = 0;
	dynamic_metasprite.callback = &dynamic_metasprite_deal_callback;
	flags |= FLAG_PLAYING_ANIMATION;
}

inline void dynamic_metasprite_process(void)
{
	if (dynamic_metasprite.elapsed_frames >= dynamic_metasprite.target_frames)
		return;

	dynamic_metasprite.elapsed_frames++;
	move_metasprite(dynamic_metasprite.metasprite,
		dynamic_metasprite.metasprite_offset,
		SPRITE_DYNAMIC,
		dynamic_metasprite.src[0] + (dynamic_metasprite.dist[0] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames),
		(INT16)scroll * -8 + dynamic_metasprite.src[1] + (dynamic_metasprite.dist[1] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames)
	);
	if (dynamic_metasprite.elapsed_frames == dynamic_metasprite.target_frames
		&& dynamic_metasprite.callback)
		dynamic_metasprite.callback();
}

/*******************************************************************************
*	Cursor
*******************************************************************************/

//If the cursor is higher than the pile, lower it to the top of the pile
void cursor_adjust_height(void)
{
	Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	if (cursor.height >= pile->height)
		cursor.height = pile->height - !!pile->height;
}

inline void cursor_grab_stack(void)
{
	UINT8 i;
	Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	Card *top = pile->base;
	for (i = 1; i < cursor.height; i++)
		top = top->next_card;
	Card *stack = cursor.height ? top->next_card : top;
	if (!(VISIBLE(stack->data) && is_stack_coherent(stack)))
		return;

	cursor.held_card = stack;
	cursor.hand_pile_idx = cursor.pile_idx;
	cursor.held_stack_size = pile->height - cursor.height;
	pile->height = cursor.height;
	flags |= FLAG_REDRAW_HAND;
	if (cursor.height) {
		pile->top = top;
		top->next_card = NULL;
		cursor.card_to_show = top;
	} else {
		pile->base = NULL;
		pile->top = NULL;
		cursor.card_to_show = NULL;
	}
}

inline void cursor_place_stack(void)
{
	Pile *pile = IDX_PTR(piles, cursor.hand_pile_idx);
	if (cursor.hand_pile_idx == cursor.pile_idx) {
		pile_append_cursor_stack(pile);
	} else if (!pile->height
		|| RANK(pile->top->data) == RANK(cursor.held_card->data) + 1u) {
		pile_append_cursor_stack(pile);
		score--;
	}
}

void set_cursor_setting(void)
{
	switch (cursor.pile_idx) {
	case 0u:
		settings &= ~BITMASK_SETTING_NUM_SUITS;
		settings |= cursor.height;
		draw_setting_frame_metasprites();
		break;
	case 1u:
		settings &= ~BITMASK_SETTING_MUSIC;
		settings |= !cursor.height << BIT_OFFSET_SETTING_MUSIC;
		draw_setting_frame_metasprites();
		break;
	case 2u:
		settings &= ~BITMASK_SETTING_ANIMATION_SPEED;
		settings |= cursor.height << BIT_OFFSET_SETTING_ANIMATION_SPEED;
		draw_setting_frame_metasprites();
		break;
	case 3u:
		start_game();
		break;
	}
}

void change_cursor_height(const INT8 inc)
{
	cursor.height = (INT8)cursor.height + inc;
	if (cursor.height < scroll) {
		scroll = cursor.height;
		move_bkg(0, scroll * 8u);
	} else if (cursor.height > scroll + 9u) {
		scroll = cursor.height - 9u;
		move_bkg(0, scroll * 8u);
	}
}

inline void cursor_process(void)
{
	switch (flags & FLAG_GAME_STATE) {
	case FLAG_GAME_STATE_SPLASH:
		return;
	}
	cursor.anim_ctr++;
	cursor.anim_ctr &= (1u << (CURSOR_PERIOD_LOGSCALE + 1u)) - 1u;
	UINT8 prev_anim_frame = cursor.anim_frame;
	cursor.anim_frame = cursor.anim_ctr >> CURSOR_PERIOD_LOGSCALE;
	if (cursor.anim_frame != prev_anim_frame)
		flags |= FLAG_REDRAW_CURSOR;

	if (flags & FLAG_REDRAW_CURSOR) {
		flags &= ~FLAG_REDRAW_CURSOR;
		switch (flags & FLAG_GAME_STATE) {
		case FLAG_GAME_STATE_SETTINGS:
			move_metasprite(cursor_metasprites[cursor.anim_frame],
				OFFSET_SPRITE_CURSOR + OFFSET_CURSOR_FRAME,
				SPRITE_FRAME,
				cursor.height * 16u + SETTINGS_SPLIT_X * 8u,
				SETTINGS_PAD_Y * 8u + cursor.pile_idx * 32u
			);
			break;
		case FLAG_GAME_STATE_LEADERBOARD:
			if (selected_leaderboard) {
				set_sprite_tile(SPRITE_FRAME, OFFSET_SPRITE_CURSOR + OFFSET_CURSOR_UNDERLINE + cursor.anim_frame);
				move_sprite(SPRITE_FRAME, (LEADERBOARD_NAME_X + 1u) * 8u + cursor.pile_idx * 8u, 16u + cursor.height * 8u);
			}
			break;
		case FLAG_GAME_STATE_INGAME:
			if (cursor.pile_idx == PILE_IDX_DECK)
				move_metasprite(cursor_metasprites[cursor.anim_frame],
					OFFSET_SPRITE_CURSOR + OFFSET_CURSOR_FRAME,
					SPRITE_FRAME,
					0,
					0
				);
			else
				move_metasprite(cursor_metasprites[cursor.anim_frame],
					OFFSET_SPRITE_CURSOR + OFFSET_CURSOR_FRAME,
					SPRITE_FRAME,
					cursor.pile_idx * 16u,
					(cursor.height + 3u - scroll) * 8u
				);
			break;
		}

	}
	if (flags & FLAG_REDRAW_HAND) {
		flags &= ~FLAG_REDRAW_HAND;
		if (cursor.held_card) {
			UINT8 height = piles[cursor.hand_pile_idx].height;
			move_metasprite(metasprite_sequential_2x3,
				OFFSET_SPRITE_CURSOR + OFFSET_CURSOR_HAND,
				SPRITE_HAND,
				cursor.hand_pile_idx * 16u,
				(height + !height + 2u - scroll) * 8u
			);
		} else {
			metasprite_2x3_hide(SPRITE_HAND);
		}
	}
}

/*******************************************************************************
*	Card
*******************************************************************************/

void init_deck(void)
{
	Card *card = IDX_PTR(deck, 0);
	UINT8 suit;
	UINT8 rank;
	UINT8 i;

	//Set cards in deck
	UINT8 suit_increment = 4u >> NUM_SUITS(settings);
	UINT8 i_max = suit_increment * 2u;
	for (suit = 0; suit < 4u; suit += suit_increment) {
		for (rank = 0; rank < 13u; rank++) {
			for (i = 0; i < i_max; i++) {
				card->data = rank | (suit << BIT_OFFSET_CARD_SUIT);
				card++;
			}
		}
	}

	//Shuffle
	card = IDX_PTR(deck, 103u);
	for (i = 103u; i; i--) {
		Card *swap = IDX_PTR(deck, (UINT8)rand() % i);
		Card temp;
		temp = *card;
		*card = *swap;
		*swap = temp;
		card--;
	}

	//Initialize piles
	card = IDX_PTR(deck, 0);
	for (i = 0; i < 44u; i++) {
		card->next_card = IDX_PTR(deck, i + 10u);
		card++;
	}
	for (; i < 104u; i++) {
		card->data |= BITMASK_CARD_VISIBLE;
		card->next_card = NULL;
		card++;
	}

	card = IDX_PTR(deck, 0);
	Pile *pile = IDX_PTR(piles, 0);
	for (i = 0; i < 10; i++) {
		pile->base = card;
		if (i < 4u) {
			pile->top = IDX_PTR(deck, 50u + i);
			pile->height = 6u;
		} else {
			pile->top = IDX_PTR(deck, 40u + i);
			pile->height = 5u;
		}

		card++;
		pile++;
	}

	top_card_idx = 54u;
}

UINT8 is_stack_coherent(Card *card)
{
	while (card->next_card) {
		UINT8 prev_data = card->data;
		card = card->next_card;
		if (prev_data != card->data + 1u)
			return 0u;
	}
	return 1u;
}

inline void deal(void)
{
	UINT8 i;
	Pile *pile = IDX_PTR(piles, 0);

	//Ensure all piles have cards
	for (i = 0; i < 10u; i++) {
		if (!pile->height)
			return;
		pile++;
	}

	pile = IDX_PTR(piles, 0);
	Card *deck_top = IDX_PTR(deck, top_card_idx);
	top_card_idx += 10u;

	//Add card to top of each pile
	for (i = 0; i < 10u; i++) {
		pile->top->next_card = deck_top;
		pile->top = deck_top;
		pile->height++;
		deck_top++;
		pile++;
	}

	dynamic_metasprite_deal();
}

void pile_append_cursor_stack(Pile *pile)
{
	if (pile->height)
		pile->top->next_card = cursor.held_card;
	else
		pile->base = cursor.held_card;

	Pile *src_pile = IDX_PTR(piles, cursor.pile_idx);
	Card *top_card = cursor.held_card;
	while (top_card->next_card)
		top_card = top_card->next_card;
	pile->top = top_card;
	cursor.height = pile->height - !!pile->height;
	pile->height += cursor.held_stack_size;
	if (cursor.hand_pile_idx != cursor.pile_idx) {
		UINT8 piles_to_clear = 0;
		if (src_pile->height == 13u && is_stack_coherent(src_pile->base)) {
			piles_to_clear = cursor.pile_idx;
		}
		if (pile->height == 13u && is_stack_coherent(pile->base)) {
			cursor.height = 0;
			piles_to_clear |= piles_to_clear ? cursor.hand_pile_idx << 4u : cursor.hand_pile_idx;
		}

		if (cursor.card_to_show)
			cursor.card_to_show->data |= BITMASK_CARD_VISIBLE;
		dynamic_metasprite_fold(top_card->data,
			cursor.pile_idx * 16u,
			(src_pile->height + 2u + cursor.held_stack_size) * 8u, cursor.hand_pile_idx * 16u,
			(pile->height + 3u - cursor.held_stack_size) * 8u,
			cursor.held_stack_size,
			cursor.held_card,
			BITMASK_DYNAMIC_METASPRITE_UNFOLD,
			piles_to_clear
		);
	}

	cursor.held_card = NULL;
	cursor.pile_idx = cursor.hand_pile_idx;
	flags |= FLAG_REDRAW_CURSOR;
}

/*******************************************************************************
*	MISCELLANEOUS
*******************************************************************************/

void start_game(void)
{
	flags &= ~FLAG_GAME_STATE;
	flags |= FLAG_GAME_STATE_INGAME | FLAG_REDRAW_CURSOR;
	cursor.pile_idx = 0;
	cursor.height = 0;
	metasprite_2x3_hide(SPRITE_FRAME_1);
	metasprite_2x3_hide(SPRITE_FRAME_2);
	metasprite_2x3_hide(SPRITE_FRAME_3);
	init_deck();
	clear_bkg();
	draw_bkg_game();
}

inline void start_settings(void)
{
	flags &= ~FLAG_GAME_STATE;
	flags |= FLAG_GAME_STATE_SETTINGS | FLAG_REDRAW_CURSOR;
	cursor.pile_idx = 0;
	cursor.height = 0;
	draw_setting_frame_metasprites();
	clear_bkg();
	draw_bkg_settings();
}

void start_splash_screen(void)
{
	flags &= ~FLAG_GAME_STATE;
	flags |= FLAG_GAME_STATE_SPLASH;
	clear_bkg();
	draw_bkg_splash_screen();
	dynamic_metasprite_splash_screen();
}

void start_leaderboard(void)
{
	ENABLE_RAM_MBC1;
	flags &= ~FLAG_GAME_STATE;
	flags |= FLAG_GAME_STATE_LEADERBOARD;
	cursor.pile_idx = 0;
	clear_bkg();
	draw_bkg_leaderboard();
	DISABLE_RAM_MBC1;
}

void add_leaderboard(void)
{
	ENABLE_RAM_MBC1;
	LeaderBoard *iter = leaderboard[NUM_SUITS(settings)];
	UINT8 i;
	for (i = 0; i < 3u; i++) {
		if (score > iter->score)
			break;
		iter++;
	}
	if (i == 3u)
		return;
	iter->score = score;
	iter->name[0] = 0x0B;
	iter->name[1] = 0x0B;
	iter->name[2] = 0x0B;
	selected_leaderboard = iter;
	cursor.height = LEADERBOARD_PAD_Y + NUM_SUITS(settings) * 4u + i;
	flags |= FLAG_REDRAW_CURSOR;
	DISABLE_RAM_MBC1;
}

void nvram_check(void)
{
	ENABLE_RAM_MBC1;
	if (nvram_check_data != NVRAM_SET) {
		nvram_check_data = NVRAM_SET;
		LeaderBoard *iter = IDX_PTR(leaderboard[0], 0u);
		UINT8 i, j;
		for (i = 0; i < 3; i++) {
			iter->score = 400u - 100u * (UINT16)i;
			iter->name[0] = 0x21u;
			iter->name[1] = 0x19u;
			iter->name[2] = 0x14u;
			iter++;
			for (j = 0; j < 2; j++) {
				iter->score = 0u;
				iter->name[0] = 0u;
				iter->name[1] = 0u;
				iter->name[2] = 0u;
				iter++;
			}
		}
	}
	DISABLE_RAM_MBC1;
}

void inc_letter(const INT8 inc)
{
	ENABLE_RAM_MBC1;
	UINT8 *letter = &selected_leaderboard->name[cursor.pile_idx];
	*letter = (INT8)*letter + inc;
	if (*letter < 0x0Bu)
		*letter = 0x24u;
	else if (*letter > 0x24u)
		*letter = 0x0Bu;
	set_bkg_tile_xy(LEADERBOARD_NAME_X + cursor.pile_idx, cursor.height, *letter);
	DISABLE_RAM_MBC1;
}

inline void input_process(void)
{
	static UINT8 prev_input = 0;
	UINT8 input = joypad();
	UINT8 new_input = input & ~prev_input;
	if (new_input) {
		switch (flags & FLAG_GAME_STATE) {
		case FLAG_GAME_STATE_SPLASH:
			if (new_input & J_START) {
				initrand(DIV_REG);
				if (flags & FLAG_PLAYING_ANIMATION)
					dynamic_metasprite_end_animation();
				start_settings();
			} else if (new_input & J_SELECT) {
				if (flags & FLAG_PLAYING_ANIMATION)
					dynamic_metasprite_end_animation();
				start_leaderboard();
			}
			break;
		case FLAG_GAME_STATE_LEADERBOARD:
			flags |= FLAG_REDRAW_CURSOR;
			if (selected_leaderboard) {
				if (new_input & J_START
					&& cursor.pile_idx == 2u) {
					selected_leaderboard = NULL;
					set_sprite_tile(SPRITE_FRAME, OFFSET_SPRITE_NONE);
				} else if (new_input & J_A) {
					if (cursor.pile_idx == 2u) {
						selected_leaderboard = NULL;
						set_sprite_tile(SPRITE_FRAME, OFFSET_SPRITE_NONE);
					} else {
 						cursor.pile_idx++;
					}
				} else if (new_input & J_RIGHT
					&& cursor.pile_idx < 2u) {
					cursor.pile_idx++;
				} else if (new_input & J_LEFT
					&& cursor.pile_idx) {
					cursor.pile_idx--;
				} else if (new_input & J_UP) {
					inc_letter(1);
				} else if (new_input & J_DOWN) {
					inc_letter(-1);
				}
			} else if (new_input & (J_START | J_SELECT | J_A | J_B)) {
				start_splash_screen();
			}
			break;
		case FLAG_GAME_STATE_SETTINGS:
			flags |= FLAG_REDRAW_CURSOR;
			if (new_input & J_START) {
				start_game();
			} else if (new_input & J_LEFT
				&& cursor.height) {
				cursor.height--;
			} else if (new_input & J_RIGHT
				&& cursor.height + 1u < setting_pile_heights[cursor.pile_idx]) {
				cursor.height++;
			} else if (new_input & J_UP
				&& cursor.pile_idx) {
				cursor.pile_idx--;
				cursor.height = 0;
			} else if (new_input & J_DOWN
				&& cursor.pile_idx < NUM_SETTING_PILES - 1u) {
				cursor.pile_idx++;
				cursor.height = 0;
			}
			if (new_input & J_A) {
				set_cursor_setting();
			}
			break;
		case FLAG_GAME_STATE_INGAME:
			if (cursor.held_card) {
				flags |= FLAG_REDRAW_HAND;
				if (new_input & J_LEFT
					&& cursor.hand_pile_idx != 0) {
					cursor.hand_pile_idx--;
				} else if (new_input & J_RIGHT
					&& cursor.hand_pile_idx < 9) {
					cursor.hand_pile_idx++;
				}
				if (new_input & J_A
					&& ~flags & FLAG_PLAYING_ANIMATION) {
					cursor_place_stack();
				}
			} else {
				flags |= FLAG_REDRAW_CURSOR;
				if (new_input & J_DOWN) {
					if (cursor.pile_idx == PILE_IDX_DECK)
						cursor.pile_idx = 0;
					else if (cursor.height + 1u < piles[cursor.pile_idx].height)
						change_cursor_height(1);
				} else if (new_input & J_UP) {
					if (cursor.height == 0)
						cursor.pile_idx = PILE_IDX_DECK;
					else
						change_cursor_height(-1);
				} else if (new_input & J_LEFT
					&& cursor.pile_idx != 0
					&& cursor.pile_idx != PILE_IDX_DECK) {
						cursor.pile_idx--;
						cursor_adjust_height();
				} else if (new_input & J_RIGHT
					&& cursor.pile_idx < PILE_IDX_DECK - 1u) {
						cursor.pile_idx++;
						cursor_adjust_height();
				}
				if (new_input & J_A
					&& ~flags & FLAG_PLAYING_ANIMATION) {
					if (cursor.pile_idx == PILE_IDX_DECK && top_card_idx != 104u)
						deal();
					else
						cursor_grab_stack();
				}
			}
			break;
		}
	}
	prev_input = input;
}

void main(void)
{
	font_init();
	font_t font = font_load(font_min);
	font_set(font);
	set_bkg_data(OFFSET_BKG_FONT_ADDON, N_FONT_ADDON, font_addon);

	set_bkg_data(OFFSET_BKG_TITLE, N_TITLE, title_textures);
	set_bkg_data(OFFSET_BKG_CARD, N_CARD, card_textures);
	set_bkg_data(OFFSET_BKG_CARD_ADDON, N_CARD_ADDON, card_addon);
	set_bkg_data(OFFSET_BKG_BUTTON, N_BUTTON, button_textures);
	set_sprite_data(OFFSET_SPRITE_CURSOR, N_CURSOR, cursor_textures);

	nvram_check();

	start_splash_screen();

	SHOW_BKG;
	SHOW_SPRITES;
	DISPLAY_ON;

	while (1) {
		input_process();

		cursor_process();

		dynamic_metasprite_process();

		wait_vbl_done();
	}
}
