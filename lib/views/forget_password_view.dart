
import 'package:flutter/material.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);
  static const id = '/ForgetPassword';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: const AppbarWidget(
        text: '',
        elevation: 0.5,
    ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30,bottom: 35,
        right: 20,left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment:  CrossAxisAlignment.start,
          children:
          [
            Center(
              child: Image.asset('$baseUrlImage/img_forget_password.png',
                  width: 200.0, height: 200.0,
                  fit: BoxFit.fitHeight,
              alignment: Alignment.center),
            ),
            sizedBox(height: 15),
            Text('رمز عبور \n خود را فراموش کردید ؟',
            style: theme.textTheme.headline6,),
            sizedBox(height: 15),
            Text('با وارد کردن ایمیل خود و دریافت کد،رمز جدید برای خود تعیین کنید .',
            style: theme.textTheme.subtitle1!.copyWith(
              fontFamily: fontLotus,
            ),),

            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 6
              ),
              child: Text('ایمیل',
              style: theme.textTheme.subtitle1!.copyWith(
                color: MyColors.blueHex,
                fontWeight: FontWeight.bold,
                fontFamily: fontLotus
              ),),
            ),

            const TextFormFieldWidget(
              actionKeyboard: TextInputAction.done,
                hintText: 'ایمیل خود را وارد کنید'),
            sizedBox(height: 25),
            Center(
              child: ElevationButtonWidget(
                text: 'بازیابی رمز عبور',
                  call: (){

                   }),
            )


          ],
        ),
      ),
    );
  }
}
