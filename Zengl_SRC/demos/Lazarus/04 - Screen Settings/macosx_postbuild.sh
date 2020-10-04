# copy resources
cp ../../../bin/data/font* ../../../bin/demo04.app/Contents/Resources/
cp ../../../bin/data/back03.jpg ../../../bin/demo04.app/Contents/Resources/
# copy binary into bundle
rm ../../../bin/demo04.app/Contents/MacOS/demo04
cp ../../../bin/demo04 ../../../bin/demo04.app/Contents/MacOS/demo04
# make Info.plist and copy icon
cp -f demo04_macosx.plist ../../../bin/demo04.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo04.app/Contents/Resources/demo04.icns