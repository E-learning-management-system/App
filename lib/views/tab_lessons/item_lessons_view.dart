
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/item_lessons_controller.dart';
import 'package:project/controllers/posts_cpntroller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/exercise_item_model.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/models/lessons_item_model.dart';
import 'package:project/models/post_model.dart';
import 'package:project/views/tab_lessons/final_lessons_view.dart';
import 'package:project/views/tab_lessons/last_topic_view.dart';
import 'package:project/views/tab_lessons/record_home_work_view.dart';
import 'package:project/views/tab_lessons/search_view.dart';
import 'package:project/views/tab_profile/profile_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/bottomAppBar.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/empty_view_widget.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class ItemLessonsView extends StatelessWidget {
  final LessonsItemModel lesson;
  const ItemLessonsView({Key? key, required this.lesson}): super(key: key);
  static const String id = '/item_lessons_view';
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ItemLessonsController>(context,listen: false);
    controller.setId(lesson.id);
    // controller.getSubjectsOfCourse(lesson.id);
    final theme = Theme.of(context).textTheme;
    return _buildBody(
      controller: controller,
      theme: theme,
      title: lesson.title,
      context: context
    );
  }

  Future setLastTopic(ItemLessonsController controller)async{
    await controller.setItemCategory(StatusCategory.LastTopics);
  }
  Widget _buildBody(
      {required TextTheme theme,
        required ItemLessonsController controller,
        required String title,
      required BuildContext context}) {

    return Scaffold(
      appBar: AppbarWidget(
          text: title,
          centerTitle: false,
        showIc: true,
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.startFloat,
      body: Column(
              children: [
                _buildSearchWidget(context,controller),
                _buildCategoryWidget(),
                _buildListItems(theme, controller,context),

               ],
            ),
      floatingActionButton:    Visibility(
        visible: sharedPreferences.getType() == 't' && controller.status != StatusCategory.BookMark,
        child: FloatingActionButton.extended(
            backgroundColor: MyColors.blueHex,
            onPressed: ()async {
              if(controller.status == StatusCategory.HomeWork)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecordHomeWorkView(exercise: ExerciseItemModel(courseName:'',file:'',id:lesson.id,title: '',teacher: '',date: '',deadline: '',description: '',courseId: 0),),settings: RouteSettings(arguments:sharedPreferences.getType() == 't'?
                  EnCreateHomeWork.CreateNew :EnCreateHomeWork.Student )
                  ),);
                return;
              }
              if(controller.status==StatusCategory.Sp){
                sharedPreferences.setLessonTitle(lesson.title);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FinalLessonsView(),),);
                return;
              }
              await controller.openDialog(context);
            },
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusButton)
            ),
            icon: const Icon(
              Icons.add,
              size: 18,
            ),
            label:Text(controller.button),
      ),
    )
    );
  }
  Widget _buildSearchWidget(BuildContext context,ItemLessonsController controller)
  {
    return   Padding(
      padding:const EdgeInsets.only(
          top: 50,
          right: 46,
          left: 46,
      ),
      child: SizedBox(
        height: 40,
        child: TextFormFieldWidget(
          onTap: (){
            List<ItemCategoryModel> list=[];
            for(var i in controller.listModel) {
              if(controller.status==StatusCategory.LastTopics) {
                list.add(ItemCategoryModel(title:i.title,category: 'Subject'));
              }
              if(controller.status==StatusCategory.HomeWork) {
                list.add(ItemCategoryModel(title:i.title,category: 'Exercise'));
              }
            }
            Navigator.pushNamed(context, SearchView.id,arguments: list);

          },
          readOnly: true,
          hintText: '?????? ?? ????',
          noneEnableBorder: false,
          actionKeyboard: TextInputAction.search,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(
              Icons.search),
        ),
      ),
    );
  }

  Widget _buildCategoryWidget()
  {
    return  Consumer<ItemLessonsController>(
      builder: (context, controller, child) =>
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 22.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevationButtonWidget(
                        width: 150,
                        icon: Icons.star,
                        text: '?????????? ??????????',
                        call: () async{
                          await controller.setItemCategory(StatusCategory.LastTopics);
                        },
                        iconColor:
                        controller.status ==
                            StatusCategory.LastTopics
                            ? MyColors.blueHex
                            : Colors.white,
                        primaryColor:
                        controller.status ==
                            StatusCategory.LastTopics
                            ? MyColors.blueHex
                            : Colors.white,

                        textColor: controller.status ==
                            StatusCategory.LastTopics
                            ? Colors.white
                            : Colors.black,

                        bgColorIcon: controller.status !=
                            StatusCategory.LastTopics
                            ? Color(0xff4b2b99)
                            : Colors.white
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevationButtonWidget(
                      width: 150,
                      icon: Icons.assignment_rounded,
                      text: '????????????',
                      call: () async{
                        await controller.setItemCategory(StatusCategory.HomeWork);

                      },
                      iconColor:
                      controller.status ==
                          StatusCategory.HomeWork
                          ? Colors.green
                          : Colors.white,
                      primaryColor:
                      controller.status ==
                          StatusCategory.HomeWork
                          ? Colors.green
                          : Colors.white,

                      textColor: controller.status ==
                          StatusCategory.HomeWork
                          ? Colors.white
                          : Colors.black,

                      bgColorIcon: controller.status !=
                          StatusCategory.HomeWork
                          ? Colors.green
                          : Colors.white,
                    ),
                  ],
                ),
              ),
              sizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: ElevationButtonWidget(
                      width: 175,
                      icon: Icons.bookmark,
                      text: '?????? ?????? ?????????? ??????',
                      fontSize: 13,
                      call: () async{
                        await controller.setItemCategory(StatusCategory.BookMark);
                      },
                      iconColor:
                      controller.status ==
                          StatusCategory.BookMark
                          ? Colors.orange
                          : Colors.white,
                      primaryColor:
                      controller.status == StatusCategory
                          .BookMark
                          ? Colors.orange
                          : Colors.white,

                      textColor: controller.status ==
                          StatusCategory.BookMark
                          ? Colors.white
                          : Colors.black,

                      bgColorIcon: controller.status !=
                          StatusCategory.BookMark
                          ? Colors.orange
                          : Colors.white,
                    ),
                  ),
                  sizedBox(width: 8),


                  Visibility(
                    visible: sharedPreferences.getType() == 't',
                    child: ElevationButtonWidget(
                      width: 140,
                      icon: Icons.person,
                      text: '?????????????????? ????????',
                      fontSize: 10,
                      call: () async{
                       await controller.setItemCategory(StatusCategory.Sp);
                      },
                      iconColor:
                      controller.status ==
                          StatusCategory.Sp
                          ? Colors.pink
                          : Colors.white,
                      primaryColor:
                      controller.status == StatusCategory
                          .Sp
                          ? Colors.pink
                          : Colors.white,

                      textColor: controller.status ==
                          StatusCategory.Sp
                          ? Colors.white
                          : Colors.black,

                      bgColorIcon: controller.status !=
                          StatusCategory.Sp
                          ? Colors.pink
                          : Colors.white,
                    ),
                  ),



                ],
              ),

            ],
          ),
    );
  }
  Widget _buildListItems(TextTheme theme,ItemLessonsController controller,BuildContext context)
  {
    return Expanded(
      child:FutureBuilder(
        future:setLastTopic(controller) ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Consumer<ItemLessonsController>(
            builder: (context, value, child) {
              if(value.isLoading)
              {
                return Center(child: CircularProgressIndicator(),);
              }
              if(value.listModel.isEmpty)
              {
                return EmptyViewWidget();
              }

              return ListView.builder(
                itemCount: value.listModel.length,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20
                ),
                itemBuilder:(context, index) {
                  // final data = value.listOfExerciseOfCourse[index];
                  if(value.status == StatusCategory.BookMark)
                  {
                    return _buildBookMark(theme,value.saved[index],controller);
                  }
                  if(value.status == StatusCategory.Sp)
                  {
                    return _buildUsers(theme,value.listModel[index],context,controller);
                  }
                  if(value.status== StatusCategory.LastTopics){
                    final data = value.listOfSubjectOfCourse[index];
                    return GestureDetector(
                      onTap: ()async{
                        await PostsController().getPostsOfSubject(data.id);
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => LastTopicView(subject:data),
                          ),);


                      },
                      child: SizedBox(
                        height: 135,
                        child: Card(
                          margin: const EdgeInsets.only(top: 30),
                          color: data.bgColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(padding: const EdgeInsets.all(10.0),child:  Text(data.title,
                                          style: theme.headline6!.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32,
                                          )),),
                                      const Spacer(),
                                      IconButton(
                                          hoverColor: Colors.white,
                                          onPressed: ()async{
                                            int count = 0;
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    content: const Text(
                                                        '???? ?????? ?????? ???????? ?????????? ????????????'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () async => {
                                                          if(await controller.deleteTopic(data.id)){
                                                            showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext context) =>
                                                                  AlertDialog(
                                                                    content: const Text(
                                                                        ' ???? ???????????? ?????? ????.'),
                                                                    actions: <Widget>[

                                                                      TextButton(

                                                                        onPressed: ()async =>
                                                                        {
                                                                        await controller.setItemCategory(StatusCategory.LastTopics),
                                                                    Navigator.of(
                                                                            context)
                                                                        .popUntil((_) =>
                                                                            count++ >=
                                                                            2)
                                                                  },
                                                                        child: const Text('????????'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                            )

                                                          }
                                                          else{
                                                            showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext context) =>
                                                                  AlertDialog(
                                                                    title: const Text('??????'),
                                                                    content: const Text(
                                                                        '?????????? ???? ?????? ???????? ???????? ????????.'),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        onPressed: () => Navigator.of(context).popUntil((_) => count++ >= 2),
                                                                        child: const Text('????????'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                            )
                                                          }
                                                        },
                                                        child: const Text('??????'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(context),
                                                        child: const Text('??????'),
                                                      ),
                                                    ],
                                                  ),
                                            );}, icon: const Icon(
                                        Icons.delete_forever_rounded,
                                        size:30 ,
                                        color:Colors.white ,))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if(value.status== StatusCategory.HomeWork){
                    final data = value.listOfExerciseOfCourse[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordHomeWorkView(exercise: data,),settings: RouteSettings(arguments:sharedPreferences.getType() == 't'?
                          EnCreateHomeWork.Professor :EnCreateHomeWork.Student )
                          ),);

                      },
                      child: SizedBox(
                        height: 120,
                        child: Card(
                          margin: const EdgeInsets.only(top: 15),
                          color: data.bgColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadiusTxtField)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.title,
                                        style: theme.headline6!.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        )),
                                    Text(data.deadline.substring(0,10),
                                        style: theme.subtitle2!.
                                        copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(data.description,
                                  style: theme.headline6!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }, );
            },
          );
        },
      ),

    );
  }

  Widget _buildBookMark(TextTheme theme, PostItemModel data,ItemLessonsController controller)
  {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Text(data.title,
                  style: theme.bodyText1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,),
                ),
                IconButton(onPressed: ()async{

                 var res= await controller.unSavePost(data.id);
                 if(res){
                   print('delete');

                 }
                },
                    icon: const Icon(
                      Icons.delete,
                      size: 18,
                      color: Colors.grey,
                    ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
                margin: const EdgeInsets.only(right: 15),
                child: Text(data.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,)),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              margin: EdgeInsets.only(
                right: 30,
                left: 30
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.
                circular(borderRadiusButton),
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('$baseUrlImage/ic_profile.png',
                height: 35,
                width: 35,),
                Container(
                  margin: const EdgeInsets.only(
                    right: 4,
                    left: 8
                  ),
                    child: Text(data.user_email, overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 9),)),
                Container(
                  width: 1,
                  height: 20,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.
                     circular(borderRadiusButton),
                     color: Colors.grey.shade400,
                   ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      right: 5,
                      left: 2
                  ),
                  child: const Icon(Icons.comment,
                  color: Colors.grey,
                  size: 15),
                ),
                Container(
                    margin: const EdgeInsets.only(
                        right: 3,
                        left: 4
                    ),
                    child: Text(data.comments.toString()+'  ??????????',style: const TextStyle(fontSize: 10))),
                Container(
                  width: 1,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.
                    circular(borderRadiusButton),
                    color: Colors.grey.shade400,
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(data.date.substring(0,10),
                style:  const TextStyle(fontSize: 10),)

              ],
            )

          ],
        ),
      ),
    );
  }

  Widget _buildUsers(TextTheme theme, LessonsItemModel data,BuildContext context,ItemLessonsController controller)
  {
    return GestureDetector(onTap:(){
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => const ProfileView(),settings: RouteSettings(arguments:data.title)
        ),);
    },child: Card(
      color: data.bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
        ),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: 12),
                child: Image.asset('$baseUrlImage/ic_profile.png',
                  height: 50,
                  width: 50,)),
            Container(
              margin: EdgeInsets.only(right: 15),
              child: Text(data.title.length>=20?' ...'+data.title.substring(0,20):data.title,
                  style: theme.bodyMedium!.copyWith(
                      color: Colors.white
                  )),
            ),
            const Spacer(),
            IconButton(onPressed: ()async{
              int count = 0;
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      content: const Text(
                          '???? ?????? ?????? ???????????? ?????????? ????????????'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async => {
                            if(await controller.deleteUsers(data.teacher)){
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      content: const Text(
                                          ' ???? ???????????? ?????? ????.'),
                                      actions: <Widget>[

                                        TextButton(

                                          onPressed: ()async=>
                                          {
                                            await controller.setItemCategory(StatusCategory.Sp),
                                            Navigator.of(context)
                                                .popUntil((_) => count++ >= 2)
                                          },
                                          child: const Text('????????'),
                                        ),
                                      ],
                                    ),
                              )

                            }
                            else{
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('??????'),
                                      content: const Text(
                                          '?????????? ???? ?????? ???????????? ???????? ????????.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.of(context).popUntil((_) => count++ >= 2),
                                          child: const Text('????????'),
                                        ),
                                      ],
                                    ),
                              )
                            }
                          },
                          child: const Text('??????'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('??????'),
                        ),
                      ],
                    ),
              );}, icon: const Icon(Icons.delete_forever_rounded,size:22 ,color:Colors.white70 ,))


          ],
        ),
      ),
    ),);
  }

}

enum EnCreateHomeWork{
  Student,
  Professor,
  CreateNew
}