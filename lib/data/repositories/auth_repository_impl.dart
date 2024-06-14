import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/local/auth_local_data_source.dart';
import 'package:guruku_student/data/datasources/remote/auth_remote_data_source.dart';
import 'package:guruku_student/data/model/login_model/login_response_model.dart';
import 'package:guruku_student/domain/entity/auth/forgot_pw_response.dart';
import 'package:guruku_student/domain/entity/auth/login_response.dart';
import 'package:guruku_student/domain/entity/auth/refresh_otp.dart';
import 'package:guruku_student/domain/entity/auth/register_response.dart';
import 'package:guruku_student/domain/entity/auth/req_forgot_pw_response.dart';
import 'package:guruku_student/domain/entity/auth/verify_otp_response.dart';
import 'package:guruku_student/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });
@override
  Future<Either<Failure, LoginResponse>> login(
      {required String email, required String password}) async {
    try {
      final result = await remoteDataSource.login(email: email, password: password);
      return Right(result.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException {
      return const Left(ServerFailure('Server error occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the Internet'));
    }
  }

  @override
  Future<LoginResponse?> getAuth() async {
    final result = await localDataSource.getAuth();
    if (result != null) return result.toEntity();
    return null;
  }

  @override
  Future<Either<Failure, RegisterResponse>> register(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final result = await remoteDataSource.register(
          username: username, email: email, password: password);
      return Right(result.toEntity());
    } on AuthException {
      return const Left(AuthFailure('Input dengan benar'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(
      {required String email, required String otp}) async {
    try {
      final result = await remoteDataSource.verifyOtp(email: email, otp: otp);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, RefreshOtpResponse>> refreshOtp(
      {required String email}) async {
    try {
      final result = await remoteDataSource.refreshOtp(email: email);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal Koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, ReqForgotPwResponse>> reqForgotPw(
      {required String email}) async {
    try {
      final result = await remoteDataSource.reqForgotPw(email: email);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal Koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, ForgotPwResponse>> forgotPw(
      {required String email, required String password}) async {
    try {
      final result =
          await remoteDataSource.forgotPw(email: email, password: password);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal Koneksi internet'));
    }
  }

  @override
  Future<String> removeAuth() async {
    final result = await localDataSource.removeAuth();
    if (result) return 'Berhasil menghapus data auth';
    return 'Gagal menghapus data auth';
  }

  @override
  Future<String> saveAuth(LoginResponse data) async {
    final result =
        await localDataSource.saveAuth(LoginResonseModel.fromEntity(data));
    if (result) return 'Berhasil menyimpan data auth';
    return 'Gagal menyimpan data auth';
  }
}
