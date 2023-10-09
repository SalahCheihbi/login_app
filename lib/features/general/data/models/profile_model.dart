import 'package:login_app/features/general/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel(
      {required super.name,
      required super.profile,
      required super.zone,
      required super.controlSector});
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      profile: json['profile'],
      zone: json['zone'],
      controlSector: json['controlSector'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile': profile,
      'zone': zone,
      'controlSector': controlSector,
    };
  }
}
