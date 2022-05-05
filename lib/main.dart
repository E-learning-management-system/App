import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/onboarding_controller.dart';
import 'package:project/controllers/signup_controller.dart';
import 'package:project/controllers/verify_email_controller.dart';

import 'package:project/helpers/them_app.dart';
import 'package:project/controllers/login_controller.dart';

import 'package:project/views/forget_password_view.dart';

import 'package:project/views/onboarding_view.dart';
import 'package:project/views/splash_view.dart';
import 'package:project/views/tab_lessons/lessons_view.dart';
import 'package:project/views/verify_email_view.dart';
import 'package:provider/provider.dart';

import 'views/login_view.dart';
import 'views/signup_view.dart';

import 'views/home_view.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(
          child: HomeView(),
            create: (context) => HomeController(),),

        ChangeNotifierProvider<SignUpController>(
          child: SignUpView(),
            create: (context) => SignUpController(),),

        ChangeNotifierProvider<OnBoardingController>(
          child: OnBoardingView(),
            create: (context) => OnBoardingController(),),

        ChangeNotifierProvider<VerifyEmailController>(
          child: VerifyEmailView(),
            create: (context) => VerifyEmailController(),),


        ChangeNotifierProvider<LoginController>(
          child: LoginView(),
            create: (context) => LoginController(),),

        ChangeNotifierProvider<LessonsController>(
          child: const LessonsView(),
            create: (context) => LessonsController(),),


      ],
      child: MaterialApp(
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
          ],
          locale: Locale("fa", "IR"),

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
          LessonsView.id : (context) => const LessonsView()

        },
        title: 'Flutter Demo',
        theme: ThemeApp.theme,
          builder: (_,widget){
            return SafeArea(child: widget!);
          },
          initialRoute: SplashView.id,


      ),
    );
  }
}

