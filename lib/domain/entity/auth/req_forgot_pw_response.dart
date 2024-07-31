import 'package:equatable/equatable.dart';

class ReqForgotPwResponse extends Equatable {
  final String message;

  const ReqForgotPwResponse({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
