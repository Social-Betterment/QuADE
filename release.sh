#!/bin/bash

./bump_version.sh patch
PUBSPEC_FILE="./pubspec.yaml"
current_version_full=$(yq e '.version' "$PUBSPEC_FILE")
flutter build web --base-href="/$current_version_full/" --release --wasm
export FOLDER=build/web
export TARGET_FOLDER=dist/web
VERSION=$(sed -n 's|.*"version":"\([^"]*\)".*|\1|p' "$FOLDER/version.json")
rm -rf "$TARGET_FOLDER"
mkdir "$TARGET_FOLDER"
mv "$FOLDER" "$TARGET_FOLDER/$VERSION"
mv "$TARGET_FOLDER/$VERSION/index.html" "$TARGET_FOLDER"
cp "$TARGET_FOLDER/$VERSION/version.json" "$TARGET_FOLDER"
cd "$TARGET_FOLDER"
cd ..
rm code.tar.gz
rm code.tar
tar -cf code.tar ./web
gzip -9 code.tar
cd ..
