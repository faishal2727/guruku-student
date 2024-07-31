import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/utils.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/injection.dart' as di;
import 'package:guruku_student/presentation/blocs/detail_order/detail_order_bloc.dart';
import 'package:guruku_student/presentation/blocs/detail_teacher/detail_teacher_bloc.dart';
import 'package:guruku_student/presentation/blocs/get_present/get_present_bloc.dart';
import 'package:guruku_student/presentation/blocs/history_order_cancel/order_cancel_bloc.dart';
import 'package:guruku_student/presentation/blocs/history_order_packages/history_order_packages_bloc.dart';
import 'package:guruku_student/presentation/blocs/history_order_pending/order_pending_bloc.dart';
import 'package:guruku_student/presentation/blocs/history_order_success/order_success_bloc.dart';
import 'package:guruku_student/presentation/blocs/login/login_bloc.dart';
import 'package:guruku_student/presentation/blocs/main/main_bloc.dart';
import 'package:guruku_student/presentation/blocs/notif/notif_bloc.dart';
import 'package:guruku_student/presentation/blocs/order/order_bloc.dart';
import 'package:guruku_student/presentation/blocs/packages/packages_bloc.dart';
import 'package:guruku_student/presentation/blocs/payment/payment_bloc.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:guruku_student/presentation/blocs/refresh_otp/refresh_otp_bloc.dart';
import 'package:guruku_student/presentation/blocs/register/register_bloc.dart';
import 'package:guruku_student/presentation/blocs/req_forgot_pw/req_forgot_pw_bloc.dart';
import 'package:guruku_student/presentation/blocs/review/review_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher/teacher_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher_biology/teacher_biology_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher_english/teacher_english_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher_indonesian/teacher_indo_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher_math/teacher_math_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher_search/teacher_search_bloc.dart';
import 'package:guruku_student/presentation/blocs/verify_otp/verify_otp_bloc.dart';
import 'package:guruku_student/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:guruku_student/presentation/blocs/withdraw/withdraw_bloc.dart';
import 'package:guruku_student/presentation/cubits/carousel/carousel_cubit.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_cubit.dart';
import 'package:guruku_student/presentation/pages/auth/screens/login_page.dart';
import 'package:guruku_student/presentation/pages/auth/screens/sign_up_page.dart';
import 'package:guruku_student/presentation/pages/auth/screens/sign_up_student_page.dart';
import 'package:guruku_student/presentation/pages/auth/screens/req_forgot_password.dart';
import 'package:guruku_student/presentation/pages/auth/screens/sign_up_teacher_page.dart';
import 'package:guruku_student/presentation/pages/auth/screens/verify_otp_forgot_pw.dart';
import 'package:guruku_student/presentation/pages/auth/screens/verify_otp_page.dart';
import 'package:guruku_student/presentation/pages/detai_present/screens/detail_present_page.dart';
import 'package:guruku_student/presentation/pages/detai_present/screens/detail_tidak_hadir_page.dart';
import 'package:guruku_student/presentation/pages/detail_order_cancel/screens/detail_order_cancel_page.dart';
import 'package:guruku_student/presentation/pages/detail_teacher/screens/detail_teacher_page.dart';
import 'package:guruku_student/presentation/pages/detail_order_done/screens/detail_order_done_page.dart';
import 'package:guruku_student/presentation/pages/detail_order_pending/screens/detail_order_pending_page.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/history_order_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/change_location_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/home_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_biology_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_english_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_indonesian_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_math_page.dart';
import 'package:guruku_student/presentation/pages/main/student_landing_page.dart';
import 'package:guruku_student/presentation/pages/main/splash_screen.dart';
import 'package:guruku_student/presentation/pages/notification/screens/notification_page.dart';
import 'package:guruku_student/presentation/pages/packages/screens/detail_packages_page.dart';
import 'package:guruku_student/presentation/pages/packages/screens/detail_pending_packages_page.dart';
import 'package:guruku_student/presentation/pages/packages/screens/detail_success_packages_page.dart';
import 'package:guruku_student/presentation/pages/packages/screens/history_order_packages_page.dart';
import 'package:guruku_student/presentation/pages/packages/screens/order_packages_page.dart';
import 'package:guruku_student/presentation/pages/packages/screens/packages_page.dart';
import 'package:guruku_student/presentation/pages/pick_schedule/screen/pick.dart';
import 'package:guruku_student/presentation/pages/profile/balance/screens/withdraw_user_balance_page.dart';
import 'package:guruku_student/presentation/pages/profile/detail_profile/screens/detail_profile_page.dart';
import 'package:guruku_student/presentation/pages/profile/faq/screens/faq_page.dart';
import 'package:guruku_student/presentation/pages/profile/main/screens/profile_page.dart';
import 'package:guruku_student/presentation/pages/profile/balance/screens/balance_user_page.dart';
import 'package:guruku_student/presentation/pages/profile/update_avatar/update_avatar_page.dart';
import 'package:guruku_student/presentation/pages/profile/update_profile/screens/update_profile_page.dart';
import 'package:guruku_student/presentation/pages/profile/wishlist/screens/wishlist_page.dart';
import 'package:guruku_student/presentation/pages/review_list/screens/list_review_page.dart';
import 'package:guruku_student/presentation/pages/review_post/screens/add_review_page.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/add_data_teacher/add_data_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/my_data_teacher/my_data_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/order_teacher/order_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/register_teacher/register_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_schedule/screen/my_schedule_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_schedule/screen/schedule_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/screens/my_doc_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/screens/teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/balance/screens/balance_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/balance/screens/req_wd_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/balance/screens/wd_detail_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/dashboard/screens/dashboard_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/screens/detai_hadir_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/screens/detail_tidak_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/screens/history_order_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/screens/order_detail_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/screens/add_packages_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/screens/history_package_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/screens/my_packages_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/screens/order_detail_success_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/screens/update_packages_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/screens/tac_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/screens/teacher_landing_page.dart';
import 'package:location/location.dart';
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
        BlocProvider(create: (_) => di.locator<LoginBloc>()),
        BlocProvider(create: (_) => di.locator<RegisterBloc>()),
        BlocProvider(create: (_) => di.locator<VerifyOtpBloc>()),
        BlocProvider(create: (_) => di.locator<RefreshOtpBloc>()),
        BlocProvider(create: (_) => di.locator<ReqForgotPwBloc>()),
        BlocProvider(
            create: (_) => di.locator<MainBloc>()..add(DoIsLoginEvent())),
        BlocProvider(
            create: (_) => di.locator<ProfileBloc>()..add(OnProfileEvent())),
        BlocProvider(create: (_) => di.locator<TeacherBloc>()),
        BlocProvider(create: (_) => di.locator<DetailTeacherBloc>()),
        BlocProvider(create: (_) => CarouselCubit()),
        BlocProvider(create: (_) => ImagePickerCubit()),
        BlocProvider(create: (_) => di.locator<TeacherMathBloc>()),
        BlocProvider(create: (_) => di.locator<TeacherEnglishBloc>()),
        BlocProvider(create: (_) => di.locator<TeacherIndoBloc>()),
        BlocProvider(create: (_) => di.locator<TeacherBiologyBloc>()),
        BlocProvider(create: (_) => di.locator<TeacherSearchBloc>()),
        // BlocProvider(create: (_) => di.locator<BookmarkTeacherBloc>()),
        BlocProvider(create: (_) => di.locator<PaymentBloc>()),
        BlocProvider(create: (_) => di.locator<OrderBloc>()),
        BlocProvider(create: (_) => di.locator<OrderPendingBloc>()),
        BlocProvider(create: (_) => di.locator<OrderSuccessBloc>()),
        BlocProvider(create: (_) => di.locator<OrderCancelBloc>()),
        BlocProvider(create: (_) => di.locator<DetailOrderBloc>()),
        BlocProvider(create: (_) => di.locator<ReviewBloc>()),
        BlocProvider(create: (_) => di.locator<WishlistBloc>()),
        BlocProvider(create: (_) => di.locator<GetPresentBloc>()),
        BlocProvider(create: (_) => di.locator<RegisterTeacherBloc>()),
        BlocProvider(create: (_) => di.locator<AddDataTeacherBloc>()),
        BlocProvider(create: (_) => di.locator<MyDataTeacherBloc>()),
        BlocProvider(create: (_) => di.locator<OrderTeacherBloc>()),
        BlocProvider(create: (_) => di.locator<NotifBloc>()),
        BlocProvider(create: (_) => di.locator<WithdrawBloc>()),
        BlocProvider(create: (_) => di.locator<PackagesBloc>()),
        BlocProvider(create: (_) => di.locator<HistoryOrderPackagesBloc>()),
      ],
      child: MaterialApp(
        title: 'Guruku',
        theme: ThemeData(
          colorScheme: kColorScheme,
          textTheme: kTextTheme,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case SplashScreen.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SplashScreen());
            case StudentLandingPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const StudentLandingPage());

            // <========================================>
            // ====== START ROUTE TO HANDLE AUTH ========
            case LoginPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const LoginPage());
            case SignUpPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const SignUpPage());
            case SignUpTeacherPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const SignUpTeacherPage());
            case SignUpStudentPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const SignUpStudentPage());
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
            case ChangeLocationPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const ChangeLocationPage());
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
            case NotificationPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const NotificationPage());
            case PackagesPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(builder: (_) => PackagesPage(id: id));

            case DetailPendingPackagesPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailPendingPackagesPage(id: id));
            case DetailSuccessPackagesPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailSuccessPackagesPage(id: id));
            case HistoryPackageTeacherPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const HistoryPackageTeacherPage());
            case OrderDetailSuccessPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => OrderDetailSuccessPage(id: id));
            case DetailPackagesPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailPackagesPage(id: id));
            case OrderPackagesPage.ROUTE_NAME:
              final args = settings.arguments as Map<String, dynamic>;
              final id = args['id'] as int;
              final selectedTime = args['selectedTime'] as String;
              return MaterialPageRoute(
                builder: (_) =>
                    OrderPackagesPage(id: id, selectedTime: selectedTime),
              );
            case HistoryOrderPackagesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const HistoryOrderPackagesPage());
            case MyPackagesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const MyPackagesPage());
            // <========================================>
            // ====== END ROUTE TO HANDLE HOME ==========

            // <==================================================>
            // ====== START ROUTE TO HANDLE DETAIL TEACHER ========
            case DetailTeacherPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailTeacherPage(id: id),
              );

            case WdDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => WdDetailPage(id: id),
              );
            case AddPackagesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AddPackagesPage());
            case Pick.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => Pick(id: id),
              );
            case ListReviewPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(builder: (_) => ListReviewPage(id: id));

            // case DetailOrderPage.ROUTE_NAME:
            //   return MaterialPageRoute(builder: (_) => const DetailOrderPage());
            case DetailOrderPendingPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailOrderPendingPage(id: id));
            case DetailOrderDonePage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailOrderDonePage(id: id));
            case DetailTidakHadirPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailTidakHadirPage(id: id));
            case DetailPresentPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailPresentPage(id: id));
            case DetailHadirPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(builder: (_) => DetailHadirPage(id: id));
            case DetailTidakPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(builder: (_) => DetailTidakPage(id: id));
            case DetailOrderCancelPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailOrderCancelPage(id: id));

            case AddReviewPage.ROUTE_NAME:
              final data = settings.arguments as DetailHistoryOrder;
              return MaterialPageRoute(
                  builder: (_) => AddReviewPage(dataHistoryOrder: data));

            // <==================================================>
            // ====== END ROUTE TO HANDLE DETAIL TEACHER ==========

            // ===== START ROUTE TO HANDLE PROFILE ======
            case TacPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const TacPage());
            case ProfilePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const ProfilePage());
            case DetailProfilePage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const DetailProfilePage());
            case UpdateProfilePage.ROUTE_NAME:
              final profile = settings.arguments as DetailProfileResponse;
              return MaterialPageRoute(
                  builder: (_) => UpdateProfilePage(profile: profile));
            // case UpdatePage.ROUTE_NAME:
            //   final profile = settings.arguments as DetailProfileResponse;
            //   return MaterialPageRoute(
            //       builder: (_) => UpdatePage(profile: profile));
            case BalanceUserPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const BalanceUserPage());
            case WithdrawUserBalancePage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const WithdrawUserBalancePage());
            case UpdateAvatarPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const UpdateAvatarPage());
            case FaqPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const FaqPage());
            // case BookmarkPage.ROUTE_NAME:
            //   return MaterialPageRoute(builder: (_) => const BookmarkPage());
            case HistoryOrderPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => HistoryOrderPage(
                        initialIndex: id,
                      ));
            case WishlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WishlistPage());

            case TeacherLandingPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const TeacherLandingPage());
            case DashboardTeacherPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DashboardTeacherPage(id: id));
            case HistoryOrderTeacherPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => HistoryOrderTeacherPage(id: id));
            case TeacherPage.ROUTE_NAME:
              final data = settings.arguments as MyDataTeacherResponse;
              return MaterialPageRoute(builder: (_) => TeacherPage(data: data));
            case UpdatePackagesPage.ROUTE_NAME:
              final data = settings.arguments as Packages;
              return MaterialPageRoute(
                  builder: (_) => UpdatePackagesPage(data: data));
            case SchedulePage.ROUTE_NAME:
              final data = settings.arguments as MyDataTeacherResponse;
              return MaterialPageRoute(
                  builder: (_) => SchedulePage(data: data));
            case MySchedulePage.ROUTE_NAME:
              final data = settings.arguments as MyDataTeacherResponse;
              return MaterialPageRoute(
                  builder: (_) => MySchedulePage(data: data));
            case BalanceTeacherPage.ROUTE_NAME:
              final data = settings.arguments as MyDataTeacherResponse;
              return MaterialPageRoute(
                  builder: (_) => BalanceTeacherPage(data: data));
            case MyDocPage.ROUTE_NAME:
              final data = settings.arguments as MyDataTeacherResponse;
              return MaterialPageRoute(builder: (_) => MyDocPage(data: data));
            case ReqWdTeacherPage.ROUTE_NAME:
              final data = settings.arguments as MyDataTeacherResponse;
              return MaterialPageRoute(
                  builder: (_) => ReqWdTeacherPage(data: data));

            case OrderDetailTeacherPage.ROUTE_NAME:
              final args = settings.arguments as Map<String, int?>;
              final idTeacher = args['idTeacher']!;
              final idOrder = args['idOrder']!;
              return MaterialPageRoute(
                builder: (_) => OrderDetailTeacherPage(
                  idTeacher: idTeacher,
                  idOrder: idOrder,
                ),
              );

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
