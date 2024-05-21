#Make sure you're under the jni directory
cd ./limbo-android-lib/src/main/jni

# Now download the source code for the external libraries and unzip them under the jni directory
#Note: if some of these file links don't download with wget use your browser to download them

##### Get QEMU
# download link:  http://download.qemu-project.org/qemu-x.x.x.tar.xz 
# Current versions supported by limbo: 5.1.0 and 2.9.1
# example for version 5.1.0:
wget http://download.qemu-project.org/qemu-5.1.0.tar.xz -P /tmp/
tar -xJf /tmp/qemu-5.1.0.tar.xz
mv qemu-5.1.0 qemu

##### GET glib
wget https://ftp.gnome.org/pub/GNOME/sources/glib/2.56/glib-2.56.1.tar.xz -P /tmp/
tar -xJf /tmp/glib-2.56.1.tar.xz
mv glib-2.56.1 glib

##### GET libffi
wget https://sourceware.org/pub/libffi/libffi-3.3.tar.gz -P /tmp/
tar -xzf /tmp/libffi-3.3.tar.gz
mv libffi-3.3 libffi

##### GET pixman
wget https://www.cairographics.org/releases/pixman-0.40.0.tar.gz -P /tmp/
tar -xzf /tmp/pixman-0.40.0.tar.gz
mv pixman-0.40.0 pixman

##### GET SDL2
wget https://www.libsdl.org/release/SDL2-2.0.8.tar.gz -P /tmp/
tar -xzf /tmp/SDL2-2.0.8.tar.gz
mv SDL2-2.0.8 SDL2
