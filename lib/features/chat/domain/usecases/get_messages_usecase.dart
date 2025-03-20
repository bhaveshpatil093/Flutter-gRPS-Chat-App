import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  Future<Either<Failure, List<Message>>> call(String chatId, {int limit = 50}) async {
    return repository.getMessages(chatId, limit: limit);
  }

  Stream<Message> get messageStream => repository.messageStream;
} 