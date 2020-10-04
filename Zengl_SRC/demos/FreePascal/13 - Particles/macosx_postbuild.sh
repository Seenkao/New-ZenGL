# copy resources
cp ../../../bin/data/back02.png ../../../bin/demo13.app/Contents/Resources/
cp ../../../bin/data/font* ../../../bin/demo13.app/Contents/Resources/
cp ../../../bin/data/emitter_* ../../../bin/demo13.app/Contents/Resources/
cp ../../../bin/data/particle.png ../../../bin/demo13.app/Contents/Resources/
# make Info.plist and copy icon
cp -f demo13_macosx.plist ../../../bin/demo13.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo13.app/Contents/Resources/demo13.icns