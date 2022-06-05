
import 'package:flutter/material.dart';
import 'package:project/helpers/constants.dart';

class AppbarWidget extends StatelessWidget implements PreferredSize{
  final String? text;
  final double elevation;
  final bool centerTitle;
  final bool showIc;
  final bool shoeIcPop;
  AppbarWidget({Key? key,
    required this.text,
    this.elevation = 1,
    this.centerTitle=true,
    this.showIc=false,
    this.shoeIcPop = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      elevation: elevation,
      leading: Visibility(
        visible: shoeIcPop,
        replacement: SizedBox(),
        child: IconButton(
          splashRadius: 20,
          onPressed: (){
            Navigator.pop(context);
          },
           icon: Icon(Icons.arrow_back_rounded),
            ),
      ),
      leadingWidth: shoeIcPop?45 : 0,
      title: Row(
        children: [
          Visibility(
            visible: showIc,
            child: Image.asset('$baseUrlImage/ic_appbar.png',
            width: 20,
            height: 20,),
          ),
          sizedBox(width: 8),
          Text(text!),

        ],
      ),
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => const Size(double.infinity, 50);
}


Widget sizedBox({double? height, double? width}) => SizedBox(height:height ,
width: width,);