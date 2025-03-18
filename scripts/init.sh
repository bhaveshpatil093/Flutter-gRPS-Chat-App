#!/bin/bash

# Exit on error
set -e

echo "Initializing Flutter gRPC Chat project..."

# Create necessary directories
echo "Creating project structure..."
mkdir -p lib/{core/{constants,theme,utils,widgets},features/{auth,chat}/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{bloc,pages,widgets}}}

# Create necessary files
echo "Creating necessary files..."
touch lib/core/constants/app_constants.dart
touch lib/core/theme/app_theme.dart
touch lib/core/utils/logger.dart
touch lib/core/widgets/loading_indicator.dart
touch lib/features/auth/data/models/user_model.dart
touch lib/features/auth/domain/entities/user.dart
touch lib/features/auth/domain/repositories/auth_repository.dart
touch lib/features/auth/presentation/bloc/auth_bloc.dart
touch lib/features/auth/presentation/pages/login_page.dart
touch lib/features/auth/presentation/pages/signup_page.dart
touch lib/features/chat/data/models/message_model.dart
touch lib/features/chat/domain/entities/message.dart
touch lib/features/chat/domain/repositories/chat_repository.dart
touch lib/features/chat/presentation/bloc/chat_bloc.dart
touch lib/features/chat/presentation/pages/chat_page.dart
touch lib/features/chat/presentation/widgets/message_bubble.dart

# Create assets directories
echo "Creating assets directories..."
mkdir -p assets/{images,icons}

# Install dependencies
echo "Installing dependencies..."
flutter pub get

# Generate gRPC code
echo "Generating gRPC code..."
chmod +x scripts/generate_grpc.sh
./scripts/generate_grpc.sh

echo "Project initialization complete!"
echo "Next steps:"
echo "1. Configure AWS services using the commands in README.md"
echo "2. Update amplifyconfiguration.json with your AWS resources"
echo "3. Set up the gRPC server"
echo "4. Run the application using 'flutter run'" 