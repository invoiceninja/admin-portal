#!/bin/bash

echo "Bump version..."

current_version=$(grep "version: 5.0." pubspec.yaml | cut -f2 -d "+" )
echo "Current Version: $current_version"

new_vesion=$((current_version+1))
echo "New Version: $new_vesion"

# pubspec.foss.yaml
# pubspec.yaml
# flatpak.yml
# com.invoiceninja.app.metainfo
# contants
# snapcraft