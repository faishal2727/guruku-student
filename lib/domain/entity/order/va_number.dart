import 'package:equatable/equatable.dart';

class VaNumber extends Equatable {
  final String bank;
  final String vaNumber;

  const VaNumber({
    required this.bank,
    required this.vaNumber,
  });

  @override
  List<Object?> get props => [
        bank,
        vaNumber,
      ];
}
