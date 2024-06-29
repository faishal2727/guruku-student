import 'package:equatable/equatable.dart';

class DataReview extends Equatable {
  final int id;
  final String rate;
  final String desc;
  final String? detail;
  final int idStudent;
  final int idTeacher;

  const DataReview({
    required this.id,
    required this.rate,
    required this.desc,
    required this.detail,
    required this.idStudent,
    required this.idTeacher,
  });

  @override
  List<Object?> get props => [
        id,
        rate,
        desc,
        detail,
        idStudent,
        idTeacher,
      ];
}
