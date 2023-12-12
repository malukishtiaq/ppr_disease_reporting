keystore is in android>keyapk folder

password is 8 times a... aaaaaaaa
PPRReporting


git push origin HEAD

to remove a folder from git
git rm -r --cached .dart_tool   

keytool -list -v -keystore ~/Meetbok.keystore -alias Meetbok -storepass aaaaaaaa -keypass aaaaaaaa 

This file has some imp commands as backup.


for android
export PATH="$PATH:/Users/ishtiaqahmed/Documents/development/flutter/bin" && cd android && ./gradlew clean && cd .. && flutter clean && flutter pub get && flutter run -d "sdk gphone64 arm64"

for setting PATH
export PATH="$PATH:/Users/ishtiaqahmed/Documents/development/flutter/bin"

for flutter pod delete and rebuild
rm ~/Pods && rm Podfile.lock && rm ~/.pub-cache/hosted/pub.dartlang.org/ && cd .. && rm pubspec.lock && 
export PATH="$PATH:/Users/ishtiaqahmed/Documents/development/flutter/bin" && flutter clean && flutter pub get && cd ios && pod deintegrate && pod repo update && pod install && flutter run


export PATH="$PATH:/Users/ishtiaqahmed/Documents/development/flutter/bin" && flutter clean && flutter pub get && cd ios && pod deintegrate && pod install

flutter build apk --release

for android release
flutter build appbundle

flutter build apk
cd android && ./gradlew clean

In the Finder, you can open your home folder by choosing Go > Home or by pressing Shift-Command-H.

CocoaPods issue. Go to: /ios/Pods/Target Support Files/Pods/Pods-AppName-frameworks.sh
Replace in *-frameworks.sh files:
source="$(readlink "${source}")" >>> source="$(readlink -f "${source}")"
https://stackoverflow.com/questions/63533819/rsync-error-some-files-could-not-be-transferred-code-23-command-phasescriptex

flutter build appbundle --target-platform android-arm --analyze-size

filter to hide extra logging in debug console.
!D/EGL