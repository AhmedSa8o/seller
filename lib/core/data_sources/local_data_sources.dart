import 'package:seller_app/modules/authentication/login/model/user_response_model.dart';

import '/utils/k_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../errors/exception.dart';

abstract class LocalDataSources {
  bool checkOnBoarding();

  Future<bool> cachedOnBoarding();
  Future<bool> cacheUserResponse(UserResponseModel userResponseModel);
  UserResponseModel getExistingUserInfo();
  Future<bool> clearUserResponse();
}

class LocalDataSourcesImpl implements LocalDataSources {
  final SharedPreferences sharedPreferences;

  LocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<bool> cachedOnBoarding() async {
    return sharedPreferences.setBool(KString.cachedOnBoardingKey, true);
  }

  @override
  bool checkOnBoarding() {
    final jsonString = sharedPreferences.getBool(KString.cachedOnBoardingKey);
    if (jsonString != null) {
      return true;
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheUserResponse(UserResponseModel userResponseModel) {
    return sharedPreferences.setString(
        KString.getExistingUserResponseKey, userResponseModel.toJson());
  }

  @override
  UserResponseModel getExistingUserInfo() {
    final jsonData = sharedPreferences.getString(KString.getExistingUserResponseKey);
    if(jsonData != null){
      print('savedDaaaaa $jsonData');
      return UserResponseModel.fromJson(jsonData);
    }else{
      throw const DatabaseException('Not save users');
    }
  }

  @override
  Future<bool> clearUserResponse() {
   return sharedPreferences.remove(KString.getExistingUserResponseKey);
  }
}
