import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/views/home_professor_view.dart';
import 'package:project/views/home_view.dart';
import 'package:project/views/setting_view.dart';
import 'package:project/views/tab_calendar/calendar_view.dart';
import 'package:project/views/tab_lessons/lessons_view.dart';
import 'package:project/views/setting_view.dart';
import 'package:project/views/change_password_view.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);
  static const String id = '/base_view';

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int selectIndex = 0;
  final myViews = [
    if (sharedPreferences.getType() == 't') ...[
      const HomeProfessorView()
    ] else ...[
      const HomeView()
    ],
    const LessonsView(),
    const CalendarView(),
    const SettingView(),
  ];
  final styleText = const TextStyle(
    fontSize: 16,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: myViews[selectIndex],
      ),
      bottomNavigationBar: _buildBottomNavigatorBar(),
    );
  }

  Widget _buildBottomNavigatorBar() {
    return BottomNavyBar(
      selectedIndex: selectIndex,
      onItemSelected: (index) => setState(() {
        if (index == 4) {
          return;
        }

        selectIndex = index;
      }),
      animationDuration: const Duration(milliseconds: 200),
      items: [
        BottomNavyBarItem(
          textAlign: TextAlign.center,
          icon: const Icon(Icons.home),
          title: Text(
            'خانه',
            style: styleText,
          ),
        ),
        BottomNavyBarItem(
          textAlign: TextAlign.center,
          icon: const Icon(
            Icons.menu_book_outlined,
          ),
          title: Text(
            'دروس',
            style: styleText,
          ),
        ),
        BottomNavyBarItem(
          textAlign: TextAlign.center,
          icon: const Icon(Icons.event_note_outlined),
          title: Text(
            'تقویم',
            style: styleText,
          ),
        ),
        BottomNavyBarItem(
          textAlign: TextAlign.center,
          icon: const Icon(Icons.person),
          title: Text(
            'تنظیمات',
            style: styleText,
          ),
        ),
      ],
    );
  }
}
