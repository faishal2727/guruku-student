// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/schedule_model.dart'; // Import model ScheduleModel
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';

class TeacherDetailModel extends Equatable {
  int id;
  String? username;
  String? name;
  String? email;
  String? avatar;
  String? picture;
  String? phone;
  List<ScheduleModel> schedule; // Menggunakan ScheduleModel
  String? typeTeaching;
  String? price;
  String? description;
  String? timeExperience;
  String? education;
  String? lat;
  String? lon;
  String? address;

  TeacherDetailModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.avatar,
    required this.picture,
    required this.phone,
    required this.schedule,
    required this.typeTeaching,
    required this.price,
    required this.description,
    required this.education,
    required this.lat,
    required this.lon,
    required this.address,
  });

  factory TeacherDetailModel.fromJson(Map<String, dynamic> json) {
    return TeacherDetailModel(
      id: json["data"]["id"],
      username: json["data"]["username"],
      name: json["data"]["name"],
      email: json["data"]["email"],
      avatar: json["data"]["avatar"],
      picture: json["data"]["picture"],
      phone: json["data"]["phone"],
      schedule: List<ScheduleModel>.from(
        json["data"]["schedule"].map((x) => ScheduleModel.fromJson(x))),
      typeTeaching: json["type_teaching"],
      price: json["data"]["price"],
      description: json["data"]["description"],
      education: json["data"]["education"],
      lat: json["data"]["lat"],
      lon: json["data"]["lon"],
      address: json["data"]["address"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
        "avatar": avatar,
        "picture": picture,
        "phone": phone,
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
        "type_teaching": typeTeaching,
        "price": price,
        "description": description,
        "time_experience": timeExperience,
        "education": education,
        "lat": lat,
        "lon": lon,
        "addess": address,
      };

  TeacherDetail toEntity() {
    return TeacherDetail(
      id: id,
      username: username,
      name: name,
      email: email,
      avatar: avatar,
      picture: picture,
      phone: phone,
      schedule: schedule.map((sche) => sche.toEntity()).toList(),
      typeTeaching: typeTeaching,
      price: price,
      description: description,
      timeExperience: timeExperience,
      education: education,
      lat: lat,
      lon: lon,
      address: address,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        email,
        avatar,
        picture,
        phone,
        schedule,
        typeTeaching,
        price,
        description,
        timeExperience,
        education,
        lat,
        lon,
        address,
      ];
}
