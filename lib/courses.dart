import 'package:flutter/material.dart';
import 'package:project/ui/bottomAppBar.dart';
import 'package:project/ui/card.dart';
import 'package:project/ui/topAppBar.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final _formSearchKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90), // Set this height
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'سلام؛',
                      style: TextStyle(
                        color: Color(0xff2f2f2f),
                        fontSize: 16,
                        fontFamily: 'BLotus',
                      ),
                    ),
                    Text(
                      'دانیال صابر 👋',
                      style: TextStyle(
                        color: Color(0xff181818),
                        fontSize: 28,
                        fontFamily: 'BLotus',
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => {},
                  child: Image.asset("assets/images/profile.png",
                      width: 60.0, height: 60.0, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formSearchKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (screenWidth - 40) * 0.8,
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              textDirection: TextDirection.ltr,
                            ),
                            hintTextDirection: TextDirection.rtl,
                            border: InputBorder.none,
                            hintText: "جست و جو",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.grey),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                primary: Colors.lightBlue),
                            onPressed: () async {
                              // if () {
                              //   setState(() {});
                              //   Navigator.pushNamed(context, '/search');
                              // }
                            },
                            child: Icon(Icons.tune),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text("دسته بندی"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 170,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              primary: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.home_outlined),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    'همه',
                                    style: TextStyle(
                                        fontFamily: 'Vazir',
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        width: 170,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              primary: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.home_outlined),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    "دروس",
                                    style: TextStyle(
                                        fontFamily: 'Vazir',
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 170,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              primary: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.home_outlined),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    'تکالیف',
                                    style: TextStyle(
                                        fontFamily: 'Vazir',
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        width: 170,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              primary: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.home_outlined),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    'آخرین مباحث',
                                    style: TextStyle(
                                        fontFamily: 'Vazir',
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ListView(
          //   scrollDirection: Axis.horizontal,
          Row(
            children: [
              Card_(),
              Card_(),
              Card_(),
              Card_(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: B_AppBar(),
    );
  }
}
