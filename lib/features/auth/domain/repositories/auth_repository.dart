import 'package:dartz/dartz.dart';
import 'package:flutter_grpc_chat/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signUp({
    required String email,
    required String password,
    required String username,
  });

  Future<Either<Failure, String>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, String>> getCurrentUserId();

  Future<Either<Failure, bool>> isSignedIn();
} 