import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_app/core/constant/constant.dart';
import 'package:login_app/core/error/exceptions.dart';
import 'package:login_app/features/auth/data/models/token_model.dart';

abstract class LoginRemoteDataSource {
  Future<List<TokenModel>> getLogin(String email, String password);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TokenModel>> getLogin(String email, String password) async {
    final response = await client.post(
      Uri.parse("$baseUrl/auth/sign_in"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final token = TokenModel.fromJson(decodedJson);
      globalToken = token.token;
      return [token];
    } else {
      throw ServerException();
    }
  }
}
