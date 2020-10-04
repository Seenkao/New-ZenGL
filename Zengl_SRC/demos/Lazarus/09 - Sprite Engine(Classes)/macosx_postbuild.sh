# copy resources
cp ../../../bin/data/zengl.png ../../../bin/demo09.app/Contents/Resources/
cp ../../../bin/data/miku.png ../../../bin/demo09.app/Contents/Resources/
cp ../../../bin/data/font* ../../../bin/demo09.app/Contents/Resources/
# copy binary into bundle
rm ../../../bin/demo09.app/Contents/MacOS/demo09
cp ../../../bin/demo09 ../../../bin/demo09.app/Contents/MacOS/demo09
# make Info.plist and copy icon
cp -f demo09_macosx.plist ../../../bin/demo09.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo09.app/Contents/Resources/demo09.icns