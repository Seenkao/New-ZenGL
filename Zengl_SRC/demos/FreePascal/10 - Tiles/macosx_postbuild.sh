# copy resources
cp ../../../bin/data/ground.map ../../../bin/demo10.app/Contents/Resources/
cp ../../../bin/data/tiles.png ../../../bin/demo10.app/Contents/Resources/
cp ../../../bin/data/font* ../../../bin/demo10.app/Contents/Resources/
# make Info.plist and copy icon
cp -f demo10_macosx.plist ../../../bin/demo10.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo10.app/Contents/Resources/demo10.icns