# copy resources
cp ../../../bin/data/font* ../../../bin/demo02.app/Contents/Resources/
cp ../../../bin/data/zengl.png ../../../bin/demo02.app/Contents/Resources/
cp ../../../bin/data/click.wav ../../../bin/demo02.app/Contents/Resources/
cp ../../../bin/data/back01.jpg ../../../bin/demo02.app/Contents/Resources/
cp ../../../bin/data/music.ogg ../../../bin/demo02.app/Contents/Resources/
cp ../../../bin/data/zengl.zip ../../../bin/demo02.app/Contents/Resources/
# copy binary into bundle
rm ../../../bin/demo02.app/Contents/MacOS/demo02
cp ../../../bin/demo02 ../../../bin/demo02.app/Contents/MacOS/demo02
# make Info.plist and copy icon
cp -f demo02_macosx.plist ../../../bin/demo02.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo02.app/Contents/Resources/demo02.icns