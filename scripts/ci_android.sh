#!/bin/bash
set -euxo pipefail

avdmanager list device || echo "error displaying emulator devices"

flutter drive --target=test_driver/app.dart
