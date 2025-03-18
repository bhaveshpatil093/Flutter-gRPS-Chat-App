import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_grpc_chat/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_grpc_chat/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_grpc_chat/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:flutter_grpc_chat/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_grpc_chat/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_grpc_chat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_grpc_chat/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:flutter_grpc_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_grpc_chat/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:flutter_grpc_chat/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:flutter_grpc_chat/features/chat/presentation/bloc/chat_bloc.dart';

final getIt = GetIt.instance;

@InjectableModule
abstract class RegisterModule {
  @singleton
  AuthRepository get authRepository => AuthRepositoryImpl();

  @singleton
  ChatRepository get chatRepository => ChatRepositoryImpl();

  @singleton
  SignInUseCase get signInUseCase => SignInUseCase(getIt<AuthRepository>());

  @singleton
  SignUpUseCase get signUpUseCase => SignUpUseCase(getIt<AuthRepository>());

  @singleton
  SignOutUseCase get signOutUseCase => SignOutUseCase(getIt<AuthRepository>());

  @singleton
  SendMessageUseCase get sendMessageUseCase => SendMessageUseCase(getIt<ChatRepository>());

  @singleton
  GetMessagesUseCase get getMessagesUseCase => GetMessagesUseCase(getIt<ChatRepository>());

  @singleton
  AuthBloc get authBloc => AuthBloc(
        signInUseCase: getIt<SignInUseCase>(),
        signUpUseCase: getIt<SignUpUseCase>(),
        signOutUseCase: getIt<SignOutUseCase>(),
      );

  @singleton
  ChatBloc get chatBloc => ChatBloc(
        sendMessageUseCase: getIt<SendMessageUseCase>(),
        getMessagesUseCase: getIt<GetMessagesUseCase>(),
      );
}

Future<void> configureDependencies() async {
  getIt.registerSingleton<RegisterModule>(RegisterModule());
} 