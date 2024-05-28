import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/bookmark_teacher_response_model.dart';
import 'package:guruku_student/data/model/teacher_detail_model.dart';
import 'package:guruku_student/data/model/teacher_model.dart';
import 'package:guruku_student/data/model/teacher_response.dart';
import 'package:http/http.dart' as http;

abstract class TeacherRemoteDataSource {
  Future<List<TeacherModel>> getAllTeacher();
  Future<List<TeacherModel>> getTeacherMath();
  Future<List<TeacherModel>> getTeacherEnglish();
  Future<List<TeacherModel>> getTeacherIndonesian();
  Future<List<TeacherModel>> getTeacherBilogy();
  Future<TeacherDetailModel> getTeacherDetail(int id);
  Future<List<TeacherModel>> getSearchTeacher(String query);
  Future<BookmarkTeacherResponseModel> addBookmarkTeacher({
    required int idStudent,
    required int idTeacher,
    required String token,
  });
}

class TeacherRemoteDataSourceImpl implements TeacherRemoteDataSource {
  final http.Client client;

  TeacherRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TeacherModel>> getAllTeacher() async {
    final response =
        await client.get(Uri.parse('http://10.0.2.2:3010/v1/teacher'));
    if (response.statusCode == 200) {
      return TeacherResponse.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TeacherDetailModel> getTeacherDetail(int id) async {
    final response =
        await client.get(Uri.parse('http://10.0.2.2:3010/v1/teacher/$id'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return TeacherDetailModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TeacherModel>> getTeacherMath() async {
    final response = await client
        .get(Uri.parse('http://10.0.2.2:3010/v1/teacher-category/Matematika'));
    if (response.statusCode == 200) {
      List<TeacherModel> teacherList =
          TeacherResponse.fromJson(json.decode(response.body)).data;
      print('Daftar Guru Matematika:');
      for (TeacherModel teacher in teacherList) {
        print('Nama: ${teacher.name}, Mata Pelajaran: ${teacher.name}');
      }
      return teacherList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TeacherModel>> getTeacherBilogy() async {
    final response = await client
        .get(Uri.parse('http://10.0.2.2:3010/v1/teacher-category/Biology'));
    if (response.statusCode == 200) {
      return TeacherResponse.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TeacherModel>> getTeacherEnglish() async {
    final response = await client
        .get(Uri.parse('http://10.0.2.2:3010/v1/teacher-category/English'));
    if (response.statusCode == 200) {
      return TeacherResponse.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TeacherModel>> getTeacherIndonesian() async {
    final response = await client
        .get(Uri.parse('http://10.0.2.2:3010/v1/teacher-category/Indonesia'));
    if (response.statusCode == 200) {
      return TeacherResponse.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TeacherModel>> getSearchTeacher(String query) async {
    final Uri uri = Uri.parse(
        'http://10.0.2.2:3010/v1/teacher-search?type_teaching=$query&teacher=$query');

    debugPrint('Request URL: $uri');

    final response = await client.get(uri);
    debugPrint('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final teacherResponse =
          TeacherResponse.fromJson(json.decode(response.body));
      debugPrint('Response data: ${teacherResponse.data}');
      return teacherResponse.data;
    } else {
      debugPrint('Server Exception thrown');
      throw ServerException();
    }
  }

  @override
  Future<BookmarkTeacherResponseModel> addBookmarkTeacher({
    required int idStudent,
    required int idTeacher,
    required String token,
  }) async {
    final uri = Uri.parse('http://10.0.2.2:3010/v1/$idTeacher');
    final response = await client.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'id_student': idStudent,
        'id_teacher': idTeacher,
      }),
    );

    if (response.statusCode == 200) {
      return BookmarkTeacherResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
