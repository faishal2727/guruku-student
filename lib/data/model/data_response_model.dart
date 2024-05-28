import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/data_response.dart';

class DataResponseModel extends Equatable {
  final String email;
  final String otp;

  const DataResponseModel({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
      };

  factory DataResponseModel.fromJson(Map<String, dynamic> json) =>
      DataResponseModel(
        email: json['email'],
        otp: json['otp'],
      );

  DataResponse toEntity() => DataResponse(
        email: email,
        otp: otp,
      );

  factory DataResponseModel.fromEntity(DataResponse data) => DataResponseModel(
        email: data.email,
        otp: data.otp,
      );

  @override
  List<Object?> get props => [
        email,
        otp,
      ];
}
