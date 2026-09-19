dnl -*- Autoconf -*-
dnl Process this file with autoconf to produce a configure script.

AC_PREREQ(2.59)
AC_INIT(MUSCALTDBTDB, 1.1.0, software@scec.org)
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([foreign tar-pax no-exeext])

dnl
dnl Dependencies
dnl

dnl
dnl Command line tools
dnl

AC_PROG_CC
AC_PROG_CXX
AC_PROG_INSTALL
AC_PROG_MKDIR_P
AC_PROG_LN_S

dnl --- begin: add libtool and --enable-shared handling ---
# initialize libtool (provides LT_INIT and shared/static helpers)
# If libtool is not available, autoreconf will tell you.
LT_INIT

# standard --enable-shared/--disable-shared option
AC_ARG_ENABLE([shared],
  [AS_HELP_STRING([--enable-shared|--disable-shared],
    [build shared libraries (default: enabled)])],
  [case "${enableval}" in
     yes) enable_shared=yes ;;
     no) enable_shared=no ;;
     *) enable_shared=${enableval} ;;
   esac],
  [enable_shared=yes])


## for conversion code in tools directory 
dnl tiledb
AC_ARG_ENABLE([tiledb],
    [AC_HELP_STRING([--enable-tiledb],
        [install TileDB library @<:@default=yes@:>@])],
        [if test "$enableval" = yes ; then install_tiledb=yes; else install_tiledb=no; fi],
        [install_tiledb=yes])
AM_CONDITIONAL([INSTALL_TILEDB], [test "$install_tiledb" = yes])
AC_ARG_WITH([tiledb-incdir],
  [AS_HELP_STRING([--with-tiledb-incdir], [directory containing TILEDB header files])],
  [with_tiledb_incdir="$withval"],
  [with_tiledb_incdir=no])
AC_SUBST(with_tiledb_incdir)
AC_ARG_WITH([tiledb-libdir],
  [AS_HELP_STRING([--with-tiledb-libdir], [directory containing TILEDB library])],
  [with_tiledb_libdir="$withval"],
  [with_tiledb_libdir=no])
AC_SUBST(with_tiledb_libdir)


# export the variable for Makefile.in / Automake
AC_SUBST([enable_shared])
dnl --- end ---

dnl TAR
AC_PATH_PROG(TAR, tar)
if test -z "$TAR" ; then
  AC_MSG_FAILURE([cannot find 'tar' program.])
  TAR=`echo "Error: tar is not installed." ; false`
fi

dnl
dnl Setup environment so dependencies are used in build
dnl

dnl TILEDB (required)
if test "$install_tiledb" = yes ; then
  TILEDB_INCLUDES=""
  TILEDB_LDFLAGS="-ltiledb"
else
  SCEC_TILEDB_HEADER
  SCEC_TILEDB_LIB
fi
if test "$with_tiledb_incdir" != no ; then
  TILEDB_INCLUDES="-I$with_tiledb_incdir"
fi
if test "$with_tiledb_libdir" != no ; then
  TILEDB_LDFLAGS="-L$with_tiledb_libdir -ltiledb"
fi

CFLAGS="$CFLAGS"
CPPFLAGS="-I$prefix/include $TILEDB_INCLUDES $CPPFLAGS"
LDFLAGS="-L$prefix/lib -L$prefix/lib64 $TILEDB_LDFLAGS $LDFLAGS"

dnl
dnl Verify configuration
dnl

##check optional large data path
##MUSCALTDB_LARGEDATA_DIR=$CVM_LARGEDATA_DIR/model/muscaltdb
if test x"$CVM_LARGEDATA_DIR" != x; then
   # test directory existence
   MUSCALTDB_LARGEDATA_DIR=$CVM_LARGEDATA_DIR/model/muscaltdb
# In docker container building.. this is not accessible  yet ???
   if test x"$CVM_IN_DOCKER" != x; then
     AM_CONDITIONAL([WITH_MUSCALTDB_LARGEDATA_DIR], true)
     AC_SUBST(MUSCALTDB_LARGEDATA_DIR)
   else 
     AC_CHECK_FILE([$MUSCALTDB_LARGEDATA_DIR/model_MUSCAL_CANVAS_dll0.01_vardz_float32_cmpd.tiledb],
                [AM_CONDITIONAL([WITH_MUSCALTDB_LARGEDATA_DIR], true) AC_SUBST(MUSCALTDB_LARGEDATA_DIR)],
                [AM_CONDITIONAL([WITH_MUSCALTDB_LARGEDATA_DIR], false)])
   fi
else
   AM_CONDITIONAL(WITH_MUSCALTDB_LARGEDATA_DIR, false)
fi

AC_SUBST(CFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(LDFLAGS)

AC_CONFIG_FILES([
  Makefile
  src/Makefile
  data/Makefile
  test/Makefile
  tools/Makefile
  ])

AC_OUTPUT

AM_CONDITIONAL([BUILD_SHARED_LIBRARY], [test "$enable_shared" = yes])
if test "$enable_shared" = yes; then
  AC_MSG_NOTICE([Building shared libraries. Shared libraries enabled.])
else
  AC_MSG_WARN([Building static libraries. Shared libraries are not enabled.])
fi


dnl End of file
