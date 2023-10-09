import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/exceptions.dart';
import 'package:login_app/features/auth/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  Future<List<TokenModel>> getCachedLogin();
  Future<Unit> cachedLogin(List<TokenModel> loginModel);
}

// ignore: constant_identifier_names
const CACHED_LOGIN = "CACHED_LOGIN";

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachedLogin(List<TokenModel> tokenModel) async {
    List loginModelsToJson = tokenModel
        .map<Map<String, dynamic>>((token) => token.toJson())
        .toList();
    sharedPreferences.setString(CACHED_LOGIN, json.encode(loginModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<TokenModel>> getCachedLogin() {
    final jsonString = sharedPreferences.getString(CACHED_LOGIN);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<TokenModel> jsonToTokenModels = decodeJsonData
          .map<TokenModel>(
              (jsonTokenModel) => TokenModel.fromJson(jsonTokenModel))
          .toList();
      return Future.value(jsonToTokenModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
