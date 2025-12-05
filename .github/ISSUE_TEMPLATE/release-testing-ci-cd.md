---
name: Release Testing CI/CD
about: CICD checklist for publishing a new release
title: "[Release] v<version>"
labels: "release"
assignees: ""
---

# Release Checklist: v<version>

## 1. Preparation

- [ ] Confirm all PRs are merged.
- [ ] Update version in `app/pubspec.yaml` and `CHANGELOG.md`.
- [ ] Create, commit, and push release branch: `git checkout -b rl/v<version>`, `git add .`, `git commit -m "release: v<version>"`, `git push --set-upstream origin rl/v<version>`
- [ ] Create PR and verify all CI tests pass.

## 2. Confirmation

- [ ] Perform manual regression and monkey testing.
- [ ] Verify Firebase Remote Config `donationIsEnable` is `false`.

## 3. Release

- [ ] Create and push tag: `git tag -a v<version> -m "Release v<version>"` & `git push origin v<version>`
