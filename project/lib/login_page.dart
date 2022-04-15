import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formLoginKey = GlobalKey<FormState>();
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xA0DEF3FF),
        body:
            SingleChildScrollView(

              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
              "ورود",
            style: TextStyle(color: Colors.black87, fontSize: 27),
          ),
          Image.asset("assets/images/login.png",
                width: 350.0, height: 300.0, fit: BoxFit.cover),
          Form(
                key: _formLoginKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "ایمیل",
                          style: TextStyle(),
                        ),
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            hintText: "ایمیل خود را وارد کنید",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.blueAccent)),
                            filled: true,
                            contentPadding:
                            EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لطفا ایمیل خود را وارد کنید.';
                            } else {
                              return null;
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "رمز عبور",
                          style: TextStyle(),
                        ),
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            hintText: "رمز عبور خود را وارد کنید",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.blueAccent)),
                            filled: true,
                            contentPadding:
                            EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لطفا رمز عبور خود را وارد کنید';
                            } else {
                              return null;
                            }
                          }),
                      CheckboxListTile(
                          title: Text("مرا به خاطر بسپار"),
                          checkColor: Colors.white,
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading),
                      Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 200,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder()),
                              onPressed: () async {
                                if (_formLoginKey.currentState!.validate()) {
                                  setState(() {});
                                  Navigator.pushNamed(context, '/home');
                                }
                              },
                              child: Text("ورود")),
                        ),
                      ),
                    ],
                  ),
                )),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("حساب کاربری ندارید؟"),
                ),
                InkWell(
                  child: Text(
                    'ثبت نام',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                ),
              ],
          )
        ]),
            ));
  }
}
