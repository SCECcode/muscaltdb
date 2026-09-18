#!/bin/bash

tmp=`uname -s`

if [ $tmp == 'Darwin' ]; then
##for macOS, make sure have automake/aclocal
  brew install automake
  brew reinstall gcc
  brew install libtool
  export PATH="/opt/homebrew/opt/libtool/libexec/gnubin:$PATH"
fi

## need to grab some python libs
python3 -m pip install scipy h5py numpy pandas pybind11 netCDF4


libtoolize
aclocal -I m4
autoconf
automake --add-missing --force-missing
./configure --prefix=$UCVM_INSTALL_PATH/model/muscaltdb --with-tiledb-include-path=$UCVM_INSTALL_PATH/lib/tiledb/include --with-tiledb-lib-path='$UCVM_INSTALL_PATH/lib/tiledb/lib64 -ltiledb -Wl,-rpath,$UCVM_INSTALL_PATH}/lib/tiledb/lib64'

make
make install

