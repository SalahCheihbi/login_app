import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/features/auth/data/models/login_model.dart';
import 'package:login_app/features/auth/domain/entities/login_entity.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const tLoginModel = LoginModel(
    email: 'test@gmail.com',
    password: 'test1234',
  );
  test('should be a subclass of login entity', () async {
    // assert
    expect(tLoginModel, isA<LoginEntity>());
  });

  test('should return a valid model from json ', () async {
    // arrange
    Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_login_response.json'));
    // act
    final result = LoginModel.fromJson(jsonMap);
    // assert
    expect(result, equals(tLoginModel));
  });

  test('should return a json map containing the proper data', () async {
    // act
    final result = tLoginModel.toJson();
    // assert
    final expectedJsonMap = {"email": "test@gmail.com", "password": "test1234"};
    expect(result, expectedJsonMap);
  });
}
