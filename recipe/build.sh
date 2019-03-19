#!/bin/bash

export CFLAGS="$CFLAGS $(gsl-config --cflags)"
export LDFLAGS="$LDFLAGS $(gsl-config --libs)"

# For whatever reason, it can't link to gsl correctly without this on OS X.
export DYLD_FALLBACK_LIBRARY_PATH=$PREFIX/lib

if [[ $target_platform =~ linux.* ]] || [[ $target_platform == win-32 ]] || [[ $target_platform == win-64 ]] || [[ $target_platform == osx-64 ]]; then
  export DISABLE_AUTOBREW=1
  $R CMD INSTALL --build . || (cat config.log && exit 1)
else
  mkdir -p $PREFIX/lib/R/library/gsl
  mv * $PREFIX/lib/R/library/gsl
fi
