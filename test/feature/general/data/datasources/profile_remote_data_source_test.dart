import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/core/constant/constant.dart';
import 'package:login_app/core/error/exceptions.dart';
import 'package:login_app/features/general/data/datasources/profile_remote_data_source.dart';
import 'package:login_app/features/general/data/models/profile_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late MockHttpClient mockHttpClient;
  late ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });

  group('get profile', () {
    test('should return profile when the response code is 200', () {
      // arrange
      when(mockHttpClient.post(
        Uri.parse('$baseUrl/profile'), // Use the correct URL here
        headers: {
          'Authorization': 'JWT $globalToken'
        }, // Use the correct header format
      )).thenAnswer((_) async => http.Response(
          readJson('helpers/dummy_data/dummy_profile_response.json'), 200));
      // act
      final result = profileRemoteDataSourceImpl.getProfile();
      // assert
      expect(result, isA<Future<ProfileModel>>());
    });

    test(
        'should throw a server exception when the response code is 401 or other',
        () async {
      // arrange
      when(
        mockHttpClient.post(
          Uri.parse('$baseUrl/profile'),
          headers: {'Authorization': 'JWT $globalToken'},
        ),
      ).thenAnswer((_) async => http.Response('Not found', 401));
      // act
      final result = profileRemoteDataSourceImpl.getProfile();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
