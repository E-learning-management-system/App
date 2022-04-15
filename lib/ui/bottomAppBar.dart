import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class B_AppBar extends StatelessWidget {
  const B_AppBar({Key? key}) : super(key: key);

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                ),
                child: Row(
                  children: const [
                    Text(
                      'خانه',
                      style:
                      TextStyle(fontFamily: 'Vazir', color: Colors.white),
                    ),
                    Icon(Icons.home_outlined)
                  ],
                )),
            InkWell(
              onTap: () => {},
              child: const Icon(
                Icons.menu_book_outlined,
                color: Colors.lightBlue,
              ),
            ),
            InkWell(
              onTap: () => {},
              child: const Icon(
                Icons.event_note_outlined,
                color: Colors.lightBlue,
              ),
            ),
            InkWell(
              onTap: () => {},
              child: Icon(
                Icons.person,
                color: Colors.lightBlue,
              ),
            ),



          ],
        ),
      ),
      color: Colors.white,
    );
  }
}
