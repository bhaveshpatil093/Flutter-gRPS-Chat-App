import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_app/features/chat/domain/entities/message.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

// Events
abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class GetMessagesRequested extends ChatEvent {
  final String chatId;
  final int limit;

  const GetMessagesRequested(this.chatId, {this.limit = 50});

  @override
  List<Object?> get props => [chatId, limit];
}

class SendMessageRequested extends ChatEvent {
  final Message message;

  const SendMessageRequested(this.message);

  @override
  List<Object?> get props => [message];
}

class NewMessageReceived extends ChatEvent {
  final Message message;

  const NewMessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}

class MarkMessageAsReadRequested extends ChatEvent {
  final String messageId;

  const MarkMessageAsReadRequested(this.messageId);

  @override
  List<Object?> get props => [messageId];
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

class MessageRead extends ChatState {
  final String messageId;

  const MessageRead(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

class MessageError extends ChatState {
  final String message;

  const MessageError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  StreamSubscription? _messageSubscription;

  ChatBloc(this._chatRepository) : super(ChatInitial()) {
    on<GetMessagesRequested>(_onGetMessagesRequested);
    on<SendMessageRequested>(_onSendMessageRequested);
    on<NewMessageReceived>(_onNewMessageReceived);
    on<MarkMessageAsReadRequested>(_onMarkMessageAsReadRequested);

    _messageSubscription = _chatRepository.messageStream.listen(
      (message) => add(NewMessageReceived(message)),
    );
  }

  Future<void> _onGetMessagesRequested(
    GetMessagesRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());

    final result = await _chatRepository.getMessages(
      event.chatId,
      limit: event.limit,
    );

    result.fold(
      (failure) => emit(MessageError(failure.message)),
      (messages) => emit(MessagesLoaded(messages)),
    );
  }

  Future<void> _onSendMessageRequested(
    SendMessageRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());

    final result = await _chatRepository.sendMessage(event.message);

    result.fold(
      (failure) => emit(MessageError(failure.message)),
      (_) => emit(MessageSent(event.message)),
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

  Future<void> _onMarkMessageAsReadRequested(
    MarkMessageAsReadRequested event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _chatRepository.markMessageAsRead(event.messageId);

    result.fold(
      (failure) => emit(MessageError(failure.message)),
      (_) => emit(MessageRead(event.messageId)),
    );
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
} 