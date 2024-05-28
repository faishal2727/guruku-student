import 'dart:convert';

import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/payment_response_model.dart';
import 'package:http/http.dart' as http;

abstract class PaymentRemoteDataSource {
  Future<PaymentReposneModel> doPayment({
    required int orderId,
    required int total,
    required String name,
  });
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final http.Client client;

  PaymentRemoteDataSourceImpl({required this.client});

  @override
  Future<PaymentReposneModel> doPayment(
      {required int orderId, required int total, required String name}) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:3010/v1/process-transaction'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'order_id': orderId,
        'total': total,
        'name': name,
      }),
    );
    if (response.statusCode == 200) {
      final result = PaymentReposneModel.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerException();
    }
  }
}
