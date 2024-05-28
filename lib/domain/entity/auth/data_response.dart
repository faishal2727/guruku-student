import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class DataResponse extends Equatable {
  String email;
  String otp;

  DataResponse({
    required this.email,
    required this.otp,
  });

  @override
  List<Object?> get props => [
        email,
        otp,
      ];
}
