import 'package:chat_app/features/chat/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required String id,
    required String chatId,
    required String senderId,
    required String content,
    required MessageType type,
    required DateTime timestamp,
    bool isRead = false,
    String? mediaUrl,
    String? fileName,
    int? fileSize,
  }) : super(
          id: id,
          chatId: chatId,
          senderId: senderId,
          content: content,
          type: type,
          timestamp: timestamp,
          isRead: isRead,
          mediaUrl: mediaUrl,
          fileName: fileName,
          fileSize: fileSize,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      senderId: json['senderId'] as String,
      content: json['content'] as String,
      type: MessageType.values[json['type'] as int],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
      isRead: json['isRead'] as bool? ?? false,
      mediaUrl: json['mediaUrl'] as String?,
      fileName: json['fileName'] as String?,
      fileSize: json['fileSize'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'content': content,
      'type': type.index,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isRead': isRead,
      'mediaUrl': mediaUrl,
      'fileName': fileName,
      'fileSize': fileSize,
    };
  }
} 