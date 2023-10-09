import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/exceptions.dart';
import 'package:login_app/features/general/data/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileModel> getCachedProfile();
  Future<Unit> cachedProfile(List<ProfileModel> profileModel);
}

const CACHED_PROFILE = "CACHED_PROFILE";

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProfileLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachedProfile(List<ProfileModel> profileModel) {
    List profileModelToJson =
        profileModel.map((profile) => profile.toJson()).toList();
    sharedPreferences.setString(
        CACHED_PROFILE, json.encode(profileModelToJson));
    return Future.value(unit);
  }

  @override
  Future<ProfileModel> getCachedProfile() {
    final jsonString = sharedPreferences.getString(CACHED_PROFILE);
    if (jsonString != null) {
      var decodeJsonData = json.decode(jsonString);

      return decodeJsonData;
    } else {
      throw EmptyCacheException();
    }
  }
}
