import 'package:dartz/dartz.dart';
import '../model/category_brand_model.dart';
import '../model/store_product_state_model.dart';
import '/core/data_sources/remote_data_sources.dart';
import '/core/errors/exception.dart';
import '/core/errors/failure.dart';

abstract class StoreProductRepository {
  Future<Either<dynamic, String>> storeProduct(
      StoreProductStateModel body, String token);

  Future<Either<Failure, CategoryBrandModel>> getAllCategoryAndBrands(
      String token);

  Future<Either<Failure, String>> updateProductStatus(String id, String token);
}

class StoreProductRepositoryImpl implements StoreProductRepository {
  final RemoteDataSources remoteDataSources;

  StoreProductRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<dynamic, String>> storeProduct(
      StoreProductStateModel body, String token) async {
    try {
      final store = await remoteDataSources.storeProduct(body, token);
      return Right(store);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, CategoryBrandModel>> getAllCategoryAndBrands(
      String token) async {
    try {
      final result = await remoteDataSources.getAllCategoryAndBrands(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> updateProductStatus(
      String id, String token) async {
    try {
      final status = await remoteDataSources.updateProductStatus(id, token);
      return right(status);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
