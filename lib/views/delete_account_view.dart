import 'package:flutter/material.dart';
import 'package:project/controllers/delete_account_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/validator.dart';
import 'package:project/views/splash_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({Key? key}) : super(key: key);
  static const String id = '/delete_account_view';

  @override
  Widget build(BuildContext context) {
    String sPassword = '';
    final controller = Provider.of<DeleteAccountController>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, right: 34, left: 33),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Image.asset(
                    '$baseUrlImage/danger.png',
                    height: 199,
                    width: 245,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 120, right: 20),
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.arrow_forward),
                    ),
                    // ),
                  ),
                ),
              ],
            ),
            sizedBox(
              height: 48,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                sizedBox(width: 8),
                const Text(
                  '?????? ???????? ????????????',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    fontFamily: 'BLotus',
                  ),
                ),
              ],
            ),
            sizedBox(height: 25),
            Form(
              key: controller.keyForm,
              child: Column(
                children: [
                  sizedBox(height: 36),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      autofocus: false,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BLotus',
                      ),
                      decoration: InputDecoration(
                        hintText: '?????? ?????? ???? ???????? ????????',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'BLotus',
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: Validator.validatePassword,
                    ),
                  ),
                  sizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      autofocus: false,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BLotus',
                      ),
                      onChanged: (String text) {
                        sPassword = text;
                      },
                      decoration: InputDecoration(
                        hintText: '?????????? ??????',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'BLotus',
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: Validator.validatePassword,
                    ),
                  ),
                ],
              ),
            ),
            sizedBox(height: 36),
            ElevationButtonWidget(
              width: 158,
              height: 44,
              text: "?????? ???????? ????????????",
              primaryColor: MyColors.redButtonColor,
              call: () async {
                if (controller.keyForm.currentState!.validate()) {
                  var res = await controller.deleteAccount();
                  if (res == 'ok') {
                    Navigator.pushNamed(context, SplashView.id);
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('??????'),
                        content:
                            const Text('?????????? ???? ?????? ???????? ???????????? ???????? ????????.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('????????'),
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

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(13)),
      borderSide: BorderSide(
          color: MyColors.inpBorderColor, width: 1, style: BorderStyle.solid),
    );
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: MyColors.hintColor,
        width: 3,
      ),
    );
  }
}
