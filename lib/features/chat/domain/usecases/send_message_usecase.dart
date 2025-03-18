import 'package:dartz/dartz.dart';
import 'package:flutter_grpc_chat/core/error/failures.dart';
import 'package:flutter_grpc_chat/features/chat/domain/entities/message.dart';
import 'package:flutter_grpc_chat/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<Failure, void>> call(Message message) async {
    return await repository.sendMessage(message);
  }
} 