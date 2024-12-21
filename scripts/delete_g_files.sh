#!/bin/bash

find . -type f -name "*.g.dart" -exec rm -v {} +

find . -type f -name "*.gen.dart" -exec rm -v {} +

echo "All .g.dart files have been deleted."
