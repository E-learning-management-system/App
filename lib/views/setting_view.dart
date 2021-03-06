import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io';

import 'package:project/controllers/setting_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/models/profile_model.dart';
import 'package:project/views/change_password_view.dart';
import 'package:project/views/delete_account_view.dart';
import 'package:project/views/home_view.dart';
import 'package:project/views/login_view.dart';
import 'package:project/views/setting_drawer_view.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:provider/provider.dart';

import '../widgets/topAppBar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:project/pickers/user_image_picker.dart';
import 'dart:math' as Math;

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  static const id = '/SettingView';

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  File? _pickedImage;

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _universityFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  var my_color_variable;
  TextEditingController _bioController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _uniController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _photoController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    my_color_variable = MyColors.lightGreen;
    // _bioController.text = '?????????????? ???????????? ???????????????? ?????????????? ????????????';
    // _nameController.text = '???????????? ????????';
    // _uniController.text = '??????????????';
    _passController.text = 'Password\$r#';
    // _emailController.text = 'cheekym@gmail.com';
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

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    final File? imagefile = File(image!.path);

    setState(() {
      _pickedImage = imagefile!;
      // _photoController.text=imagefile!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ChangeSettingControler>(context);
    String name = '';
    String bio = '';
    String photo = '';
    String email = '';
    Future<ProfileModel> profile() async {
      var res = await controller.getProfile();
      if (res != false) {
        return res;
      }

      return ProfileModel(
          name: '',
          email: '',
          university: '',
          type: '',
          date_joined: '',
          last_login: '',
          bio: '',
          photo: '');
    }

    if (sharedPreferences.isLogin) {
      return Scaffold(
        body: FutureBuilder(
          future: profile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            ProfileModel profile = snapshot.data as ProfileModel;
            // _emailController.text = profile.email;
            // _nameController.text = profile.name;
            // _bioController.text = profile.bio;
            // _photoController.text = profile.photo;
            return Form(
              key: controller.keyForm,
              child: Column(
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
                                          .pushReplacementNamed(
                                              SettingDrawer.id),
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
                          // child: UserImagePicker(),
                          child: new Center(
                            child: new Container(
                              width: 75.0,
                              height: 75.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage:

                                    // profile.photo !=null ? Image.network('https://googleflutter.com/sample_image.jpg') as ImageProvider:

                                    _pickedImage != null
                                        ? FileImage(_pickedImage!)
                                        : FileImage(File(_photoController.text))

                                // AssetImage(
                                //         "assets/images/ic_profile.png")
                                //     as ImageProvider

                                ,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60.0,
                          left: 55.0,
                          right: 0.0,
                          child: InkWell(
                            onTap: _pickImage,
                            child: new Center(
                              child: new Container(
                                width: 75.0,
                                height: 75.0,
                                child: Image.asset("assets/images/camera.png"),
                              ),
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
                          profile.name,
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
                          '?????????????? ???????????? ???????????????? ${profile.university} ',
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
                      child: ListView(
                        children: [
                          Text(
                            '????????????????',
                            style: TextStyle(
                              color: Color(0xff181818),
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'BLotus',
                            ),
                          ),
                          SizedBox(
                            height: 79,
                            child: TextFormField(
                              onChanged: (String newBio) {
                                bio = newBio;
                              },
                              autofocus: false,
                              controller:
                                  TextEditingController(text: profile.bio),
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
                                FocusScope.of(context)
                                    .requestFocus(_nameFocusNode);
                              },
                              validator: (value) {
                                if (value!.length > 50) {
                                  return '???????????????? ???????? ???????? ???? 50 ?????????????? ????????.';
                                }

                                return null;
                              },
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 22,
                                  bottom: 3,
                                ),
                                child: Text(
                                  '?????? ?? ?????? ????????????????',
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
                                  '??????????????',
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
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    onChanged: (String newName) {
                                      name = newName;
                                    },
                                    autofocus: false,
                                    controller: TextEditingController(
                                        text: profile.name),
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
                                        return '?????? ?? ?????? ???????????????? ?????????? ???????? ????????.';
                                      }
                                      if (value.length > 10) {
                                        return '?????? ?? ?????? ???????????????? ???????? ???????? ???? 10 ?????????????? ????????.';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: TextEditingController(
                                        text: profile.university),
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
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return '?????? ?????????????? ?????????? ???????? ????????.';
                                    //   }
                                    //   if (value.length > 10) {
                                    //     return '?????????????? ???????? ???????? ???? 10 ?????????????? ????????.';
                                    //   }

                                    //   return null;
                                    // },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 11),
                            child: Text(
                              '??????????',
                              style: TextStyle(
                                color: Color(0xff181818),
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BLotus',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              autofocus: false,
                              controller:
                                  TextEditingController(text: profile.email),
                              onChanged: (String newEmail) {
                                email = newEmail;
                              },
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
                                () {};
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '?????????? ?????????? ???????? ????????.';
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 11),
                            child: Text(
                              '?????? ????????',
                              style: TextStyle(
                                color: Color(0xff181818),
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BLotus',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              readOnly: true,
                              autofocus: false,
                              controller: _passController,
                              textDirection: TextDirection.ltr,
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
                              onFieldSubmitted: (_) {},
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 36, bottom: 33.7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: MyColors.blueHex,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 31,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (controller.keyForm.currentState!
                                          .validate()) {
                                        var resEmail =
                                            await controller.changeEmail(email);
                                        var resProfile =
                                            await controller.changeProfile(
                                                name, bio, _pickedImage!);
                                        if (resEmail && resProfile) {
                                          print(email);

                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text('???????????? ????????'),
                                              content: const Text(
                                                  '??????????????  ???? ???????????? ?????????? ????????.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('????????'),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text('??????'),
                                              content: const Text(
                                                  '?????????? ???? ?????????? ???????????????? ???????? ???????? ????????.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('????????'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: const Text(
                                      '??????????',
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
                                      '?????? ???????? ????????????',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.red,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'BLotus',
                                      ),
                                    ),
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(DeleteAccountView.id),
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
                ],
              ),
            );
          },
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, LoginView.id);
      return const Text('???????? ?????? ?????? ????????.');
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

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
