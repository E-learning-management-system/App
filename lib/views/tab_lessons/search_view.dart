
import 'package:flutter/material.dart';
import 'package:project/controllers/item_lessons_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/search_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/helpers/utility.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/views/tab_lessons/last_topic_view.dart';
import 'package:project/views/tab_lessons/record_home_work_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'item_lessons_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);
  static const String id = '/search_view';

  @override
  Widget build(BuildContext context) {
    final  controller = Provider.of<SearchController>(context);
    controller.list1 = ModalRoute.of(context)!.settings.arguments as List<ItemCategoryModel>;

    return Scaffold(
      appBar: AppbarWidget(
        text: 'جست و حو',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30,
            right: 15,
            left: 15),
        child: Column(
          children: [
            TextFormFieldWidget(hintText: 'کلمه مورد نظر را وارد کنید',
                controller: controller.searchBox,
                onChanged: (v)=>{
              controller.onChanged(v),
                },
                fillColor: MyColors.blueAccentHex,
                noneEnableBorder: false,
                colorHint: Colors.white,
                textTypeColor: Colors.white,
                actionKeyboard: TextInputAction.search,
                filled: true),
            sizedBox(height: 12,),
            Row(
              children: [
                const Text('نتایج جست و جو',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                sizedBox(width: 4),
                const Icon(Icons.search,color: Colors.yellow,)
              ],
            ),
            _buildListSearch(controller)

          ],
        ),
      ),
    );
  }

  _buildListSearch(SearchController controller)
  {
    if(controller.searchBox.value.text==''){
      controller.myList=controller.list1;
    }
    return GridView.builder(
      shrinkWrap: true,
      itemCount: controller.myList.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8,
          vertical: 15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 7/8,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4),
      itemBuilder: (context, index) {
        return GestureDetector(child:  Column(
          children: [
            Image.asset(Utility.randomImage(),
              height: 100,
              width: 100,),
            sizedBox(height: 4),
            Text(controller.myList[index].title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,)
          ],
        ), onTap: ()async{
          if(controller.myList[index].category=='Lesson'){
            var id=await sharedPreferences.getLessonId(controller.myList[index].title);
            var data=await controller.getLessonById(id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemLessonsView(lesson:data),
              ),);
          }
          if(controller.myList[index].category=='Subject'){
            var id=sharedPreferences.getTopicId(controller.myList[index].title);
            var data=await controller.getTopicById(id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LastTopicView(subject: data,),
              ),);
          }
          if(controller.myList[index].category=='Exercise'){
            var id=sharedPreferences.getExerciseByTitle(controller.myList[index].title);
            var data=await controller.getExerciseById(id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecordHomeWorkView(exercise: data,),
              ),);
          }
        },);
      },);
  }
}

