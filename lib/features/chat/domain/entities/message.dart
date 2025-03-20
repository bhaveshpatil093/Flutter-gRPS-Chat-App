import 'package:equatable/equatable.dart';

enum MessageType {
  text,
  image,
  video,
  file,
}

class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isRead;
  final String? mediaUrl;
  final String? fileName;
  final int? fileSize;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.mediaUrl,
    this.fileName,
    this.fileSize,
  });

  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? content,
    MessageType? type,
    DateTime? timestamp,
    bool? isRead,
    String? mediaUrl,
    String? fileName,
    int? fileSize,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
    );
  }

  @override
  List<Object?> get props => [
        id,
        chatId,
        senderId,
        content,
        type,
        timestamp,
        isRead,
        mediaUrl,
        fileName,
        fileSize,
      ];
} 