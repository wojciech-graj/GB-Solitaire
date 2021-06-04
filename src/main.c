#include <gb/gb.h>
#include <gb/metasprites.h>

#include <rand.h>

#include "../res/cursor.h"
#include "../res/card.h"
#include "../res/regular_metasprite.h"

//TODO: sprite z-order

#define SCOREBAR_HEIGHT 3u

//period in frames is 2 ^ CURSOR_PERIOD
#define CURSOR_PERIOD 6u

#define PILE_IDX_DECK 10u

#define SIZEOF_TILE 16u

#define FOLD_TARGET_FRAMES 16
#define MOVE_TARGET_FRAMES 16

#define OFFSET_BKG_NONE     0
#define OFFSET_BKG_CARD     1u
#define OFFSET_BKG_RANK     (OFFSET_BKG_CARD + OFFSET_CARD_RANK)
#define OFFSET_BKG_SUIT     (OFFSET_BKG_CARD + OFFSET_CARD_SUIT)
#define OFFSET_BKG_BLANK    (OFFSET_BKG_CARD + OFFSET_CARD_BLANK)
#define OFFSET_BKG_BACK     (OFFSET_BKG_CARD + OFFSET_CARD_BACK)
#define OFFSET_BKG_RANK_ROT (OFFSET_BKG_CARD + OFFSET_CARD_RANK_ROT)
#define OFFSET_BKG_SUIT_ROT (OFFSET_BKG_CARD + OFFSET_CARD_SUIT_ROT)
#define OFFSET_BKG_OUTLINE  (OFFSET_BKG_CARD + OFFSET_CARD_OUTLINE)

#define OFFSET_SPRITE_NONE     0
#define OFFSET_SPRITE_CURSOR   1u
#define OFFSET_SPRITE_FRAME    (OFFSET_SPRITE_CURSOR + OFFSET_CURSOR_FRAME)
#define OFFSET_SPRITE_HAND     (OFFSET_SPRITE_CURSOR + OFFSET_CURSOR_HAND)
#define OFFSET_SPRITE_CARD     (OFFSET_SPRITE_CURSOR + N_CURSOR)
#define OFFSET_SPRITE_RANK     (OFFSET_SPRITE_CARD + OFFSET_CARD_RANK)
#define OFFSET_SPRITE_SUIT     (OFFSET_SPRITE_CARD + OFFSET_CARD_SUIT)
#define OFFSET_SPRITE_BLANK    (OFFSET_SPRITE_CARD + OFFSET_CARD_BLANK)
#define OFFSET_SPRITE_BACK     (OFFSET_SPRITE_CARD + OFFSET_CARD_BACK)
#define OFFSET_SPRITE_RANK_ROT (OFFSET_SPRITE_CARD + OFFSET_CARD_RANK_ROT)
#define OFFSET_SPRITE_SUIT_ROT (OFFSET_SPRITE_CARD + OFFSET_CARD_SUIT_ROT)
#define OFFSET_SPRITE_OUTLINE  (OFFSET_SPRITE_CARD + OFFSET_CARD_OUTLINE)

#define SPRITE_FRAME   0
#define SPRITE_HAND    (SPRITE_FRAME + N_SPRITE_FRAME)
#define SPRITE_DYNAMIC (SPRITE_HAND + N_SPRITE_HAND)

#define BIT_OFFSET_DATA_RANK    0
#define BIT_OFFSET_DATA_SUIT    4u
#define BIT_OFFSET_DATA_VISIBLE 6u

#define BITMASK_DATA_RANK    0b00001111
#define BITMASK_DATA_SUIT    0b00110000
#define BITMASK_DATA_VISIBLE 0b01000000

#define RANK(data)    (data & BITMASK_DATA_RANK)
#define SUIT(data)    ((data & BITMASK_DATA_SUIT) >> BIT_OFFSET_DATA_SUIT)
#define VISIBLE(data) (data & BITMASK_DATA_VISIBLE)

#define FLAG_REDRAW_CURSOR     0b00000001
#define FLAG_REDRAW_HAND       0b00000010
#define FLAG_PLAYING_ANIMATION 0b00000100

#define BITMASK_DYNAMIC_METASPRITE_UNFOLD 0b10000000

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
} Cursor;

typedef struct DynamicMetaSprite {
	INT16 src[2];
	INT16 dist[2];
	INT8 target_frames;
	INT8 elapsed_frames;

	metasprite_t const * metasprite;
	UINT8 metasprite_offset;

	UINT8 data[4];
	void *data_ptr;

	void (*callback)(void);
} DynamicMetaSprite;

Card deck[104];
Pile piles[10];
UINT8 top_card_idx;
UINT8 flags = 0;

UINT16 score = 500;

DynamicMetaSprite dynamic_metasprite = {
	.target_frames = -1,
	.elapsed_frames = 0,
};

Cursor cursor = {
	.held_card = NULL,
	.card_to_show = NULL,
	.hand_pile_idx = 0,
	.pile_idx = 10,
	.height = 0,
	.anim_ctr = 0,
	.anim_frame = 0,
};

