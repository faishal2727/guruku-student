import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/notif/notif_response_model.dart';
import 'package:guruku_student/data/model/notif/response_notif.dart';
import 'package:http/http.dart' as http;

abstract class NotifRemoteDataSource {
  Future<List<NotifResponseModel>> getNotifStudent(String token);
}

class NotifRemoteDataSourceImpl implements NotifRemoteDataSource {
  final http.Client client;

  NotifRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NotifResponseModel>> getNotifStudent(String token) async {
    final response = await client.get(
      Uri.parse("https://faizal.simagang.my.id/faisol/v1/user/notif"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Response COBA: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return ResponseNotif.fromJson(json.decode(response.body))
          .data;
    } else {
      throw ServerException();
    }
  }
}
