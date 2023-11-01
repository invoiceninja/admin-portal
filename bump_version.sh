#!/bin/bash

current_version=$(grep "version: 5.0." pubspec.yaml | cut -f2 -d "+" )
new_vesion=$((current_version+1))
date_today=$(date +%F)

echo "Bump version... $current_version => $new_vesion"

sed -i -e "s/version: 5.0.$current_version+$current_version/version: 5.0.$new_vesion+$new_vesion/g" ./pubspec.yaml
sed -i -e "s/version: 5.0.$current_version+$current_version/version: 5.0.$new_vesion+$new_vesion/g" ./pubspec.foss.yaml
sed -i -e "s/v5.0.$current_version/v5.0.$new_vesion/g" ./.github/workflows/flatpak.yml
sed -i -e 's/<releases>/<releases>\n    <release version="5.0.'$new_vesion'" date="'$date_today'"\/>/g' ./flatpak/com.invoiceninja.InvoiceNinja.metainfo.xml
sed -i -e "s/kClientVersion = '5.0.$current_version'/kClientVersion = '5.0.$new_vesion'/g" ./lib/constants.dart
sed -i -e "s/version: '5.0.$current_version'/version: '5.0.$new_vesion'/g" ./snap/snapcraft.yaml