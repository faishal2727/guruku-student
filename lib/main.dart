import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/utils.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/injection.dart' as di;
import 'package:guruku_student/presentation/blocs/bookmark/bookmark_teacher_bloc.dart';
import 'package:guruku_student/presentation/blocs/detail_teacher/detail_teacher_bloc.dart';
import 'package:guruku_student/presentation/blocs/login/login_bloc.dart';
import 'package:guruku_student/presentation/blocs/main/main_bloc.dart';
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
import 'package:guruku_student/presentation/cubits/carousel/carousel_cubit.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_cubit.dart';
import 'package:guruku_student/presentation/pages/auth/screens/login_page.dart';
import 'package:guruku_student/presentation/pages/auth/screens/register_page.dart';
import 'package:guruku_student/presentation/pages/auth/screens/req_forgot_password.dart';
import 'package:guruku_student/presentation/pages/auth/screens/verify_otp_forgot_pw.dart';
import 'package:guruku_student/presentation/pages/auth/screens/verify_otp_page.dart';
import 'package:guruku_student/presentation/pages/detail/screens/detail_teacher_page.dart';
import 'package:guruku_student/presentation/pages/detail_order/screens/detail_order_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/home_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_biology_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_english_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_indonesian_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_math_page.dart';
import 'package:guruku_student/presentation/pages/main/main_page.dart';
import 'package:guruku_student/presentation/pages/pick_schedule/screen/percobaan.dart';
import 'package:guruku_student/presentation/pages/profile/bookmark/screens/bookmark_page.dart';
import 'package:guruku_student/presentation/pages/profile/detail_profile/screens/detail_profile_page.dart';
import 'package:guruku_student/presentation/pages/profile/faq/screens/faq_page.dart';
import 'package:guruku_student/presentation/pages/profile/main/screens/profile_page.dart';
import 'package:guruku_student/presentation/pages/profile/setting/screens/setting_page.dart';
import 'package:guruku_student/presentation/pages/profile/update_avatar/update_avatar_page.dart';
import 'package:guruku_student/presentation/pages/profile/update_profile/screens/update_profile_page.dart';
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

  // Mendapatkan status izin lokasi
  PermissionStatus permission = await Location().hasPermission();

  // Jika izin belum diberikan, minta izin
  if (permission == PermissionStatus.denied) {
    permission = await Location().requestPermission();
  }
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.locator<LoginBloc>()..add(DoAuthCheckEventk())),
        BlocProvider(create: (_) => di.locator<RegisterBloc>()),
        BlocProvider(create: (_) => di.locator<VerifyOtpBloc>()),
        BlocProvider(create: (_) => di.locator<RefreshOtpBloc>()),
        BlocProvider(create: (_) => di.locator<ReqForgotPwBloc>()),
        BlocProvider(create: (_) => di.locator<MainBloc>()),
        BlocProvider(create: (_) => di.locator<ProfileBloc>()),
        BlocProvider(create: (_) => di.locator<TeacherBloc>()),
        BlocProvider(create: (_) => di.locator<DetailTeacherBloc>()),
        BlocProvider(create: (_) => CarouselCubit()),
        BlocProvider(create: (_) => ImagePickerCubit()),
        BlocProvider(create: (_) => di.locator<TeacherMathBloc>()),
        BlocProvider(create: (_) => di.locator<TeacherEnglishBloc>()),
        BlocProvider(create: (_) => di.locator<TeacherIndoBloc>()),
        BlocProvider(create: (_) => di.locator<TeacherBiologyBloc>()),
        BlocProvider(create: (_) => di.locator<TeacherSearchBloc>()),
        BlocProvider(create: (_) => di.locator<BookmarkTeacherBloc>()),
        BlocProvider(create: (_) => di.locator<PaymentBloc>()),
      ],
      child: MaterialApp(
        title: 'Guruku',
        
        theme: ThemeData(
          colorScheme: kColorScheme,
          textTheme: kTextTheme,
        ),
        home: const MainPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MainPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const MainPage());

            // <========================================>
            // ====== START ROUTE TO HANDLE AUTH ========
            case LoginPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const LoginPage());
            case RegisterPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const RegisterPage());
            case VerifyOtpPage.ROUTE_NAME:
              final otp = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => VerifyOtpPage(
                  email: otp,
                ),
              );
            case ReqForgotPasswordPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const ReqForgotPasswordPage());
            case VerifyOtpForgotPwPage.ROUTE_NAME:
              final otp = settings.arguments as String;
              return MaterialPageRoute(
                  builder: (_) => VerifyOtpForgotPwPage(email: otp));

            // <========================================>
            // ====== END ROUTE TO HANDLE AUTH ========

            // <========================================>
            // ====== START ROUTE TO HANDLE HOME =======
            case HomePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const HomePage());
            case TeacherMathPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const TeacherMathPage());
            case TeacherEnglishPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const TeacherEnglishPage());
            case TeacherIndonesianPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const TeacherIndonesianPage());
            case TeacherBiologyPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const TeacherBiologyPage());
            // <========================================>
            // ====== END ROUTE TO HANDLE HOME ==========

            // <==================================================>
            // ====== START ROUTE TO HANDLE DETAIL TEACHER ========
            case DetailTeacherPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailTeacherPage(id: id),
              );
            case Pick.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => Pick(id: id),
              );
            case DetailOrderPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const DetailOrderPage());

            // <==================================================>
            // ====== END ROUTE TO HANDLE DETAIL TEACHER ==========

            // ===== START ROUTE TO HANDLE PROFILE ======
            case ProfilePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const ProfilePage());
            case DetailProfilePage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const DetailProfilePage());
            case UpdateProfilePage.ROUTE_NAME:
              final profile = settings.arguments as DetailProfileResponse;
              return MaterialPageRoute(
                builder: (_) => UpdateProfilePage(profile: profile),
              );
            case SettingPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const SettingPage());
            case UpdateAvatarPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const UpdateAvatarPage());
            case FaqPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const FaqPage());
            case BookmarkPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const BookmarkPage());
            // ===== END ROUTE TO HANDLE PROFILE ========

            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :( '),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
