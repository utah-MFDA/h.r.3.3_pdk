#/bin/sh

lib=./../../../MFlibrary/xyce_lib/MFlibrary/libMFlibrary.so

#echo $hardware

Xyce -plugin $lib $1
