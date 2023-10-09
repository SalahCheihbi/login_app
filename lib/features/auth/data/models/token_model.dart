import 'package:login_app/features/auth/domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  const TokenModel({required super.token});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json["token"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }
}
