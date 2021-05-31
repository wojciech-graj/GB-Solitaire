#include <gb/gb.h>
#include <rand.h>
#include <stdint.h>
#include <stdio.h>

#include "../res/cards.h"

#define OFFSET_TEX_RANK 1u
#define OFFSET_TEX_SUIT (OFFSET_TEX_RANK + 13u)
#define OFFSET_TEX_BLANK (OFFSET_TEX_SUIT + 4u)
#define OFFSET_TEX_BACK (OFFSET_TEX_BLANK + 6u)
#define OFFSET_TEX_INV_RANK (OFFSET_TEX_BACK + 6u)
#define OFFSET_TEX_INV_SUIT (OFFSET_TEX_INV_RANK + 13u)

#define IDX_PTR(arr, idx) (arr + idx)

typedef struct Card Card;
typedef struct Card {
	Card *next_card;
	UINT8 rank : 4;
	UINT8 suit : 2;
	UINT8 visible : 1;
} Card;

Card deck[104];
Card *piles[10];
UINT8 top_card_idx;

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
	for (i = 0; i < 10; i++) {
		piles[i] = card;
		card++;
	}

	top_card_idx = 53u;
}

void draw_pile(Card *card, UINT8 x, UINT8 y)
{
	while (1) {
		if (card->visible) {
			set_bkg_tile_xy(x, y, card->rank + OFFSET_TEX_RANK);
			set_bkg_tile_xy(x + 1u, y, card->suit + OFFSET_TEX_SUIT);
		} else {
			set_bkg_tile_xy(x, y, OFFSET_TEX_BACK);
			set_bkg_tile_xy(x + 1u, y, OFFSET_TEX_BACK + 1u);
		}
		if (!card->next_card) {
			set_bkg_tile_xy(x, y + 1u, OFFSET_TEX_BLANK + 2u);
			set_bkg_tile_xy(x + 1u, y + 1u, OFFSET_TEX_BLANK + 3u);
			set_bkg_tile_xy(x, y + 2u, card->suit + OFFSET_TEX_INV_SUIT);
			set_bkg_tile_xy(x + 1u, y + 2u, card->rank + OFFSET_TEX_INV_RANK);
			break;
		}

		y++;
		card = card->next_card;
	}
}

void draw_background(void)
{
	UINT8 x;
	Card **pile = IDX_PTR(piles, 0);
	for (x = 0; x < 20u; x += 2u) {
		draw_pile(*pile, x, 0);
		pile++;
	}
}

void main(void)
{
	initrand(DIV_REG);

	set_bkg_data(0, 47u, card_textures);

	init_deck();

	draw_background();
	SHOW_BKG;

	while (1) {
		delay(1000u);
	}
}
