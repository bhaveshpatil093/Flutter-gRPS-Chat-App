import 'package:dartz/dartz.dart';
import 'package:flutter_grpc_chat/core/error/failures.dart';
import 'package:flutter_grpc_chat/features/chat/domain/entities/message.dart';
import 'package:flutter_grpc_chat/features/chat/domain/repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  Future<Either<Failure, List<Message>>> call({
    required String chatId,
    int? limit,
    String? lastMessageId,
  }) async {
    return await repository.getMessages(
      chatId: chatId,
      limit: limit,
      lastMessageId: lastMessageId,
    );
  }
} 