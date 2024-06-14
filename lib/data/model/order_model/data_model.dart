import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/order_model/va_number_model.dart';
import 'package:guruku_student/domain/entity/order/data.dart';

class DataModel extends Equatable {
  final String statusCode;
  final String statusMessage;
  final String orderId;
  final String merchantId;
  final String grossAmount;
  final String currency;
  final String paymentType;
  final DateTime transactionTime;
  final String transactionStatus;
  final String fraudStatus;
  final List<VaNumberModel> vaNumber;
  final DateTime expiryTime;

  const DataModel({
    required this.statusCode,
    required this.statusMessage,
    required this.orderId,
    required this.merchantId,
    required this.grossAmount,
    required this.currency,
    required this.paymentType,
    required this.transactionTime,
    required this.transactionStatus,
    required this.fraudStatus,
    required this.vaNumber,
    required this.expiryTime,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        orderId: json["order_id"],
        merchantId: json["merchant_id"],
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        paymentType: json["payment_type"],
        transactionTime: DateTime.parse(json["transaction_time"]),
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        vaNumber: List<VaNumberModel>.from(
            (json["va_numbers"] as List).map((x) => VaNumberModel.fromJson(x))),
        expiryTime: DateTime.parse(json["expiry_time"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "order_id": orderId,
        "merchant_id": merchantId,
        "gross_amount": grossAmount,
        "currency": currency,
        "payment_type": paymentType,
        "transaction_time": transactionTime.toIso8601String(),
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "va_numbers": List<dynamic>.from(vaNumber.map((x) => x.toJson())),
        "expiry_time": expiryTime.toIso8601String(),
      };

  Data toEntity() => Data(
        statusCode: statusCode,
        statusMessage: statusMessage,
        orderId: orderId,
        merchantId: merchantId,
        grossAmount: grossAmount,
        currency: currency,
        paymentType: paymentType,
        transactionTime: transactionTime,
        transactionStatus: transactionStatus,
        fraudStatus: fraudStatus,
        vaNumber: vaNumber.map((va) => va.toEntity()).toList(),
        expiryTime: expiryTime,
      );

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
        orderId,
        merchantId,
        grossAmount,
        currency,
        paymentType,
        transactionTime,
        transactionStatus,
        fraudStatus,
        vaNumber,
        expiryTime,
      ];
}
