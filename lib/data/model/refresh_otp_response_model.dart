import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/data_response_model.dart';
import 'package:guruku_student/domain/entity/auth/refresh_otp.dart';

class RefreshOtpResponseModel extends Equatable {
  final String status;
  final DataResponseModel data;

  const RefreshOtpResponseModel({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data.toJson(),
      };

  factory RefreshOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      RefreshOtpResponseModel(
        status: json['status'],
        data: DataResponseModel.fromJson(
          json['data'],
        ),
      );

  RefreshOtpResponse toEntity() => RefreshOtpResponse(
        status: status,
        data: data.toEntity(),
      );

  factory RefreshOtpResponseModel.fromEntity(RefreshOtpResponse data) =>
      RefreshOtpResponseModel(
        status: data.status,
        data: DataResponseModel.fromEntity(data.data),
      );

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}
