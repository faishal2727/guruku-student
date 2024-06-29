import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/order_model/va_number_model.dart';
import 'package:guruku_student/domain/entity/order/data.dart';

class DataModel extends Equatable {
  final String statusCode;
  final String statusMessage;
  final String transactionId;
  final String orderId;
  final String merchantId;
  final String grossAmount;
  final String currency;
  final String paymentType;
  final DateTime transactionTime;
  final String transactionStatus;
  final String fraudStatus;
  final List<VaNumberModel>? vaNumber; // Optional field
  final DateTime expiryTime;
  final String? paymentCode; // Optional field for cstore
  final String? store; // Optional field for cstore

  const DataModel({
    required this.statusCode,
    required this.statusMessage,
    required this.transactionId,
    required this.orderId,
    required this.merchantId,
    required this.grossAmount,
    required this.currency,
    required this.paymentType,
    required this.transactionTime,
    required this.transactionStatus,
    required this.fraudStatus,
    this.vaNumber, // Optional field
    required this.expiryTime,
    this.paymentCode, // Optional field for cstore
    this.store, // Optional field for cstore
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        transactionId: json["transaction_id"],
        orderId: json["order_id"],
        merchantId: json["merchant_id"],
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        paymentType: json["payment_type"],
        transactionTime: DateTime.parse(json["transaction_time"]),
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        vaNumber: json["va_numbers"] != null
            ? List<VaNumberModel>.from(
                (json["va_numbers"] as List)
                    .map((x) => VaNumberModel.fromJson(x)))
            : null, // Handle optional field
        expiryTime: DateTime.parse(json["expiry_time"]),
        paymentCode: json["payment_code"], // Handle optional field for cstore
        store: json["store"], // Handle optional field for cstore
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "transaction_id": transactionId,
        "order_id": orderId,
        "merchant_id": merchantId,
        "gross_amount": grossAmount,
        "currency": currency,
        "payment_type": paymentType,
        "transaction_time": transactionTime.toIso8601String(),
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "va_numbers": vaNumber != null
            ? List<dynamic>.from(vaNumber!.map((x) => x.toJson()))
            : null, // Handle optional field
        "expiry_time": expiryTime.toIso8601String(),
        "payment_code": paymentCode, // Handle optional field for cstore
        "store": store, // Handle optional field for cstore
      };

  Data toEntity() => Data(
        statusCode: statusCode,
        statusMessage: statusMessage,
        transactionId: transactionId,
        orderId: orderId,
        merchantId: merchantId,
        grossAmount: grossAmount,
        currency: currency,
        paymentType: paymentType,
        transactionTime: transactionTime,
        transactionStatus: transactionStatus,
        fraudStatus: fraudStatus,
        vaNumber: vaNumber?.map((va) => va.toEntity()).toList(),
        expiryTime: expiryTime,
        paymentCode: paymentCode, // Handle optional field for cstore
        store: store, // Handle optional field for cstore
      );

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
        transactionId,
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
        paymentCode,
        store,
      ];
}
