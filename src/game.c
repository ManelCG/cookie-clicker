#include <game.h>

#include <gmp.h>

#include <unistd.h>
#include <stdlib.h>

#include <pthread.h>

typedef struct Game {
  mpz_t cookies;
  mpz_t cps;
  mpz_t buildings[256];
  mpz_t multiplier;
} Game;

Game *game_new(){
  Game *g = malloc(sizeof(Game));

  mpz_init(g->cookies);
  mpz_set_ui(g->cookies, 0);

  // mpz_init(g->:q



  return g;
}

void game_gain_cookies(Game *g, mpz_t cookies, pthread_mutex_t *mutex){
  pthread_mutex_lock(mutex);
  mpz_add(g->cookies, g->cookies, cookies);
  pthread_mutex_unlock(mutex);
}

void game_lose_cookies(Game *g, mpz_t cookies, pthread_mutex_t *mutex){
  pthread_mutex_lock(mutex);
  mpz_sub(g->cookies, g->cookies, cookies);
  pthread_mutex_unlock(mutex);
}
