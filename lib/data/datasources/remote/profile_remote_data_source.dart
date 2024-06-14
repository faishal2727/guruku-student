import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/detail_profile_response_model.dart';
import 'package:guruku_student/data/model/profile_model/update_profile_request_model..dart';
import 'package:guruku_student/data/model/profile_model/update_profile_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

abstract class ProfileRemoteDataSource {
  Future<DetailProfileResponseModel> getDetailProfile(String token);
  Future<UpdateProfileResponseModel> updateProfile(
      UpdateProfileRequestModel updateData, String token);
  Future<UpdateProfileResponseModel> updateAvatar(
      List<int> bytes, String fileName, String token);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<DetailProfileResponseModel> getDetailProfile(String token) async {
    final response = await client.get(
      Uri.parse('https://faizal.simagang.my.id/faisol/v1/user/current-user'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      debugPrint("Response Body: ${response.body}");

      debugPrint("BANGSAT ${response.statusCode}");

      return DetailProfileResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UpdateProfileResponseModel> updateProfile(
      UpdateProfileRequestModel updateData, String token) async {
    final uri = Uri.parse('https://faizal.simagang.my.id/faisol/v1/user/update');

    final response = await client.put(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(updateData.toJson()),
    );

    debugPrint('Response Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return UpdateProfileResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UpdateProfileResponseModel> updateAvatar(
      List<int> bytes, String fileName, String token) async {
    try {
      final uri = Uri.parse('https://faizal.simagang.my.id/faisol/v1/user/update');
      var request = http.MultipartRequest('PUT', uri);

      final multiPartFile = http.MultipartFile.fromBytes(
        "images",
        bytes,
        filename: fileName,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multiPartFile);
      request.headers.addAll({"Authorization": "Bearer $token"});

      debugPrint('Request URL: $uri');
      debugPrint('Request Headers: ${request.headers}');
      debugPrint('Request Files: ${request.files}');

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final parsedResponse = json.decode(responseData);
        return UpdateProfileResponseModel.fromJson(parsedResponse);
      } else {
        final responseData = await response.stream.bytesToString();
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Reason Phrase: ${response.reasonPhrase}');
        debugPrint('Response Data: $responseData');
        throw Exception('Failed to update avatar: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Exception: $e');
      throw Exception('Failed to update avatar: $e');
    }
  }
}
