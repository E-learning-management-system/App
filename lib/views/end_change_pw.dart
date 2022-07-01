
import 'package:flutter/material.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/widgets/elevation_button.dart';
class EndChangePw extends StatelessWidget {
  const EndChangePw({Key? key}) : super(key: key);
  static const String id = '/end_change_pw';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('$baseUrlImage/img_end_pw.png',
            height: 110,
            width: 110,),
            SizedBox(height: 16,),
            Text('!رمز عبور شما با موفقیت تغییر یافت!'),
            SizedBox(height: 26,),
            ElevationButtonWidget(
                call: (){

            },)
          ],
        ),
      ),
    );
  }
}