void metasprite_2x3_hide(UINT8 sprite)
{
	move_metasprite(metasprite_same_2x3,
		OFFSET_SPRITE_NONE,
		sprite,
		0,
		0
	);
}

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
				card->data = rank | (suit << BIT_OFFSET_DATA_SUIT);
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
		card->data |= BITMASK_DATA_VISIBLE;
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

inline void clear_bkg_2x1(const UINT8 x, const UINT8 y)
{
	set_bkg_tile_xy(x, y, OFFSET_BKG_NONE);
	set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_NONE);
}

void draw_card_top(const UINT8 x, const UINT8 y, const UINT8 card_data)
{
	if (VISIBLE(card_data)) {
		set_bkg_tile_xy(x, y, RANK(card_data) + OFFSET_BKG_RANK);
		set_bkg_tile_xy(x + 1u, y, SUIT(card_data) + OFFSET_BKG_SUIT);
	} else {
		set_bkg_tile_xy(x, y, OFFSET_BKG_BACK);
		set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_BACK + 1u);
	}
}

void draw_card_bottom(const UINT8 x, const UINT8 y, const UINT8 card_data)
{
	set_bkg_tile_xy(x, y, OFFSET_BKG_BLANK + 2u);
	set_bkg_tile_xy(x + 1u, y, OFFSET_BKG_BLANK + 3u);
	set_bkg_tile_xy(x, y+ 1u, SUIT(card_data) + OFFSET_BKG_SUIT_ROT);
	set_bkg_tile_xy(x + 1u, y+ 1u, RANK(card_data) + OFFSET_BKG_RANK_ROT);
}

inline void draw_card(const UINT8 x, const UINT8 y, const UINT8 card_data)
{
	draw_card_top(x, y, card_data);
	draw_card_bottom(x, y + 1u, card_data);
}

