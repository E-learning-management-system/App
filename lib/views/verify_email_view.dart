

import 'package:flutter/material.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/pin_code.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);
  static const String id = '/VerifyEmail';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: const AppbarWidget(
          text: 'تایید ایمیل',
          elevation: 0.5,
        ),
        body:
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20,bottom: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Image.asset('$baseUrlImage/img_email.png',
                    width: 200.0, height: 200.0,
                    fit: BoxFit.fill),
                sizedBox(height: 20),
                _buildTextEmail(theme),

                _buildPinCode(),
                sizedBox(height: 25),
                _buildSendAgain(theme),
                sizedBox(height: 20),
                _buildButtonVerify(theme)
              ]),
        ));
  }
  Widget _buildTextEmail(ThemeData theme)
  {
    return   Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('لطفا با وارد کردن کد تایید ارسال شده به ایمیل',
              style: theme.textTheme.subtitle2!.copyWith(
                  fontFamily: fontBZar
              ), ),
            sizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('test@gmial.com',
                    style: theme.textTheme.caption!
                        .copyWith(
                        color: MyColors.blueHex,
                        fontFamily: fontBZar
                    )),
                Text('  ایمیل خود را تایید کنید. ',
                  style: theme.textTheme.caption!
                      .copyWith(
                      fontFamily: fontBZar
                  ),)
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _buildSendAgain(ThemeData theme)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("کد را دریافت نکردید ؟",
              style: theme.textTheme.subtitle2!.copyWith(
                fontFamily: fontLotus
              )
          ),
        ),
        InkWell(
          child: Text(
            'ارسال مجدد',
            style: theme.textTheme.caption!.copyWith(
                color: MyColors.orange,
              fontWeight: FontWeight.bold
            ),
          ),
          // onTap: () => Navigator.of(context)
          //     .pushReplacementNamed( SignUpView.id),
        ),
      ],
    );
  }
  Widget _buildPinCode()
  {
    return  Container(
      margin: const EdgeInsets.only(right: 20,
          left: 20),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeFields(
          length: 4,
          margin: const EdgeInsets.only(right: 10,
              left: 10),
          borderColor: MyColors.greyHex,
          onComplete: (output) {
            // Your logic with pin code
            print(output);
          },
        ),
      ),
    );
  }

  Widget _buildButtonVerify(ThemeData theme)
  {
    return ElevationButtonWidget(
        call: (){},
      text: 'تایید',
      primaryColor: MyColors.blueDark,

    );
  }
}
