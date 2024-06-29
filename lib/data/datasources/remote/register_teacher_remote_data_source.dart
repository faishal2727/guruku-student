import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/teacher_model/my_data_teacher_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:guruku_student/data/model/teacher_model/add_teacher_response_model.dart';

abstract class RegisterTeacherRemoteDataSource {
  Future<AddTeacherResponseModel> addDataTeacher(
    String picturePath,
    String token,
    String name,
    String desc,
    String typeTeaching,
    String price,
    String timeExperience,
    String lat,
    String lon,
    String address,
  );
  Future<AddTeacherResponseModel> pickSchedule(
    String token,
     List<Map<String, dynamic>> schedule,
  );
  Future<MyDataTeacherResponseModel> getMyDataTeacher(String token, int id);
}

class RegisterTeacherRemoteDataSourceImpl
    implements RegisterTeacherRemoteDataSource {
  final http.Client client;

  RegisterTeacherRemoteDataSourceImpl({
    required this.client,
  });

  Future<String> uploadImageToCloudinary(
    List<int> bytes,
    String fileName,
  ) async {
    final cloudinaryUrl =
        Uri.parse('https://api.cloudinary.com/v1_1/daqu7uzs2/image/upload');
    final request = http.MultipartRequest('POST', cloudinaryUrl);
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: fileName,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );
    request.fields['upload_preset'] = 'wtzu2gnv';

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonMap = json.decode(responseData);
      return jsonMap['secure_url'];
    } else {
      throw Exception('Failed to upload image to Cloudinary');
    }
  }

  @override
  Future<AddTeacherResponseModel> addDataTeacher(
    String picture,
    String token,
    String name,
    String desc,
    String typeTeaching,
    String price,
    String timeExperience,
    String lat,
    String lon,
    String address,
  ) async {
    final uri =
        Uri.parse("https://faizal.simagang.my.id/faisol/v1/teacher/update");
    var request = http.MultipartRequest('PUT', uri);

    final Map<String, String> fields = {
      "picture": picture,
      "name": name,
      "description": desc,
      "type_teaching": typeTeaching,
      "price": price,
      "time_experience": timeExperience,
      "lat": lat,
      "lon": lon,
      "address": address,
    };
    request.fields.addAll(fields);
    request.headers.addAll({"Authorization": "Bearer $token"});

    debugPrint('Request URL: $uri');
    debugPrint('Request Headers: ${request.headers}');
    debugPrint('Request Fields: ${request.fields}');

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    debugPrint('Response Status Code: $statusCode');
    debugPrint('Response Data: $responseData');

    if (statusCode == 200) {
      final AddTeacherResponseModel upload =
          AddTeacherResponseModel.fromJson(json.decode(responseData));
      return upload;
    } else {
      throw Exception("Failed to upload image");
    }
  }

  @override
  Future<AddTeacherResponseModel> pickSchedule(
    String token,
     List<Map<String, dynamic>> schedule,
  ) async {
    final response = await client.put(
      Uri.parse('https://faizal.simagang.my.id/faisol/v1/teacher/update'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'schedule': schedule,
        },
      ),
    );
    if (response.statusCode == 200) {
      final AddTeacherResponseModel upload =
          AddTeacherResponseModel.fromJson(json.decode(response.body));
      return upload;
    } else {
      throw Exception("Failed kirim jadwal");
    }
  }

  @override
  Future<MyDataTeacherResponseModel> getMyDataTeacher(
      String token, int id) async {
    final response = await client.get(
      Uri.parse('https://faizal.simagang.my.id/faisol/v1/teacher/get/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint("KAMBING ${response.body}");
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return MyDataTeacherResponseModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }
}
