import 'package:equatable/equatable.dart';

class ReviewRequest extends Equatable {
  final int idTeacher;
  final int idOrder;
  final String rate;
  final String desc;
  final String detail;

  const ReviewRequest({
    required this.idTeacher,
    required this.idOrder,
    required this.rate,
    required this.desc,
    required this.detail,
  });

  @override
  List<Object?> get props => [
        idTeacher,
        idOrder,
        rate,
        desc,
        detail,
      ];
}
