import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/subject_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/views/Setting_view.dart';
import 'package:project/views/home_view.dart';
import 'package:project/views/login_view.dart';
import 'package:project/views/splash_view.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:provider/provider.dart';
import 'package:project/controllers/exercise_controller.dart';
import '../widgets/topAppBar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class SettingDrawer extends StatelessWidget {
  const SettingDrawer({Key? key}) : super(key: key);
  static const id = '/SettingDrawer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: ListView(
                // Important: Remove any padding from the ListView.

                children: [
                  ListTile(
                    title: const Text(
                      'تنظیمات',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BLotus',
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        print("tapped");
                      },
                      child: new Container(
                        child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(SettingView.id),
                          child: Icon(
                            Icons.close,
                            color: MyColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: InkWell(
                      onTap: () {
                        print("tapped");
                      },
                      child: new Container(
                        child: InkWell(
                          child: Icon(
                            Icons.phone_outlined,
                            color: MyColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                    title: const Text(
                      'تماس با ما',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 96, 91, 91),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BLotus',
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        print("tapped");
                      },
                      child: new Container(
                        child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(SettingView.id),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: MyColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: InkWell(
                      onTap: () {
                        print("tapped");
                      },
                      child: new Container(
                        child: InkWell(
                          child: Icon(
                            Icons.info_outline,
                            color: MyColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                    title: const Text(
                      'درباره سورن',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 96, 91, 91),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BLotus',
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        print("tapped");
                      },
                      child: new Container(
                        child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(SettingView.id),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: MyColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: InkWell(
                      onTap: () {
                        print("tapped");
                      },
                      child: new Container(
                        margin: EdgeInsets.only(left: 0),
                        child: InkWell(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/Icon_metro_question.png",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: const Text(
                      'پرسش های متداول',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 96, 91, 91),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BLotus',
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        print("tapped");
                      },
                      child: new Container(
                        child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(SettingView.id),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: MyColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: InkWell(
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(SplashView.id),
                      child: new Container(
                        child: InkWell(
                          child: Icon(
                            Icons.exit_to_app,
                            color: MyColors.drawerRed,
                          ),
                        ),
                      ),
                    ),
                    title: const Text(
                      'خروج از حساب کاربری',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BLotus',
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(SplashView.id),
                      child: new Container(
                        child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(SplashView.id),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: MyColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ],
                padding: EdgeInsets.all(24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/image_soren.png",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 29),
            child: Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'App version: 1.0.1',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
