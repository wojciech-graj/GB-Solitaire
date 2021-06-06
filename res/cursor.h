#ifndef CURSOR_H
#define CURSOR_H

#define N_SPRITE_FRAME 6u
#define N_SPRITE_HAND  6u
#define N_SPRITE_BLANK 6u

#define CURSOR_METASPRITE_HAND  2u
#define CURSOR_METASPRITE_BLANK 3u

#define N_CURSOR_FRAME     2u
#define N_CURSOR_HAND      6u
#define N_CURSOR_UNDERLINE 2u
#define N_CURSOR           (N_CURSOR_FRAME + N_CURSOR_HAND + N_CURSOR_UNDERLINE)

#define OFFSET_CURSOR_FRAME     0u
#define OFFSET_CURSOR_HAND      (OFFSET_CURSOR_FRAME + N_CURSOR_FRAME)
#define OFFSET_CURSOR_UNDERLINE (OFFSET_CURSOR_HAND + N_CURSOR_HAND)

extern const unsigned char cursor_textures[];

extern const metasprite_t * const cursor_metasprites[];

#endif
