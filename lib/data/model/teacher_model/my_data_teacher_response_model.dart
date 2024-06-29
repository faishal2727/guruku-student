// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/teacher_model/my_schedule_model.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';

class MyDataTeacherResponseModel extends Equatable {
  int id;
  String? username;
  String? name;
  String? email;
  String? avatar;
  String? picture;
  String? phone;
  List<MyScheduleModel>? schedule;
  String? typeTeaching;
  String? price;
  String? description;
  String? timeExperience;
  String? education;
  String? lat;
  String? lon;
  String? address;
  int? userId;

  MyDataTeacherResponseModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.avatar,
    required this.picture,
    required this.phone,
    this.schedule,
    required this.typeTeaching,
    required this.price,
    required this.description,
    required this.timeExperience,
    required this.education,
    required this.lat,
    required this.lon,
    required this.address,
    required this.userId,
  });
  factory MyDataTeacherResponseModel.fromJson(Map<String, dynamic> json) {
    return MyDataTeacherResponseModel(
      id: json["data"]["id"],
      username: json["data"]["username"],
      name: json["data"]["name"],
      email: json["data"]["email"],
      avatar: json["data"]["avatar"],
      picture: json["data"]["picture"],
      phone: json["data"]["phone"],
      schedule: json["data"]["schedule"] != null
          ? List<MyScheduleModel>.from(
              json["data"]["schedule"].map((x) => MyScheduleModel.fromJson(x)))
          : null,
      typeTeaching: json["data"]["type_teaching"],
      price: json["data"]["price"],
      description: json["data"]["description"],
      timeExperience: json["data"]["time_experience"],
      education: json["data"]["education"],
      lat: json["data"]["lat"],
      lon: json["data"]["lon"],
      address: json["data"]["address"],
      userId: json["data"]["user_id"],
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
        "schedule": schedule != null
            ? List<dynamic>.from(schedule!.map((x) => x.toJson()))
            : null,
        "type_teaching": typeTeaching,
        "price": price,
        "description": description,
        "time_experience": timeExperience,
        "education": education,
        "lat": lat,
        "lon": lon,
        "addess": address,
        "user_id": userId,
      };

  MyDataTeacherResponse toEntity() {
    return MyDataTeacherResponse(
      id: id,
      username: username,
      name: name,
      email: email,
      avatar: avatar,
      picture: picture,
      phone: phone,
      schedule: schedule != null
          ? schedule!.map((sche) => sche.toEntity()).toList()
          : [],
      typeTeaching: typeTeaching,
      price: price,
      description: description,
      timeExperience: timeExperience,
      education: education,
      lat: lat,
      lon: lon,
      address: address,
      userId: userId,
    );
  }

  factory MyDataTeacherResponseModel.fromEntity(MyDataTeacherResponse entity) {
  return MyDataTeacherResponseModel(
    id: entity.id,
    username: entity.username,
    name: entity.name,
    email: entity.email,
    avatar: entity.avatar,
    picture: entity.picture,
    phone: entity.phone,
    schedule: entity.schedule?.map((sche) => MyScheduleModel.fromEntity(sche)).toList(),
    typeTeaching: entity.typeTeaching,
    price: entity.price,
    description: entity.description,
    timeExperience: entity.timeExperience,
    education: entity.education,
    lat: entity.lat,
    lon: entity.lon,
    address: entity.address,
    userId: entity.userId,
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
        userId,
      ];
}
