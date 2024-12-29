import 'package:dartz/dartz.dart';
import '../controller/update_variant_cubit/update_variant_state_model.dart';
import '../model/create_variant_state_model.dart';
import '/core/errors/exception.dart';
import '/core/errors/failure.dart';

import '../../../core/data_sources/remote_data_sources.dart';
import '../model/product_variant-model.dart';
import '../model/single_variant_model/single_variant_model.dart';

abstract class VariantRepository {
  Future<Either<Failure, ProductVariantModel>> getAllProductVariantById(
      String id, String token);

  Future<Either<Failure, SingleVariant>> getAllProductVariantByVariantId(
      String id, String token);

  Future<Either<Failure, String>> deleteProductVariant(String id, String token);

  Future<Either<Failure, String>> variantProductStatusChange(
      String id, String token);

  Future<Either<dynamic, String>> createVariantProduct(
      String token, CreateVariantStateModel body);

  Future<Either<dynamic, String>> updateVariantProduct(
      String id, String token, UpdateVariantStateModel body);
}

class VariantRepositoryImpl implements VariantRepository {
  final RemoteDataSources remoteDataSources;

  VariantRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, ProductVariantModel>> getAllProductVariantById(
      String id, String token) async {
    try {
      final variant =
          await remoteDataSources.getAllProductVariantById(id, token);
      return Right(variant);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SingleVariant>> getAllProductVariantByVariantId(
      String id, String token) async {
    try {
      final result =
          await remoteDataSources.getAllProductVariantByVariantId(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProductVariant(
      String id, String token) async {
    try {
      final result = await remoteDataSources.deleteProductVariant(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> variantProductStatusChange(
      String id, String token) async {
    try {
      final statusChange =
          await remoteDataSources.variantProductStatusChange(id, token);
      return Right(statusChange);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> createVariantProduct(
      String token, CreateVariantStateModel body) async {
    try {
      final createVariant =
          await remoteDataSources.createVariantProduct(token, body);
      return Right(createVariant);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> updateVariantProduct(
      String id, String token, UpdateVariantStateModel body) async {
    try {
      final createVariant =
          await remoteDataSources.updateVariantProduct(id, token, body);
      return Right(createVariant);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
