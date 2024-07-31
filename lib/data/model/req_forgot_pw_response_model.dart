import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/req_forgot_pw_response.dart';

class ReqForgotPwResponseModel extends Equatable {
  final String message;

  const ReqForgotPwResponseModel({
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'message': message,
      };

  factory ReqForgotPwResponseModel.fromJson(Map<String, dynamic> json) =>
      ReqForgotPwResponseModel(
        message: json['message'],
      );

  ReqForgotPwResponse toEntity() => ReqForgotPwResponse(
        message: message,
      );

  factory ReqForgotPwResponseModel.fromEntity(ReqForgotPwResponse data) =>
      ReqForgotPwResponseModel(
        message: data.message,
      );

  @override
  List<Object?> get props => [
        message,
      ];
}
