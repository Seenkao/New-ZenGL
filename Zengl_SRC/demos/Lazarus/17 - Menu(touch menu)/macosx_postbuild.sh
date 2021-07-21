# copy resources
cp ../../../bin/data/font* ../../../bin/demo17.app/Contents/Resources/
cp ../../../bin/data/CalibriBold50pt* ../../../bin/demo17.app/Contents/Resources/
cp ../../../bin/data/arrow.png ../../../bin/demo17.app/Contents/Resources/
# copy binary into bundle
rm ../../../bin/demo17.app/Contents/MacOS/demo17
cp ../../../bin/demo17 ../../../bin/demo17.app/Contents/MacOS/demo17
# make Info.plist and copy icon
cp -f demo17_macosx.plist ../../../bin/demo17.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo17.app/Contents/Resources/demo17.icns
