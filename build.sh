# Needed packages
sudo apt-get update
sudo apt-get install make autoconf automake git python3 binutils gtk-doc-tools
sudo apt-get install libtool-bin pkg-config flex bison gettext texinfo rsync
sudo apt-get install -y wget unzip libncurses5

#Make sure you're under the jni directory
cd ./limbo-android-lib/src/main/jni

# Now download the source code for the external libraries and unzip them under the jni directory
#Note: if some of these file links don't download with wget use your browser to download them

##### Get QEMU
# download link:  http://download.qemu-project.org/qemu-x.x.x.tar.xz 
# Current versions supported by limbo: 5.1.0 and 2.9.1
# example for version 5.1.0:
wget https://download.qemu.org/qemu-5.1.0.tar.xz -P /tmp/
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

### Apply patch for QEMU:
# example for 5.1.0:
cd ./qemu/
patch -p1 < ../patches/qemu-5.1.0.patch

### Apply glib patch for Limbo:
cd ../glib/
patch -p1 < ../patches/glib-2.56.1.patch

### Apply SDL2 patch for Limbo:
cd ../SDL2/
patch -p1 < ../patches/sdl2-2.0.8.patch

cd ..

set -e

# Set up environment variables
export ANDROID_SDK_ROOT="$GITHUB_WORKSPACE/android-sdk"
export NDK_ROOT="$GITHUB_WORKSPACE/android-ndk-r23b"
export BUILD_HOST="arm64-v8a"
export BUILD_GUEST="x86_64-softmmu"

# Download and set up Android SDK
wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -O cmdline-tools.zip
mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools"
unzip -q cmdline-tools.zip -d "$ANDROID_SDK_ROOT/cmdline-tools"
mv "$ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools" "$ANDROID_SDK_ROOT/cmdline-tools/latest"
yes | "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager" --licenses
"$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager" "platform-tools" "platforms;android-30" "build-tools;30.0.3"

# Download and set up Android NDK
wget https://dl.google.com/android/repository/android-ndk-r23b-linux.zip -O android-ndk-r23b.zip
unzip -q android-ndk-r23b.zip -d "$GITHUB_WORKSPACE"

# Build native libraries
export PATH="$NDK_ROOT:$PATH"
make limbo

# Set up Gradle
wget https://services.gradle.org/distributions/gradle-7.4.2-bin.zip
unzip -q gradle-7.4.2-bin.zip -d "$GITHUB_WORKSPACE"
export PATH="$GITHUB_WORKSPACE/gradle-7.4.2/bin:$PATH"

# Build APK
cd "$GITHUB_WORKSPACE"
gradle wrapper
./gradlew assembleRelease

pwd
ls

cd limbo-android-lib
cd build
cd outputs
cd apk
cd release

pwd
ls
