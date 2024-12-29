import 'package:dartz/dartz.dart';
import 'package:seller_app/modules/order/model/seller_all_order_model.dart';

import '../../../core/data_sources/remote_data_sources.dart';
import '../../../core/errors/exception.dart';
import '../../../core/errors/failure.dart';
import '../model/order_models.dart';
import '../model/product_model.dart';

abstract class OrdersRepository {
  Future<Either<Failure, ProductModel>> getAllProduct(String token);
  Future<Either<Failure, ProductModel>> getAllPendingProduct(String token);

  Future<Either<Failure, SellerAllOrdersModel>> getSellerAllOrders(
      String token);

  Future<Either<Failure, SellerAllOrdersModel>> getSellerPendingOrders(
      String token);

  Future<Either<Failure, SellerAllOrdersModel>> getSellerProgressOrders(
      String token);

  Future<Either<Failure, SellerAllOrdersModel>> getSellerDeliveredOrders(
      String token);

  Future<Either<Failure, SellerAllOrdersModel>> getSellerCompletedOrders(
      String token);

  Future<Either<Failure, SellerAllOrdersModel>> getSellerDeclinedOrders(
      String token);

  Future<Either<Failure, String>> deleteSingleProduct(String id, String token);

  Future<Either<Failure, OrderModel>> getSingleOrderDetailsProduct(
      String id, String token);


}

class OrdersRepositoryImpl implements OrdersRepository {
  final RemoteDataSources remoteDataSources;

  OrdersRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, ProductModel>> getAllProduct(String token) async {
    try {
      final result = await remoteDataSources.getAllProduct(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, ProductModel>> getAllPendingProduct(String token) async{
    try {
      final result = await remoteDataSources.getAllPendingProduct(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SellerAllOrdersModel>> getSellerAllOrders(
      String token) async {
    try {
      final result = await remoteDataSources.getSellerAllOrders(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SellerAllOrdersModel>> getSellerCompletedOrders(
      String token) async {
    try {
      final result = await remoteDataSources.getSellerCompletedOrders(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SellerAllOrdersModel>> getSellerDeclinedOrders(
      String token) async {
    try {
      final result = await remoteDataSources.getSellerDeclinedOrders(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SellerAllOrdersModel>> getSellerDeliveredOrders(
      String token) async {
    try {
      final result = await remoteDataSources.getSellerDeliveredOrders(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SellerAllOrdersModel>> getSellerPendingOrders(
      String token) async {
    try {
      final result = await remoteDataSources.getSellerPendingOrders(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SellerAllOrdersModel>> getSellerProgressOrders(
      String token) async {
    try {
      final result = await remoteDataSources.getSellerProgressOrders(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteSingleProduct(
      String id, String token) async {
    try {
      final result = await remoteDataSources.deleteSingleProduct(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> getSingleOrderDetailsProduct(
      String id, String token) async {
    try {
      final result =
          await remoteDataSources.getSingleOrderDetailsProduct(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}
