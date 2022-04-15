import 'package:flutter/material.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formSignupKey = GlobalKey<FormState>();
  String dropdownValue = "استاد";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "ثبت نام",
            style: TextStyle(color: Colors.black87, fontSize: 27),
          ),
          Image.asset("assets/images/signup.png",
              width: 200.0, height: 200.0, fit: BoxFit.cover),
          Form(
              key: _formSignupKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "نقش",
                        style: TextStyle(),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent)),
                        filled: true,
                        contentPadding:
                        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                      ),
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>["استاد","دانشجو"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "ایمیل",
                        style: TextStyle(),
                      ),
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          hintText: "ایمیل خود را وارد کنید",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.pinkAccent)),
                          filled: true,
                          contentPadding:
                          EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا ایمیل خود را وارد کنید';
                          } else {
                            return null;
                          }
                        }),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "دانشگاه",
                        style: TextStyle(),
                      ),
                    ),
                    TextFormField(

                        decoration: InputDecoration(
                          hintText: "نام موسسه یا دانشگاه",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.pinkAccent)),
                          filled: true,
                          contentPadding:
                          EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا نام دانشگاه خود را وارد کنید';
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
                              borderSide: BorderSide(color: Colors.pinkAccent)),
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

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "تکرار رمز عبور",
                        style: TextStyle(),
                      ),
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "تکرار رمز عبور خود را وارد کنید",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.pinkAccent)),
                          filled: true,
                          contentPadding:
                          EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا تکرار رمز عبور خود را وارد کنید';
                          } else {
                            return null;
                          }
                        }),

                    Container(
                      padding: EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary:Colors.pinkAccent
                            ),
                            onPressed: () async {
                              if (_formSignupKey.currentState!.validate()) {
                                setState(() {});
                                Navigator.pushNamed(context, '/home');
                              }
                            },
                            child: Text("ثبت نام")),
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
                child: Text("حساب کاربری دارید؟"),
              ),
              InkWell(
                child: Text(
                  'ورود',
                  style: TextStyle(color: Colors.pink),
                ),
                onTap: () => Navigator.pushNamed(context, '/login'),
              ),
            ],
          )
        ]),
      )
    );

  }
}

