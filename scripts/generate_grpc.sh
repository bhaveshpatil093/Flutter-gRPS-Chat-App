#!/bin/bash

# Create the output directory if it doesn't exist
mkdir -p lib/features/chat/data/generated

# Generate Dart code from proto files
protoc --dart_out=grpc:lib/features/chat/data/generated \
    -Iprotos \
    protos/chat.proto

# Format the generated code
dart format lib/features/chat/data/generated 