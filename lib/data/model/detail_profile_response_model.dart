// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';

class DetailProfileResponseModel extends Equatable {
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

  DetailProfileResponseModel({
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

  factory DetailProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      DetailProfileResponseModel(
        id: json['data']['id'],
        username: json['data']['username'],
        name: json['data']['name'],
        email: json['data']['email'],
        password: json['data']['password'],
        phone: json['data']['phone'],
        education: json['data']['education'],
        images: json['data']['images'],
        bod: json['data']['bod'],
        address: json['data']['address'],
        lat: json['data']['lat'],
        lon: json['data']['lon'],
        gender: json['data']['gender'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'education': education,
        'images': images,
        'bod': bod,
        'address': address,
        'lat': lat,
        'lon': lon,
        'gender': gender,
      };

  DetailProfileResponse toEntity() {
    return DetailProfileResponse(
      id: id,
      username: username,
      name: name,
      email: email,
      password: password,
      phone: phone,
      education: education,
      images: images,
      bod: bod,
      address: address,
      lat: lat,
      lon: lon,
      gender: gender,
    );
  }

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



  // factory DetailProfileResponseModel.fromEntity(DetailProfileResponse data) =>
  //     DetailProfileResponseModel(
  //       id: data.id,
  //       username: data.username,
  //       name: data.name,
  //       email: data.email,
  //       password: data.password,
  //       phone: data.phone,
  //       education: data.education,
  //       images: data.images,
  //       bod: data.bod,
  //       address: data.address,
  //       lat: data.lat,
  //       lon: data.lon,
  //       gender: data.gender,
  //     );
