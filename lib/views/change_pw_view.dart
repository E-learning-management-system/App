
import 'package:flutter/material.dart';
import 'package:project/controllers/change_pw_controller.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/validator.dart';
import 'package:project/views/end_change_pw.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class ChangePwView extends StatelessWidget {
  const ChangePwView({Key? key}) : super(key: key);
  static const String id = '/change_pw_view';
  @override
  Widget build(BuildContext context) {
    String Password='';
    final controller = Provider.of<ChangePwController>(context);
    return Scaffold(
      appBar: AppbarWidget(
        text: 'تغییر رمز عبور',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 12,
        right: 15,
        left: 15),
        child: Column(
          children: [
            Image.asset('$baseUrlImage/img_change_pw.png',
            height: 200,
            width: 200,),
            sizedBox(height: 20,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock,color: Colors.blue,),
                sizedBox(width: 8),
                const Text('تعیین رمز عبور',
                style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 16)),
              ],),

            sizedBox(height: 20),
            Form(
              key: controller.keyForm,
                child: Column(
              children: [
                const TextFormFieldWidget(hintText: 'رمز جدید',
                    functionValidate: Validator.validatePassword,
                    obscureText: true
                ),
                sizedBox(height: 15),
                TextFormFieldWidget(hintText: 'تکرار رمز عبور',
                    functionValidate: Validator.validatePassword,
                    obscureText: true,
                onChanged: (String text){Password=text;},),
              ],
            )),
            sizedBox(height: 30),
            ElevationButtonWidget(call: ()async{
              if(controller.keyForm.currentState!.validate())
                {
                  var res= await controller.changhPW(Password);
                  if(res) {
                    Navigator.pushNamed(context, EndChangePw.id);
                  } else{
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('خطا'),
                        content: const Text('مشکلی در تغییر رمز عیور وجود دارد.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('باشه'),
                          ),
                        ],
                      ),
                    );
                  }
                }
            },
            )
          ],
        ),
      ),
    );
  }
}
