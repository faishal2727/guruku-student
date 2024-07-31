import 'package:equatable/equatable.dart';

class PackagesResponse extends Equatable {
  final int code;
  final bool error;
  final String message;
  
  const PackagesResponse({
    required this.code,
    required this.error,
    required this.message,
  });

  @override
  List<Object?> get props => [
        code,
        error,
        message,
      ];
}
