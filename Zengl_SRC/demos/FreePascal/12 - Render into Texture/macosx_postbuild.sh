# copy resources
cp ../../../bin/data/tux_stand.png ../../../bin/demo12.app/Contents/Resources/
cp ../../../bin/data/font* ../../../bin/demo12.app/Contents/Resources/
# make Info.plist and copy icon
cp -f demo12_macosx.plist ../../../bin/demo12.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo12.app/Contents/Resources/demo12.icns