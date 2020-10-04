# copy binary into bundle
rm ../../../bin/demo05.app/Contents/MacOS/demo05
cp ../../../bin/demo05 ../../../bin/demo05.app/Contents/MacOS/demo05
# make Info.plist and copy icon
cp -f demo05_macosx.plist ../../../bin/demo05.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo05.app/Contents/Resources/demo05.icns