import 'package:dartz/dartz.dart';

import '../../../../core/data_sources/local_data_sources.dart';
import '../../../../core/data_sources/remote_data_sources.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../model/user_response_model.dart';

abstract class LoginRepository {
  Future<Either<dynamic, UserResponseModel>> login(Map<String, dynamic> body);

  Future<Either<Failure, String>> logout(String token);

  Either<Failure, UserResponseModel> getExistingUserInfo();
}

class LoginRepositoryImpl implements LoginRepository {
  final RemoteDataSources remoteDataSources;
  final LocalDataSources localDataSources;

  LoginRepositoryImpl(
      {required this.remoteDataSources, required this.localDataSources});

  @override
  Future<Either<dynamic, UserResponseModel>> login(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSources.login(body);
      localDataSources
          .cacheUserResponse(result); //can't stay login because of this
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Either<Failure, UserResponseModel> getExistingUserInfo() {
    try {
      final result = localDataSources.getExistingUserInfo();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> logout(String token) async {
    try {
      final logout = await remoteDataSources.logout(token);
      localDataSources.clearUserResponse();
      return Right(logout);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
