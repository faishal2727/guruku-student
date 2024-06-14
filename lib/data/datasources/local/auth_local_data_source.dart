import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guruku_student/data/model/login_model/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> saveAuth(LoginResonseModel data);
  Future<bool> removeAuth();
  Future<LoginResonseModel?> getAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _authKey = 'auth';

  @override
  Future<bool> saveAuth(LoginResonseModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.setString(_authKey, json.encode(data.toJson()));
    debugPrint('Save Auth Status: $success');
    return success;
  }

  @override
  Future<LoginResonseModel?> getAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString(_authKey);

    if (authJson != null) {
      final tokenModel = LoginResonseModel.fromJson(json.decode(authJson));
      debugPrint('Get Auth Successful. Token: $tokenModel');
      return tokenModel;
    } else {
      debugPrint('No Auth Data Found.');
      return null;
    }
  }

  @override
  Future<bool> removeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove(_authKey);
    return success;
  }
}
