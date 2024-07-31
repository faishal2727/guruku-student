part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class DoCancel extends OrderEvent {
  final String code;

  const DoCancel({
    required this.code,
  });
}

class DoOrder extends OrderEvent {
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
  final String lat;
  final String lon;
  final String mapel;

  const DoOrder({
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
    required this.lat,
    required this.lon,
    required this.mapel,
  });
}

class DoOrderPackages extends OrderEvent {
  final String onBehalf;
  final String email;
  final String phone;
  final int total;
  final String paymentType;
  final String bankVa;
  final int idTeacher;
  final String address;
  final String lat;
  final String lon;
  final String mapel;
  final String time;
  final int packageId;

  const DoOrderPackages({
    required this.onBehalf,
    required this.email,
    required this.phone,
    required this.total,
    required this.paymentType,
    required this.bankVa,
    required this.idTeacher,
    required this.address,
    required this.lat,
    required this.lon,
    required this.mapel,
    required this.time,
    required this.packageId,
  });
}
