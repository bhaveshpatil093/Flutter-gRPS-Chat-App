import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/message.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final _uuid = const Uuid();
  String _chatId = '';

  @override
  void initState() {
    super.initState();
    _chatId = _uuid.v4();
    context.read<ChatBloc>().add(GetMessagesRequested(_chatId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
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

  void _sendMessage(String content, MessageType type, {String? mediaUrl, String? fileName, int? fileSize}) {
    if (content.isEmpty && type == MessageType.text) return;

    final message = Message(
      id: _uuid.v4(),
      chatId: _chatId,
      senderId: 'user123', // Replace with actual user ID
      content: content,
      type: type,
      timestamp: DateTime.now(),
      mediaUrl: mediaUrl,
      fileName: fileName,
      fileSize: fileSize,
    );

    context.read<ChatBloc>().add(SendMessageRequested(message));
    _messageController.clear();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path!);
      final fileName = result.files.single.name;
      final fileSize = await file.length();

      // TODO: Upload file and get URL
      final mediaUrl = 'https://example.com/files/$fileName';

      _sendMessage(
        fileName,
        MessageType.file,
        mediaUrl: mediaUrl,
        fileName: fileName,
        fileSize: fileSize,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is MessageSent) {
                  _scrollToBottom();
                }
              },
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is MessagesLoaded) {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return MessageBubble(
                        message: message,
                        isMe: message.senderId == 'user123', // Replace with actual user ID
                      );
                    },
                  );
                }
                if (state is MessageError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
          Container(
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
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: _pickFile,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (text) => _sendMessage(text, MessageType.text),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _sendMessage(_messageController.text, MessageType.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 