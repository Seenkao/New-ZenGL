# copy resources
cp ../../../bin/data/font* ../../../bin/demo16.app/Contents/Resources/
# make Info.plist and copy icon
cp -f demo16_macosx.plist ../../../bin/demo16.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo16.app/Contents/Resources/demo16.icns