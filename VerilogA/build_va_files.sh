# copy files to lib
mkdir -p ./lib
cp *.va ./lib

# run va files
#cd ./lib && buildxyceplugin.sh chan *.va ./ && rm -rf *.va
buildxyceplugin.sh *.va ./lib && rm ./lib/*.va

mkdir -p ./lib/headers
mv ./lib/*.H ./lib/headers
mv ./lib/*.h ./lib/headers

mkdir -p ./lib/cpp
mv ./lib/*.C ./lib/cpp

