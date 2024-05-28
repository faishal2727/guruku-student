import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/data_response_model.dart';
import 'package:guruku_student/domain/entity/auth/req_forgot_pw_response.dart';

class ReqForgotPwResponseModel extends Equatable {
  final String status;
  final DataResponseModel data;

  const ReqForgotPwResponseModel({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data.toJson(),
      };

  factory ReqForgotPwResponseModel.fromJson(Map<String, dynamic> json) =>
      ReqForgotPwResponseModel(
        status: json['status'],
        data: DataResponseModel.fromJson(
          json["data"],
        ),
      );

  ReqForgotPwResponse toEntity() => ReqForgotPwResponse(
        status: status,
        data: data.toEntity(),
      );

  factory ReqForgotPwResponseModel.fromEntity(ReqForgotPwResponse data) =>
      ReqForgotPwResponseModel(
        status: data.status,
        data: DataResponseModel.fromEntity(data.data),
      );

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}
