import 'package:dartz/dartz.dart';
import '../../../core/data_sources/remote_data_sources.dart';
import '../../on_boarding/model/setting_model.dart';
import '../../on_boarding/model/website_setup_model.dart';
import '/core/data_sources/local_data_sources.dart';
import '/core/errors/exception.dart';

import '../../../core/errors/failure.dart';

abstract class SettingRepository {
  Future<Either<Failure, WebsiteSetupModel>> getSetting();

  Either<Failure, bool> checkOnBoarding();

  Future<Either<Failure, bool>> cachedOnBoarding();
}

class SettingRepositoryImpl implements SettingRepository {
  final LocalDataSources localDataSources;
  final RemoteDataSources remoteDataSources;

  SettingRepositoryImpl(
      {required this.remoteDataSources, required this.localDataSources});

  @override
  Future<Either<Failure, WebsiteSetupModel>> getSetting() async {
    try {
      final result = await remoteDataSources.getSetting();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> cachedOnBoarding() async {
    try {
      final result = await localDataSources.cachedOnBoarding();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Either<Failure, bool> checkOnBoarding() {
    try {
      return Right(localDataSources.checkOnBoarding());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
