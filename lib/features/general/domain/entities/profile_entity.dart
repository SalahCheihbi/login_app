import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? name;
  final String? profile;
  final String? zone;
  final String? controlSector;

  const ProfileEntity(
      {required this.name,
      required this.profile,
      required this.zone,
      required this.controlSector});

  @override
  List<Object?> get props => [
        name,
        profile,
        zone,
        controlSector,
      ];
}
