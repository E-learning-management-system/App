import 'package:flutter/material.dart';

class Card_ extends StatelessWidget {
  const Card_({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 32, 17, 241),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      elevation: 0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90, height: 90,
                child:  Image.asset("assets/images/image_2.PNG")),
            const Text('ریاضی مهندسی',
                style: TextStyle(
                  color: Color.fromARGB(255, 253, 251, 251),
                  fontFamily: 'Vazir',
                  fontSize: 16,
                ),
              ),
            ],
        ),
      ),
    );
  }
}
