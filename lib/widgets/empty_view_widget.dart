

import 'package:flutter/material.dart';


class EmptyViewWidget extends StatelessWidget {
  const EmptyViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(
        'موردی یافت نشد !',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
