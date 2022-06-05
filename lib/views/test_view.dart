import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/subject_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/views/home_view.dart';
import 'package:project/views/login_view.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:provider/provider.dart';
import 'package:project/controllers/exercise_controller.dart';
import '../widgets/topAppBar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  static const id = '/TestPage';

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Container(
            // height: 160.0,
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
                                      ))),
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
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'دانشجوی مهندسی کامپیوتر دانشگاه خوارزمی',
                    border: myinputborder(),
                    // enabledBorder: myinputborder(),
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Image.asset(
    //           "assets/images/path.png",
    //           fit: BoxFit.contain,
    //           height: 32,
    //         ),
    //         Container(
    //             padding: const EdgeInsets.all(8.0), child: Text('YourAppTitle'))
    //       ],
    //     ),
    //   ),
    // appBar: AppBar(
    //   title: Image.asset("assets/images/path.png", fit: BoxFit.cover),
    // ),
    // body: ,

    // body: SizedBox.expand(
    //   child: PageView(
    //     controller: _pageController,
    //     onPageChanged: (index) {
    //       setState(() => _currentIndex = index);
    //     },
    //     children: <Widget>[
    //       HomeView(),
    //       Container(
    //         color: Colors.red,
    //       ),
    //       Container(
    //         color: Colors.green,
    //       ),
    //       Container(
    //         color: Colors.blue,
    //       ),
    //     ],
    //   ),
    // ),
    // bottomNavigationBar: BottomNavyBar(
    //   selectedIndex: _currentIndex,
    //   onItemSelected: (index) {
    //     setState(() => _currentIndex = index);
    //     _pageController.jumpToPage(index);
    //   },
    //   items: <BottomNavyBarItem>[
    //     BottomNavyBarItem(
    //       title: Text(
    //         'خانه',
    //         style: TextStyle(
    //           fontFamily: 'Vazir',
    //           color: Colors.white,
    //         ),
    //       ),
    //       icon: Icon(Icons.home),
    //       activeColor: MyColors.blueAccentHex,
    //       // inactiveColor: Colors.white,
    //     ),
    //     BottomNavyBarItem(
    //       title: Text('دروس'),
    //       icon: Icon(Icons.menu_book_outlined),
    //     ),
    //     BottomNavyBarItem(
    //       title: Text('تقویم'),
    //       icon: Icon(Icons.event_note_outlined),
    //     ),
    //     BottomNavyBarItem(
    //       title: Text('تنظیمات'),
    //       icon: Icon(Icons.person),
    //     ),
    //   ],
    // ),
    // );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 3,
        ));
  }
}
