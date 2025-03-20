import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<Message> sendMessage(Message message);
  Future<List<Message>> getMessages(String chatId);
  Stream<Message> subscribeToMessages(String chatId);
  Future<String> uploadMedia(String filePath, String fileName, int fileSize);
  Future<void> markMessageAsRead(String messageId);
} 