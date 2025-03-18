import 'package:dartz/dartz.dart';
import 'package:flutter_grpc_chat/core/error/failures.dart';
import 'package:flutter_grpc_chat/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String email,
    required String password,
  }) async {
    return await repository.signIn(
      email: email,
      password: password,
    );
  }
} 