#ifndef NVRAM_H
#define NVRAM_H

//A random value used to check if the nvram has been set
#define NVRAM_SET 0xCD3E0137ul

#define NUM_LEADERBOARD 9u

typedef struct LeaderBoard {
	UINT8 name[3];
	UINT16 score;
} LeaderBoard;

extern LeaderBoard leaderboard[3][3];

extern UINT32 nvram_check_data;

#endif
