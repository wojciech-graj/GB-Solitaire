#ifndef CARD_H
#define CARD_H

#define N_CARD_RANK          13u
#define N_CARD_SUIT          4u
#define N_CARD_BLANK         6u
#define N_CARD_BACK          6u
#define N_CARD_RANK_ROT      13u
#define N_CARD_SUIT_ROT      4u
#define N_CARD_OUTLINE       6u
#define N_CARD_LIGHT_OUTLINE 6u
#define N_CARD          (N_CARD_RANK + N_CARD_SUIT + N_CARD_BLANK + N_CARD_BACK + N_CARD_RANK_ROT + N_CARD_SUIT_ROT + N_CARD_OUTLINE + N_CARD_LIGHT_OUTLINE)

#define OFFSET_CARD_RANK          0u
#define OFFSET_CARD_SUIT          (OFFSET_CARD_RANK + N_CARD_RANK)
#define OFFSET_CARD_BLANK         (OFFSET_CARD_SUIT + N_CARD_SUIT)
#define OFFSET_CARD_BACK          (OFFSET_CARD_BLANK + N_CARD_BLANK)
#define OFFSET_CARD_RANK_ROT      (OFFSET_CARD_BACK + N_CARD_BACK)
#define OFFSET_CARD_SUIT_ROT      (OFFSET_CARD_RANK_ROT + N_CARD_RANK_ROT)
#define OFFSET_CARD_OUTLINE       (OFFSET_CARD_SUIT_ROT + N_CARD_SUIT_ROT)
#define OFFSET_CARD_LIGHT_OUTLINE (OFFSET_CARD_OUTLINE + N_CARD_OUTLINE)

extern const unsigned char card_textures[];

#endif
