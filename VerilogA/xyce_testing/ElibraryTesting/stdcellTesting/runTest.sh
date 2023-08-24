#/bin/bash
hardware=./../../Elibrary/xyce_lib/hardware/libXyce_Plugin_EPressurePump.so
stdcells=./../../Elibrary/xyce_lib/std_lib/libXyce_Plugin_Eserpentine_75px_0.so

outputFileLoc=./outputFiles

ouputLog=xyceOut.log

#rm -f $outputLog
#touch $outputLog

Xyce -plugin $hardware,$stdcells serp75_test.cir #> $outputLog
#Xyce -plugin $hardware,$stdcells serp100_test.cir
#Xyce -plugin $hardware,$stdcells serp200_test.cir

mkdir -p $outputFileLoc
mv *.prn $outputFileLoc

