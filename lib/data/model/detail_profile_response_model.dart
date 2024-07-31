// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';
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
  String? role;
  String? balanceUser;
  int? teacherId;
  String? status;
  TeacherModel? teacher;

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
    required this.role,
    required this.balanceUser,
    required this.teacherId,
    required this.status,
    this.teacher,
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
        role: json['data']['role'],
        balanceUser: json["data"]["balance_user"],
        teacherId: json['data']['teacher_id'],
        status: json['data']['status'],
        teacher: json['data']['data'] != null
            ? TeacherModel.fromJson(json['data']['data'])
            : null,
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
        'role': role,
        'balance_user': balanceUser,
        'teacher_id': teacherId,
        'status': status,
        'data': teacher?.toJson()
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
        role: role,
        balanceUser: balanceUser,
        teacherId: teacherId,
        status: status,
        teacher: teacher?.toEntity());
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
        role,
        balanceUser,
        teacherId,
        status,
        teacher,
      ];
}

