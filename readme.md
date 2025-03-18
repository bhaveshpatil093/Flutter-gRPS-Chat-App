# Flutter gRPC Chat

A secure, low-latency chat application built with Flutter and gRPC.

## Features

- Real-time messaging using gRPC
- Secure authentication with AWS Cognito
- Media file support (images, videos, and other files)
- Message history and retrieval
- Modern UI with Material Design 3
- Clean architecture with BLoC pattern
- Proper error handling and state management
- Efficient data storage using Parquet format
- Secure file storage using AWS S3
- User metadata storage using DynamoDB

## Prerequisites

1. **Development Environment**
   - Flutter SDK (>=3.0.0)
   - Android Studio / VS Code with Flutter extensions
   - Git
   - Protocol Buffers compiler (protoc)
   - Dart protoc plugin

2. **AWS Account Setup**
   - AWS Account with appropriate permissions
   - AWS CLI installed and configured
   - AWS credentials configured

3. **Server Requirements**
   - Go 1.21 or later
   - Docker installed
   - EC2 instance with appropriate security groups

## Detailed Setup Instructions

### 1. Development Environment Setup

```bash
# Install Flutter
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor

# Install Protocol Buffers
# For Windows:
# Download from https://github.com/protocolbuffers/protobuf/releases
# For macOS:
brew install protobuf

# Install Dart protoc plugin
dart pub global activate protoc_plugin
```

### 2. AWS Services Setup

```bash
# Configure AWS CLI
aws configure

# Create Cognito User Pool
aws cognito-idp create-user-pool \
  --pool-name flutter-grpc-chat-pool \
  --policies '{"PasswordPolicy":{"MinimumLength":8,"RequireUppercase":true,"RequireLowercase":true,"RequireNumbers":true,"RequireSymbols":true}}' \
  --schema '[{"Name":"email","Required":true,"Mutable":true},{"Name":"username","Required":true,"Mutable":true}]'

# Create Cognito App Client
aws cognito-idp create-user-pool-client \
  --user-pool-id YOUR_USER_POOL_ID \
  --client-name flutter-grpc-chat-client \
  --no-generate-secret \
  --explicit-auth-flows "ALLOW_USER_SRP_AUTH" "ALLOW_REFRESH_TOKEN_AUTH"

# Create Cognito Identity Pool
aws cognito-identity create-identity-pool \
  --identity-pool-name flutter-grpc-chat-identity-pool \
  --allow-unauthenticated-identities \
  --cognito-identity-providers ProviderName=cognito-idp.REGION.amazonaws.com/USER_POOL_ID,ClientId=APP_CLIENT_ID,ServerSideTokenCheck=false

# Create S3 bucket
aws s3api create-bucket \
  --bucket flutter-grpc-chat-media \
  --region REGION \
  --create-bucket-configuration LocationConstraint=REGION

# Create DynamoDB tables
aws dynamodb create-table \
  --table-name chat-messages \
  --attribute-definitions AttributeName=id,AttributeType=S \
  --key-schema AttributeName=id,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

aws dynamodb create-table \
  --table-name chat-users \
  --attribute-definitions AttributeName=id,AttributeType=S \
  --key-schema AttributeName=id,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```

### 3. Configure Amplify

1. Update `amplifyconfiguration.json` with your AWS resources:
   - Replace `YOUR_REGION` with your AWS region
   - Replace `YOUR_USER_POOL_ID` with your Cognito User Pool ID
   - Replace `YOUR_IDENTITY_POOL_ID` with your Cognito Identity Pool ID
   - Replace `YOUR_APP_CLIENT_ID` with your Cognito App Client ID
   - Replace `YOUR_S3_BUCKET` with your S3 bucket name

### 4. Set up gRPC Server

```bash
# Clone the server repository
git clone https://github.com/your-username/grpc-chat-server.git
cd grpc-chat-server

# Install Go dependencies
go mod download

# Generate gRPC code
chmod +x scripts/generate_grpc.sh
./scripts/generate_grpc.sh

# Build and deploy to EC2
chmod +x scripts/deploy_server.sh
./scripts/deploy_server.sh
```

### 5. Flutter App Setup

```bash
# Install dependencies
flutter pub get

# Generate gRPC client code
chmod +x scripts/generate_grpc.sh
./scripts/generate_grpc.sh

# Run the application
   flutter run
   ```

## Project Structure

```
lib/
  core/
    constants/
    theme/
    utils/
    widgets/
  features/
    auth/
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        bloc/
        pages/
        widgets/
    chat/
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        bloc/
        pages/
        widgets/
  main.dart
```

## Architecture

The application follows clean architecture principles:

- **Presentation Layer**: UI components and BLoC state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: Repository implementations and data sources

## Testing

```bash
# Run unit tests
flutter test

# Run widget tests
flutter test --tags=widget

# Run integration tests
flutter test --tags=integration
```

## Common Issues and Solutions

1. **gRPC Generation Issues**
   - Ensure protoc is installed and in PATH
   - Verify Dart protoc plugin is installed
   - Check proto file syntax

2. **AWS Configuration Issues**
   - Verify AWS credentials are correct
   - Check IAM permissions
   - Ensure all required services are enabled

3. **Build Issues**
   - Run `flutter clean`
   - Delete `pubspec.lock`
   - Run `flutter pub get`

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.
