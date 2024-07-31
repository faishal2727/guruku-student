import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/teacher_model/add_packages_response_model.dart';
import 'package:guruku_student/data/model/teacher_model/packages_detail_model.dart';
import 'package:guruku_student/data/model/teacher_model/packages_model.dart';
import 'package:guruku_student/data/model/teacher_model/packages_response_model.dart';
import 'package:http/http.dart' as http;

abstract class PackagesRemoteDataSource {
  Future<List<PackagesModel>> getPackages(int id);
  Future<PackagesDetailModel> getDetailPackages(int id);
  Future<AddPackagesResponseModel> addPackages(
    String token,
    int duration,
    String name,
    int price,
    String desc,
    List<String> day,
    List<String> time,
    int teacherId,
  );
  Future<AddPackagesResponseModel> updatePackages(
    int id,
    int duration,
    String name,
    int price,
    String desc,
    List<String> day,
    List<String> time,
  );
  Future<List<PackagesModel>> getMyPackages(String token);
}

class PackagesRemoteDataSourceImpl implements PackagesRemoteDataSource {
  final http.Client client;
  PackagesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PackagesModel>> getPackages(int id) async {
    final response = await client.get(
      Uri.parse('https://faizal.simagang.my.id/faisol/v1/list-paket/$id'),
    );

    debugPrint("KURBAN ${response.statusCode}");
    debugPrint("KURBAN ${response.body}");

    if (response.statusCode == 200) {
      return PackagesResponseModel.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PackagesDetailModel> getDetailPackages(int id) async {
    final response = await client.get(
        Uri.parse('https://faizal.simagang.my.id/faisol/v1/detail-paket/$id'));
    debugPrint("KAMBING ${response.body}");
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return PackagesDetailModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AddPackagesResponseModel> addPackages(
    String token,
    int duration,
    String name,
    int price,
    String desc,
    List<String> day,
    List<String> time,
    int teacherId,
  ) async {
    final uri = Uri.parse("https://faizal.simagang.my.id/faisol/v1/paket");

    // Buat map untuk body JSON
    final Map<String, dynamic> body = {
      "duration": duration,
      "name": name,
      "price": price,
      "desc": desc,
      "day": day,
      "time": time,
      "teacher_id": teacherId,
    };

    final response = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    final int statusCode = response.statusCode;
    final String responseData = response.body;

    debugPrint('Response Status Code: $statusCode');
    debugPrint('Response Data: $responseData');

    if (statusCode == 201) {
      final AddPackagesResponseModel upload =
          AddPackagesResponseModel.fromJson(json.decode(responseData));
      return upload;
    } else {
      throw Exception("Gagal mengunggah data");
    }
  }

  @override
  Future<List<PackagesModel>> getMyPackages(String token) async {
    final response = await client.get(
      Uri.parse("https://faizal.simagang.my.id/faisol/v1/my-paket"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return PackagesResponseModel.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AddPackagesResponseModel> updatePackages(
    int id,
    int duration,
    String name,
    int price,
    String desc,
    List<String> day,
    List<String> time,
  ) async {
    final uri =
        Uri.parse("https://faizal.simagang.my.id/faisol/v1/update-paket/$id");

    // Buat map untuk body JSON
    final Map<String, dynamic> body = {
      "duration": duration,
      "name": name,
      "description": desc,
      "price": price,
      "desc": desc,
      "day": day,
      "time": time,
    };

    final response = await http.put(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    final int statusCode = response.statusCode;
    final String responseData = response.body;

    debugPrint('Response Status Code: $statusCode');
    debugPrint('Response Data: $responseData');

    if (statusCode == 200) {
      final AddPackagesResponseModel upload =
          AddPackagesResponseModel.fromJson(json.decode(responseData));
      return upload;
    } else {
      throw Exception("Gagal mengunggah data");
    }
  }
}
