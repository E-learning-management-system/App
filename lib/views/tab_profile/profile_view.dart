

import 'package:flutter/material.dart';
import 'package:project/controllers/profile_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:provider/provider.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);
  static const String id = '/profile';
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProfileController>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: 100,
              width: double.infinity,
              color: MyColors.blueAccentHex,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 12, left: 24),
                    alignment: Alignment.topLeft,
                    child: Icon(
                        Icons.arrow_forward
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 36,
                    top: 20
                  ),
                  child: Row(
                    children: [
                      Image.asset('$baseUrlImage/ic_profile.png',
                      height: 60,
                      width: 60,),
                      SizedBox(width: 12,),
                      Text('دانیال صابر',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.only(right: 12,
                  left: 12),
                  child: Text('دانشجویی مهندسی کامپیوتر دانشگاه خوارزمی',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 60,),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      Image.asset('$baseUrlImage/ic_uni.png',
                      height: 33,
                      width: 33,),
                      SizedBox(width: 8,),
                      Text('خوارزم',
                      style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('TestEmail@email.com',),
                      SizedBox(width: 8,),
                      Image.asset('$baseUrlImage/ic_mail.png',
                      height: 27,
                      width: 27,)
                    ],
                  ),
                )



              ],
            ),
          )

        ],
      ),
    );
  }
}
class CustomShape extends CustomClipper<Path>
{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width,size.height);
    path.lineTo(-size.height, -20);
    path.lineTo(size.width,0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}
