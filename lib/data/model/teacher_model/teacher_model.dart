// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';

class TeacherModel extends Equatable {
  int id;
  String? username;
  String? name;
  String? email;
  String? avatar;
  String? picture;
  String? phone;
  String? typeTeaching;
  String? price;
  String? description;
  String? timeExperience;
  String? education;
  String? lat;
  String? lon;
  String? addess;
  String? rate;
  bool? isTeacher;
  String? balance;
  double? distance;
 

  TeacherModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.avatar,
    required this.picture,
    required this.phone,
    required this.typeTeaching,
    required this.price,
    required this.description,
    required this.timeExperience,
    required this.education,
    required this.lat,
    required this.lon,
    required this.addess,
    required this.rate,
    required this.isTeacher,
    required this.balance,
    required this.distance,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        picture: json["picture"],
        phone: json["phone"],
        typeTeaching: json["type_teaching"],
        price: json["price"],
        description: json["description"],
        timeExperience: json["time_experience"],
        education: json["education"],
        lat: json["lat"],
        lon: json["lon"],
        addess: json["address"],
        rate: json["rate"],
        isTeacher: json["is_teacher"],
        balance: json["balance"],
        distance: json["distance"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
        "avatar": avatar,
        "picture": picture,
        "phone": phone,
        "type_teaching": typeTeaching,
        "price": price,
        "description": description,
        "time_experience": timeExperience,
        "education": education,
        "lat": lat,
        "lon": lon,
        "address": addess,
        "rate":rate,
        "is_teacher": isTeacher,
        "balance": balance,
        "distance": distance,
      };

  Teacher toEntity() {
    return Teacher(
      id: id,
      username: username,
      name: name,
      email: email,
      avatar: avatar,
      picture: picture,
      phone: phone,
      typeTeaching: typeTeaching,
      price: price,
      description: description,
      timeExperience: timeExperience,
      education: education,
      lat: lat,
      lon: lon,
      addess: addess,
      rate: rate,
      isTeacher: isTeacher,
      balance: balance,
      distance: distance,
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
        typeTeaching,
        price,
        description,
        timeExperience,
        education,
        lat,
        lon,
        rate,
        addess,
        distance,
      ];
}
