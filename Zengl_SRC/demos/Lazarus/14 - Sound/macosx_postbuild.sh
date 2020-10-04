# copy resources
cp ../../../bin/data/click.wav ../../../bin/demo14.app/Contents/Resources/
cp ../../../bin/data/music.ogg ../../../bin/demo14.app/Contents/Resources/
cp ../../../bin/data/audio-stop.png ../../../bin/demo14.app/Contents/Resources/
cp ../../../bin/data/audio-play.png ../../../bin/demo14.app/Contents/Resources/
cp ../../../bin/data/font* ../../../bin/demo14.app/Contents/Resources/
# copy binary into bundle
rm ../../../bin/demo14.app/Contents/MacOS/demo14
cp ../../../bin/demo14 ../../../bin/demo14.app/Contents/MacOS/demo14
# make Info.plist and copy icon
cp -f demo14_macosx.plist ../../../bin/demo14.app/Contents/Info.plist
cp ../../../bin/data/zengl.icns ../../../bin/demo14.app/Contents/Resources/demo14.icns