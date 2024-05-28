import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/data_response.dart';

class RefreshOtpResponse extends Equatable {
  final String status;
  final DataResponse data;

  const RefreshOtpResponse({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}
