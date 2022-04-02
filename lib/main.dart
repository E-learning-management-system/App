import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/login_page.dart';
import 'package:project/signup_page.dart';
import 'package:project/splash_1.dart';
import 'package:project/splash_2.dart';
import 'package:project/splash_3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
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
        '/splash1': (context) => const Splash1(),
        '/splash2': (context) => const Splash2(),
        '/splash3': (context) => const Splash3(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Directionality( // add this
        textDirection: TextDirection.rtl,
        child :Splash1(),
      )


    );
  }
}

