# Define include headers to install in $(prefix)/include
include_HEADERS = muscaltdb.h

# Define executable binaries to install in $(prefix)/bin
bin_PROGRAMS = muscaltdb_query

# Define shared/static libraries to install in $(prefix)/lib
lib_LTLIBRARIES = libmuscaltdb.la

# ------------------------------------------------------------------------------
# Library Definition
# ------------------------------------------------------------------------------

# Sources for the shared/static library
libmuscaltdb_la_SOURCES = \
	muscaltdb.c \
	muscaltdb_dataset.c \
	muscaltdb_util.c \
	cJSON.c \
	kdtree_util.c

# Include path and flags for compiling the library
libmuscaltdb_la_CPPFLAGS = -I$(top_srcdir) -I$(prefix)/include -DDYNAMIC_LIBRARY

# Linker flags and libraries for libmuscaltdb
libmuscaltdb_la_LDFLAGS = -version-info 1:0:0 -L$(prefix)/lib
libmuscaltdb_la_LIBADD = -lm $(LIBS)

# ------------------------------------------------------------------------------
# Executables Definitions
# ------------------------------------------------------------------------------

AM_CPPFLAGS = -I$(top_srcdir) -I$(prefix)/include
AM_LDFLAGS = -L$(prefix)/lib

# muscaltdb_query links against our Libtool library
muscaltdb_query_SOURCES = muscaltdb_query.c
muscaltdb_query_LDADD = libmuscaltdb.la -lm $(LIBS)

# ------------------------------------------------------------------------------
# macOS .so compatibility symlink
# ------------------------------------------------------------------------------
install-exec-hook:
	@if test "`uname -s`" = "Darwin"; then \
		cd $(DESTDIR)$(libdir) && \
		rm -f libmuscaltdb.so && \
		ln -s libmuscaltdb.dylib libmuscaltdb.so; \
	fi
