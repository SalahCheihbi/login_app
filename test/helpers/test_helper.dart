import 'package:http/http.dart' as http;
import 'package:login_app/core/network/network_info.dart';
import 'package:login_app/features/auth/data/datasources/login_local_data_source.dart';
import 'package:login_app/features/auth/data/datasources/login_remote_data_source.dart';
import 'package:login_app/features/auth/domain/repository/login_repository.dart';
import 'package:login_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:login_app/features/general/data/datasources/profile_local_data_source.dart';
import 'package:login_app/features/general/data/datasources/profile_remote_data_source.dart';
import 'package:login_app/features/general/domain/repository/profile_repository.dart';
import 'package:login_app/features/general/domain/usercase/get_profile.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  LoginRepository,
  LoginRemoteDataSource,
  LoginUseCase,
  NetWorkInfo,
  LoginLocalDataSource,
  ProfileRepository,
  ProfileLocalDataSource,
  ProfileRemoteDataSource,
  GetProfileUseCase
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
