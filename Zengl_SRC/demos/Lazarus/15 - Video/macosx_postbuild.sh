# copy resources
cp ../../../bin/data/font* ../../../bin/demo15.app/Contents/Resources/
cp ../../../bin/data/video.ogv ../../../bin/demo15.app/Contents/Resources/
# copy binary into bundle
rm ../../../bin/demo15.app/Contents/MacOS/demo15
cp ../../../bin/demo15 ../../../bin/demo15.app/Contents/MacOS/demo15
# make Info.plist and copy icon
cp -f demo15_macosx.plist ../../../bin/demo15.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo15.app/Contents/Resources/demo15.icns