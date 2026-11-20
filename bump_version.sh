#!/bin/bash

current_version=$(grep "version: 5.0." pubspec.yaml | cut -f2 -d "+" )
new_version=$((current_version+1))

echo "Bump version... $current_version => $new_version"

sed -i '' -e "s/version: 5.0.$current_version+$current_version/version: 5.0.$new_version+$new_version/g" ./pubspec.yaml
sed -i '' -e "s/kClientVersion = '5.0.$current_version'/kClientVersion = '5.0.$new_version'/g" ./lib/constants.dart

rm lib/flutter_version.dart
echo "const FLUTTER_VERSION = const <String, String>" > lib/flutter_version.dart
flutter --version --machine >> lib/flutter_version.dart
echo ";" >> lib/flutter_version.dart
sed -i "y/\"/'/" lib/flutter_version.dart
dart format lib

./update_foss.sh || exit 1