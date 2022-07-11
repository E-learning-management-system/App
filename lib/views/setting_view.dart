import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/subject_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/views/home_view.dart';
import 'package:project/views/login_view.dart';
import 'package:project/views/setting_drawer_view.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:provider/provider.dart';
import 'package:project/controllers/exercise_controller.dart';
import '../widgets/topAppBar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

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
  TextEditingController _bioController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _uniController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // height: 160.0,

          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  // color: Colors.red,
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    child: Image.asset('assets/images/path.png'),
                    fit: BoxFit.fill,
                  ),
                  // Center(
                  //   child: Text(
                  //     "Home",
                  //     style: TextStyle(color: Colors.white, fontSize: 18.0),
                  //   ),
                  // ),
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
                padding: const EdgeInsets.symmetric(vertical: 5.0),
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
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'بیوگرافی',
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
                    controller: _bioController,
                    // initialValue: 'دانشجوی مهندسی کامپیوتر دانشگاه خوارزمی',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BLotus',
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_nameFocusNode);
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                            fillColor: MyColors.appBarColor,
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
                            fillColor: MyColors.appBarColor,
                            border: myinputborder(),
                            enabledBorder: myinputborder(),
                          ),

                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: _universityFocusNode,

                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus();
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                      fillColor: MyColors.appBarColor,
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                    ),

                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                      fillColor: MyColors.appBarColor,
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                    ),

                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    focusNode: _passwordFocusNode,
                    // onFieldSubmitted: (_) {
                    //   FocusScope.of(context).requestFocus(_priceFocusNode);
                    // },
                  ),
                ],
                padding: EdgeInsets.all(30),
              ),
            ),
          )),
        ],
      ),
    );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(13)),
        borderSide: BorderSide(
          color: Color.fromRGBO(218, 221, 224, 0.55),
          width: 1,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromRGBO(218, 221, 224, 0.55),
          width: 3,
        ));
  }
}
