#include <gb/gb.h>
#include <gb/metasprites.h>

#include "regular_metasprite.h"

const metasprite_t metasprite_sequential_2x3[] = {
	{16, 8, 0, 0}, {0, 8, 1, 0},
	{8, -8, 2, 0}, {0, 8, 3, 0},
	{8, -8, 4, 0}, {0, 8, 5, 0},
	{metasprite_end}
};

const metasprite_t metasprite_same_2x3[] = {
	{16, 8, 0, 0}, {0, 8, 0, 0},
	{8, -8, 0, 0}, {0, 8, 0, 0},
	{8, -8, 0, 0}, {0, 8, 0, 0},
	{metasprite_end}
};
