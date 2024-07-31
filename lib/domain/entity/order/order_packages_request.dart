import 'package:equatable/equatable.dart';

class OrderPackagesRequest extends Equatable {
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

  const OrderPackagesRequest({
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

  @override
  List<Object?> get props => [
        onBehalf,
        email,
        phone,
        total,
        paymentType,
        bankVa,
        idTeacher,
        address,
        lat,
        lon,
        mapel,
        time,
        packageId,
      ];
}
