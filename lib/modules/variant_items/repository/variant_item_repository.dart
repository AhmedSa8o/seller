import 'package:dartz/dartz.dart';
import 'package:seller_app/core/data_sources/remote_data_sources.dart';
import 'package:seller_app/core/errors/exception.dart';

import '../../../core/errors/failure.dart';
import '../../variant/model/single_variant_item_model/single_variant_item_model.dart';
import '../controller/store_bloc/update_variant_item_state_model.dart';
import '../model/variant_item_model.dart';

//VP = Variant Product
//V = Variant
//VI = Variant Item
abstract class VariantItemRepository {
  Future<Either<Failure, VariantItem>> getVariantItemById(
      String id, String token);

  Future<Either<Failure, VariantItemModel>> getVIByVPIdAndVId(
      String productId, String variantId, String token);

  Future<Either<Failure, String>> deleteVariantItemById(
      String id, String token);

  Future<Either<dynamic, String>> storeVariantItem(
      String token, Map<String, dynamic> body);

  Future<Either<dynamic, String>> updateVariantItem(
      String itemId, String token, UpdateVariantItemStateModel body);

  Future<Either<Failure, String>> updateVIStatus(String itemId, String token);
}

class VariantItemRepositoryImpl implements VariantItemRepository {
  final RemoteDataSources remoteDataSources;

  VariantItemRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, VariantItemModel>> getVIByVPIdAndVId(
      String productId, String variantId, String token) async {
    try {
      final result = await remoteDataSources.getVIByVPIdAndVId(
          productId, variantId, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, VariantItem>> getVariantItemById(
      String id, String token) async {
    try {
      final result = await remoteDataSources.getVariantItemById(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteVariantItemById(
      String id, String token) async {
    try {
      final delete = await remoteDataSources.deleteVariantItemById(id, token);
      return Right(delete);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> storeVariantItem(
      String token, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSources.storeVariantItem(token, body);
      return Right(result);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> updateVIStatus(
      String itemId, String token) async {
    try {
      final result = await remoteDataSources.updateVIStatus(itemId, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> updateVariantItem(
      String itemId, String token, UpdateVariantItemStateModel body) async {
    try {
      final result =
          await remoteDataSources.updateVariantItem(itemId, token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
