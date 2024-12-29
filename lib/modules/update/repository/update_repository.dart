import 'package:dartz/dartz.dart';
import '../model/edit_product_model/edit_product_model.dart';
import '../model/update_product_model_state.dart';
import '/core/data_sources/remote_data_sources.dart';
import '/core/errors/exception.dart';
import '/core/errors/failure.dart';

abstract class UpdateProductRepository {
  Future<Either<dynamic, String>> updateSingleProduct(
      String id, String token, UpdateProductModelState body);

  Future<Either<Failure, EditProductModel>> getEditProduct(
      String id, String token);
}

class UpdateProductRepositoryImpl implements UpdateProductRepository {
  final RemoteDataSources remoteDataSources;

  const UpdateProductRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<dynamic, String>> updateSingleProduct(
      String id, String token, UpdateProductModelState body) async {
    try {
      final result =
          await remoteDataSources.updateSingleProduct(id, token, body);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, EditProductModel>> getEditProduct(
      String id, String token) async {
    try {
      final result = await remoteDataSources.getEditProduct(id, token);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
