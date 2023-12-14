#/bin/sh

lib=./../../../Elibrary/xyce_lib/Elibrary/libElibrary.so

#echo $hardware

Xyce -plugin $lib pressurePumpTest.cir
Xyce -plugin $lib pressurePumpTest2.cir
Xyce -plugin $lib pressurePumpTest3.cir
