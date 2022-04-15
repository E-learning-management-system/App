import 'package:flutter/material.dart';
class Splash1 extends StatelessWidget {
  const Splash1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
                "assets/images/image_1.png",
                width: 200.0,
                height: 100.0,
                fit: BoxFit.cover
            ),
            Text(
              "سامانه هدفمند یادگیری الکترونیکی ",
              style: TextStyle(color: Color(0xff9200c7),fontSize: 25),
            ),
            Image.asset(
                "assets/images/image_2.PNG",
                width: 250.0,
                height: 250.0,
                fit: BoxFit.cover
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap:() {
                    Navigator.pushNamed(context, '/splash1');
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                      width: 15.0,
                      height: 15.0,
                      decoration: new BoxDecoration(
                        color: Color(0xff005ffc),
                        shape: BoxShape.circle,
                      )),
                ),
                InkWell(
                  onTap:() {
                    Navigator.pushNamed(context, '/splash2');
                  },
                  child: Container(
                      margin: EdgeInsets.all(5),
                      width: 15.0,
                      height: 15.0,
                      decoration: new BoxDecoration(
                        color: Color(0xff83b2ff),
                        shape: BoxShape.circle,
                      )),
                ),
                InkWell(
                  onTap:() {
                    Navigator.pushNamed(context, '/splash3');
                  },
                  child: Container(
                      margin: EdgeInsets.all(5),
                      width: 15.0,
                      height: 15.0,
                      decoration: new BoxDecoration(
                        color: Color(0xff83b2ff),
                        shape: BoxShape.circle,
                      )),
                ),

              ],
            ),
            ])

      ),
    );
  }
}
