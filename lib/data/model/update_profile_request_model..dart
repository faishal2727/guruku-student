// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_request.dart';

class UpdateProfileRequestModel extends Equatable {
  String username;
  String name;
  String email;
  String phone;
  String education;
  String address;
  DateTime bod;
  String lat;
  String lon;

  UpdateProfileRequestModel({
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

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequestModel(
        username: json["username"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        education: json["education"],
        address: json["address"],
        bod: json["bod"],
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "email": email,
        "phone": phone,
        "education": education,
        "address": address,
        "bod": bod.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };

  factory UpdateProfileRequestModel.fromEntity(UpdateProfileRequest data) =>
      UpdateProfileRequestModel(
        username: data.username,
        name: data.name,
        email: data.email,
        phone: data.phone,
        education: data.education,
        address: data.address,
        bod: data.bod,
        lat: data.lat,
        lon: data.lon,
      );
  UpdateProfileRequest toEntity() => UpdateProfileRequest(
        username: username,
        name: name,
        email: email,
        phone: phone,
        address: address,
        bod: bod,
        lat: lat,
        lon: lon,
        education: education,
      );

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
