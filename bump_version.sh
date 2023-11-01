#!/bin/bash

current_version=$(grep "version: 5.0." pubspec.yaml | cut -f2 -d "+" )
new_vesion=$((current_version+1))

echo "Bump version... $current_version => $new_vesion"

sed -i -e "s/version: 5.0.$current_version+$current_version/version: 5.0.$new_vesion+$new_vesion/g" ./pubspec.yaml
sed -i -e "s/version: 5.0.$current_version+$current_version/version: 5.0.$new_vesion+$new_vesion/g" ./pubspec.foss.yaml



# pubspec.yaml
# pubspec.foss.yaml
# flatpak.yml
# com.invoiceninja.app.metainfo
# contants
# snapcraft