import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_grpc_chat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_grpc_chat/features/chat/domain/entities/message.dart';
import 'package:flutter_grpc_chat/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_grpc_chat/features/chat/presentation/widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isAttaching = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    context.read<ChatBloc>().add(
          const GetMessagesRequested(
            chatId: 'default-chat', // Replace with actual chat ID
            limit: 50,
          ),
        );
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: (context.read<AuthBloc>().state as Authenticated).userId,
      content: _messageController.text.trim(),
      type: MessageType.text,
      timestamp: DateTime.now(),
    );

    context.read<ChatBloc>().add(SendMessageRequested(message));
    _messageController.clear();
    _scrollToBottom();
  }

  Future<void> _handleAttachFile() async {
    setState(() => _isAttaching = true);

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'pdf'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        final message = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: (context.read<AuthBloc>().state as Authenticated).userId,
          content: 'File attachment',
          type: _getMessageType(result.files.single.extension!),
          timestamp: DateTime.now(),
          fileName: result.files.single.name,
          fileSize: result.files.single.size,
        );

        context.read<ChatBloc>().add(SendMessageRequested(message));
      }
    } finally {
      setState(() => _isAttaching = false);
    }
  }

  Future<void> _handleAttachImage() async {
    setState(() => _isAttaching = true);

    try {
      final result = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (result != null) {
        final message = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: (context.read<AuthBloc>().state as Authenticated).userId,
          content: 'Image attachment',
          type: MessageType.image,
          timestamp: DateTime.now(),
          fileName: result.name,
          fileSize: await result.length(),
        );

        context.read<ChatBloc>().add(SendMessageRequested(message));
      }
    } finally {
      setState(() => _isAttaching = false);
    }
  }

  MessageType _getMessageType(String extension) {
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return MessageType.image;
      case 'mp4':
        return MessageType.video;
      default:
        return MessageType.file;
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ChatError) {
                  return Center(
                    child: Text(
                      state.failure.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is MessagesLoaded) {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return MessageBubble(message: message);
                    },
                  );
                }

                return const Center(child: Text('No messages yet'));
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: _isAttaching ? null : _handleAttachFile,
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _isAttaching ? null : _handleAttachImage,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _handleSendMessage,
          ),
        ],
      ),
    );
  }
} 