
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/schedule_model.dart';
import 'package:guruku_student/domain/entity/register_teacher/dataku_response.dart';

class Dataku extends Equatable {
  int id;
  String? username;
  String? name;
  String? email;
  String? avatar;
  String? picture;
  String? phone;
  List<ScheduleModel>? schedule;
  String? typeTeaching;
  String? price;
  String? description;
  String? timeExperience;
  String? education;
  String? lat;
  String? lon;
  String? address;
  int? userId;

  Dataku({
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
  factory Dataku.fromJson(Map<String, dynamic> json) {
    return Dataku(
      id: json["id"],
      username: json["username"],
      name: json["name"],
      email: json["email"],
      avatar: json["avatar"],
      picture: json["picture"],
      phone: json["phone"],
      schedule: json["schedule"] != null
          ? List<ScheduleModel>.from(
              json["schedule"].map((x) => ScheduleModel.fromJson(x)))
          : null,
      typeTeaching: json["type_teaching"],
      price: json["price"],
      description: json["description"],
      timeExperience: json["time_experience"],
      education: json["education"],
      lat: json["lat"],
      lon: json["lon"],
      address: json["address"],
      userId: json["user_id"],
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

  DatakuResponse toEntity() {
    return DatakuResponse(
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

  factory Dataku.fromEntity(DatakuResponse entity) {
  return Dataku(
    id: entity.id,
    username: entity.username,
    name: entity.name,
    email: entity.email,
    avatar: entity.avatar,
    picture: entity.picture,
    phone: entity.phone,
    schedule: entity.schedule?.map((sche) => ScheduleModel.fromEntity(sche)).toList(),
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
