#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# 1. Download and set up the Flutter SDK
git clone https://github.com/flutter/flutter.git --depth 1
export PATH="$PATH:`pwd`/flutter/bin"

# 2. Run flutter doctor to confirm setup
flutter doctor

# 3. Get dependencies for the Flutter project
flutter pub get

# 4. Run the build command to create the web app
flutter build web

echo "Build complete!"