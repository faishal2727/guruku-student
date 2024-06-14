import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/order/va_number.dart';

class Data extends Equatable {
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
  final List<VaNumber> vaNumber;
  final DateTime expiryTime;

  const Data({
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

// "data": {
//         "status_code": "201",
//         "status_message": "Success, Bank Transfer transaction is created",
//         "transaction_id": "fa2124bd-d0b4-479d-baa2-a254ad7c8a86",
//         "order_id": "1717764656910",
//         "merchant_id": "G653448562",
//         "gross_amount": "64500.00",
//         "currency": "IDR",
//         "payment_type": "bank_transfer",
//         "transaction_time": "2024-06-07 19:50:58",
//         "transaction_status": "pending",
//         "fraud_status": "accept",
//         "va_numbers": [
//             {
//                 "bank": "bni",
//                 "va_number": "9884856291795191"
//             }
//         ],
//         "expiry_time": "2024-06-07 21:15:58"
//     },
//     "else": "2024-05-31T14:00:00.000Z"