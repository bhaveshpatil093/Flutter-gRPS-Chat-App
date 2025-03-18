import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_grpc_chat/core/error/failures.dart';
import 'package:flutter_grpc_chat/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, String>> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: email,
        CognitoUserAttributeKey.preferredUsername: username,
      };

      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );

      return Right(result.userId);
    } on AuthException catch (e) {
      return Left(AuthFailure(
        message: e.message,
        code: e.name,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, String>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      return Right(result.userId);
    } on AuthException catch (e) {
      return Left(AuthFailure(
        message: e.message,
        code: e.name,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await Amplify.Auth.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(
        message: e.message,
        code: e.name,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentUserId() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      return Right(user.userId);
    } on AuthException catch (e) {
      return Left(AuthFailure(
        message: e.message,
        code: e.name,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      return Right(session.isSignedIn);
    } on AuthException catch (e) {
      return Left(AuthFailure(
        message: e.message,
        code: e.name,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
      ));
    }
  }
} 