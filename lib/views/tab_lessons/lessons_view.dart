

import 'package:flutter/material.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/verify_email_controller.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/models/lessons_item_model.dart';
import 'package:project/views/tab_lessons/create_new_lessons_view.dart';
import 'package:project/widgets/bottomAppBar.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';



class LessonsView extends StatelessWidget {
  const LessonsView({Key? key}) : super(key: key);
  static const String id = '/lessons_view';

  @override
  Widget build(BuildContext context){
    final controller = Provider.of<LessonsController>(context);
    final theme = Theme.of(context).textTheme;


    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          _buildSearchWidget(),
          Expanded(
            child: ListView.builder(
              itemExtent: 140,
                itemCount: controller.listOfLessons.length,
                padding: const EdgeInsets.only(right: 20,
                left: 20,
                bottom: 20),
                itemBuilder: (context, index) {
                final data = controller.listOfLessons[index];

                  return _buildItemLessons(
                    index: index+1,
                    data: data,
                    theme: theme
                      );
                },),
          )
        ],
      ),
      floatingActionButton: _buildFloatAc(context),
      bottomNavigationBar: B_AppBar(
        fromLessons: true,
        onTapHome: (){
          Navigator.of(context).pop();
        },
      ),
    );
  }
  Widget _buildSearchWidget()
  {
    return  const Padding(
      padding:EdgeInsets.only(
          top: 50,
          right: 15,
          left: 15,
          bottom: 20
      ),
      child: SizedBox(
        height: 40,
        child: TextFormFieldWidget(
          hintText: 'جست و جو',
          noneEnableBorder: false,
          actionKeyboard: TextInputAction.search,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Icon(
              Icons.search),
        ),
      ),
    );
  }

  Widget _buildItemLessons({
    required LessonsItemModel data,
    required int index,
  required TextTheme theme})
  {

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusButton)
      ),
      color: data.bgColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(data.title,
                style: theme.headline6!.copyWith(
                  color: Colors.white
                )),
                const SizedBox(
                  height: 15,
                ),
                Text('تاریخ امتحان : ${data.examDate}',
                style: theme.caption!.copyWith(
                    color: Colors.white
                ),)
              ],
            ),
            Image.asset('img_1.png'
            ,height: 100,
            width: 100,),

          ],
        ),
      ),
    );
  }

  Widget _buildFloatAc(BuildContext context)
  {
    return FloatingActionButton.extended(
        onPressed: (){
          Navigator.of(context).pushNamed(CreateNewLessonsView.id);
        },
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusButton)
        ),
        icon: const Icon(
          Icons.add,
          size: 18,
        ),
        label: const Text('درس جدید'));
  }


}
