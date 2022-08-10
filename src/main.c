#include <gtk/gtk.h>

#include <game.h>

#include <gui_templates.h>

#include <stdio.h>
#include <stdbool.h>

#include <gmp.h>

#include <pthread.h>

pthread_mutex_t mutex_cookie_arithmetic;

void draw_main_window(GtkWidget *w, gpointer data){
  Game *g = (Game *) data;
  GtkWidget *window_root = gtk_widget_get_toplevel(w);

  gui_templates_clear_container(window_root);

  //Boxes
  GtkWidget *main_vbox;
  GtkWidget *main_hbox;
  GtkWidget *left_vbox;
  GtkWidget *center_vbox;
  GtkWidget *right_vbox;

  //Widgets


  //Packing
  left_vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);

  center_vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);

  right_vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);

  main_hbox = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 5);
  gtk_box_pack_start(GTK_BOX(main_hbox), left_vbox, false, false, 0);
  gtk_box_pack_start(GTK_BOX(main_hbox), center_vbox, false, false, 0);
  gtk_box_pack_start(GTK_BOX(main_hbox), right_vbox, false, false, 0);

  main_vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);
  gtk_box_pack_start(GTK_BOX(main_vbox), main_hbox, true, true, 0);

  gtk_container_add(GTK_CONTAINER(window_root), main_vbox);
  gtk_widget_show_all(window_root);
}

int main(int argc, char *argv[]){
  gtk_init(&argc, &argv);
  pthread_mutex_init(&mutex_cookie_arithmetic, NULL);

  GtkWidget *window_root = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_title(GTK_WINDOW(window_root), "Cookie Clicker");
  g_signal_connect(window_root, "destroy", G_CALLBACK(gtk_main_quit), (gpointer) window_root);
  gtk_window_set_position(GTK_WINDOW(window_root), GTK_WIN_POS_CENTER);
  gtk_container_set_border_width(GTK_CONTAINER(window_root), 0);

  gtk_widget_show_all(window_root);

  Game *g = game_new();
  draw_main_window(window_root, (gpointer) g);

  gtk_main();

  pthread_mutex_destroy(&mutex_cookie_arithmetic);
  return 0;
}
