import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/history_order/data_detail_history_order_model.dart';
import 'package:guruku_student/data/model/history_order/data_history_order_model.dart';
import 'package:guruku_student/data/model/history_order/history_order_response_model.dart';
import 'package:guruku_student/data/model/order_model/order_request_model.dart';
import 'package:guruku_student/data/model/order_model/order_response_model.dart';
import 'package:http/http.dart' as http;

abstract class OrderRemoteDataSource {
  Future<OrderResponseModel> doOrder(
    OrderRequestModel orderRequest,
    String token,
  );
  Future<List<DataHistoryOrderModel>> historyOrderPending(String token);
  Future<List<DataHistoryOrderModel>> historyOrderSuccess(String token);
  Future<List<DataHistoryOrderModel>> historyOrderCancel(String token);
  Future<List<DataHistoryOrderModel>> getAllPresent(String token);
  Future<DataDetailHistoryOrderModel> getDetailOrder(String token, int id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;

  OrderRemoteDataSourceImpl({required this.client});

  @override
  Future<OrderResponseModel> doOrder(
    OrderRequestModel orderRequest,
    String token,
  ) async {
    final uri = Uri.parse('https://faizal.simagang.my.id/faisol/v1/order');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = json.encode(orderRequest.toJson());
    debugPrint('Request URL: $uri');
    debugPrint('Request Headers: $headers');
    debugPrint('Request Body: $body');

    final response = await client.post(uri, headers: headers, body: body);

    debugPrint('Response Order Code: ${response.statusCode}');
    debugPrint('Response Body : ${response.body}');
    if (response.statusCode == 201) {
      return OrderResponseModel.fromJson(json.decode(response.body));
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error';
      throw OrderException(message: errorMessage);
    }
  }

  @override
  Future<List<DataHistoryOrderModel>> historyOrderPending(String token) async {
    final response = await client.get(
      Uri.parse("https://faizal.simagang.my.id/faisol/v1/user/history/pending"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return HistoryOrderResponseModel.fromJson(json.decode(response.body))
          .data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DataHistoryOrderModel>> historyOrderSuccess(String token) async {
    final response = await client.get(
      Uri.parse("https://faizal.simagang.my.id/faisol/v1/user/uyeku?payment_status=success&present=belum"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return HistoryOrderResponseModel.fromJson(json.decode(response.body))
          .data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DataHistoryOrderModel>> historyOrderCancel(String token) async {
    final response = await client.get(
      Uri.parse("https://faizal.simagang.my.id/faisol/v1/user/history/expired"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return HistoryOrderResponseModel.fromJson(json.decode(response.body))
          .data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DataHistoryOrderModel>> getAllPresent(String token) async {
    final response = await client.get(
      Uri.parse("https://faizal.simagang.my.id/faisol/v1/user/uyeku?payment_status=success&present=hadir"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Response COBA: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return HistoryOrderResponseModel.fromJson(json.decode(response.body))
          .data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DataDetailHistoryOrderModel> getDetailOrder(
      String token, int id) async {
    final response = await client.get(
      Uri.parse(
          'https://faizal.simagang.my.id/faisol/v1/user/detail-history/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint('Nguyuh1 status: ${response.statusCode}');
    debugPrint('Nguyuh2 body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DataDetailHistoryOrderModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }
}
