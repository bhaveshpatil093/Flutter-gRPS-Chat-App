import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/chat/domain/entities/message.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isMe ? Theme.of(context).primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            _buildMessageContent(context),
            const SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(message.timestamp),
              style: TextStyle(
                fontSize: 12,
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    switch (message.type) {
      case MessageType.text:
        return Text(
          message.content,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),
        );
      case MessageType.image:
        return _buildImageMessage(context);
      case MessageType.video:
        return _buildVideoMessage(context);
      case MessageType.file:
        return _buildFileMessage(context);
    }
  }

  Widget _buildImageMessage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show full-screen image
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Image.network(message.mediaUrl!),
          ),
        );
      },
      child: Container(
        constraints: const BoxConstraints(maxWidth: 200),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            message.mediaUrl!,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildVideoMessage(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (message.mediaUrl != null) {
          final url = Uri.parse(message.mediaUrl!);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.play_circle_outline),
            const SizedBox(width: 8),
            Text(message.fileName ?? 'Video'),
          ],
        ),
      ),
    );
  }

  Widget _buildFileMessage(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (message.mediaUrl != null) {
          final url = Uri.parse(message.mediaUrl!);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.attach_file),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message.fileName ?? 'File'),
                if (message.fileSize != null)
                  Text(
                    '${(message.fileSize! / 1024).toStringAsFixed(1)} KB',
                    style: const TextStyle(fontSize: 12),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 