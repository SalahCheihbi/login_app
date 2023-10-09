import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/core/constant/constant.dart';
import 'package:login_app/core/error/exceptions.dart';
import 'package:login_app/features/auth/data/datasources/login_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/features/auth/data/models/token_model.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late MockHttpClient mockHttpClient;
  late LoginRemoteDataSourceImpl loginRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    loginRemoteDataSourceImpl =
        LoginRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get login ', () {
    test('should return login model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.post(
        Uri.parse('$baseUrl/auth/sign_in'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: '{"email":"test@gmail.com","password":"test1234"}',
      )).thenAnswer((_) async => http.Response(
            readJson('helpers/dummy_data/dummy_token_response.json'),
            200,
          ));
      // act
      final result = await loginRemoteDataSourceImpl.getLogin(
          'test@gmail.com', 'test1234');
      // assert
      expect(result, isA<List<TokenModel>>());
    });
    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      // arrange
      when(
        mockHttpClient.post(
          Uri.parse('$baseUrl/auth/sign_in'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: '{"email":"test@gmail.com","password":"test1234"}',
        ),
      ).thenAnswer((_) async => http.Response('Not found', 404));
      // act
      final result =
          loginRemoteDataSourceImpl.getLogin('test@gmail.com', 'test1234');

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
