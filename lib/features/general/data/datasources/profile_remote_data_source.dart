import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_app/core/constant/constant.dart';
import 'package:login_app/core/error/exceptions.dart';
import 'package:login_app/features/general/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<ProfileModel> getProfile() async {
    final response = await client.post(
      Uri.parse("$baseUrl/profile"),
      headers: {'Authorization': 'JWT $globalToken'},
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      return ProfileModel.fromJson(decodedJson);
    } else {
      throw ServerException();
    }
  }
}
