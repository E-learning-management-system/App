
import 'package:flutter/material.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/views/onboarding_view.dart';
import 'package:project/widgets/app_bar_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const String id ='/Splash';
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000),(){
      Navigator.of(context).pushReplacementNamed(OnBoardingView.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('$baseUrlImage/img_splash.png',
                width: 200.0, height: 100.0, fit: BoxFit.fill),
            sizedBox(height: 30),
            Text(
              "سامانه هدفمند یادگیری الکترونیکی ",
              style: TextStyle(
                color: MyColors.purpleHex,
                fontSize: 25,
                fontFamily: 'BZar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
