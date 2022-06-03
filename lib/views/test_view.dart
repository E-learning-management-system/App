import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/subject_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/views/home_view.dart';
import 'package:project/views/login_view.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:provider/provider.dart';
import 'package:project/controllers/exercise_controller.dart';
import '../widgets/topAppBar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  static const id = '/TestPage';

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeView(),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.blue,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text(
              'خانه',
              style: TextStyle(
                fontFamily: 'Vazir',
                color: Colors.white,
              ),
            ),
            icon: Icon(Icons.home),
            activeColor: MyColors.blueAccentHex,
            // inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            title: Text('دروس'),
            icon: Icon(Icons.menu_book_outlined),
          ),
          BottomNavyBarItem(
            title: Text('تقویم'),
            icon: Icon(Icons.event_note_outlined),
          ),
          BottomNavyBarItem(
            title: Text('تنظیمات'),
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
