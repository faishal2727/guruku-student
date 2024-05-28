import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/forgot_pw_response.dart';

class ForgotPwResponseModel extends Equatable {
  final String status;

  const ForgotPwResponseModel({
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
      };

  factory ForgotPwResponseModel.fromJson(Map<String, dynamic> json) =>
      ForgotPwResponseModel(
        status: json['status'],
      );

  ForgotPwResponse toEntity() => ForgotPwResponse(
        status: status,
      );

  factory ForgotPwResponseModel.fromEntity(ForgotPwResponse status) =>
      ForgotPwResponseModel(
        status: status.status,
      );

  @override
  List<Object?> get props => [
        status,
      ];
}
