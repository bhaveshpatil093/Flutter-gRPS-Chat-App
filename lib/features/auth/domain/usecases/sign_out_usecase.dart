import 'package:dartz/dartz.dart';
import 'package:flutter_grpc_chat/core/error/failures.dart';
import 'package:flutter_grpc_chat/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
} 