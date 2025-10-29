#!/bin/bash

current_version=$(grep "version: 5.0." pubspec.yaml | cut -f2 -d "+" )
new_version=$((current_version+1))
date_today=$(date +%F)

echo "Bump version... $current_version => $new_version"

sed -i -e "s/version: 5.0.$current_version+$current_version/version: 5.0.$new_version+$new_version/g" ./pubspec.yaml
sed -i -e "s/version: 5.0.$current_version+$current_version/version: 5.0.$new_version+$new_version/g" ./pubspec.foss.yaml
sed -i -e "s/v5.0.$current_version/v5.0.$new_version/g" ./.github/workflows/flatpak.yml
sed -i -e 's/<releases>/<releases>\n    <release version="5.0.'$new_version'" date="'$date_today'"\/>/g' ./flatpak/com.invoiceninja.InvoiceNinja.metainfo.xml
sed -i -e "s/kClientVersion = '5.0.$current_version'/kClientVersion = '5.0.$new_version'/g" ./lib/constants.dart
sed -i -e "s/version: '5.0.$current_version'/version: '5.0.$new_version'/g" ./snap/snapcraft.yaml

rm lib/flutter_version.dart
echo "const FLUTTER_VERSION = const <String, String>" > lib/flutter_version.dart
flutter --version --machine >> lib/flutter_version.dart
echo ";" >> lib/flutter_version.dart
sed -i "y/\"/'/" lib/flutter_version.dart
dart format lib