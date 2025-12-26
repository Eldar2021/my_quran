---
name: Release Testing
about: Manual checklist for publishing a new release
title: "[Release] v<version>"
labels: "release"
assignees: ""
---

# Release Checklist: v<version>

## 1. Preparation

- [ ] Confirm all PRs are merged.
- [ ] Update version in `app/pubspec.yaml` and `CHANGELOG.md`.
- [ ] Ensure `ChuckerFlutter.showOnRelease = false`.
- [ ] Create, commit, and push release branch: `git checkout -b rl/v<version>`, `git commit -m "release: v<version>"`, `git push --set-upstream origin rl/v<version>`
- [ ] Create PR and verify all CI tests pass.

## 2. Testing

- [ ] Perform manual regression and monkey testing.
- [ ] Verify Firebase Remote Config `donationIsEnable` is `false`.

## 3. Tagging

- [ ] Create and push tag: `git tag -a v<version> -m "Release v<version>"` & `git push origin v<version>`

## 4. Android Deployment

- [ ] Verify Android keys (`android_password.dart`, `android_upload_keystore`).
- [ ] Set `android/app/build.gradle` to `release` mode.
- [ ] Build: `flutter clean && flutter pub get && cd app && flutter build appbundle`
- [ ] Upload to Play Store, add release notes, submit, and publish after approval.

## 5. iOS Deployment

- [ ] Build: `flutter clean && flutter pub get`
- [ ] In Xcode: Verify certificates, profiles, Bundle ID, and Team ID.
- [ ] "Product" -> "Archive", then "Distribute App" to "TestFlight & App Store".
- [ ] In App Store Connect: Create new version, add notes, select build, and submit.

## 6. Post-Release Cleanup

- [ ] Revert `android/app/build.gradle` back to `debug` and commit.
