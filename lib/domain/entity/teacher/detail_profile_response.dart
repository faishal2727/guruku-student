// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class DetailProfileResponse extends Equatable {
  int? id;
  String? username;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? education;
  String? images;
  String? bod;
  String? address;
  String? lat;
  String? lon;
  String? gender;

  DetailProfileResponse({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.education,
    required this.images,
    required this.bod,
    required this.address,
    required this.lat,
    required this.lon,
    required this.gender,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        email,
        password,
        phone,
        education,
        images,
        bod,
        address,
        lat,
        lon,
        gender,
      ];
}
