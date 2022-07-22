import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/subject_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/views/change_password_view.dart';
import 'package:project/views/home_view.dart';
import 'package:project/views/login_view.dart';
import 'package:project/views/setting_drawer_view.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:provider/provider.dart';
import 'package:project/controllers/exercise_controller.dart';
import '../widgets/topAppBar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'dart:math' as Math;

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  static const id = '/SettingView';

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _universityFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var my_color_variable;
  TextEditingController _bioController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _uniController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    my_color_variable = MyColors.lightGreen;
    _bioController.text = 'دانشجوی مهندسی کامپیوتر دانشگاه خوارزم';
    _nameController.text = 'دانیال صابر';
    _uniController.text = 'خوارزمی';
    _passController.text = 'Password\$r#';
    _emailController.text = 'cheekym@gmail.com';
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _universityFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    if (sharedPreferences.isLogin) {
      return Scaffold(
        body: Column(
          children: <Widget>[
            // height: 160.0,

            Container(
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: CustomShape(),
                    child: Container(
                      height: 175,
                      width: double.infinity,
                      color: MyColors.blueAccentHex,
                    ),
                  ),
                  Positioned(
                    top: 60.0,
                    left: 320.0,
                    right: 0.0,
                    child: Center(
                      child: new Container(
                        child: new Material(
                          child: new InkWell(
                            onTap: () {
                              print("tapped");
                            },
                            child: new Container(
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushReplacementNamed(SettingDrawer.id),
                                child: Icon(
                                  Icons.menu,
                                  color: MyColors.iconColor,
                                ),
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80.0,
                    left: 0.0,
                    right: 0.0,
                    child: new Center(
                      child: new Container(
                        child: new Material(
                          child: new InkWell(
                            onTap: () {
                              print("tapped");
                            },
                            child: new Container(
                              width: 75.0,
                              height: 75.0,
                              child: InkWell(
                                onTap: () => {},
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/images/ic_profile.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60.0,
                    left: 55.0,
                    right: 0.0,
                    child: new Center(
                      child: new Container(
                        width: 75.0,
                        height: 75.0,
                        child: Image.asset("assets/images/camera.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'دانیال صابر',
                    style: TextStyle(
                      color: Color(0xff181818),
                      fontSize: 26,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'BLotus',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'دانشجوی مهندسی کامپیوتر دانشگاه خوارزمی',
                    style: TextStyle(
                      color: Color(0xff181818),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BLotus',
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Expanded(
                child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      Text(
                        'بیوگرافی',
                        style: TextStyle(
                          color: Color(0xff181818),
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'BLotus',
                        ),
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: _bioController,
                        // initialValue: 'دانشجوی مهندسی کامپیوتر دانشگاه خوارزمی',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BLotus',
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: myinputborder(),
                          enabledBorder: myinputborder(),
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_nameFocusNode);
                        },
                        validator: (value) {
                          if (value!.length > 50) {
                            return 'بیوگرافی باید کمتر از 50 کاراکتر باشد.';
                          }

                          return null;
                        },
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 22,
                              bottom: 3,
                            ),
                            child: Text(
                              'نام و نام خانوادگی',
                              style: TextStyle(
                                color: Color(0xff181818),
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BLotus',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 22,
                              bottom: 3,
                            ),
                            child: Text(
                              'دانشگاه',
                              style: TextStyle(
                                color: Color(0xff181818),
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BLotus',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              autofocus: false,
                              controller: _nameController,
                              // initialValue: 'دانشجوی مهندسی کامپیوتر دانشگاه خوارزمی',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BLotus',
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                              ),

                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              focusNode: _nameFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_universityFocusNode);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'نام و نام خانوادگی نباید خالی باشد.';
                                }
                                if (value.length > 10) {
                                  return 'نام و نام خانوادگی باید کمتر از 10 کاراکتر باشد.';
                                }

                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              autofocus: false,
                              controller: _uniController,
                              // initialValue: 'دانشجوی مهندسی کامپیوتر دانشگاه خوارزمی',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BLotus',
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                              ),

                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              focusNode: _universityFocusNode,

                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'نام دانشگاه نباید خالی باشد.';
                                }
                                if (value.length > 10) {
                                  return 'دانشگاه باید کمتر از 10 کاراکتر باشد.';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 11),
                        child: Text(
                          'ایمیل',
                          style: TextStyle(
                            color: Color(0xff181818),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'BLotus',
                          ),
                        ),
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: _emailController,
                        // initialValue: 'دانشجوی مهندسی کامپیوتر دانشگاه خوارزمی',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BLotus',
                        ),
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.brightness_1_rounded,
                              size: 15,
                              color: my_color_variable,
                            ), // icon is 48px widget.
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: myinputborder(),
                          enabledBorder: myinputborder(),
                        ),

                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        focusNode: _emailFocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ایمیل نباید خالی باشد.';
                          }
                          if (!EmailValidator.validate(value, true)) {
                            setState(
                              () {
                                my_color_variable = Colors.red;
                              },
                            );
                          } else {
                            setState(
                              () {
                                my_color_variable = MyColors.lightGreen;
                              },
                            );

                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 11),
                        child: Text(
                          'رمز عبور',
                          style: TextStyle(
                            color: Color(0xff181818),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'BLotus',
                          ),
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        autofocus: false,
                        controller: _passController,
                        textDirection: TextDirection.ltr,
                        // initialValue: 'دانشجوی مهندسی کامپیوتر دانشگاه خوارزمی',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BLotus',
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: new Container(
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(ChangePasswordView.id),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/Icon feather-edit-2.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: myinputborder(),
                          enabledBorder: myinputborder(),
                        ),

                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        focusNode: _passwordFocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 36, bottom: 33.7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: MyColors.blueHex,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 25,
                                  ),
                                ),
                                onPressed: _saveForm,
                                child: const Text(
                                  'ذخیره',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BLotus',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: InkWell(
                                child: const Text(
                                  'حذف حساب کاربری',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.red,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BLotus',
                                  ),
                                ),
                                onTap: () => Navigator.of(context)
                                    .pushReplacementNamed(SettingDrawer.id),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    padding: EdgeInsets.only(top: 26, left: 33, right: 32),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, LoginView.id);
      return const Text('لطفا کمی صبر کنید.');
    }
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(13)),
      borderSide: BorderSide(
        color: Color.fromRGBO(218, 221, 224, 0.55),
        width: 1,
      ),
    );
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Color.fromRGBO(218, 221, 224, 0.55),
        width: 3,
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.7, size.width, 0);
    // double degToRad(num deg) => deg * (Math.pi / 180.0);
    // path.addArc(Rect.from(Offset(size.width/2,size.height/2), size.width, size.height), degToRad(360),
    //     degToRad(360));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
