import 'package:flutter/material.dart';

class B_AppBar extends StatelessWidget {
  const B_AppBar({
    Key? key,
    this.onTapLessons,
    this.onTapHome,
    this.fromLessons = false,
  }) : super(key: key);
  final void Function()? onTapLessons;
  final void Function()? onTapHome;
  final bool fromLessons;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            fromLessons
                ? InkWell(
                    onTap: (){
                     onTapHome!.call();
                    },
                    child: const Icon(
                      Icons.home,
                      color: Colors.lightBlue,
                    ),
                  )
                : ElevatedButton(
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
                            style: TextStyle(
                                fontFamily: 'Vazir', color: Colors.white),
                          ),
                        ),
                      ],
                    )),
            fromLessons
                ? ElevatedButton(
                    onPressed: () => {},
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      primary: Colors.lightBlue,
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.menu_book_outlined),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            'دروس',
                            style: TextStyle(
                                fontFamily: 'Vazir', color: Colors.white),
                          ),
                        ),
                      ],
                    ))
                : InkWell(
                    onTap: onTapLessons,
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
