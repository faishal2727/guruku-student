import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/order/order_packages_request.dart';

class OrderPackagesRequestModel extends Equatable {
  final String onBehalf;
  final String email;
  final String phone;
  final int total;
  final String paymentType;
  final String bankVa;
  final int idTeacher;
  final String address; // Added attribute
  final String lat;
  final String lon;
  final String mapel;
  final String time;    // Modified attribute
  final int packageId;  // Added attribute

  const OrderPackagesRequestModel({
    required this.onBehalf,
    required this.email,
    required this.phone,
    required this.total,
    required this.paymentType,
    required this.bankVa,
    required this.idTeacher,
    required this.address, // Added attribute
    required this.lat,
    required this.lon,
    required this.mapel,
    required this.time,    // Modified attribute
    required this.packageId, // Added attribute
  });

  factory OrderPackagesRequestModel.fromJson(Map<String, dynamic> json) => OrderPackagesRequestModel(
        onBehalf: json['on_behalf'],
        email: json["email"],
        phone: json["phone"],
        total: json["total"],
        paymentType: json["payment_type"],
        bankVa: json["bank_va"],
        idTeacher: json["id_teacher"],
        address: json["address"], // Added attribute
        lat: json["lat"],
        lon: json["lon"],
        mapel: json["mapel"],
        time: json["time"], // Modified attribute
        packageId: json["package_id"], // Added attribute
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "on_behalf": onBehalf,
      "email": email,
      "phone": phone,
      "total": total,
      "payment_type": paymentType,
      "id_teacher": idTeacher,
      "address": address, // Added attribute
      "lat": lat,
      "lon": lon,
      "mapel": mapel,
      "time": time, // Modified attribute
      "package_id": packageId, // Added attribute
    };

    if (paymentType == "cstore") {
      data["cstore"] = bankVa;
    } else {
      data["bank_va"] = bankVa;
    }

    return data;
  }

  factory OrderPackagesRequestModel.fromEntity(OrderPackagesRequest data) => OrderPackagesRequestModel(
        onBehalf: data.onBehalf,
        email: data.email,
        phone: data.phone,
        total: data.total,
        paymentType: data.paymentType,
        bankVa: data.bankVa,
        idTeacher: data.idTeacher,
        address: data.address, // Added attribute
        lat: data.lat,
        lon: data.lon,
        mapel: data.mapel,
        time: data.time, // Modified attribute
        packageId: data.packageId, // Added attribute
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
        address, // Added attribute
        lat,
        lon,
        mapel,
        time, // Modified attribute
        packageId, // Added attribute
      ];
}
