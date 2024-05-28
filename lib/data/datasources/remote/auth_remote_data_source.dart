import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/model/forgot_pw_response_model.dart';
import 'package:guruku_student/data/model/login_response_model.dart';
import 'package:guruku_student/data/model/refresh_otp_response_model.dart';
import 'package:guruku_student/data/model/register_response_model.dart';
import 'package:guruku_student/data/model/req_forgot_pw_response_model.dart';
import 'package:guruku_student/data/model/verify_otp_response_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<RegisterResponseModel> register({
    required String username,
    required String email,
    required String password,
  });
  Future<LoginResonseModel> login({
    required String email,
    required String password,
  });
  Future<VerifyOtpResponseModel> verifyOtp({
    required String email,
    required String otp,
  });
  Future<RefreshOtpResponseModel> refreshOtp({
    required String email,
  });
  Future<ReqForgotPwResponseModel> reqForgotPw({
    required String email,
  });
  Future<ForgotPwResponseModel> forgotPw({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  // login student
  @override
  Future<LoginResonseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:3010/v1/user/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final tokenModel = LoginResonseModel.fromJson(json.decode(response.body));
      return tokenModel;
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error';
      debugPrint(
          'Login gagal: $errorMessage (status code ${response.statusCode})');
      throw AuthException(message: errorMessage);
    }
  }

  // register student
  AuthRemoteDataSourceImpl({required this.client});
  @override
  Future<RegisterResponseModel> register(
      {required String username,
      required String email,
      required String password}) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:3010/v1/user/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      final registerModel =
          RegisterResponseModel.fromJson(json.decode(response.body));
      return registerModel;
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error';
      debugPrint(
          'Register gagal: $errorMessage (status code ${response.statusCode})');
      throw AuthException(message: errorMessage);
    }
  }

  // verify otp
  @override
  Future<VerifyOtpResponseModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:3010/v1/user/verify-otp'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'email': email,
          'otp': otp,
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = VerifyOtpResponseModel.fromJson(json.decode(response.body));
      return data;
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error';
      debugPrint(
          'Verifikasi OTP gagal: $errorMessage (status code ${response.statusCode})');
      throw AuthException(message: errorMessage);
    }
  }

  // refresh otp
  @override
  Future<RefreshOtpResponseModel> refreshOtp({required String email}) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:3010/v1/user/refresh-otp'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'email': email,
        },
      ),
    );

    if (response.statusCode == 201) {
      final data = RefreshOtpResponseModel.fromJson(json.decode(response.body));
      return data;
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error';
      debugPrint(
          'Refresh OTP gagal: $errorMessage (status code ${response.statusCode})');
      throw AuthException(message: errorMessage);
    }
  }

  // request to forgot password with send email
  @override
  Future<ReqForgotPwResponseModel> reqForgotPw({required String email}) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:3010/v1/user/req-forgot-password'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'email': email,
        },
      ),
    );
    if (response.statusCode == 201) {
      final data =
          ReqForgotPwResponseModel.fromJson(json.decode(response.body));
      return data;
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error';
      debugPrint(
          'Kirim Email gagal: $errorMessage (status code ${response.statusCode})');
      throw AuthException(message: errorMessage);
    }
  }

  // forgot password
  @override
  Future<ForgotPwResponseModel> forgotPw({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:3010v1/user/forgot-password'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = ForgotPwResponseModel.fromJson(json.decode(response.body));
      return data;
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Unknown error';
      debugPrint(
          'Lupa password gagal: $errorMessage (status code ${response.statusCode})');
      throw AuthException(message: errorMessage);
    }
  }
}
