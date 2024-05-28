import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/auth/forgot_pw_response.dart';
import 'package:guruku_student/domain/entity/auth/login_response.dart';
import 'package:guruku_student/domain/entity/auth/refresh_otp.dart';
import 'package:guruku_student/domain/entity/auth/register_response.dart';
import 'package:guruku_student/domain/entity/auth/req_forgot_pw_response.dart';
import 'package:guruku_student/domain/entity/auth/verify_otp_response.dart';

abstract class AuthRepository {
  // register
  Future<Either<Failure, RegisterResponse>> register({
    required String username,
    required String email,
    required String password,
  });

  // login
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  });

  // verify-otp
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp({
    required String email,
    required String otp,
  });

  // refresh-otp
  Future<Either<Failure, RefreshOtpResponse>> refreshOtp({
    required String email,
  });

  // req-forgot-password
  Future<Either<Failure, ReqForgotPwResponse>> reqForgotPw({
    required String email,
  });

  // forgot-password
  Future<Either<Failure, ForgotPwResponse>> forgotPw({
    required String email,
    required String password,
  });

  // save data user to save session login
  Future<String> saveAuth(LoginResponse data);

  // remove session login
  Future<String> removeAuth();

  // get data user to ceck loginn or no
  Future<LoginResponse?> getAuth();
}
