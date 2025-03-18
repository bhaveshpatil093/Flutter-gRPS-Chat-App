import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_grpc_chat/core/error/failures.dart';
import 'package:flutter_grpc_chat/features/chat/domain/entities/message.dart';
import 'package:flutter_grpc_chat/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:flutter_grpc_chat/features/chat/domain/usecases/get_messages_usecase.dart';

// Events
abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class SendMessageRequested extends ChatEvent {
  final Message message;

  const SendMessageRequested(this.message);

  @override
  List<Object?> get props => [message];
}

class GetMessagesRequested extends ChatEvent {
  final String chatId;
  final int? limit;
  final String? lastMessageId;

  const GetMessagesRequested({
    required this.chatId,
    this.limit,
    this.lastMessageId,
  });

  @override
  List<Object?> get props => [chatId, limit, lastMessageId];
}

class NewMessageReceived extends ChatEvent {
  final Message message;

  const NewMessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}

// States
abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class MessagesLoaded extends ChatState {
  final List<Message> messages;

  const MessagesLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class MessageSent extends ChatState {
  final Message message;

  const MessageSent(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatError extends ChatState {
  final Failure failure;

  const ChatError(this.failure);

  @override
  List<Object?> get props => [failure];
}

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  StreamSubscription? _messageStreamSubscription;

  ChatBloc({
    required this.sendMessageUseCase,
    required this.getMessagesUseCase,
  }) : super(ChatInitial()) {
    on<SendMessageRequested>(_onSendMessageRequested);
    on<GetMessagesRequested>(_onGetMessagesRequested);
    on<NewMessageReceived>(_onNewMessageReceived);
  }

  Future<void> _onSendMessageRequested(
    SendMessageRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await sendMessageUseCase(event.message);

    result.fold(
      (failure) => emit(ChatError(failure)),
      (_) => emit(MessageSent(event.message)),
    );
  }

  Future<void> _onGetMessagesRequested(
    GetMessagesRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await getMessagesUseCase(
      chatId: event.chatId,
      limit: event.limit,
      lastMessageId: event.lastMessageId,
    );

    result.fold(
      (failure) => emit(ChatError(failure)),
      (messages) => emit(MessagesLoaded(messages)),
    );
  }

  void _onNewMessageReceived(
    NewMessageReceived event,
    Emitter<ChatState> emit,
  ) {
    if (state is MessagesLoaded) {
      final currentMessages = (state as MessagesLoaded).messages;
      emit(MessagesLoaded([...currentMessages, event.message]));
    }
  }

  void startMessageStream(String chatId) {
    _messageStreamSubscription?.cancel();
    // Implement message stream subscription
  }

  @override
  Future<void> close() {
    _messageStreamSubscription?.cancel();
    return super.close();
  }
} 