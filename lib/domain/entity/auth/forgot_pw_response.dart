import 'package:equatable/equatable.dart';

class ForgotPwResponse extends Equatable {
  final String status;

  const ForgotPwResponse({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
