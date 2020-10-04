# copy resources
cp ../../../bin/data/font* ../../../bin/demo15.app/Contents/Resources/
cp ../../../bin/data/video.ogv ../../../bin/demo15.app/Contents/Resources/
# make Info.plist and copy icon
cp -f demo15_macosx.plist ../../../bin/demo15.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo15.app/Contents/Resources/demo15.icns