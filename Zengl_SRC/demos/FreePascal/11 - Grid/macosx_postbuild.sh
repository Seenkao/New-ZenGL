# copy resources
cp ../../../bin/data/back04.jpg ../../../bin/demo11.app/Contents/Resources/
cp ../../../bin/data/font* ../../../bin/demo11.app/Contents/Resources/
# copy binary into bundle
rm ../../../bin/demo11.app/Contents/MacOS/demo11
cp ../../../bin/demo11 ../../../bin/demo11.app/Contents/MacOS/demo11
# make Info.plist and copy icon
cp -f demo11_macosx.plist ../../../bin/demo11.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo11.app/Contents/Resources/demo11.icns