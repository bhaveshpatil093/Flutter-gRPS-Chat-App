import 'package:dartz/dartz.dart';
import 'package:flutter_grpc_chat/core/error/failures.dart';
import 'package:flutter_grpc_chat/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String email,
    required String password,
    required String username,
  }) async {
    return await repository.signUp(
      email: email,
      password: password,
      username: username,
    );
  }
} 