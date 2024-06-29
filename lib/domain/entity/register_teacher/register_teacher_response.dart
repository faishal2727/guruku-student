import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/register_teacher/dataku_response.dart';

class RegisterTeacherResponse extends Equatable {
  final int code;
  final bool error;
  final String status;
  final DatakuResponse data;

  const RegisterTeacherResponse(
      {required this.code,
      required this.error,
      required this.status,
      required this.data});

  @override
  List<Object?> get props => [
        code,
        error,
        status,
        data,
      ];
}
