
import 'package:flutter/material.dart';
import 'package:project/controllers/student_delivery_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/models/answer_model.dart';
import 'package:project/views/tab_lessons/answer_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/empty_view_widget.dart';
import 'package:provider/provider.dart';

import '../../helpers/sharedPreferences.dart';
import 'item_lessons_view.dart';
class StudentDeliveryView extends StatelessWidget {
  const StudentDeliveryView({Key? key,required this.title,required this.Id}) : super(key: key);
  static const String id = '/student_delivery';
  final String title;
  final int Id;
  @override
  Widget build(BuildContext context) {
    final isComplete = ModalRoute.of(context)!.settings.arguments as bool;
    final cnt = Provider.of<StudentDeliveryController>(context,listen: false);
    Future<List<String>?> list()async{
     if(isComplete){
       await cnt.getAnswerStudent(Id);
       print("print");
       return cnt.answerStudent[Id];
     }else{
       await cnt.getNotAnswerStudent(Id);
       return cnt.notAnswerStudent[Id];
     }
    }
    return Scaffold(
      appBar: AppbarWidget(text: title,),
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
                child: FutureBuilder(
                  future: list(),
                  builder:(context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return const EmptyViewWidget();
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 0,
                          right: 15,left: 15),
                      itemCount:isComplete? cnt.answerStudent[Id]?.length: cnt.notAnswerStudent[Id]?.length,
                      itemExtent: 80,
                      itemBuilder: (context, index) {
                        final data = isComplete? cnt.answerStudent[Id]![index]: cnt.notAnswerStudent[Id]![index];
                        return GestureDetector(onTap: (){
                          if(isComplete) {
                            Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                AnswerView(answer: cnt.answers.where((element) =>
                                element.user_email == data).toList()[0],),settings: RouteSettings(arguments:sharedPreferences.getType() == 't'?
                          EnCreateHomeWork.Professor :EnCreateHomeWork.Student )
                          ),);
                          }
                          },child: Card(
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
                                  child: Text(data,
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      )),
                                ),

                              ],
                            ),
                          ),
                        ),);
                      },
                    );
                  },
                ),  )


          ],
        ),
      ),
    );
  }
}
