#include <gb/gb.h>
#include <gb/metasprites.h>

#include <rand.h>

#include "../res/cursor.h"
#include "../res/cards.h"

#define SCOREBAR_HEIGHT 3u

//period in frames is 2 ^ CURSOR_PERIOD
#define CURSOR_PERIOD 6u

#define PILE_IDX_DECK 10u

#define OFFSET_BKG_NONE     0
#define OFFSET_BKG_RANK     1u
#define OFFSET_BKG_SUIT     (OFFSET_BKG_RANK + 13u)
#define OFFSET_BKG_BLANK    (OFFSET_BKG_SUIT + 4u)
#define OFFSET_BKG_BACK     (OFFSET_BKG_BLANK + 6u)
#define OFFSET_BKG_RANK_ROT (OFFSET_BKG_BACK + 6u)
#define OFFSET_BKG_SUIT_ROT (OFFSET_BKG_RANK_ROT + 13u)

#define SPRITE_CURSOR 0
#define SPRITE_HAND   6u

#define OFFSET_SPRITE_NONE   0
#define OFFSET_SPRITE_CURSOR 1u

#define OFFSET_SUIT    4u
#define OFFSET_VISIBLE 6u

#define BITMASK_RANK    0b00001111
#define BITMASK_SUIT    0b00110000
#define BITMASK_VISIBLE 0b01000000

#define BITMASK_REDRAW_CURSOR 0b00000001
#define BITMASK_REDRAW_HAND   0b00000010

#define RANK(data)    (data & BITMASK_RANK)
#define SUIT(data)    ((data & BITMASK_SUIT) >> OFFSET_SUIT)
#define VISIBLE(data) (data & BITMASK_VISIBLE)

#define IDX_PTR(arr, idx) (arr + idx)

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

typedef struct Cursor {
	Card *held_card;
	Card *card_to_show;
	UINT8 held_stack_size;

	UINT8 hand_pile_idx;

	UINT8 pile_idx;
	UINT8 height;

	UINT8 anim_ctr;
	UINT8 anim_frame;
	UINT8 redraw;
} Cursor;

Card deck[104];
Pile piles[10];
UINT8 top_card_idx;
UINT16 score = 500;

Cursor cursor = {
	.held_card = NULL,
	.card_to_show = NULL,
	.hand_pile_idx = 0,
	.pile_idx = 10,
	.height = 0,
	.anim_ctr = 0,
	.anim_frame = 0,
	.redraw = BITMASK_REDRAW_CURSOR,
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
				card->data = rank | (suit << OFFSET_SUIT);
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
		card->next_card = IDX_PTR(deck, i + 10u);
		card++;
	}
	for (; i < 104u; i++) {
		card->data |= BITMASK_VISIBLE;
		card->next_card = NULL;
		card++;
	}

	card = IDX_PTR(deck, 0);
	Pile *pile = IDX_PTR(piles, 0);
	for (i = 0; i < 10; i++) {
		pile->base = card;
		if (i < 4u) {
			pile->top = IDX_PTR(deck, 50u + i);
			pile->height = 5u;
		} else {
			pile->top = IDX_PTR(deck, 40u + i);
			pile->height = 4u;
		}

		card++;
		pile++;
	}

	top_card_idx = 54u;
}

void draw_pile(Card *card, UINT8 pile_idx, UINT8 height)
{
	pile_idx <<= 1;
	height += SCOREBAR_HEIGHT;
	while (1) {
		if (VISIBLE(card->data)) {
			set_bkg_tile_xy(pile_idx, height, RANK(card->data) + OFFSET_BKG_RANK);
			set_bkg_tile_xy(pile_idx + 1u, height, SUIT(card->data) + OFFSET_BKG_SUIT);
		} else {
			set_bkg_tile_xy(pile_idx, height, OFFSET_BKG_BACK);
			set_bkg_tile_xy(pile_idx + 1u, height, OFFSET_BKG_BACK + 1u);
		}
		if (!card->next_card) {
			set_bkg_tile_xy(pile_idx, ++height, OFFSET_BKG_BLANK + 2u);
			set_bkg_tile_xy(pile_idx + 1u, height, OFFSET_BKG_BLANK + 3u);
			set_bkg_tile_xy(pile_idx, ++height, SUIT(card->data) + OFFSET_BKG_SUIT_ROT);
			set_bkg_tile_xy(pile_idx + 1u, height, RANK(card->data) + OFFSET_BKG_RANK_ROT);
			break;
		}

		height++;
		card = card->next_card;
	}

	//clear previous cards which were lower on the screen
	while (*get_bkg_xy_addr(pile_idx, ++height)) {
		set_bkg_tile_xy(pile_idx, height, OFFSET_BKG_NONE);
		set_bkg_tile_xy(pile_idx + 1u, height, OFFSET_BKG_NONE);
	}
}

void draw_card(UINT8 x, UINT8 y, UINT8 bkg_offset)
{
	set_bkg_tile_xy(x, y, bkg_offset);
	set_bkg_tile_xy(x + 1u, y, bkg_offset + 1u);
	set_bkg_tile_xy(x, y + 1u, bkg_offset + 2u);
	set_bkg_tile_xy(x + 1u, y + 1u, bkg_offset + 3u);
	set_bkg_tile_xy(x, y + 2u, bkg_offset + 4u);
	set_bkg_tile_xy(x + 1u, y + 2u, bkg_offset + 5u);
}

void draw_background(void)
{
	UINT8 i;
	Pile *pile = IDX_PTR(piles, 0);
	for (i = 0; i < 10u; i++) {
		draw_pile(pile->base, i, 0);
		pile++;
	}
	draw_card(0, 0, OFFSET_BKG_BACK);
}

