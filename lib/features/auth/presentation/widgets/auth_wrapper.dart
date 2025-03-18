import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grpc_chat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_grpc_chat/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_grpc_chat/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_grpc_chat/features/chat/presentation/pages/chat_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is Authenticated) {
          return const ChatPage();
        }

        if (state is Unauthenticated) {
          return const LoginPage();
        }

        if (state is AuthError) {
          return Scaffold(
            body: Center(
              child: Text(
                state.failure.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        return const LoginPage();
      },
    );
  }
} 