import 'package:equatable/equatable.dart';

class OrderRequest extends Equatable {
  final String onBehalf;
  final String email;
  final String phone;
  final int total;
  final String paymentType;
  final String bankVa;
  final int idTeacher;
  final DateTime meetingDate;
  final String meetingTime;
  final String note;

  const OrderRequest({
    required this.onBehalf,
    required this.email,
    required this.phone,
    required this.total,
    required this.paymentType,
    required this.bankVa,
    required this.idTeacher,
    required this.meetingDate,
    required this.meetingTime,
    required this.note,
  });
  
  @override
  List<Object?> get props => [
    onBehalf,
    email,
    phone,
    total,
    paymentType,
    bankVa,
    idTeacher,
    meetingDate,
    meetingTime,
    note,
  ];
}
