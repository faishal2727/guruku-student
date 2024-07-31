// // ignore_for_file: prefer_const_constructors_in_immutables

// import 'package:equatable/equatable.dart';
// import 'package:guruku_student/domain/entity/teacher/teacher.dart';
// import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';

// class TeacherTable extends Equatable {
//   final int id;
//   final String? name;
//   final String? avatar;
//   final String? price;
//   final String? address;
//   // final String? typeTeaching;

//   TeacherTable({
//     required this.id,
//     required this.name,
//     required this.avatar,
//     required this.price,
//     required this.address,
//     // required this.typeTeaching,
//   });

//   factory TeacherTable.fromEntity(TeacherDetail teacher) => TeacherTable(
//         id: teacher.id,
//         name: teacher.name,
//         avatar: teacher.avatar,
//         price: teacher.price,
//         address: teacher.address,
//         // typeTeaching: teacher.typeTeaching.toList(),
//       );

//   factory TeacherTable.fromMap(Map<String, dynamic> map) => TeacherTable(
//         id: map['id'],
//         name: map['name'],
//         avatar: map['avatar'],
//         price: map['price'],
//         address: map['address'],
//         // typeTeaching: map['type_teaching'],
//       );

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'avatar': avatar,
//         'price': price,
//         'address': address,
//         // 'type_teaching': typeTeaching,
//       };

//   Teacher toEntity() => Teacher.bookmark(
//         id: id,
//         name: name,
//         avatar: avatar,
//         addess: address,
//         price: price,
//         // typeTeaching: typeTeaching,
//       );

//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         avatar,
//         price,
//         address,
//         // typeTeaching,
//       ];
// }
