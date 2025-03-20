import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/chat/domain/entities/message.dart' as domain;
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/features/chat/data/models/chat.pb.dart' as grpc;
import 'package:chat_app/features/chat/data/models/chat.pbgrpc.dart' as grpc;
import 'package:uuid/uuid.dart';
import 'package:fixnum/fixnum.dart';

class ChatRepositoryImpl implements ChatRepository {
  final grpc.ChatServiceClient _client;

  ChatRepositoryImpl(this._client);

  @override
  Future<Either<Failure, domain.Message>> sendMessage(domain.Message message) async {
    try {
      final request = grpc.SendMessageRequest(
        message: grpc.Message(
          id: message.id,
          chatId: message.chatId,
          senderId: message.senderId,
          content: message.content,
          type: _domainMessageTypeToGrpc(message.type),
          timestamp: message.timestamp.millisecondsSinceEpoch ~/ 1000,
          isRead: message.isRead,
          mediaUrl: message.mediaUrl,
          fileName: message.fileName,
          fileSize: message.fileSize?.toInt() ?? 0,
        ),
      );

      final response = await _client.sendMessage(request);
      return Right(_grpcMessageToDomain(response.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<domain.Message>>> getMessages(String chatId, {int limit = 50}) async {
    try {
      final request = grpc.GetMessagesRequest(chatId: chatId, limit: limit);
      final response = await _client.getMessages(request);
      return Right(response.messages.map(_grpcMessageToDomain).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<domain.Message> get messageStream {
    final request = grpc.SubscribeToMessagesRequest();
    return _client.subscribeToMessages(request).map(_grpcMessageToDomain);
  }

  @override
  Future<Either<Failure, String>> uploadMedia(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final request = grpc.UploadMediaRequest(
        data: bytes,
        fileName: file.path.split('/').last,
      );

      final response = await _client.uploadMedia(request);
      return Right(response.url);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markMessageAsRead(String messageId) async {
    try {
      final request = grpc.MarkMessageAsReadRequest(messageId: messageId);
      await _client.markMessageAsRead(request);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  domain.Message _grpcMessageToDomain(grpc.Message message) {
    return domain.Message(
      id: message.id,
      chatId: message.chatId,
      senderId: message.senderId,
      content: message.content,
      type: _grpcMessageTypeToDomain(message.type),
      timestamp: DateTime.fromMillisecondsSinceEpoch(message.timestamp.toInt() * 1000),
      isRead: message.isRead,
      mediaUrl: message.hasMediaUrl() ? message.mediaUrl : null,
      fileName: message.hasFileName() ? message.fileName : null,
      fileSize: message.hasFileSize() ? message.fileSize.toInt() : null,
    );
  }

  domain.MessageType _grpcMessageTypeToDomain(grpc.MessageType type) {
    switch (type) {
      case grpc.MessageType.TEXT:
        return domain.MessageType.text;
      case grpc.MessageType.IMAGE:
        return domain.MessageType.image;
      case grpc.MessageType.VIDEO:
        return domain.MessageType.video;
      case grpc.MessageType.FILE:
        return domain.MessageType.file;
      default:
        return domain.MessageType.text;
    }
  }

  grpc.MessageType _domainMessageTypeToGrpc(domain.MessageType type) {
    switch (type) {
      case domain.MessageType.text:
        return grpc.MessageType.TEXT;
      case domain.MessageType.image:
        return grpc.MessageType.IMAGE;
      case domain.MessageType.video:
        return grpc.MessageType.VIDEO;
      case domain.MessageType.file:
        return grpc.MessageType.FILE;
    }
  }
} 
} 