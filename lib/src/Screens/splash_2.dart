import 'package:flutter/material.dart';
class Splash2 extends StatelessWidget {
  const Splash2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                  "assets/images/image_3.PNG",
                  width: 300.0,
                  height: 300.0,
                  fit: BoxFit.cover
              ),
              Text(
                "پرسش و پاسخ با اساتید ",
                style: TextStyle(color: Color(0xff181818),fontSize: 25),
              ),
              Text(
                "دانشجویان می توانند سوالات خود را مطرح کنند و برای ویرایش پاسخ این سوال ها همکاری کنند. ",
                style: TextStyle(color: Color(0xff494949),fontSize: 15),
                textDirection: TextDirection.rtl,
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
                          color: Color(0xff83b2ff),
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
                          color: Color(0xff005ffc),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary:Colors.pinkAccent),
                    onPressed: (){
                      Navigator.pushNamed(context, '/login');
                    }, child: Text("ورود"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/signup');
                    }, child: Text("ثبت نام"),
                  )
                ],
              )
            ])

    );
  }
}