void draw_pile(Card *card, UINT8 pile_idx, UINT8 height)
{
	pile_idx <<= 1;
	height += SCOREBAR_HEIGHT;
	if (!card)
		return;
	while (1) {
		draw_card_top(pile_idx, height, card->data);
		if (!card->next_card) {
			draw_card_bottom(pile_idx, height + 1u, card->data);
			break;
		}
		height++;
		card = card->next_card;
	}
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

void draw_background(void)
{
	UINT8 i;
	Pile *pile = IDX_PTR(piles, 0);
	for (i = 0; i < 10u; i++) {
		draw_pile(pile->base, i, 0);
		pile++;
	}
	draw_sequential_card(0, 0, OFFSET_BKG_BACK);
}

void cursor_adjust_height(void)
{
	Pile *pile = IDX_PTR(piles, cursor.pile_idx);
	if (cursor.height >= pile->height)
		cursor.height = pile->height - !!pile->height;
}

UINT8 is_stack_coherent(Card *card)
{
	while (card->next_card) {
		UINT8 prev_data = card->data;
		card = card->next_card;
		if (prev_data != card->data + 1u)
			return 0;
	}
	return 1u;
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

void dynamic_metasprite_deal_callback(void)
{
	Pile *pile = IDX_PTR(piles, dynamic_metasprite.data[0]);
	draw_card(dynamic_metasprite.data[0] * 2u, SCOREBAR_HEIGHT + pile->height - 1u, pile->top->data);
	if (dynamic_metasprite.data[0] == 9u) {
		if (top_card_idx == 104u)
			draw_sequential_card(0, 0, OFFSET_BKG_OUTLINE);
		metasprite_2x3_hide(SPRITE_DYNAMIC);
		flags &= ~FLAG_PLAYING_ANIMATION;
		dynamic_metasprite.target_frames = -1;
		return;
	}
	pile++;
	dynamic_metasprite.data[0]++;
	dynamic_metasprite.dist[0] += 16;
	dynamic_metasprite.dist[1] = (INT16)(SCOREBAR_HEIGHT + pile->height - 1u) * 8;
	dynamic_metasprite.elapsed_frames = 0;
}

void dynamic_metasprite_deal(void)
{
	Pile *pile = IDX_PTR(piles, 0);
	dynamic_metasprite.src[0] = 0;
	dynamic_metasprite.src[1] = 0;
	dynamic_metasprite.dist[0] = 0;
	dynamic_metasprite.dist[1] = (INT16)(SCOREBAR_HEIGHT + pile->height - 1u) * 8;
	dynamic_metasprite.elapsed_frames = 0;
	dynamic_metasprite.target_frames = MOVE_TARGET_FRAMES;
	dynamic_metasprite.metasprite = metasprite_sequential_2x3;
	dynamic_metasprite.metasprite_offset = OFFSET_SPRITE_BACK;
	dynamic_metasprite.data[0] = 0;
	dynamic_metasprite.callback = &dynamic_metasprite_deal_callback;
	flags |= FLAG_PLAYING_ANIMATION;
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
		pile->top = deck_top;
		pile->height++;
		deck_top++;
		pile++;
	}
	top_card_idx += 10u;

	dynamic_metasprite_deal();
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

void dynamic_metasprite_fold(const UINT8 top_card_data, const UINT8 src_x, const UINT8 src_y, const UINT8 dest_x, const UINT8 dest_y, const UINT8 stack_height, const Card *base_card, const UINT8 unfold, const UINT8 piles_to_clear);

void dynamic_metasprite_fold_pile(void)
{
	UINT8 pile_idx = dynamic_metasprite.data[3] & 0xF;
	if (!pile_idx) {
		metasprite_2x3_hide(SPRITE_DYNAMIC);
		flags &= ~FLAG_PLAYING_ANIMATION;
		dynamic_metasprite.target_frames = -1;
		return;
	}

	Pile *pile = IDX_PTR(piles, pile_idx);
	UINT8 x = pile_idx * 16u;
	dynamic_metasprite_fold(pile->top->data,
		x,
		SCOREBAR_HEIGHT + 8u * 15u,
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
	Card *card = dynamic_metasprite.data_ptr;
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
		dynamic_metasprite.target_frames = FOLD_TARGET_FRAMES;
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
			draw_sequential_card(dynamic_metasprite.src[0] / 8u, dynamic_metasprite.src[1] / 8u, OFFSET_BKG_OUTLINE);
		}
		dynamic_metasprite.dist[0] = (INT16)dynamic_metasprite.data[1] - dynamic_metasprite.src[0];
		dynamic_metasprite.dist[1] = (INT16)dynamic_metasprite.data[2] - dynamic_metasprite.src[1];
		dynamic_metasprite.target_frames = MOVE_TARGET_FRAMES;
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
		dynamic_metasprite.target_frames = FOLD_TARGET_FRAMES;
		dynamic_metasprite.callback = &dynamic_metasprite_fold_callback;
	}
	dynamic_metasprite_fold_callback();
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
			cursor.card_to_show->data |= BITMASK_DATA_VISIBLE;
		dynamic_metasprite_fold(top_card->data,
			cursor.pile_idx * 16u,
			(src_pile->height + SCOREBAR_HEIGHT + cursor.held_stack_size - 1u) * 8u, cursor.hand_pile_idx * 16u,
			(pile->height + SCOREBAR_HEIGHT - cursor.held_stack_size) * 8u,
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
		if (new_input & J_A
			&& ~flags & FLAG_PLAYING_ANIMATION) {
			if (cursor.pile_idx == PILE_IDX_DECK && top_card_idx != 104u)
				deal();
			else
				cursor_grab_stack();
		}
	}
	prev_input = input;
}

inline void cursor_process(void)
{
	cursor.anim_ctr++;
	cursor.anim_ctr &= (1u << (CURSOR_PERIOD + 1u)) - 1u;
	UINT8 prev_anim_frame = cursor.anim_frame;
	cursor.anim_frame = cursor.anim_ctr >> CURSOR_PERIOD;
	if (cursor.anim_frame != prev_anim_frame)
		flags |= FLAG_REDRAW_CURSOR;

	if (flags & FLAG_REDRAW_CURSOR) {
		flags &= ~FLAG_REDRAW_CURSOR;
		if (cursor.pile_idx == PILE_IDX_DECK)
			move_metasprite(cursor_metasprites[cursor.anim_frame],
				OFFSET_SPRITE_FRAME,
				SPRITE_FRAME,
				0,
				0
			);
		else
			move_metasprite(cursor_metasprites[cursor.anim_frame],
				OFFSET_SPRITE_FRAME,
				SPRITE_FRAME,
				cursor.pile_idx << 4u,
				SCOREBAR_HEIGHT * 8u  + (cursor.height << 3u)
			);
	}
	if (flags & FLAG_REDRAW_HAND) {
		flags &= ~FLAG_REDRAW_HAND;
		if (cursor.held_card) {
			UINT8 height = piles[cursor.hand_pile_idx].height;
			move_metasprite(metasprite_sequential_2x3,
				OFFSET_SPRITE_HAND,
				SPRITE_HAND,
				cursor.hand_pile_idx << 4u,
				SCOREBAR_HEIGHT * 8u + ((height + !height) << 3u) - 8u
			);
		} else {
			metasprite_2x3_hide(SPRITE_HAND);
		}
	}
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
		dynamic_metasprite.src[1] + (dynamic_metasprite.dist[1] * dynamic_metasprite.elapsed_frames / dynamic_metasprite.target_frames)
	);
	if (dynamic_metasprite.elapsed_frames == dynamic_metasprite.target_frames
		&& dynamic_metasprite.callback)
		dynamic_metasprite.callback();
}

void main(void)
{
	set_bkg_data(OFFSET_BKG_CARD, N_CARD, card_textures);

	initrand(DIV_REG);

	init_deck();

	draw_background();
	SHOW_BKG;

	set_sprite_data(OFFSET_SPRITE_CURSOR, N_CURSOR, cursor_textures);
	set_sprite_data(OFFSET_SPRITE_CARD, N_CARD, card_textures);
	SHOW_SPRITES;

	while (1) {
		input_process();

		cursor_process();

		dynamic_metasprite_process();

		wait_vbl_done();
	}
}
