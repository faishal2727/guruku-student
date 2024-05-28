import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/data_response.dart';

class ReqForgotPwResponse extends Equatable {
  final String status;
  final DataResponse data;

  const ReqForgotPwResponse({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}