void cursor_adjust_height(void)
{
	Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	if (cursor.height > pile->height)
		cursor.height = pile->height;
}

inline void cursor_grab_stack(void)
{
	UINT8 i;
	Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	Card *top = pile->base;
	for (i = 1; i < cursor.height; i++)
		top = top->next_card;
	Card *stack = cursor.height ? top->next_card : top;
	if (!VISIBLE(stack->data))
		return;

	Card *card = stack;
	while (card->next_card) {
		UINT8 prev_data = card->data;
		card = card->next_card;
		if (prev_data != card->data + 1u)
			return;
	}

	cursor.held_card = stack;
	cursor.hand_pile_idx = cursor.pile_idx;
	cursor.held_stack_size = pile->height - cursor.height + !!cursor.height;//NOTE: this is somewhat jank and may cause problems
	pile->height = cursor.height - !!cursor.height;
	if (cursor.height) {
		pile->top = top;
		top->next_card = NULL;
		if (!VISIBLE(top->data))
			cursor.card_to_show = top;
	} else {
		pile->base = NULL;
		pile->top = NULL;
	}
}

inline void deal(void)
{
	UINT8 i;
	Pile *pile = IDX_PTR(piles, 0);
	for (i = 0; i < 10u; i++) {
		if (!pile->height)
			return;
		pile++;
	}

	pile = IDX_PTR(piles, 0);
	Card *deck_top = IDX_PTR(deck, top_card_idx);
	for (i = 0; i < 10u; i++) {
		pile->top->next_card = deck_top;
		pile->height++;
		draw_pile(deck_top, i, pile->height);
		deck_top++;
		pile++;
	}
	top_card_idx += 10u;

	if (top_card_idx == 104u)
		draw_card(0, 0, OFFSET_BKG_BLANK);
}

void pile_append_cursor_stack(Pile *pile)
{
	if (pile->height)
		pile->top->next_card = cursor.held_card;
	else
		pile->base = cursor.held_card;

	Card *top_card = cursor.held_card;
	while (top_card->next_card)
		top_card = top_card->next_card;
	pile->top = top_card;
	pile->height += cursor.held_stack_size;
	cursor.held_card = NULL;
	if (cursor.card_to_show && cursor.hand_pile_idx != cursor.pile_idx)
		cursor.card_to_show->data |= BITMASK_VISIBLE;
	cursor.card_to_show = NULL;
	cursor.height = pile->height;
	cursor.redraw |= BITMASK_REDRAW_CURSOR;

	draw_pile(piles[cursor.pile_idx].base, cursor.pile_idx, 0);
	draw_pile(pile->base, cursor.hand_pile_idx, 0); //TODO: optimize

	cursor.pile_idx = cursor.hand_pile_idx;
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

inline void input_process(void)
{
	static UINT8 prev_input = 0;
	UINT8 input = joypad();
	UINT8 new_input = input & ~prev_input;
	if (cursor.held_card) {
		cursor.redraw |= BITMASK_REDRAW_HAND;
		if (new_input & J_LEFT
			&& cursor.hand_pile_idx != 0) {
			cursor.hand_pile_idx--;
		} else if (new_input & J_RIGHT
			&& cursor.hand_pile_idx < 9) {
			cursor.hand_pile_idx++;
		}
		if (new_input & J_A) {
			cursor_place_stack();
		}
	} else {
		cursor.redraw |= BITMASK_REDRAW_CURSOR;
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
		} else if (new_input & J_LEFT
			&& cursor.pile_idx != 0
			&& cursor.pile_idx != PILE_IDX_DECK) {
				cursor.pile_idx--;
				cursor_adjust_height();
		} else if (new_input & J_RIGHT
			&& cursor.pile_idx < 9) {
				cursor.pile_idx++;
				cursor_adjust_height();
		}
		if (new_input & J_A) {
			if (cursor.pile_idx == PILE_IDX_DECK && top_card_idx != 104u)
				deal();
			else
				cursor_grab_stack();
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
		cursor.redraw |= BITMASK_REDRAW_CURSOR;

	if (cursor.redraw & BITMASK_REDRAW_CURSOR) {
		cursor.redraw &= ~BITMASK_REDRAW_CURSOR;
		if (cursor.pile_idx == PILE_IDX_DECK)
			move_metasprite(cursor_frames[cursor.anim_frame], OFFSET_SPRITE_CURSOR, SPRITE_CURSOR, 0, 0);
		else
			move_metasprite(cursor_frames[cursor.anim_frame], OFFSET_SPRITE_CURSOR, SPRITE_CURSOR, cursor.pile_idx << 4u, SCOREBAR_HEIGHT * 8u  + (cursor.height << 3u));
	}
	if (cursor.redraw & BITMASK_REDRAW_HAND) {
		cursor.redraw &= ~BITMASK_REDRAW_HAND;
		if (cursor.held_card)
			move_metasprite(cursor_frames[CURSOR_FRAME_HAND], OFFSET_SPRITE_CURSOR, SPRITE_HAND, cursor.hand_pile_idx << 4u, SCOREBAR_HEIGHT * 8u + (piles[cursor.hand_pile_idx].height << 3u));
		else
			move_metasprite(cursor_frames[CURSOR_FRAME_BLANK], OFFSET_SPRITE_NONE, 6, SPRITE_HAND, 0);
	}
}

void main(void)
{
	initrand(DIV_REG);

	set_bkg_data(0, 47u, card_textures);

	init_deck();

	draw_background();
	SHOW_BKG;

	set_sprite_data(OFFSET_SPRITE_CURSOR, 8, cursor_textures);
	SHOW_SPRITES;

	while (1) {
		input_process();

		cursor_anim_process();

		wait_vbl_done();
	}
}
