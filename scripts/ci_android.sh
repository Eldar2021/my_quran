#!/bin/bash
set -euxo pipefail

avdmanager list device || echo "error displaying emulator devices"
cd app
flutter test integration_test/app_test.dart
