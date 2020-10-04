# copy resources
cp ../../../bin/data/font* ../../../bin/demo03.app/Contents/Resources/
# copy binary into bundle
rm ../../../bin/demo03.app/Contents/MacOS/demo03
cp ../../../bin/demo03 ../../../bin/demo03.app/Contents/MacOS/demo03
# make Info.plist and copy icon
cp -f demo03_macosx.plist ../../../bin/demo03.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo03.app/Contents/Resources/demo03.icns