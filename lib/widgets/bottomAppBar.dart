import 'package:flutter/material.dart';

class B_AppBar extends StatelessWidget {
  const B_AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  primary: Colors.lightBlue,
                ),
                child: Row(
                  children: const [
                    Icon(Icons.home),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Text(
                        'خانه',
                        style:
                            TextStyle(fontFamily: 'Vazir', color: Colors.white),
                      ),
                    ),
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
