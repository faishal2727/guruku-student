// ignore_for_file: must_be_immutable

part of 'add_data_teacher_bloc.dart';

abstract class AddDataTeacherEvent extends Equatable {
  const AddDataTeacherEvent();
  @override
  List<Object> get props => [];
}

class OnPickSchedule extends AddDataTeacherEvent {
  List<Map<String, dynamic>> schedule;

   OnPickSchedule({
    required this.schedule,
  });
  @override
  List<Object> get props => [schedule];
}

class OnAddDataTeacher extends AddDataTeacherEvent {
  final String picture;
  final String name;
  final String desc;
  final String typeTeaching;
  final String price;
  final String timeExperience;
  final String lat;
  final String lon;
  final String address;

  const OnAddDataTeacher({
    required this.picture,
    required this.name,
    required this.desc,
    required this.typeTeaching,
    required this.price,
    required this.timeExperience,
    required this.lat,
    required this.lon,
    required this.address,
  });

  @override
  List<Object> get props => [
        picture,
        name,
        desc,
        typeTeaching,
        price,
        timeExperience,
        lat,
        lon,
        address,
      ];
}
