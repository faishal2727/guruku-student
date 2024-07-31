import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/withdraw/detail_wd_model.dart';
import 'package:guruku_student/data/model/withdraw/list_wd_response.dart';
import 'package:guruku_student/data/model/withdraw/withdraw_detail_response_model.dart';
import 'package:guruku_student/data/model/withdraw/withdraw_response_model.dart';
import 'package:http/http.dart' as http;

abstract class WithdrawRemoteDataSource {
  Future<WithdrawResponseModel> reqWd(
    String token,
    int idTeacher,
    String amount,
    String noBank,
    String bankName,
  );
  Future<List<WithdrawDetailResponseModel>> listWdTeacher(
    String token,
    int idTeacher,
  );
  Future<List<WithdrawDetailResponseModel>> listWdStudent(
    String token,
  );
  Future<DetailWdModel> getDetailWd(String token, int id);
}

class WithdrawRemoteDataSourceImpl implements WithdrawRemoteDataSource {
  final http.Client client;

  WithdrawRemoteDataSourceImpl({required this.client});

  @override
  Future<WithdrawResponseModel> reqWd(
    String token,
    int idTeacher,
    String amount,
    String noBank,
    String bankName,
  ) async {
    final response = await client.post(
      Uri.parse('https://faizal.simagang.my.id/faisol/v1/withdraw/create'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'teacher_id': idTeacher,
        'amount': amount,
        'bank_account_number': noBank,
        'bank_name': bankName,
      }),
    );

    if (response.statusCode == 200) {
      final req = WithdrawResponseModel.fromJson(json.decode(response.body));
      return req;
    } else if (response.statusCode == 400) {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Bad Request';
      debugPrint(
          'Withdraw gagal: $errorMessage (status code ${response.statusCode})');
      throw WDException(message: errorMessage);
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error';
      debugPrint(
          'Withdraw gagal: $errorMessage (status code ${response.statusCode})');
      throw WDException(message: errorMessage);
    }
  }

  @override
  Future<List<WithdrawDetailResponseModel>> listWdTeacher(
      String token, int idTeacher) async {
    final response = await client.get(
      Uri.parse(
          "https://faizal.simagang.my.id/faisol/v1/teacher/withdraw/$idTeacher"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return ListWdResponse.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<WithdrawDetailResponseModel>> listWdStudent(String token) async {
    final response = await client.get(
      Uri.parse("https://faizal.simagang.my.id/faisol/v1/student/withdraw"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return ListWdResponse.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DetailWdModel> getDetailWd(String token, int id) async {
    final response = await client.get(
      Uri.parse('https://faizal.simagang.my.id/faisol/v1/user/withdraw/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint('Nguyuh1 status: ${response.statusCode}');
    debugPrint('Nguyuh2 body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DetailWdModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }
}
