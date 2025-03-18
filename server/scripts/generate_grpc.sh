#!/bin/bash

# Exit on error
set -e

# Create the output directory if it doesn't exist
mkdir -p pkg/chat

# Generate Go code from proto files
protoc --go_out=. --go_opt=paths=source_relative \
    --go-grpc_out=. --go-grpc_opt=paths=source_relative \
    protos/chat.proto

# Format the generated code
go fmt ./... 