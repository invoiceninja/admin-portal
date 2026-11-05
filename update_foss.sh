#!/bin/bash

# Regenerates pubspec.foss.yaml and pubspec.foss.lock, which F-Droid builds with:
# its recipe copies them over pubspec.yaml and pubspec.lock, then runs
# `flutter pub get --enforce-lockfile`. bump_version.sh runs this on every release.
#
# Usage: ./update_foss.sh (or FLUTTER=/path/to/flutter ./update_foss.sh)

set -euo pipefail
cd "$(dirname "$0")"

FLUTTER=${FLUTTER:-flutter}
NON_FREE='google_sign_in|in_app_review|in_app_purchase|in_app_purchase_android|in_app_purchase_storekit|pinput'

# Pub pins the SDK packages (meta, test_api...) per Flutter version, so the lock
# must come from the version F-Droid builds with.
want=$(cat .flutter-version)
have=$("$FLUTTER" --version --machine | sed -n 's/.*"frameworkVersion": "\(.*\)".*/\1/p')
if [ "$have" != "$want" ]; then
    echo "Flutter is $have, need $want (see .flutter-version); set FLUTTER=/path/to/flutter"
    exit 1
fi

# pubspec.yaml minus the non-free packages and any comment directly above them
echo "Generating pubspec.foss.yaml"
{
    echo "# Generated from pubspec.yaml by update_foss.sh. Do not edit."
    awk -v re="^  ($NON_FREE):" '
        /^ *#/ { buf = buf $0 "\n"; next }
        $0 ~ re { buf = ""; next }
        { printf "%s", buf; buf = ""; print }
        END { printf "%s", buf }
    ' pubspec.yaml
} > pubspec.foss.yaml

# F-Droid's recipe still seds these names out of pubspec.yaml
if grep -nE "google_sign_in|in_app_review|in_app_purchase|pinput" pubspec.foss.yaml; then
    echo "pubspec.foss.yaml still names a non-free package"
    exit 1
fi

# Resolving from the store lock keeps every locked version and only drops the
# packages nothing uses any more. A temp dir, because pub get here would rewrite
# the tracked plugin registrants.
echo "Generating pubspec.foss.lock"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
cp pubspec.foss.yaml "$tmp/pubspec.yaml"
cp pubspec.lock "$tmp/pubspec.lock"
(cd "$tmp" && "$FLUTTER" pub get)
cp "$tmp/pubspec.lock" pubspec.foss.lock

# F-Droid should build the same versions the store build ships
pins() { awk '/^  [^ ].*:$/ { name = $1 } /^    version:/ { print name, $2 }' "$1" | sort; }
changed=$(comm -23 <(pins pubspec.foss.lock) <(pins pubspec.lock))
if [ -n "$changed" ]; then
    echo "pubspec.foss.lock has versions that aren't in pubspec.lock:"
    echo "$changed"
    exit 1
fi

echo "Done: $(pins pubspec.foss.lock | wc -l | tr -d ' ') packages, $(pins pubspec.lock | wc -l | tr -d ' ') in the store lock"
