import '../helpers/colors.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSize {
  final String text;
  final double elevation;
  final bool centerTitle;
  const AppbarWidget(
      {Key? key,
      required this.text,
      this.elevation = 3,
      this.centerTitle = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      elevation: elevation,
      title: Text(text),
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => const Size(double.infinity, 50);
}

Widget sizedBox({double? height, double? width}) => SizedBox(
      height: height,
      width: width,
    );
