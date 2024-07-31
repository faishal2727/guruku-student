// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/profile_model/student_model.dart';
import 'package:guruku_student/data/model/schedule_model.dart';
import 'package:guruku_student/data/model/teacher_model/histories_model.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';

class TeacherDetailModel extends Equatable {
  int id;
  String? username;
  String? name;
  String? email;
  String? avatar;
  String? picture;
  String? phone;
  List<ScheduleModel>? schedule;
  List<String>? typeTeaching;
  String? price;
  String? description;
  String? timeExperience;
  String? education;
  String? lat;
  String? lon;
  String? address;
  String? rate;
  List<HistoriesModel> histories;
  int? userId;
  StudentModel? student;
  String? gelar;
  String? jurusan;
  String? tahunLulus;
  String? balance;
  List<String>? skill;

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
    required this.timeExperience,
    required this.education,
    required this.lat,
    required this.lon,
    required this.address,
    required this.rate,
    required this.histories,
    required this.userId,
    required this.student,
    required this.gelar,
    required this.jurusan,
    required this.tahunLulus,
    required this.balance,
    required this.skill,
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
      schedule: json["data"]["schedule"] != null
          ? List<ScheduleModel>.from(
              json["data"]["schedule"].map((x) => ScheduleModel.fromJson(x)))
          : null,
      typeTeaching: json["data"]["type_teaching"] is List
          ? List<String>.from(json["data"]["type_teaching"])
          : json["data"]["type_teaching"] is String
              ? [json["data"]["type_teaching"]]
              : [],
      price: json["data"]["price"],
      description: json["data"]["description"],
      timeExperience: json["data"]["time_experience"],
      education: json["data"]["education"],
      lat: json["data"]["lat"],
      lon: json["data"]["lon"],
      address: json["data"]["address"],
      rate: json["data"]["rate"],
      histories: List<HistoriesModel>.from(
          json["data"]["histories"].map((x) => HistoriesModel.fromJson(x))),
      userId: json["data"]["user_id"],
      student: json["data"]["student"] != null
          ? StudentModel.fromJson(json["data"]["student"])
          : StudentModel.defaultInstance(),
      gelar: json["data"]["gelar"],
      jurusan: json["data"]["jurusan"],
      tahunLulus: json["data"]["tahun_lulus"],
      balance: json["data"]["balance"],
      skill: json["data"]["skill"] is List
          ? List<String>.from(json["data"]["skill"])
          : json["data"]["skill"] is String
              ? [json["data"]["skill"]]
              : [],
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
        "rate": rate,
        "histories": List<dynamic>.from(histories.map((x) => x.toJson())),
        "user_id": userId,
        "student": student?.toJson(),
        "gelar": gelar,
        "jurusan": jurusan,
        "tahun_lulus": tahunLulus,
        "balance": balance,
        "skill": skill,
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
      rate: rate,
      histories: histories.map((hist) => hist.toEntity()).toList(),
      userId: userId,
      student: student?.toEntity(),
      gelar: gelar,
      jurusan: jurusan,
      tahunLulus: tahunLulus,
      balance: balance,
      skill: skill,
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
        rate,
        userId,
        student,
        gelar,
        jurusan,
        tahunLulus,
        balance,
        skill,
      ];
}
