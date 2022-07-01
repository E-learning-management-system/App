import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/controllers/calendar_controller.dart';
import 'package:project/controllers/change_pw_controller.dart';
import 'package:project/controllers/create_new_lessons_controller.dart';
import 'package:project/controllers/exercise_controller.dart';
import 'package:project/controllers/create_new_subject_controller.dart';
import 'package:project/controllers/final_lessons_controller.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/item_lessons_controller.dart';
import 'package:project/controllers/last_topic_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/onboarding_controller.dart';
import 'package:project/controllers/posts_cpntroller.dart';
import 'package:project/controllers/profile_controller.dart';
import 'package:project/controllers/record_home_work_controller.dart';
import 'package:project/controllers/search_controller.dart';
import 'package:project/controllers/signup_controller.dart';
import 'package:project/controllers/student_delivery_controller.dart';
import 'package:project/controllers/subject_controller.dart';
import 'package:project/controllers/verify_email_controller.dart';

import 'package:project/helpers/them_app.dart';
import 'package:project/controllers/login_controller.dart';
import 'package:project/views/Setting_view.dart';
import 'package:project/views/base_view/base_view.dart';
import 'package:project/views/change_pw_view.dart';
import 'package:project/views/end_change_pw.dart';
import 'package:project/views/forget_password_view.dart';
import 'package:project/views/forget_verify.dart';
import 'package:project/views/home_view.dart';
import 'package:project/views/onboarding_view.dart';
import 'package:project/views/splash_view.dart';
import 'package:project/views/tab_calendar/calendar_view.dart';
import 'package:project/views/tab_lessons/create_new_lessons_view.dart';
import 'package:project/views/tab_lessons/final_lessons_view.dart';
import 'package:project/views/tab_lessons/lessons_view.dart';
import 'package:project/views/tab_lessons/search_view.dart';
import 'package:project/views/tab_lessons/student_delivery_view.dart';
import 'package:project/views/tab_profile/profile_view.dart';
import 'package:project/views/verify_email_view.dart';
import 'package:provider/provider.dart';
import 'views/login_view.dart';
import 'views/signup_view.dart';
import 'views/setting_drawer_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignUpController>(
          child: SignUpView(),
          create: (context) => SignUpController(),
        ),
        ChangeNotifierProvider<OnBoardingController>(
          child: OnBoardingView(),
          create: (context) => OnBoardingController(),
        ),
        ChangeNotifierProvider<VerifyEmailController>(
          child: VerifyEmailView(),
          create: (context) => VerifyEmailController(),
        ),
        ChangeNotifierProvider<LoginController>(
          child: LoginView(),
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider<LessonsController>(
          child: const LessonsView(),
          create: (context) => LessonsController(),
        ),
        ChangeNotifierProvider<ExercisesController>(
          child: const HomeView(),
          create: (context) => ExercisesController(),
        ),
        ChangeNotifierProvider<SubjectsController>(
          child: const HomeView(),
          create: (context) => SubjectsController(),
        ),
        ChangeNotifierProvider<CreateNewLessonsController>(
          child: const CreateNewLessonsView(),
          create: (context) => CreateNewLessonsController(),
        ),
        ChangeNotifierProvider<HomeController>(
          child: HomeView(),
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider<CalendarController>(
          child: const CalendarView(),
          create: (context) => CalendarController(),
        ),
        ChangeNotifierProvider<ItemLessonsController>(
          create: (context) => ItemLessonsController(),
        ),
        ChangeNotifierProvider<PostsController>(
          create: (context) => PostsController(),
        ),
        ChangeNotifierProvider<CreateNewSubjectController>(

          create: (context) => CreateNewSubjectController(),
        ),
        ChangeNotifierProvider<RecordHomeWorkController>(
          create: (context) => RecordHomeWorkController(),
        ),
        ChangeNotifierProvider<FinalLessonsController>(
          child: const FinalLessonsView(),
          create: (context) => FinalLessonsController(),
        ),
        ChangeNotifierProvider<StudentDeliveryController>(
          create: (context) => StudentDeliveryController(),
        ),
        ChangeNotifierProvider<StudentDeliveryController>(
          child: const StudentDeliveryView(title: '',Id: 0),
          create: (context) => StudentDeliveryController(),
        ),
        ChangeNotifierProvider<ProfileController>(
          child: const ProfileView(),
          create: (context) => ProfileController(),
        ),

        ChangeNotifierProvider<ChangePwController>(
          child: const ChangePwView(),
          create: (context) => ChangePwController(),
        ),
        ChangeNotifierProvider<SearchController>(
          child: const SearchView(),
          create: (context) => SearchController(),
        ),

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
          LoginView.id: (context) => LoginView(),
          SignUpView.id: (context) => SignUpView(),
          HomeView.id: (context) => const HomeView(),
          ForgetPasswordView.id: (context) => const ForgetPasswordView(),
          VerifyEmailView.id: (context) => const VerifyEmailView(),
          VerifyEmailForgetView.id: (context) => const VerifyEmailForgetView(),
          LessonsView.id: (context) => const LessonsView(),
          CreateNewLessonsView.id: (context) => const CreateNewLessonsView(),
          FinalLessonsView.id: (context) => const FinalLessonsView(),
          CalendarView.id: (context) => const CalendarView(),
          ChangePwView.id: (context) => const ChangePwView(),
          BaseView.id: (context) => const BaseView(),
          SettingDrawer.id: (context) => const SettingDrawer(),
          SettingView.id: (context) => const SettingView(),
          StudentDeliveryView.id: (context) => const StudentDeliveryView(Id: 0,
          title: '',),
          ProfileView.id: (context) => const ProfileView(),
          EndChangePw.id: (context) => const EndChangePw(),
          SearchView.id: (context) => const SearchView(),
        },
        title: 'Flutter Demo',
        theme: ThemeApp.theme,
        builder: (_, widget) {
          return Container(
            color: Colors.white,
            child: SafeArea(child: widget!),
          );
        },
        initialRoute: SplashView.id,

      ),
    );
  }
}
