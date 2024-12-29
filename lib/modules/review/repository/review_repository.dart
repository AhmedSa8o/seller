import 'package:dartz/dartz.dart';
import '/core/data_sources/remote_data_sources.dart';
import '/core/errors/exception.dart';
import '/core/errors/failure.dart';
import '/modules/review/model/review_model.dart';

abstract class ReviewRepository {
  Future<Either<Failure, List<ReviewModel>>> getAllReviews(String token);

  Future<Either<Failure, ReviewModel>> getAllReviewsById(
      String id, String token);
}

class ReviewRepositoryImpl implements ReviewRepository {
  final RemoteDataSources remoteDataSources;

  ReviewRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, List<ReviewModel>>> getAllReviews(String token) async {
    try {
      final reviews = await remoteDataSources.getAllReviews(token);
      return Right(reviews);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> getAllReviewsById(
      String id, String token) async {
    try {
      final reviews = await remoteDataSources.getAllReviewsById(id, token);
      return Right(reviews);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
