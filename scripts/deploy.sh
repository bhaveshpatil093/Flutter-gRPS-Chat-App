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

# Generate gRPC code
echo "Generating gRPC code..."
chmod +x scripts/generate_grpc.sh
./scripts/generate_grpc.sh

# Build web
echo "Building web..."
flutter build web --release --web-renderer html

# Create build directory if it doesn't exist
mkdir -p build/web

# Copy build files
echo "Copying build files..."
cp -r build/web/* build/

echo "Deployment build complete!"
echo "Build files are located in the build directory" 