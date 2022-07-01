
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/controllers/last_topic_controller.dart';
import 'package:project/controllers/posts_cpntroller.dart';
import 'package:project/models/comment_model.dart';
import 'package:project/models/post_model.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/models/subject_item_model.dart';
import 'package:project/views/tab_lessons/create_new_subject.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class LastTopicView extends StatelessWidget {
  const LastTopicView({Key? key,required this.subject}) : super(key: key);
  static const String id = '/last_topic';
  final SubjectsItemModel subject;

  Future<List<PostItemModel>> myPosts(PostsController controller)async{
      await controller.getPostsOfSubject(subject.id);
      return controller.posts;
  }


  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PostsController>(context,listen: false);
    controller.setId(subject.id);
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar:  AppbarWidget(
        text: subject.title,
        showIc: true,
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.startFloat,
      body: _buildBody(theme: theme, controller: controller),
      floatingActionButton:  Visibility(
        //visible: sharedPreferences.getType() == 't',
        child: FloatingActionButton.extended(
          backgroundColor: Colors.green,
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => CreateNewSubjectView(subjectId: subject.id,),
                ),);
            },
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusButton)
            ),
            icon: const Icon(
              Icons.add,
              size: 18,
            ),
            label: const Text('پست جدید')),
      ),
    );
  }

  Widget _buildBody({required TextTheme theme,
    required PostsController controller})
  {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedBox(
            height: 20
        ),
        Container(
          margin: const EdgeInsets.only(
            right: 8,bottom: 8
          ),
          child: ElevationButtonWidget(call: (){},
            text: 'مرتب سازی',
            icon: Icons.sort,
            primaryColor: Colors.green,
            height: 35,
            width: 130,
          ),
        ),

        Expanded(
          child: FutureBuilder<List<PostItemModel>>(
            future:myPosts(controller) ,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("myPosts");
                return
                  // Consumer<PostsController>(
                  //   builder: (context, value, child) =>
                    ListView.builder(
            padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 20
            ),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              return _buildItemList(theme:theme,data: data, value: controller,
            index: index);
              },
                    );
                    // );
              } else {
                 return const Center(child: CircularProgressIndicator(),);
                 }
                 },
        )

    )
    ],
    );
  }
  Widget _buildItemList(
  {required TextTheme theme,
    required PostItemModel data,
      required PostsController value,
    required int index
  })
  {

    return Consumer<PostsController>(
        builder: (context, value, child) {
          return SizedBox(
            height: data.isExpanded == true ? 540 : 215,
            child: Stack(
              children: [
                data.isExpanded == true ? _buildIsExpanded(theme: theme,
                    data: data,
                    controller: value,
                    index: index,
                context: context) :
                _buildNotExpanded(
                    theme: theme,
                    data: data,
                    controller: value,
                    index: index),
                Positioned(
                  left: 0,
                  top: 0,
                  child: _buildCircleButton(data: data,controller: value),)
              ],
            ),
          );
        }
    );
  }
  Widget _buildNotExpanded(
  { required TextTheme theme,
    required PostItemModel data,
    required PostsController controller,
   required int index})
  {
    return Positioned(
      bottom: 0,
      left: 0,
      height: 190,
      right: 0,
      child: GestureDetector(
        onTap: (){
          controller.changeExpanded(index);
        },
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Text(data.title,
                      style: theme.headline6),
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
                _dividerWith(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('$baseUrlImage/ic_profile.png',
                      height: 25,
                      width: 25,),
                    Container(
                        margin: const EdgeInsets.only(
                            right: 4,
                            left: 5
                        ),
                        child: Text(data.user_email,style: const TextStyle(fontSize: 10),)),
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
                          right: 1,
                          left: 1
                      ),
                      child: const Icon(Icons.comment,
                          color: Colors.grey,
                          size: 15),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                            right: 1,
                            left: 2
                        ),
                        child: Text(data.comments.toString()+'  کامنت',style: const TextStyle(fontSize: 11),),),
                    Container(
                      width: 1,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.
                        circular(borderRadiusButton),
                        color: Colors.grey.shade400,
                      ),
                    ),
                    SizedBox(width: 3,),
                    Text(data.date.substring(0,10),
                      style: const TextStyle(fontSize: 10))

                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCircleButton({required PostItemModel data,required PostsController controller})
  {
    return Row(
      children: [
        MaterialButton(
          height: 30,
          minWidth: 30,
          elevation: 3,
          color: Colors.white,
          padding: const EdgeInsets.all(5),
          shape: const CircleBorder(),
          onPressed: ()async{
            if(data.is_saved=="False") {
             var res= await controller.savePost(data);
              if(res){
                data.is_saved='True';
              }
            } else {
             var res= await controller.unSavePost(data.id);
             if(res){
               data.is_saved='False';
             }
            }
          },
          child: Icon(
              Icons.bookmark,
             size: 16,
          color: data.is_saved=='True' ? Colors.red :Colors.grey ),

        ),
        sizedBox(width: 8),
        MaterialButton(
          height: 30,
          minWidth: 30,
          elevation: 3,
          color: Colors.white,
          padding: const EdgeInsets.all(5),
          shape: const CircleBorder(),
          onPressed: ()async{
            if(data.is_liked=='False') {
             var res= await controller.likePost(data.id);
             if(res){
               data.is_liked='True';
             }
            } else{
              var res=await controller.removeLike(data.id);
              if(res){
                data.is_liked='False';
              }
            }

          },
          child: Icon(
              Icons.favorite,
              size: 16,
              color: data.is_liked=='True'?Colors.red:Colors.grey),

        ),

      ],
    );
  }



  Widget _buildWhenExpanded(TextTheme theme, ItemCategoryModel data) {
    return  Padding(
      padding: const EdgeInsets.only(
        right: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('پاسخ استاد',style: theme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold
          ),),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12,bottom: 20),
                child: const Text("پاسخی داده نشده")),
          ),
          _dividerWith(),
          sizedBox(
            height: 12
          ),
          Row(
            children: [
              Text('نظرات',style: theme.subtitle2!.copyWith(
                fontWeight: FontWeight.bold
              ),),
              sizedBox(width: 4),
              Icon(Icons.comment,size: 12,
              color: Colors.grey,),

            ],
          ),

        ],
      ),
    );
  }


  Widget _buildIsExpanded(
      { required TextTheme theme,
        required PostItemModel data,
        required PostsController controller,
        required int index,
      required BuildContext context}){
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      height: 520,
      child: GestureDetector(
        onTap: () {
          controller.changeExpanded(index);
        },
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 5,
              right: 15,
              left: 15
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('$baseUrlImage/ic_profile.png',
                      height: 35,
                      width: 35,),
                    sizedBox(width: 8),
                    Text(data.title,
                        style: theme.headline6),

                  ],
                ),
               sizedBox(height: 8),
                Text(data.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,),
                 sizedBox(height: 15,),
                _dividerWith(),
                 sizedBox(height: 15,),
                _tComment(theme: theme, data: data, controller: controller, index: index),
                _dividerWith(),
                sizedBox(height: 12),
                Row(
                  children: [
                    Text('نظرات',style: theme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold
                    )),
                    sizedBox(width: 6),
                    Icon(Icons.comment,size: 16,
                      color: Colors.grey,),


                  ],
                ),
                SizedBox(
                  height: 130,
                  child: Consumer<PostsController>(
                    builder: (context, value, child){

                      if(value.postComments[data.id]?.number!=0){
                        return ListView.builder(
                            itemCount: value.postComments[data.id]?.number,
                            itemBuilder: (context, index) {
                              final dataCm =value.postComments[data.id]!.comment[index];
                              return _itemComment(theme,dataCm);
                            });
                      }
                      return const Text('موردی یافت نشد!');
                    }

                  ),
                ),
                sizedBox(height: 8),
                _buildTextFieldComment(controller.textEditController),
                sizedBox(height: 12),
                ElevationButtonWidget(
                  height: 30,
                  width: 100,
                  borderRadius: borderRadiusTxtField,
                  call: ()async{
                   var res= await controller.addComment(controller.textEditController.text,data.id);
                   if(res){
                     controller.textEditController.clear();
                    await controller.getPostsOfSubject(subject.id);
                   }else{
                     controller.textEditController.clear();
                     showDialog<String>(
                       context: context,
                       builder: (BuildContext context) => AlertDialog(
                         title: const Text('خطا'),
                         content: const Text('مشکلی در ثبت نظر وحود دارد.'),
                         actions: <Widget>[
                           TextButton(
                             onPressed: () => Navigator.pop(context),
                             child: const Text('باشه'),
                           ),
                         ],
                       ),
                     );
                   }
                  },
                  text: 'ارسال',
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  _tComment( { required TextTheme theme,
    required PostItemModel data,
    required PostsController controller,
    required int index}){
    if(controller.postComments[data.id]!.isTComment ){
      return Column(
        children: [
        Text('پاسخ استاد',style: theme.bodyText1!.copyWith(
          fontWeight: FontWeight.bold),),
        Center(
          child: Container(
              margin: const EdgeInsets.only(top: 12,bottom: 20),
              child: _itemComment(theme, controller.postComments[data.id]!.tComment),
        )
        ),

        ],
      );



    }
    else{
      return Column(
        children: [
          Text('پاسخ استاد',style: theme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold),),
          Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12,bottom: 20),
                child: const Text('پاسخی داده نشده'),
              )
          ),

        ],
      );
    }
  }
  _dividerWith()
  {
     return Container(
      height: 1,
      margin: const EdgeInsets.only(
          right: 30,
          left: 30
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.
        circular(borderRadiusButton),
        color: Colors.grey.shade400,
      ),
    );
  }
  _itemComment(TextTheme theme,CommentItemModel data)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('$baseUrlImage/ic_profile.png',
                    height: 24,
                    width: 24,),
                  sizedBox(width: 8),
                  Text(data.user_email,
                    style: theme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: MyColors.blueHex
                    ),),
                  sizedBox(width: 8),
                  Expanded(child: Text(data.text,
                    style: theme.caption,))
                ],
              ),
              sizedBox(height: 8),
              Text(data.date,style: theme.overline!.copyWith(
                color: Colors.grey

              ),)

            ],
          ),
        ),
      ),
    );
  }
  _buildTextFieldComment(TextEditingController controller)
  {
    return Visibility(
      visible: sharedPreferences.getType() !='t',
      child: SizedBox(
        height: 40,
        child: TextFormFieldWidget(
          controller: controller,
            hintText: 'نطر خود را وارد کنید'),
      ),
    );
  }
}
