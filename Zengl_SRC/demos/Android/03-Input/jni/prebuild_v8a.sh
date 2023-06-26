# clean
rm -r ../libs
# copy libraries
mkdir ../libs
mkdir ../libs/arm64-v8a/
cp ../../../../bin/Android/arm64-v8a/libjpeg_turbo.so ../libs/arm64-v8a/
cp ../../../../bin/Android/arm64-v8a/libopenal.so ../libs/arm64-v8a/
cp ../../../../bin/Android/arm64-v8a/libogg.so ../libs/arm64-v8a/
cp ../../../../bin/Android/arm64-v8a/libvorbis.so ../libs/arm64-v8a/
cp ../../../../bin/Android/arm64-v8a/libtheoradec.so ../libs/arm64-v8a/
cp ../../../../bin/Android/arm64-v8a/libzip.so ../libs/arm64-v8a/
#cp ../../../../bin/Android/arm64-v8a/libchipmunk.so ../libs/arm64-v8a/
# copy resources
mkdir ../assets/
cp ../../../../bin/data/font* ../assets
cp ../../../../bin/data/CalibriBold50pt* ../assets
cp ../../../../bin/data/arrow.png ../assets
cp ../../../../bin/data/Rus.txt ../assets
