import 'package:flutter/material.dart';
import 'package:project/controllers/login_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/validator.dart';
import 'package:project/views/forget_password_view.dart';
import 'package:project/views/home_view.dart';
import 'package:project/views/signup_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  static const id = '/Login';
  late String _email, _password;

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginController>();
    final theme = Theme.of(context);
    return Scaffold(
        appBar: const AppbarWidget(
          text: 'ورود',
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('$baseUrlImage/img_1.png',
                    width: 180.0, height: 150.0, fit: BoxFit.cover),
                Form(
                    key: controller.formLoginKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _titleWidget('ایمیل', theme),
                          TextFormFieldWidget(
                            onChanged: (newValue) {
                              _email = newValue;
                            },
                            hintText: 'ایمیل خود را وارد کنید',
                            functionValidate: Validator.validateEmail,
                          ),
                          _titleWidget('رمز عبور', theme),
                          TextFormFieldWidget(
                            obscureText: true,
                            onChanged: (newValue) {
                              _password = newValue;
                            },
                            hintText: 'رمز عبور خود را وارد کنید',
                            functionValidate:  Validator.validatePassword,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: InkWell(
                              child: Text(
                                'رمز خود را فراموش کرده اید؟',
                                style: theme.textTheme.subtitle2!
                                    .copyWith(color: Colors.blue),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ForgetPasswordView.id);
                              },
                            ),
                          ),
                          Center(
                            child: Consumer<LoginController>(
                              builder: (context, value, child) {
                                if(value.isLoading)
                                  {
                                    return const CircularProgressIndicator();
                                  }
                                return  ElevationButtonWidget(
                                  call: () async {
                                    if (controller.formLoginKey.currentState!
                                        .validate()) {
                                      var res = await controller.loginRequest(
                                          _email, _password);
                                      if (res) {
                                        Navigator.of(context)
                                            .pushNamed(HomeView.id);
                                      } else { showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text('خطا'),
                                              content: const Text(
                                                  'مشکلی در ورود وجود دارد.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => Navigator.pop(
                                                      context, '/Login'),
                                                  child: const Text('باشه'),
                                                ),
                                              ],
                                            ),
                                      );
                                      }
                                    }
                                  },
                                  primaryColor: MyColors.blueAccentHex,
                                );
                              },

                            ),
                          )
                        ],
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("حساب کاربری ندارید؟",
                          style: theme.textTheme.subtitle2),
                    ),
                    InkWell(
                      child: Text(
                        'ثبت نام',
                        style: theme.textTheme.subtitle2!
                            .copyWith(color: MyColors.blueHex),
                      ),
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(SignUpView.id),
                    ),
                  ],
                )
              ]),
        ));
  }

  Widget _titleWidget(String name, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: theme.textTheme.subtitle1,
      ),
    );
  }
}
