import 'package:dartz/dartz.dart';

import '../../../core/errors/exception.dart';
import '../../../core/errors/failure.dart';
import '../../../dependency_injection_packages.dart';
import '../controller/video_cubit/video_state_model.dart';
import '../model/video_model.dart';

abstract class VideoRepository {
  Future<Either<dynamic, String>> storeVideo(VideoStateModel body);

  Future<Either<Failure, List<VideoModel>>> getAllVideos(String productId);

  Future<Either<Failure, String>> updateVideoStatus(String productId);

  Future<Either<Failure, String>> deleteVideo(String productId);
}

class VideoRepositoryImpl implements VideoRepository {
  final RemoteDataSources remoteDataSources;

  const VideoRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, String>> deleteVideo(String productId) async {
    try {
      final result = await remoteDataSources.deleteVideo(productId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<VideoModel>>> getAllVideos(
      String productId) async {
    try {
      final result = await remoteDataSources.getAllVideos(productId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> storeVideo(VideoStateModel body) async {
    try {
      final result = await remoteDataSources.storeVideo(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> updateVideoStatus(String productId) async {
    try {
      final result = await remoteDataSources.updateVideoStatus(productId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
