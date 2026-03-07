#!/bin/bash
set -euxo pipefail

avdmanager list device || echo "error displaying emulator devices"

flutter test integration_test/app_test.dart
