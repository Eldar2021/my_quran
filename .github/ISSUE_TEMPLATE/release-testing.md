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
- [ ] Generate app bundle
  - `flutter build appbundle`
- [ ] Upload appbundle to Play Store 