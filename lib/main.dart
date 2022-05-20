import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/controllers/calendar_controller.dart';
import 'package:project/controllers/create_new_lessons_controller.dart';
import 'package:project/controllers/create_new_subject_controller.dart';
import 'package:project/controllers/final_lessons_controller.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/item_lessons_controller.dart';
import 'package:project/controllers/last_topic_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/onboarding_controller.dart';
import 'package:project/controllers/profile_controller.dart';
import 'package:project/controllers/record_home_work_controller.dart';
import 'package:project/controllers/signup_controller.dart';
import 'package:project/controllers/verify_email_controller.dart';
import 'package:project/helpers/them_app.dart';
import 'package:project/controllers/login_controller.dart';
import 'package:project/views/base_view/base_view.dart';
import 'package:project/views/forget_password_view.dart';
import 'package:project/views/onboarding_view.dart';
import 'package:project/views/splash_view.dart';
import 'package:project/views/tab_calendar/calendar_view.dart';
import 'package:project/views/tab_lessons/create_new_lessons_view.dart';
import 'package:project/views/tab_lessons/create_new_subject.dart';
import 'package:project/views/tab_lessons/final_lessons_view.dart';
import 'package:project/views/tab_lessons/item_lessons_view.dart';
import 'package:project/views/tab_lessons/last_topic_view.dart';
import 'package:project/views/tab_lessons/lessons_view.dart';
import 'package:project/views/tab_lessons/record_home_work_view.dart';
import 'package:project/views/tab_profile/profile_view.dart';
import 'package:project/views/verify_email_view.dart';
import 'package:provider/provider.dart';

import 'views/login_view.dart';
import 'views/signup_view.dart';

import 'views/home_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(
          child: const HomeView(),
            create: (context) => HomeController(),),

        ChangeNotifierProvider<SignUpController>(
          child: SignUpView(),
            create: (context) => SignUpController(),),

        ChangeNotifierProvider<OnBoardingController>(
          child: const OnBoardingView(),
            create: (context) => OnBoardingController(),),

        ChangeNotifierProvider<VerifyEmailController>(
          child: const VerifyEmailView(),
            create: (context) => VerifyEmailController(),),


        ChangeNotifierProvider<LoginController>(
          child: LoginView(),
            create: (context) => LoginController(),),

        ChangeNotifierProvider<LessonsController>(
          child: const LessonsView(),
            create: (context) => LessonsController(),),

        ChangeNotifierProvider<CreateNewLessonsController>(
          child: const CreateNewLessonsView(),
            create: (context) => CreateNewLessonsController(),),

        ChangeNotifierProvider<FinalLessonsController>(
          child: const FinalLessonsView(),
            create: (context) => FinalLessonsController(),),

        ChangeNotifierProvider<ItemLessonsController>(
          child: const ItemLessonsView(),
            create: (context) => ItemLessonsController(),),

        ChangeNotifierProvider<ProfileController>(
          child: const ProfileView(),
            create: (context) => ProfileController(),),

        ChangeNotifierProvider<LastTopicController>(
          child: const LastTopicView(),
            create: (context) => LastTopicController(),),

        ChangeNotifierProvider<CreateNewSubjectController>(
          child: const CreateNewSubjectView(),
            create: (context) => CreateNewSubjectController(),),

        ChangeNotifierProvider<RecordHomeWorkController>(
          child: const RecordHomeWorkView(),
            create: (context) => RecordHomeWorkController(),),

        ChangeNotifierProvider<CalendarController>(
          child:  CalendarView(),
            create: (context) => CalendarController(),),


      ],
      child: MaterialApp(
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("fa", "IR"),
          ],
          locale: const Locale("fa", "IR"),

        debugShowCheckedModeBanner: false,
        routes: {
          OnBoardingView.id: (context) => const OnBoardingView(),
          SplashView.id: (context) => const SplashView(),
          OnBoardingView.id: (context) => const OnBoardingView(),
          LoginView.id: (context) =>  LoginView(),
          SignUpView.id: (context) => SignUpView(),
          HomeView.id: (context) => const HomeView(),
          ForgetPasswordView.id : (context) => const ForgetPasswordView(),
          VerifyEmailView.id : (context) => const VerifyEmailView(),
          LessonsView.id : (context) => const LessonsView(),
          CreateNewLessonsView.id:(context) => const CreateNewLessonsView(),
          FinalLessonsView.id:(context) => const FinalLessonsView(),
          ItemLessonsView.id:(context) => const ItemLessonsView(),
          ProfileView.id:(context) => const ProfileView(),
          LastTopicView.id:(context) => const LastTopicView(),
          CreateNewSubjectView.id:(context) => const CreateNewSubjectView(),
          RecordHomeWorkView.id:(context) => const RecordHomeWorkView(),
          CalendarView.id:(context) =>  CalendarView(),
          BaseView.id:(context) => const BaseView(),
        },
        title: 'Flutter Demo',
        theme: ThemeApp.theme,
          builder: (_,widget){
            return Container(
              color: Colors.white,
              child: SafeArea(
              child: widget!),
            );
          },
          initialRoute: BaseView.id,


      ),
    );
  }
}

