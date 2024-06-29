// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/presentation/blocs/main/main_bloc.dart';
import 'package:guruku_student/presentation/pages/home/screens/home_page.dart';
import 'package:guruku_student/presentation/pages/maps/maps_page.dart';
import 'package:guruku_student/presentation/pages/profile/main/screens/profile_page.dart';
import 'package:guruku_student/presentation/pages/schedule/screens/schedule_page.dart';
import 'package:guruku_student/presentation/pages/search/search_page.dart';

class StudentLandingPage extends StatefulWidget {
  static const ROUTE_NAME = "/bot-nav";
  const StudentLandingPage({super.key});

  @override
  State<StudentLandingPage> createState() =>
      _StudentLandingPageState();
}

class _StudentLandingPageState
    extends State<StudentLandingPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    SchedulePage(),
    MapsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

    @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MainBloc>().add(DoIsLoginEvent());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: pr11,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
