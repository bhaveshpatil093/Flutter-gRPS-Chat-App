import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';

class WebConfig {
  static ClientChannel getGrpcChannel() {
    if (kIsWeb) {
      // For web, we'll use a proxy or gRPC-web
      return ClientChannel(
        'localhost',
        port: 8080,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
    } else {
      return ClientChannel(
        'localhost',
        port: 50051,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
    }
  }
} 