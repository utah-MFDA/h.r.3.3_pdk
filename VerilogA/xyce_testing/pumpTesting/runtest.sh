#/bin/sh

hardware=./../../Elibrary/xyce_lib/hardware/libXyce_Plugin_EPressurePump.so

#echo $hardware

Xyce -plugin $hardware pressurePumpTest.cir
