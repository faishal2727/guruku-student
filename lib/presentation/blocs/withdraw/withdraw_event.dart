part of 'withdraw_bloc.dart';

abstract class WithdrawEvent extends Equatable {
  const WithdrawEvent();

  @override
  List<Object> get props => [];
}

class ReqWd extends WithdrawEvent {
  final int idTeacher;
  final String amount;
  final String noBank;
  final String bankName;

  const ReqWd({
    required this.idTeacher,
    required this.amount,
    required this.noBank,
    required this.bankName,
  });

  @override
  List<Object> get props => [
        idTeacher,
        amount,
        noBank,
        bankName,
      ];
}

class OnListWdTeacher extends WithdrawEvent {
  final int idTeacher;

  const OnListWdTeacher({
    required this.idTeacher,
  });
  @override
  List<Object> get props => [idTeacher];
}

class OnListWdStudent extends WithdrawEvent {
  const OnListWdStudent();

  @override
  List<Object> get props => [];
}

class OnDetailWd extends WithdrawEvent {
  final int id;

  const OnDetailWd({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
