import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/history_order/data_detail_history_order_model.dart';
import 'package:guruku_student/data/model/history_order/data_history_order_model.dart';
import 'package:guruku_student/data/model/history_order/data_history_order_packages_model.dart';
import 'package:guruku_student/data/model/history_order/history_order_packages_response.dart';
import 'package:guruku_student/data/model/history_order/history_order_response_model.dart';
import 'package:guruku_student/data/model/profile_model/update_profile_response_model.dart';
import 'package:http/http.dart' as http;

abstract class OrderTeacherRemoteDataSource {
  Future<List<DataHistoryOrderModel>> orderPendingTeacher(String token);
  Future<List<DataHistoryOrderModel>> orderSuccessTeacher(String token);
  Future<List<DataHistoryOrderModel>> orderCancelTeacher(String token);
  Future<List<DataHistoryOrderModel>> orderPresentTeacher(String token);
  Future<DataDetailHistoryOrderModel> getDetailOrder(
    String token,
    int idTeacher,
    int idOrder,
  );
  Future<UpdateProfileResponseModel> updatePresent(String token, int id);
  Future<UpdateProfileResponseModel> updatePresentPackages(
    String token,
    int packageId,
    int orderId,
    String status,
  );
  Future<UpdateProfileResponseModel> updateTidak(String token, int id);
  Future<List<DataHistoryOrderPackagesModel>> historyOrderPackagesTeacher(
      String token);
}

class OrderTeacherRemoteDataSourceImpl implements OrderTeacherRemoteDataSource {
  final http.Client client;

  OrderTeacherRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DataHistoryOrderModel>> orderPendingTeacher(String token) async {
    final response = await client.get(
      Uri.parse(
          "https://faizal.simagang.my.id/faisol/v1/teacher/status?payment_status=pending"),
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
  Future<List<DataHistoryOrderModel>> orderSuccessTeacher(String token) async {
    final response = await client.get(
      Uri.parse(
          "https://faizal.simagang.my.id/faisol/v1/teacher/susu?payment_status=success&kehadiran=belum"),
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
  Future<List<DataHistoryOrderModel>> orderCancelTeacher(String token) async {
    final response = await client.get(
      Uri.parse(
          "https://faizal.simagang.my.id/faisol/v1/teacher/susu?payment_status=success&kehadiran=tidak"),
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
  Future<List<DataHistoryOrderModel>> orderPresentTeacher(String token) async {
    final response = await client.get(
      Uri.parse(
          "https://faizal.simagang.my.id/faisol/v1/teacher/susu?payment_status=success&kehadiran=hadir"),
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
  Future<DataDetailHistoryOrderModel> getDetailOrder(
      String token, int idTeacher, int idOrder) async {
    final response = await client.get(
      Uri.parse(
          'https://faizal.simagang.my.id/faisol/v1/teacher/history-detail?teacherId=$idTeacher&orderId=$idOrder'),
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

  @override
  Future<UpdateProfileResponseModel> updatePresent(String token, int id) async {
    final uri = Uri.parse('https://faizal.simagang.my.id/faisol/v1/user/hadir');

    final response = await client.put(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'id': id,
      }),
    );

    debugPrint('Response Status Code SIIIUUU: ${response.statusCode}');
    debugPrint('Response Body SIIIIUUU: ${response.body}');
    debugPrint('Request URL: $uri');

    if (response.statusCode == 200) {
      return UpdateProfileResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UpdateProfileResponseModel> updateTidak(String token, int id) async {
    final uri =
        Uri.parse('https://faizal.simagang.my.id/faisol/v1/user/tidak-hadir');

    final response = await client.put(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'id': id,
      }),
    );

    debugPrint('Response Status Code SIIIUUU: ${response.statusCode}');
    debugPrint('Response Body SIIIIUUU: ${response.body}');
    debugPrint('Request URL: $uri');

    if (response.statusCode == 200) {
      return UpdateProfileResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DataHistoryOrderPackagesModel>> historyOrderPackagesTeacher(
      String token) async {
    final response = await client.get(
      Uri.parse("https://faizal.simagang.my.id/faisol/v1/order-teacher"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return HistoryOrderPackagesResponse.fromJson(json.decode(response.body))
          .data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UpdateProfileResponseModel> updatePresentPackages(
      String token, int packageId, int orderId, String status) async {
    final uri = Uri.parse('https://faizal.simagang.my.id/faisol/v1/sessions');

    final response = await client.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "packages_id": packageId,
        "status": status,
        "order_id": orderId,
      }),
    );

    debugPrint('Response Status Code SIIIUUU: ${response.statusCode}');
    debugPrint('Response Body SIIIIUUU: ${response.body}');
    debugPrint('Request URL: $uri');

    if (response.statusCode == 201) {
      return UpdateProfileResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
