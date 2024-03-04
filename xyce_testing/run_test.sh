#/bin/sh

Xyce -plugin $1 $2 > $2.log
echo "Xyce -plugin $1 $2 > $2.log"
mv $2.log $3/logs/
mv $2.prn $3/results/