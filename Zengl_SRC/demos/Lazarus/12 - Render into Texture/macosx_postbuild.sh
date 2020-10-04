# copy resources
cp ../../../bin/data/tux_stand.png ../../../bin/demo12.app/Contents/Resources/
cp ../../../bin/data/font* ../../../bin/demo12.app/Contents/Resources/
# copy binary into bundle
rm ../../../bin/demo12.app/Contents/MacOS/demo12
cp ../../../bin/demo12 ../../../bin/demo12.app/Contents/MacOS/demo12
# make Info.plist and copy icon
cp -f demo12_macosx.plist ../../../bin/demo12.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo12.app/Contents/Resources/demo12.icns