import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:flutter_grpc_chat/features/chat/data/models/message_model.dart';

class ChatGrpcClient {
  late final ClientChannel _channel;
  late final ChatServiceClient _client;
  StreamController<MessageModel>? _messageStreamController;

  ChatGrpcClient() {
    _initializeClient();
  }

  void _initializeClient() {
    _channel = ClientChannel(
      'your-ec2-instance.com', // Replace with your EC2 instance domain
      port: 50051,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );

    _client = ChatServiceClient(_channel);
  }

  Future<void> sendMessage(MessageModel message) async {
    final request = SendMessageRequest(
      message: message.toJson(),
    );

    await _client.sendMessage(request);
  }

  Future<List<MessageModel>> getMessages({
    required String chatId,
    int? limit,
    String? lastMessageId,
  }) async {
    final request = GetMessagesRequest(
      chatId: chatId,
      limit: limit,
      lastMessageId: lastMessageId,
    );

    final response = await _client.getMessages(request);
    return response.messages
        .map((msg) => MessageModel.fromJson(msg))
        .toList();
  }

  Future<void> markMessageAsRead(String messageId) async {
    final request = MarkMessageAsReadRequest(
      messageId: messageId,
    );

    await _client.markMessageAsRead(request);
  }

  Stream<MessageModel> getMessageStream(String chatId) {
    final request = GetMessageStreamRequest(
      chatId: chatId,
    );

    _messageStreamController?.close();
    _messageStreamController = StreamController<MessageModel>();

    final responseStream = _client.getMessageStream(request);

    responseStream.listen(
      (response) {
        final message = MessageModel.fromJson(response.message);
        _messageStreamController?.add(message);
      },
      onError: (error) {
        _messageStreamController?.addError(error);
      },
      onDone: () {
        _messageStreamController?.close();
      },
    );

    return _messageStreamController!.stream;
  }

  void dispose() {
    _messageStreamController?.close();
    _channel.shutdown();
  }
}

// gRPC Request/Response classes
class SendMessageRequest {
  final Map<String, dynamic> message;

  SendMessageRequest({required this.message});

  Map<String, dynamic> toJson() => {'message': message};
}

class GetMessagesRequest {
  final String chatId;
  final int? limit;
  final String? lastMessageId;

  GetMessagesRequest({
    required this.chatId,
    this.limit,
    this.lastMessageId,
  });

  Map<String, dynamic> toJson() => {
        'chatId': chatId,
        'limit': limit,
        'lastMessageId': lastMessageId,
      };
}

class MarkMessageAsReadRequest {
  final String messageId;

  MarkMessageAsReadRequest({required this.messageId});

  Map<String, dynamic> toJson() => {'messageId': messageId};
}

class GetMessageStreamRequest {
  final String chatId;

  GetMessageStreamRequest({required this.chatId});

  Map<String, dynamic> toJson() => {'chatId': chatId};
}

// gRPC Service Client
class ChatServiceClient {
  final ClientChannel _channel;

  ChatServiceClient(this._channel);

  Future<void> sendMessage(SendMessageRequest request) async {
    // Implement gRPC call
  }

  Future<GetMessagesResponse> getMessages(GetMessagesRequest request) async {
    // Implement gRPC call
    return GetMessagesResponse(messages: []);
  }

  Future<void> markMessageAsRead(MarkMessageAsReadRequest request) async {
    // Implement gRPC call
  }

  Stream<GetMessageStreamResponse> getMessageStream(
    GetMessageStreamRequest request,
  ) {
    // Implement gRPC call
    return Stream.empty();
  }
}

class GetMessagesResponse {
  final List<Map<String, dynamic>> messages;

  GetMessagesResponse({required this.messages});
}

class GetMessageStreamResponse {
  final Map<String, dynamic> message;

  GetMessageStreamResponse({required this.message});
} 