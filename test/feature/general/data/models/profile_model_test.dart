import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/features/general/data/models/profile_model.dart';
import 'package:login_app/features/general/domain/entities/profile_entity.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const tProfileModel = ProfileModel(
      name: 'salah',
      profile: 'contrôle',
      zone: 'marshane',
      controlSector: 'Rabat - Temara');

  test('should be a subclass of profile entity', () async {
    // assert
    expect(tProfileModel, isA<ProfileEntity>());
  });

  test('should return a valid model from json ', () async {
    // arrange
    Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_profile_response.json'));
    // act
    final result = ProfileModel.fromJson(jsonMap);
    // assert
    expect(result, equals(tProfileModel));
  });

  test('should return a json map containing the proper data', () async {
    // act
    final result = tProfileModel.toJson();
    // assert
    final expectedJsonMap = {
      "name": "salah",
      "profile": "contrôle",
      "zone": "marshane",
      "controlSector": "Rabat - Temara",
    };
    expect(result, expectedJsonMap);
  });
}
