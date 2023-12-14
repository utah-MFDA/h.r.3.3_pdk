#/bin/sh

lib=./../../../Elibrary/xyce_lib/Elibrary/libElibrary.so

#echo $hardware

Xyce -plugin $lib $1


