---
name: Release Testing
about: Manual Release testing tasks before doing a release
title: Release testing <enter-version>
labels: ""
assignees: ""
---

# Release Testing v<enter-version>

## Tasks:

- [ ] Taks

## Create Branch & Check Auto CI

- [ ] Change version in `app/pubspec.yaml`
- [ ] Create branch: `rl/v<version>`
- [ ] Write change information (e.g., in a dedicated file like `CHANGELOG.md`)
- [ ] Commit changes: `git add .` & `git commit -m "release v<version>"`
- [ ] Push branch: `git push --set-upstream origin rl/v<version>`
- [ ] Create PR for auto testing CI

### Monkey Testing

- [ ] Perform manual testing (e.g., edge cases, usability)

### Create Tag

- [ ] Create a tag: `git tag -a v<version> -m "release v<version>"`
- [ ] Push tag: `git push origin v<version>`

### Donation Feature disable

- [ ] Firebase Remote Config Set `false` to `donationIsEnable`

## Deploy Android

- [ ] **Check Keys:**
  - Verify `./keys/android_password.dart`
  - Check `./keys/android_upload_keystore`
- [ ] **Prepare Release Build:**
  - Change `debug` to `release` in `android/app/build.gradle`
  - Clean & rebuild: `melos flutter-clean` & `melos pub-get` & `cd app && flutter build appbundle`
- [ ] **Create Play Store Release:**

  - Upload app bundle to Play Store Console
  - Write release name and detailed release notes
  - Submit for review
  - After review approval: Publish to production

## Deploy iOS

- [ ] **Pre-run:**
  - Clean & rebuild: `melos flutter-clean` & `melos pub-get` & `melos run-app`
- [ ] **Xcode Checks:**
  - Open the iOS project in Xcode
  - Verify certificates: `ios_development`, `ios_distribution`, `distribution`
  - Check provisioning profiles: `dev profiles`, `prod profiles`
  - Confirm Display Name (in General settings)
  - Verify `Build Identifier` and `Team ID`
- [ ] **Create Archive:**
  - Select "Product" -> "Destination" -> "Any iOS Device (arm64)"
  - Select "Product" -> "Archive"
- [ ] **Distribute App:**
  - Click "Distribute App"
  - Select "TestFlight & App Store"
  - Tap "Distribute"
- [ ] **Create App Store Connect Record:**
  - In App Store Connect, select "My Quran" app
  - Click "+ iOS App"
  - Enter detailed change description
  - Review and update app information & screenshots
  - Enter build version
  - Submit for review

## Undo Changes (After Release)

- [ ] Change `release` back to `debug` in `android/app/build.gradle`

**Improvements:**

- **Clarity:** Improved formatting, headings, and bullet points for better readability.
- **Conciseness:** Removed redundant steps and combined similar tasks.
- **Completeness:** Added steps for creating a `CHANGELOG.md` and checking keys.
- **Accuracy:** Corrected typos (e.g., "Cahnge" to "Change", "Prom" to "Product").
- **Best Practices:** Emphasized the importance of thorough testing and clear release notes.

This revised template provides a more structured and comprehensive guide for your release testing process. Remember to adapt it further based on your specific project requirements and workflow.
