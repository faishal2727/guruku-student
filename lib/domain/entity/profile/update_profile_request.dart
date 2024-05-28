import 'package:equatable/equatable.dart';

class UpdateProfileRequest extends Equatable {
  final String username;
  final String name;
  final String email;
  final String phone;
  final String education;
  final String address;
  final DateTime bod;
  final String lat;
  final String lon;

  const UpdateProfileRequest({
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.education,
    required this.address,
    required this.bod,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [
        username,
        name,
        email,
        phone,
        education,
        address,
        bod,
        lat,
        lon,
      ];
}
