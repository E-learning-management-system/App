
import 'package:flutter/material.dart';
import 'package:project/controllers/student_delivery_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';
class StudentDeliveryView extends StatelessWidget {
  const StudentDeliveryView({Key? key}) : super(key: key);
  static const String id = '/student_delivery';
  @override
  Widget build(BuildContext context) {
    final isComplete = ModalRoute.of(context)!.settings.arguments as bool;
    final cnt = Provider.of<StudentDeliveryController>(context);
    return Scaffold(
      appBar: AppbarWidget(text: 'ریاضی2 - تکلیف 1',),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30
        ),
        child: Column(
          children: [
            Text(isComplete ? 'دانشجویانی که تحویل داده اند': 'دانشچویانی که تحویل نداده اند',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isComplete ?Colors.green: Colors.red,
              fontSize: 18
            ),),
            Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 0,
                  right: 15,left: 15),
                  itemCount: cnt.listModel.length,
                    itemExtent: 80,
                    itemBuilder: (context, index) {
                      final data = cnt.listModel[index];
                      return Card(
                        margin: const EdgeInsets.only(top: 20),
                        color: MyColors.blueAccentHex,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  child: Image.asset('$baseUrlImage/ic_profile.png',
                                    height: 50,
                                    width: 50,)),
                              Container(
                                margin: const EdgeInsets.only(right: 15),
                                child: Text(data.title,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    )),
                              ),

                            ],
                          ),
                        ),
                      );
                    },))

          ],
        ),
      ),
    );
  }
}
