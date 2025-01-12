---
name: Release Testing
about: Manual Release testing tasks before doing a release
title: Release testing <enter-version>
labels: ""
assignees: ""
---

# Tested v<version>

## Tasks:

- [ ]

## Create branch & Check auto CI

- [ ] `rl/v<version>`
- [ ] Change version in `app/pubspec.yaml`
- [ ] Write change information
- [ ] Run `git add .`
- [ ] Run `git commit -m "release v<version>"`
- [ ] Run `git push --set-upstream origin rl/v<version>`
- [ ] Create PR for auto testing CI

### Monkey test

- [ ] Test manualy

### Create tag v<enter-version>

- [ ] Create a tag
  - `git tag -a v<version> -m "release v<version>"`
  - `git push origin v<version>`

## Deploy Android

- [ ] Check keys
  - `./keys/android_password.dart`
  - `./keys/android_upload_keystore`
- [ ] To prepare new version appbundle
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
  - Change `release` to `debug`
- [ ] After review "OpenTesting" Create Production release

## Deploy IOS

- [ ] Prerun on IOS (build on IOS)
  - `melos flutter-clean`
  - `melos pub-get`
  - `melos run-app`
- [ ] Open project ios folder in Xcode
- [ ] Check certificates "ios_development & ios_distirbution & distirbution"
- [ ] Check profiles "dev profiles & prod profiles"
- [ ] Check Display name (General)
- [ ] Ceck "Build identifier" & "Team id"
- [ ] Create Archive
  - Click Prom top menu "Product/Destination/any IOS device (arm64)"
  - Click Prom top menu "Product/Archive"
- [ ] Distirbute App
  - Click `Distirbute App` button
- [ ] Uploade
  - Select `TestFlight & App Store`
  - tap `Distirbute`
- [ ] Create new version form apple connect
  - Choose `My Quran` app cleck `+ios app`
  - Enter change description
  - Check app information & screenshots
  - Enter build version
  - Send to review
