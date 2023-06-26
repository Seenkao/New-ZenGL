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
