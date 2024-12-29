import 'package:dartz/dartz.dart';
import '../model/store_gallery_state_model.dart';
import '/core/errors/exception.dart';
import '/core/errors/failure.dart';
import '/modules/gallery/model/gallery_model.dart';

import '../../../core/data_sources/remote_data_sources.dart';

abstract class GalleryRepository {
  Future<Either<Failure, GalleryModel>> getAllGalleryImages(
      String id, String token);

  Future<Either<Failure, String>> galleryStatusChange(int id, String token);

  Future<Either<Failure, String>> deleteSingleGalleryImage(
      int id, String token);

  Future<Either<Failure, String>> storeGalleryImages(
      StoreGalleryStateModel body, String token);
}

class GalleryRepositoryImpl implements GalleryRepository {
  final RemoteDataSources remoteDataSources;

  GalleryRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, GalleryModel>> getAllGalleryImages(
      String id, String token) async {
    try {
      final result = await remoteDataSources.getAllGalleryImages(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> galleryStatusChange(
      int id, String token) async {
    try {
      final status = await remoteDataSources.galleryStatusChange(id, token);
      return Right(status);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteSingleGalleryImage(
      int id, String token) async {
    try {
      final delete =
          await remoteDataSources.deleteSingleGalleryImage(id, token);
      return Right(delete);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> storeGalleryImages(
      StoreGalleryStateModel body, String token) async {
    try {
      final result = await remoteDataSources.storeGalleryImages(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
