import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/review/post_review_response_model.dart';
import 'package:guruku_student/data/model/review/review_model.dart';
import 'package:guruku_student/data/model/review/review_request_model.dart';
import 'package:guruku_student/data/model/review/review_response_model.dart';
import 'package:http/http.dart' as http;

abstract class ReviewRemoteDataSource {
  Future<List<ReviewModel>> getReview(int id);
  Future<PostReviewResponseModel> postReview(
    String token,
    ReviewRequestModel request,
  );
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final http.Client client;

  ReviewRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ReviewModel>> getReview(int id) async {
    final response = await client.get(
      Uri.parse('https://faizal.simagang.my.id/faisol/v1/review/$id'),
    );

    debugPrint("KURBAN ${response.statusCode}");
    debugPrint("KURBAN ${response.body}");

    if (response.statusCode == 200) {
      return ReviewResponseModel.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostReviewResponseModel> postReview(
    String token,
    ReviewRequestModel request,
  ) async {
    final uri = Uri.parse('https://faizal.simagang.my.id/faisol/v1/review');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = json.encode(request.toJson());
    debugPrint('Request URL: $uri');
    debugPrint('Request Headers: $headers');
    debugPrint('Request Body: $body');

    final response = await client.post(
      uri,
      headers: headers,
      body: body,
    );

    debugPrint('Response Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    if (response.statusCode == 201) {
      return PostReviewResponseModel.fromJson(json.decode(response.body));
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error';
      throw ReviewException(message: errorMessage);
    }
  }
}
