import 'package:dartz/dartz.dart';
import '/core/errors/exception.dart';
import '/core/errors/failure.dart';

import '../../../core/data_sources/remote_data_sources.dart';
import '../model/dashboard_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardModel>> getDashboardData(String token);
}

class DashboardRepositoryImpl implements DashboardRepository {
  final RemoteDataSources remoteDataSources;

  DashboardRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, DashboardModel>> getDashboardData(String token) async {
    try {
      final result = await remoteDataSources.getDashboardData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
