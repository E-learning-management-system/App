import '../helpers/colors.dart' as addedColor;
import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSize {
  final String text;
  final int type;
  final String imageUrl;
  const TopAppBar(
    this.text,
    this.type,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'سلام؛',
                    style: TextStyle(
                      color: addedColor.MyColors.greyHello,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BLotus',
                    ),
                  ),
                  Text(
                    '$text👋',
                    style: TextStyle(
                      color: Color(0xff181818),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BLotus',
                    ),
                  ),
                ],
              ),
              (type == 1)
                  ? Container(
                      width: 45,
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
                    )
                  : Container(
                      width: 45,
                      child: InkWell(
                          onTap: () => {},
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/ic_profile2.png",
                                ),
                              ),
                            ),
                          )),
                    ),
            ],
          ),
        ),
      ),
    );

    // AppBar(
    //   centerTitle: centerTitle,
    //   elevation: elevation,
    //   title: Text(text),
    //   backgroundColor: Colors.white,
    // );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => const Size(double.infinity, 90);
}



// Widget sizedBox({double? height, double? width}) => SizedBox(height:height ,
// width: width,);