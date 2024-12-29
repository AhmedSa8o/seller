import 'package:dartz/dartz.dart';
import '../controller/password_change/password_change_state_model.dart';
import '../controller/update_profile/update_profile_state_model.dart';
import '../controller/update_seller_shop/update_seller_shop_state_model.dart';
import '../model/city_by_state_model.dart';
import '../model/state_by_country_model.dart';
import '/core/data_sources/remote_data_sources.dart';
import '/core/errors/exception.dart';
import '/core/errors/failure.dart';
import '/modules/profile/model/seller_profile_model.dart';

abstract class SellerProfileRepository {
  Future<Either<Failure, SellerProfileModel>> getSellerProfile(String token);

  Future<Either<dynamic, String>> passwordChange(
      String token, PasswordChangeModel body);

  Future<Either<dynamic, String>> updateSellerShop(
      UpdateSellerShopStateModel body, String token);

  Future<Either<dynamic, String>> updateSellerProfile(
      UpdateSellerProfileStateModel body, String token);

  Future<Either<Failure, List<StateByCountryModel>>> getStateByCountryList(
      String countryId, String token);

  Future<Either<Failure, List<CityByStateModel>>> getCityByStateList(
      String stateId, String token);
}

class SellerProfileRepositoryImpl implements SellerProfileRepository {
  final RemoteDataSources remoteDataSources;

  SellerProfileRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, SellerProfileModel>> getSellerProfile(
      String token) async {
    try {
      final result = await remoteDataSources.getSellerProfile(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> updateSellerProfile(
      UpdateSellerProfileStateModel body, String token) async {
    try {
      final sellerProfile =
          await remoteDataSources.updateSellerProfile(body, token);
      return Right(sellerProfile);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> updateSellerShop(
      UpdateSellerShopStateModel body, String token) async {
    try {
      final sellerShop = await remoteDataSources.updateSellerShop(body, token);
      return Right(sellerShop);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CityByStateModel>>> getCityByStateList(
      String stateId, String token) async {
    try {
      final cityList =
          await remoteDataSources.getCityByStateList(stateId, token);
      return Right(cityList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<StateByCountryModel>>> getStateByCountryList(
      String countryId, String token) async {
    try {
      final stateList =
          await remoteDataSources.getStateByCountryList(countryId, token);
      return Right(stateList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> passwordChange(
      String token, PasswordChangeModel body) async {
    try {
      final passwordChange =
          await remoteDataSources.passwordChange(body, token);
      return Right(passwordChange);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
