import 'package:flutter/material.dart';
class TopAppBar extends StatefulWidget {
  const TopAppBar({Key? key}) : super(key: key);

  @override
  _TopAppBarState createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context) {

    return PreferredSize(
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
    );
  }
}
