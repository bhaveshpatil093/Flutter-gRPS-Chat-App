#!/bin/bash

# Exit on error
set -e

echo "Starting deployment process..."

# Clean the project
echo "Cleaning project..."
flutter clean

# Get dependencies
echo "Getting dependencies..."
flutter pub get

# Enable web support
echo "Enabling web support..."
flutter config --enable-web

# Generate gRPC code
echo "Generating gRPC code..."
chmod +x scripts/generate_grpc.sh
./scripts/generate_grpc.sh

# Create web icons directory if it doesn't exist
echo "Creating web icons directory..."
mkdir -p web/icons

# Copy default icons if they don't exist
if [ ! -f web/icons/Icon-192.png ]; then
  cp assets/icons/default-192.png web/icons/Icon-192.png
fi
if [ ! -f web/icons/Icon-512.png ]; then
  cp assets/icons/default-512.png web/icons/Icon-512.png
fi
if [ ! -f web/icons/Icon-maskable-192.png ]; then
  cp assets/icons/default-192.png web/icons/Icon-maskable-192.png
fi
if [ ! -f web/icons/Icon-maskable-512.png ]; then
  cp assets/icons/default-512.png web/icons/Icon-maskable-512.png
fi

# Build web
echo "Building web..."
flutter build web --release --web-renderer html --dart-define=FLUTTER_WEB_USE_SKIA=true

# Create build directory if it doesn't exist
mkdir -p build/web

# Copy build files
echo "Copying build files..."
cp -r build/web/* build/

echo "Deployment build complete!"
echo "Build files are located in the build directory" 