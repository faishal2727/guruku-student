import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/wishlist/wishlist_model.dart';
import 'package:guruku_student/data/model/wishlist/wishlist_response_model.dart';
import 'package:http/http.dart' as http;

abstract class WishlistRemoteDataSource {
  Future<List<WishlistModel>> getAllWishlist(String token);
  Future<String> addWishlist(
    String token,
    int idTeacher
  );
  Future<bool> getWishlistDetail(
    String token,
    int idTeacher,
  );
  Future<String> removeWishlist(
    String token,
    int idTeacher,
  );
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final http.Client client;

  WishlistRemoteDataSourceImpl({required this.client});

  @override
  Future<List<WishlistModel>> getAllWishlist(String token) async {
    final response = await client.get(
      Uri.parse('https://faizal.simagang.my.id/faisol/v1/bookmark'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return WishlistResponseModel.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> addWishlist(
      String token, int idTeacher) async {
    final uri = Uri.parse(
        'https://faizal.simagang.my.id/faisol/v1/bookmark/$idTeacher');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    // final body = json.encode(req.toJson());
    debugPrint('Request URL: $uri');
    debugPrint('Request Headers: $headers');
    // debugPrint('Request Body: $body');

    final response = await client.post(
      uri,
      headers: headers
    );

    debugPrint('Response Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    if (response.statusCode == 201) {
      return 'Berhasil ditambahkan ke wishlist';
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error';
      throw ReviewException(message: errorMessage);
    }
  }

  @override
  Future<bool> getWishlistDetail(String token, int idTeacher) async {
    final response = await client.get(
      Uri.parse(
          'https://faizal.simagang.my.id/faisol/v1/ngewe?teacher_id=$idTeacher'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint("MANUK ${response.statusCode}");
    debugPrint("MANUK ${response.body}");

    if (response.statusCode == 200) {
      final data =
          WishlistResponseModel.fromJson(json.decode(response.body)).data;

      if (data.isNotEmpty && data.length == 1) return true;
      debugPrint("SAMSUNG ${data}");
    }
    return false;
  }

  @override
  Future<String> removeWishlist(String token, int idTeacher) async {
    final response = await client.get(
      Uri.parse(
          'https://faizal.simagang.my.id/faisol/v1/ngewe?teacher_id=$idTeacher'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data =
          WishlistResponseModel.fromJson(json.decode(response.body)).data;

      if (data.isNotEmpty && data.length == 1) {
        final int wislistId = data.first.idTeacher;

        final removeResponse = await client.delete(
          Uri.parse(
              'https://faizal.simagang.my.id/faisol/v1/bookmark/$wislistId'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (removeResponse.statusCode == 200) {
          return 'Berhasil dihapus dari wishlist';
        }
      }
    }
    throw ServerException();
  }
}
