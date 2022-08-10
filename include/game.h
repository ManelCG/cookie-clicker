#ifndef __GAME_H_
#define __GAME_H_

#include <pthread.h>
#include <gmp.h>

typedef struct Game Game;

Game *game_new();

void game_gain_cookies(Game *g, mpz_t cookies, pthread_mutex_t *mutex);
void game_lose_cookies(Game *g, mpz_t cookies, pthread_mutex_t *mutex);

#endif //_GAME_H_
