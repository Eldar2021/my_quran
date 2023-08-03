---
name: Release Testing
about: Manual Release testing tasks before doing a release
title: Release testing <enter-version>
labels: ''
assignees: ''

---

Tested on commit <enter-commit>

# Release Testing v<enter-version>
- [ ] Check Integration tes(CI)
- [ ] Check unit test
- [ ] Check code analyze
- [ ] Testting manual
- [ ] Change app version `pubspec.yaml`
- [ ] Create a tag 
  - `git tag -a v<version> -m "description"`
  - `git push origin v<version>`
- [ ] Write change information
 
## Deploy Android 
Testing (Open Testing)
- [ ] Check keys
  - `./keys/android_password.dart`
  - `./keys/android_upload_keystore`
- [ ] To prepare new version appbundle
  - Uncomment signingConfigs (android/app/build.gradle)
  - Enter password instead `keyPassword`, `storePassword`
  - Increment versionCode (android/app/build.gradle defaultConfig)
  - Cahnge versionName (android/app/build.gradle defaultConfig)
  - Cahnge `degug` -> `release` (android/app/build.gradle buildTypes)
- [ ] Generate app bundle
  - `melos flutter-clean`
  - `melos pub-get`
  - `cd app && flutter build appbundle`
- [ ] Create new release Play Store
  - Upload appbundle to Play Store
  - Write release name
  - Write release notes 
  - Sen Review (After review we can publish to production)
- [ ] Undo the changes 
  - Enter `password` instead `keyPassword`, `storePassword` (android/app/build.gradle)
  - Comment signingConfigs (android/app/build.gradle)
  - Change `signingConfig signingConfigs.release` to `signingConfig signingConfigs.debug`
- [ ] After review "OpenTesting" Create Production release
  
## Deploy IOS
Open project ios folder in Xcode
- [ ] Increment Version & Build (General)
- [ ] Check certificates "ios_development & ios_distirbution & distirbution"
- [ ] Check profiles "dev profiles & prod profiles"
- [ ] Check Display name (General)
- [ ] Ceck "Build identifier" & "Team id"
- [ ] Create Archive
  -  Click Prom top menu "Product/Destination/any IOS device (arm64)"
  -  Click Prom top menu "Product/Archive"
- [ ] Upload to Test flight
  - Click "Distirbute App" button
  - Check "App Store Connect" -> "Next"
  - Check "Upload" -> "Next"
  - Check "Strip Swift symbols & Upload your app's symbols & Manage Version app Build Number" -> "Next"
  - Check app information and click "Upload"
- [ ] Create new version form apple connect
  - Choose `My Quran` app cleck `+ios app`
  - Enter change description
  - Check app information & screenshots
  - Enter build version
  - Send to review
