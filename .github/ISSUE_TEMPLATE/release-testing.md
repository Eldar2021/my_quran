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
- [ ] Check `./keys/android_password.dart` && `./keys/android_upload_keystore`
- [ ] Uncomment signingConfigs (android/app/build.gradle)
- [ ] Enter password instead `keyPassword`, `storePassword`
- [ ] Increment versionCode (android/app/build.gradle defaultConfig)
- [ ] Cahnge versionName (android/app/build.gradle defaultConfig)
- [ ] Generate app bundle
  - `melos flutter-clean`
  - `melos pub-get`
  - `cd app && flutter build appbundle`
- [ ] Upload appbundle to Play Store
- [ ] Write release name
- [ ] Write release notes 
- [ ] Sen Review (After review we can publish to production)
- [ ] Enter `password` instead `keyPassword`, `storePassword` (android/app/build.gradle)
- [ ] Comment signingConfigs (android/app/build.gradle)
- [ ] Change `signingConfig signingConfigs.release` to `signingConfig signingConfigs.debug`
- [ ] After review "OpenTesting" Create Production release