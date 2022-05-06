

import 'package:flutter/cupertino.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/models/local_models/onboarding_model.dart';

class OnBoardingController extends ChangeNotifier
{
  final List<OnBoardingModel> list = [
    const OnBoardingModel(
        title: 'پرسش و پاسخ با اساتید ',
        desc:
        'دانشجویان می توانند سوالات خود را مطرح کنند و برای ویرایش پاسخ این سوال ها همکاری کنند. ',
        imageUrl: '$baseUrlImage/img_splash1.png'),
    const OnBoardingModel(
        title: 'پرسش و پاسخ با اساتید ',
        desc:
        'دانشجویان می توانند سوالات خود را مطرح کنند و برای ویرایش پاسخ این سوال ها همکاری کنند. ',
        imageUrl: '$baseUrlImage/img_splash2.png'),
    const OnBoardingModel(
        title: 'پرسش و پاسخ با اساتید ',
        desc:
        'دانشجویان می توانند سوالات خود را مطرح کنند و برای ویرایش پاسخ این سوال ها همکاری کنند. ',
        imageUrl: '$baseUrlImage/img_splash3.png'),

  ];
  final pageController = PageController();
  int currentPage = 0;
  void updateValuePageView(int value)
  {
     currentPage = value;
     print(currentPage);
     notifyListeners();
  }



}