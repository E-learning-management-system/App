import 'package:flutter/material.dart';
class Splash3 extends StatelessWidget {
  const Splash3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                  "assets/images/image_4.PNG",
                  width: 300.0,
                  height: 300.0,
                  fit: BoxFit.cover
              ),
              Text(
                "پرسش و پاسخ با اساتید ",
                style: TextStyle(color: Color(0xff181818),fontSize: 28,
                  fontFamily: 'Blotus',),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "دانشجویان می توانند سوالات خود را مطرح کنند و برای ویرایش پاسخ این سوال ها همکاری کنند. ",
                  style: TextStyle(color: Color(0xff494949),fontSize: 18,
                    fontFamily: 'lotus',),
                  textDirection: TextDirection.rtl,
                ),
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
                          color: Color(0xff005ffc),
                          shape: BoxShape.circle,
                        )),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary:Colors.lightBlue
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, '/login');
                      }, child: Text("ورود",style: TextStyle(
                      fontFamily: 'lotus',
                      fontSize: 18,
                    ),),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary:Colors.pinkAccent
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, '/signup');
                      }, child: Text("ثبت نام",style: TextStyle(
                      fontFamily: 'lotus',
                      fontSize: 18,
                    ),),
                    ),
                  )
                ],
              )
            ])

    );
  }
}
