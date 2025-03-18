import 'dart:async';
import 'dart:io';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import 'package:flutter_grpc_chat/core/error/failures.dart';
import 'package:flutter_grpc_chat/features/chat/data/datasources/chat_grpc_client.dart';
import 'package:flutter_grpc_chat/features/chat/domain/entities/message.dart';
import 'package:flutter_grpc_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_grpc_chat/features/chat/data/models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatGrpcClient _grpcClient;
  final _uuid = const Uuid();

  ChatRepositoryImpl(this._grpcClient);

  @override
  Future<Either<Failure, void>> sendMessage(Message message) async {
    try {
      final messageModel = MessageModel.fromEntity(message);
      await _grpcClient.sendMessage(messageModel);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to send message',
        code: e.code.toString(),
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages({
    required String chatId,
    int? limit,
    String? lastMessageId,
  }) async {
    try {
      final messages = await _grpcClient.getMessages(
        chatId: chatId,
        limit: limit,
        lastMessageId: lastMessageId,
      );
      return Right(messages.map((m) => m.toEntity()).toList());
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get messages',
        code: e.code.toString(),
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> markMessageAsRead(String messageId) async {
    try {
      await _grpcClient.markMessageAsRead(messageId);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to mark message as read',
        code: e.code.toString(),
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, String>> uploadMedia(String filePath) async {
    try {
      final file = File(filePath);
      final fileName = '${_uuid.v4()}${path.extension(filePath)}';
      
      final result = await Amplify.Storage.uploadFile(
        local: file,
        key: fileName,
        options: StorageUploadFileOptions(
          accessLevel: StorageAccessLevel.guest,
          contentType: _getContentType(filePath),
        ),
      );

      final url = await Amplify.Storage.getUrl(
        key: result.key,
        options: const StorageGetUrlOptions(
          accessLevel: StorageAccessLevel.guest,
          expires: 3600, // URL expires in 1 hour
        ),
      );

      return Right(url.url);
    } on StorageException catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to upload media',
        code: e.name,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
      ));
    }
  }

  @override
  Stream<Either<Failure, Message>> getMessageStream(String chatId) {
    return _grpcClient.getMessageStream(chatId).map(
      (message) => Right(message.toEntity()),
      onError: (error) {
        if (error is GrpcError) {
          return Left(ServerFailure(
            message: error.message ?? 'Failed to get message stream',
            code: error.code.toString(),
          ));
        }
        return Left(ServerFailure(
          message: 'An unexpected error occurred',
        ));
      },
    );
  }

  String _getContentType(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.mp4':
        return 'video/mp4';
      case '.pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }
} 