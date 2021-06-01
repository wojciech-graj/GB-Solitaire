#include <gb/gb.h>
#include <gb/metasprites.h>

#include <rand.h>

#include "../res/cursor.h"
#include "../res/cards.h"

#define SCOREBAR_HEIGHT 3u

//period in frames is 2 ^ CURSOR_PERIOD
#define CURSOR_PERIOD 6u

#define PILE_IDX_DECK 10u

#define OFFSET_BKG_RANK 1u
#define OFFSET_BKG_SUIT (OFFSET_BKG_RANK + 13u)
#define OFFSET_BKG_BLANK (OFFSET_BKG_SUIT + 4u)
#define OFFSET_BKG_BACK (OFFSET_BKG_BLANK + 6u)
#define OFFSET_BKG_RANK_ROT (OFFSET_BKG_BACK + 6u)
#define OFFSET_BKG_SUIT_ROT (OFFSET_BKG_RANK_ROT + 13u)

#define IDX_PTR(arr, idx) (arr + idx)

typedef struct Card Card;
typedef struct Card {
	Card *next_card;
	UINT8 rank : 4;
	UINT8 suit : 2;
	UINT8 visible : 1;
} Card;

typedef struct Pile {
	Card *card;
	UINT8 height;
} Pile;

typedef struct Cursor {
	Card *holding;
	UINT8 pile_idx;
	UINT8 height;
	UINT8 anim_ctr;
	UINT8 anim_frame;
	UINT8 redraw;
} Cursor;

Card deck[104];
Pile piles[10];
UINT8 top_card_idx;

Cursor cursor = {
	.holding = NULL,
	.pile_idx = 10,
	.height = 0,
	.anim_ctr = 0,
	.anim_frame = 0,
	.redraw = 1u,
};

//Sets cards in deck, shuffles them, then deals
void init_deck(void)
{
	Card *card = IDX_PTR(deck, 0);
	UINT8 suit;
	UINT8 rank;
	UINT8 i;

	for (suit = 0; suit < 4u; suit++) {
		for (rank = 0; rank < 13u; rank++) {
			for (i = 0; i < 2u; i++) {
				card->rank = rank;
				card->suit = suit;
				card->next_card = NULL;
				card++;
			}
		}
	}

	card = IDX_PTR(deck, 103u);
	for (i = 103u; i; i--) {
		Card *swap = IDX_PTR(deck, (UINT8)rand() % i);
		Card temp;
		temp = *card;
		*card = *swap;
		*swap = temp;
		card--;
	}

	card = IDX_PTR(deck, 0);
	for (i = 0; i < 44u; i++) {
		card->visible = 0;
		card->next_card = IDX_PTR(deck, i + 10u);
		card++;
	}
	for (; i < 54u; i++) {
		card->visible = 1u;
		card++;
	}

	card = IDX_PTR(deck, 0);
	Pile *pile = IDX_PTR(piles, 0);
	for (i = 0; i < 10; i++) {
		pile->card = card;
		pile->height = (i < 4u) ? 5u : 4u;
		card++;
		pile++;
	}

	top_card_idx = 53u;
}

void draw_pile(Card *card, UINT8 x, UINT8 y)
{
	while (1) {
		if (card->visible) {
			set_bkg_tile_xy(x, y, card->rank + OFFSET_BKG_RANK);
			set_bkg_tile_xy(x + 1u, y, card->suit + OFFSET_BKG_SUIT);
		} else {
			set_bkg_tile_xy(x, y, OFFSET_BKG_BACK);
			set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_BACK + 1u);
		}
		if (!card->next_card) {
			set_bkg_tile_xy(x, ++y, OFFSET_BKG_BLANK + 2u);
			set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_BLANK + 3u);
			set_bkg_tile_xy(x, ++y, card->suit + OFFSET_BKG_SUIT_ROT);
			set_bkg_tile_xy(x + 1u, y, card->rank + OFFSET_BKG_RANK_ROT);
			break;
		}

		y++;
		card = card->next_card;
	}
}

void draw_back(UINT8 x, UINT8 y)
{
	set_bkg_tile_xy(x, y, OFFSET_BKG_BACK);
	set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_BACK + 1u);
	set_bkg_tile_xy(x, y + 1u, OFFSET_BKG_BACK + 2u);
	set_bkg_tile_xy(x + 1u, y + 1u, OFFSET_BKG_BACK + 3u);
	set_bkg_tile_xy(x, y + 2u, OFFSET_BKG_BACK + 4u);
	set_bkg_tile_xy(x + 1u, y + 2u, OFFSET_BKG_BACK + 5u);
}

void draw_background(void)
{
	UINT8 i;
	Pile *pile = IDX_PTR(piles, 0);
	for (i = 0; i < 20u; i += 2u) {
		draw_pile(pile->card, i, SCOREBAR_HEIGHT);
		pile++;
	}
	draw_back(0, 0);
}

inline void cursor_adjust_height(void)
{
	Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	if (cursor.height > pile->height)
		cursor.height = pile->height;
}

inline void input_process(void)
{
	static UINT8 prev_input = 0;
	UINT8 input = joypad();
	UINT8 new_input = input & ~prev_input;
	if (new_input)
		cursor.redraw = 1u;
	if (new_input & J_DOWN) {
		if (cursor.pile_idx == PILE_IDX_DECK)
			cursor.pile_idx = 0;
		else if (cursor.height < piles[cursor.pile_idx].height)
			cursor.height++;
	} else if (new_input & J_UP) {
		if (cursor.height == 0)
			cursor.pile_idx = PILE_IDX_DECK;
		else
			cursor.height--;
	} else if (new_input & J_LEFT) {
		if (cursor.pile_idx != 0) {
			cursor.pile_idx--;
			cursor_adjust_height();
		}
	} else if (new_input & J_RIGHT) {
		if (cursor.pile_idx < 9) {
			cursor.pile_idx++;
			cursor_adjust_height();
		}
	}
	prev_input = input;
}

inline void cursor_anim_process(void)
{
	cursor.anim_ctr++;
	cursor.anim_ctr &= (1u << (CURSOR_PERIOD + 1u)) - 1u;
	UINT8 prev_anim_frame = cursor.anim_frame;
	cursor.anim_frame = cursor.anim_ctr >> CURSOR_PERIOD;
	if (cursor.anim_frame != prev_anim_frame)
		cursor.redraw = 1u;

	if (cursor.redraw) {
		cursor.redraw = 0;
		if (cursor.pile_idx == PILE_IDX_DECK)
			move_metasprite(cursor_frames[cursor.anim_frame], 0, 0, 0, 0);
		else
			move_metasprite(cursor_frames[cursor.anim_frame], 0, 0, cursor.pile_idx << 4u, SCOREBAR_HEIGHT * 8u  + (cursor.height << 3u));
	}
}

void main(void)
{
	initrand(DIV_REG);

	set_bkg_data(0, 47u, card_textures);

	init_deck();

	draw_background();
	SHOW_BKG;

	set_sprite_data(0, 8, cursor_textures);
	SHOW_SPRITES;

	while (1) {
		input_process();

		cursor_anim_process();

		wait_vbl_done();
	}
}
