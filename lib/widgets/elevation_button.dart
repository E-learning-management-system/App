import 'package:flutter/material.dart';

class ElevationButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final IconData? icon;
  final String text;
  final Color primaryColor;
  final Color textColor;
  final String fontFamily;
  final Function() call;
  final Color? iconColor;
  final Color? bgColorIcon;
  final double borderRadius;
  final double fontSize;

  const ElevationButtonWidget({
    Key? key,
    this.width = 170,
    this.height = 40,
    this.fontFamily = 'Vazir',
    this.icon,
    this.text = 'ورود',
    required this.call,
    this.iconColor,
    this.primaryColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 18.0,
    this.fontSize = 15,
    this.bgColorIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: call,
        style: ElevatedButton.styleFrom(
            minimumSize: Size(width, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            primary: primaryColor,
            shadowColor: primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: icon != null,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(icon, size: 15, color: iconColor),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: bgColorIcon,
                ),
              ),
            ),
            Container(
              width: 90,
              child: Padding(
                padding: const EdgeInsets.only(
                    // right: 10,
                    ),
                child: Text(
                  text,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
