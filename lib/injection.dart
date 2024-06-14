import 'package:get_it/get_it.dart';
import 'package:guruku_student/data/datasources/db/database_helper.dart';
import 'package:guruku_student/data/datasources/local/auth_local_data_source.dart';
import 'package:guruku_student/data/datasources/local/teacher_local_data_source.dart';
import 'package:guruku_student/data/datasources/remote/auth_remote_data_source.dart';
import 'package:guruku_student/data/datasources/remote/order_remote_data_source.dart';
import 'package:guruku_student/data/datasources/remote/payment_remote_data_sorce.dart';
import 'package:guruku_student/data/datasources/remote/profile_remote_data_source.dart';
import 'package:guruku_student/data/datasources/remote/teacher_remote_data_source.dart';
import 'package:guruku_student/data/repositories/auth_repository_impl.dart';
import 'package:guruku_student/data/repositories/order_repository_impl.dart';
import 'package:guruku_student/data/repositories/payment_repository_impl.dart';
import 'package:guruku_student/data/repositories/profile_repository_impl.dart';
import 'package:guruku_student/data/repositories/teacher_repository_impl.dart';
import 'package:guruku_student/domain/repositories/auth_repository.dart';
import 'package:guruku_student/domain/repositories/order_repository.dart';
import 'package:guruku_student/domain/repositories/payment_repository.dart';
import 'package:guruku_student/domain/repositories/profile_repository.dart';
import 'package:guruku_student/domain/repositories/teacher_repository.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/auth/login.dart';
import 'package:guruku_student/domain/usecase/auth/refresh_otp.dart';
import 'package:guruku_student/domain/usecase/auth/register.dart';
import 'package:guruku_student/domain/usecase/auth/remove_auth.dart';
import 'package:guruku_student/domain/usecase/auth/req_forgot_password.dart';
import 'package:guruku_student/domain/usecase/auth/save_auth.dart';
import 'package:guruku_student/domain/usecase/auth/verify_otp.dart';
import 'package:guruku_student/domain/usecase/bookmark/get_bookmark_status.dart';
import 'package:guruku_student/domain/usecase/bookmark/get_bookmark_teacher_list.dart';
import 'package:guruku_student/domain/usecase/bookmark/remove_bookmark_teacher.dart';
import 'package:guruku_student/domain/usecase/bookmark/save_bookmark_teacher.dart';
import 'package:guruku_student/domain/usecase/order/get_detail_order.dart';
import 'package:guruku_student/domain/usecase/order/history_order_cancel.dart';
import 'package:guruku_student/domain/usecase/order/history_order_pending.dart';
import 'package:guruku_student/domain/usecase/order/history_order_success.dart';
import 'package:guruku_student/domain/usecase/order/order.dart';
import 'package:guruku_student/domain/usecase/payment/payment.dart';
import 'package:guruku_student/domain/usecase/profile/detail_profile.dart';
import 'package:guruku_student/domain/usecase/profile/update_avatar.dart';
import 'package:guruku_student/domain/usecase/profile/update_profile.dart';
import 'package:guruku_student/domain/usecase/teacher/get_all_teacher.dart';
import 'package:guruku_student/domain/usecase/teacher/get_search_teacher.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_biology.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_detail.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_english.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_indonesian.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_math.dart';
import 'package:guruku_student/presentation/blocs/bookmark/bookmark_teacher_bloc.dart';
import 'package:guruku_student/presentation/blocs/detail_order/detail_order_bloc.dart';
import 'package:guruku_student/presentation/blocs/detail_teacher/detail_teacher_bloc.dart';
import 'package:guruku_student/presentation/blocs/history_order_cancel/order_cancel_bloc.dart';
import 'package:guruku_student/presentation/blocs/history_order_pending/order_pending_bloc.dart';
import 'package:guruku_student/presentation/blocs/history_order_success/order_success_bloc.dart';
import 'package:guruku_student/presentation/blocs/login/login_bloc.dart';
import 'package:guruku_student/presentation/blocs/main/main_bloc.dart';
import 'package:guruku_student/presentation/blocs/order/order_bloc.dart';
import 'package:guruku_student/presentation/blocs/payment/payment_bloc.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:guruku_student/presentation/blocs/refresh_otp/refresh_otp_bloc.dart';
import 'package:guruku_student/presentation/blocs/register/register_bloc.dart';
import 'package:guruku_student/presentation/blocs/req_forgot_pw/req_forgot_pw_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher/teacher_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher_biology/teacher_biology_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher_english/teacher_english_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher_indonesian/teacher_indo_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher_math/teacher_math_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher_search/teacher_search_bloc.dart';
import 'package:guruku_student/presentation/blocs/verify_otp/verify_otp_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => LoginBloc(
      login: locator(),
      saveAuth: locator(),
      getAuth: locator(),
      removeAuth: locator()));
  locator.registerFactory(() => VerifyOtpBloc(verifyOtp: locator()));
  locator.registerFactory(() => RefreshOtpBloc(refreshOtp: locator()));
  locator.registerFactory(() => ReqForgotPwBloc(reqForgotPassword: locator()));
  locator.registerFactory(() => RegisterBloc(register: locator()));
  locator.registerFactory(() => MainBloc(getAuth: locator()));
  locator.registerFactory(
      () => ProfileBloc(locator(), locator(), locator(), locator()));
  locator.registerFactory(() => TeacherBloc(locator()));
  locator.registerFactory(() => DetailTeacherBloc(locator()));
  locator.registerFactory(() => TeacherMathBloc(locator()));
  locator.registerFactory(() => TeacherEnglishBloc(locator()));
  locator.registerFactory(() => TeacherIndoBloc(locator()));
  locator.registerFactory(() => TeacherBiologyBloc(locator()));
  locator.registerFactory(() => TeacherSearchBloc(locator()));
  locator.registerFactory(
    () => BookmarkTeacherBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(() => PaymentBloc(payment: locator()));
  locator
      .registerFactory(() => OrderBloc(order: locator(), getAuth: locator()));
  locator.registerFactory(() => OrderPendingBloc(locator(), locator()));
  locator.registerFactory(() => OrderSuccessBloc(locator(), locator()));
  locator.registerFactory(() => OrderCancelBloc(locator(), locator()));
  locator.registerFactory(() => DetailOrderBloc(locator(), locator()));

  // datasource
  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TeacherRemoteDataSource>(
      () => TeacherRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TeacherLocalDataSource>(
      () => TeacherLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<PaymentRemoteDataSource>(
      () => PaymentRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(client: locator()));

  // usecase
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => Register(locator()));
  locator.registerLazySingleton(() => VerifyOtp(locator()));
  locator.registerLazySingleton(() => SaveAuth(locator()));
  locator.registerLazySingleton(() => GetAuth(locator()));
  locator.registerLazySingleton(() => RemoveAuth(locator()));
  locator.registerLazySingleton(() => DetailProfile(locator()));
  locator.registerLazySingleton(() => UpdateProfile(locator()));
  locator.registerLazySingleton(() => GetAllTeacher(locator()));
  locator.registerLazySingleton(() => GetTeaacherDetail(locator()));
  locator.registerLazySingleton(() => GetTeacherMath(locator()));
  locator.registerLazySingleton(() => GetTeacherEnglish(locator()));
  locator.registerLazySingleton(() => GetTeacherIndonesian(locator()));
  locator.registerLazySingleton(() => GetTeacherBiology(locator()));
  locator.registerLazySingleton(() => GetSearchTeacher(locator()));
  locator.registerLazySingleton(() => GetBookmarkStatus(locator()));
  locator.registerLazySingleton(() => GetBookmarkTeacherList(locator()));
  locator.registerLazySingleton(() => RemoveBookmarkTeacher(locator()));
  locator.registerLazySingleton(() => SaveBookmarkTeacher(locator()));
  locator.registerLazySingleton(() => ReqForgotPassword(locator()));
  locator.registerLazySingleton(() => RefreshOtp(locator()));
  locator.registerLazySingleton(() => UpdateAvatar(locator()));
  locator.registerLazySingleton(() => Payment(locator()));
  locator.registerLazySingleton(() => Order(locator()));
  locator.registerLazySingleton(() => HistoryOrderPending(locator()));
  locator.registerLazySingleton(() => HistoryOrderSuccess(locator()));
  locator.registerLazySingleton(() => HistoryOrderCancel(locator()));
  locator.registerLazySingleton(() => GetDetailOrder(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      localDataSource: locator(), remoteDataSource: locator()));
  locator.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<TeacherRepository>(() => TeacherRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));
  locator.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(remoteDataSource: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DatabaseHelper());
}
