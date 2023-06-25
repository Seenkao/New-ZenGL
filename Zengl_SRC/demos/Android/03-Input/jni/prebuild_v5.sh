# clean
rm -r ../libs
# copy libraries
mkdir ../libs
mkdir ../libs/armeabi/
cp ../../../../bin/Android/armv5/libzenjpeg.so ../libs/armeabi/
cp ../../../../bin/Android/armv5/libopenal.so ../libs/armeabi/
cp ../../../../bin/Android/armv5/libogg.so ../libs/armeabi/
cp ../../../../bin/Android/armv5/libvorbis.so ../libs/armeabi/
cp ../../../../bin/Android/armv5/libtheoradec.so ../libs/armeabi/
cp ../../../../bin/Android/armv5/libchipmunk.so ../libs/armeabi/
# copy resources
mkdir ../assets/
cp ../../../../bin/data/font* ../assets
cp ../../../../bin/data/CalibriBold50pt* ../assets
cp ../../../../bin/data/arrow.png ../assets
cp ../../../../bin/data/Rus.txt ../assets
