#/bin/tcsh

mkdir ./testFiles/smart_toilet_test2/smart_toilet2_soln1
hspice ./testFiles/smart_toilet_test2/smart_toilet2_soln1.sp -o ./testFiles/smart_toilet_test2/smart_toilet2_soln1/smart_toilet2_soln1_o

mkdir ./testFiles/smart_toilet_test2/smart_toilet2_soln2
hspice ./testFiles/smart_toilet_test2/smart_toilet2_soln2.sp -o ./testFiles/smart_toilet_test2/smart_toilet2_soln2/smart_toilet2_soln2_o

mkdir ./testFiles/smart_toilet_test2/smart_toilet2_soln3
hspice ./testFiles/smart_toilet_test2/smart_toilet2_soln3.sp -o ./testFiles/smart_toilet_test2/smart_toilet2_soln3/smart_toilet2_soln3_o

