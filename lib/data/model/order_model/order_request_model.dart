import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/order/order_request.dart';

class OrderRequestModel extends Equatable {
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

  const OrderRequestModel({
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

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) =>
      OrderRequestModel(
        onBehalf: json['onBehalf'],
        email: json["email"],
        phone: json["phone"],
        total: json["total"],
        paymentType: json["payment_type"],
        bankVa: json["bank_va"],
        idTeacher: json["id_teacher"],
        meetingDate: DateTime.parse(json["meeting_date"]),
        meetingTime: json["meeting_time"],
        note: json["note"],
        lat: json["lat"],
        lon: json["lon"],
        mapel: json["mapel"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "onBehalf": onBehalf,
      "email": email,
      "phone": phone,
      "total": total,
      "payment_type": paymentType,
      "id_teacher": idTeacher,
      'meeting_date': meetingDate.toIso8601String(),
      "meeting_time": meetingTime,
      "note": note,
      "lat": lat,
      "lon": lon,
      "mapel": mapel,
    };

    if (paymentType == "cstore") {
      data["cstore"] = bankVa;
    } else {
      data["bank_va"] = bankVa;
    }

    return data;
  }

  factory OrderRequestModel.fromEntity(OrderRequest data) => OrderRequestModel(
        onBehalf: data.onBehalf,
        email: data.email,
        phone: data.phone,
        total: data.total,
        paymentType: data.paymentType,
        bankVa: data.bankVa,
        idTeacher: data.idTeacher,
        meetingDate: data.meetingDate,
        meetingTime: data.meetingTime,
        note: data.note,
        lat: data.lat,
        lon: data.lon,
        mapel: data.mapel,
      );

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
        lat,
        lon,
        mapel,
      ];
}
