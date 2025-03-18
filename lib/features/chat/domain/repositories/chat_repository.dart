import 'package:dartz/dartz.dart';
import 'package:flutter_grpc_chat/core/error/failures.dart';
import 'package:flutter_grpc_chat/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(Message message);
  Future<Either<Failure, List<Message>>> getMessages({
    required String chatId,
    int? limit,
    String? lastMessageId,
  });
  Future<Either<Failure, void>> markMessageAsRead(String messageId);
  Future<Either<Failure, String>> uploadMedia(String filePath);
  Stream<Either<Failure, Message>> getMessageStream(String chatId);
} 