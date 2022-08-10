COOKIECLICKER_VERSION = "Alfa 0"

SDIR = src

IDIR = include
CCCMD = gcc
CFLAGS = -I$(IDIR) `pkg-config --cflags --libs gtk+-3.0` -Wall -Wno-deprecated-declarations

debug: CC = $(CCCMD) -DDEBUG_ALL -DCOOKIECLICKER_VERSION=\"$(COOKIECLICKER_VERSION)_DEBUG\"
debug: BDIR = debug

release: CC = $(CCCMD) -O2 -DCOOKIECLICKER_VERSION=\"$(COOKIECLICKER_VERSION)\"
release: BDIR = build

windows: CC = $(CCCMD) -O2 -DCOOKIECLICKER_VERSION=\"$(COOKIECLICKER_VERSION)\"
windows: BDIR = build

install: CC = $(CCCMD) -O2	-DMAKE_INSTALL -DCOOKIECLICKER_VERSION=\"$(COOKIECLICKER_VERSION)\"
install: COOKIECLICKER_DIR = /usr/lib/cookieclicker
install: BDIR = $(COOKIECLICKER_DIR)/bin

archlinux: CC = $(CCCMD) -O2 -DMAKE_INSTALL -DCOOKIECLICKER_VERSION=\"$(COOKIECLICKER_VERSION)\"

ODIR=.obj
LDIR=lib

LIBS = -lm -lpthread -lgmp

_DEPS = game.h upgrades.h gui_templates.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = main.o game.o upgrades.o gui_templates.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	mkdir -p $(ODIR)
	$(CC) -c -o $@ $< $(CFLAGS)

release: $(OBJ)
	mkdir -p $(BDIR)
	mkdir -p $(ODIR)
	$(CC) -o $(BDIR)/cookieclicker $^ $(CFLAGS) $(LIBS)

windows: $(OBJ)
	mkdir -p $(BDIR)
	mkdir -p $(ODIR)
	$(CC) -o $(BDIR)/cookieclicker $^ $(CFLAGS) $(LIBS)
	ldd build/cookieclicker.exe | grep '\/mingw.*\.dll' -o | xargs -I{} cp "{}" build/

debug: $(OBJ)
	mkdir -p $(BDIR)
	mkdir -p $(ODIR)
	$(CC) -o $(BDIR)/cookieclicker $^ $(CFLAGS) $(LIBS)

install: $(OBJ)
	mkdir -p $(COOKIECLICKER_DIR)
	mkdir -p $(BDIR)
	mkdir -p $(ODIR)
	$(CC) -o $(BDIR)/cookieclicker $^ $(CFLAGS) $(LIBS)
	ln -sf $(BDIR)/cookieclicker /usr/bin/cookieclicker
	# cp assets/cookieclicker.desktop /usr/share/applications/
	# cp assets/app_icon/256.png /usr/share/pixmaps/cookieclicker.png

archlinux: $(OBJ) $(OBJ_GUI)
	mkdir -p $(BDIR)/usr/lib/cookieclicker
	mkdir -p $(BDIR)/usr/share/applications
	mkdir -p $(BDIR)/usr/share/pixmaps
	mkdir -p $(BDIR)/usr/bin/
	mkdir -p $(ODIR)
	$(CC) -o $(BDIR)/usr/bin/cookieclicker $^ $(CFLAGS) $(LIBS)
	# cp -r assets/ $(BDIR)/usr/lib/cookieclicker/
	# cp assets/cookieclicker.desktop $(BDIR)/usr/share/applications/
	# cp assets/app_icon/256.png $(BDIR)/usr/share/pixmaps/cookieclicker.png

.PHONY: clean
clean:
	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~

.PHONY: all
all: release clean
