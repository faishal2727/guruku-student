// // ignore_for_file: constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:guruku_student/common/constants.dart';
// import 'package:guruku_student/common/global_variable.dart';
// import 'package:guruku_student/presentation/blocs/login/login_bloc.dart';
// import 'package:guruku_student/presentation/blocs/main/main_bloc.dart';
// import 'package:guruku_student/presentation/pages/auth/screens/login_page.dart';
// import 'package:guruku_student/presentation/pages/home/screens/home_page.dart';
// import 'package:guruku_student/presentation/pages/maps/maps_page.dart';
// import 'package:guruku_student/presentation/pages/profile/main/screens/profile_page.dart';
// import 'package:guruku_student/presentation/pages/schedule/screens/schedule_page.dart';
// import 'package:guruku_student/presentation/pages/search/search_page.dart';

// class MainPage extends StatefulWidget {
//   static const ROUTE_NAME = '/main-page';
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   bool _isLogin = false;

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       _isLogin = context.read<MainBloc>().state.isLogin;
//     });
//   }

//   final List<BottomNavigationBarItem> _bottomNavBarItems = [
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.home_rounded),
//       label: 'Beranda',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.search),
//       label: 'Cari',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.calendar_month),
//       label: 'Jadwal',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.location_on),
//       label: 'Maps',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.person),
//       label: 'Akun',
//     ),
//   ];

//   final List<Widget> _listWidget = [
//     const HomePage(),
//     const SearchPage(),
//     const SchedulePage(),
//     const MapsPage(),
//     const ProfilePage(),
//   ];

//   void _onBottomNavTapped(int index) async {
//     if (index== 0 || _isLogin) {
//       context.read<MainBloc>().add(DoTabChangeEvent(tabIndex: index));
//     } else {
//       final String? result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const LoginPage(),
//         ),
//       );
//       if (!mounted) return;

//       if (result != null && result == GlobalVariables.successLogin) {
//         context.read<MainBloc>().add(DoTabChangeEvent(tabIndex: index));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<MainBloc, MainState>(
//           listener: (context, state) {
//             _isLogin = state.isLogin;
//             debugPrint("KNTL $_isLogin");
//           },
//         ),
//         BlocListener<LoginBloc, LoginState>(
//           listener: (context, state) {
//             context.read<MainBloc>().add(DoIsLoginEvent());
//           },
//         ),
//       ],
//       child: BlocBuilder<MainBloc, MainState>(
//         builder: (context, state) {
//           return Scaffold(
//             body: _listWidget[state.tabIndex],
//             bottomNavigationBar: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(16.0),
//                   topRight: Radius.circular(16.0),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10.0,
//                     spreadRadius: 1.0,
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(16.0),
//                   topRight: Radius.circular(16.0),
//                 ),
//                 child: BottomNavigationBar(
//                   backgroundColor: pr11,
//                   type: BottomNavigationBarType.fixed,
//                   currentIndex: state.tabIndex,
//                   items: _bottomNavBarItems,
//                   onTap: _onBottomNavTapped,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
