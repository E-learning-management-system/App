

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/controllers/last_topic_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/views/tab_lessons/create_new_subject.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
class LastTopicView extends StatelessWidget {
  const LastTopicView({Key? key}) : super(key: key);
  static const String id = '/last_topic';

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LastTopicController>(context);
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const AppbarWidget(
        text: 'ریاضی 2 - مبحث 1',
        showIc: true,
      ),
      body: _buildBody(theme: theme, controller: controller),
      floatingActionButton:  FloatingActionButton.extended(
        backgroundColor: Colors.green,
          onPressed: (){
          Navigator.pushNamed(context, CreateNewSubjectView.id);
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
    );
  }

  Widget _buildBody({required TextTheme theme,
    required LastTopicController controller})
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
          child: Consumer<LastTopicController>(
           builder: (context, value, child) => ListView.builder(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 20
              ),
              itemCount: controller.listModel.length,
              itemBuilder: (context, index) {
              final data = controller.listModel[index];
              return _buildItemList(theme:theme,data: data, value: value,
              index: index);
            },),
          ),
        )
      ],
    );
  }
  Widget _buildItemList(
  {required TextTheme theme,
      required ItemCategoryModel data,
      required LastTopicController value,
    required int index
  })
  {
    return  SizedBox(
      height:  data.isExpanded==true ? 520 :215,
      child: Stack(
        children: [
          data.isExpanded==true?  _buildIsExpanded(theme:theme,
              data: data,
          controller: value,
          index: index) :
          _buildNotExpanded(
              theme: theme,
              data:data,
              controller: value,
          index: index),
          Positioned(
            left: 0,
            top: 0,
            child: _buildCircleButton(),)
        ],
      ),
    );
  }
  Widget _buildNotExpanded(
  { required TextTheme theme,
    required ItemCategoryModel data,
    required LastTopicController controller,
   required int index})
  {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: (){
          controller.changeExpanded(index);
        },
        child: Card(
          color: data.bgColor,
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
                    child: Text(data.nameLesson!)),
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
                      height: 35,
                      width: 35,),
                    Container(
                        margin: const EdgeInsets.only(
                            right: 4,
                            left: 8
                        ),
                        child: Text(data.name!)),
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
                          right: 10,
                          left: 4
                      ),
                      child: const Icon(Icons.comment,
                          color: Colors.grey,
                          size: 15),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                            right: 4,
                            left: 8
                        ),
                        child: Text(data.countComment.toString()+'  کامنت')),
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
                      width: 8,
                    ),
                    Text(data.date!,
                      style: theme.bodySmall,)

                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCircleButton()
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
          onPressed: (){

          },
          child: const Icon(
              Icons.bookmark,
             size: 16,
          color: Colors.grey),

        ),
        sizedBox(width: 8),
        MaterialButton(
          height: 30,
          minWidth: 30,
          elevation: 3,
          color: Colors.white,
          padding: const EdgeInsets.all(5),
          shape: const CircleBorder(),
          onPressed: (){

          },
          child: Icon(
              Icons.favorite,
              size: 16,
              color: Colors.grey),

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
                child: Text('هنوز پاسخی داده نشده ')),
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
        required ItemCategoryModel data,
        required LastTopicController controller,
        required int index}){
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      height: 500,
      child: GestureDetector(
        onTap: () {
          controller.changeExpanded(index);
        },
        child: Card(
          color: data.bgColor,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 12,
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
                Text(data.nameLesson!),
                 sizedBox(height: 15,),
                _dividerWith(),
                 sizedBox(height: 15,),
                Text('پاسخ استاد',style: theme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold
                ),),
                Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 12,bottom: 20),
                      child: Text('هنوز پاسخی داده نشده ')),
                ),
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
                  child: Consumer<LastTopicController>(
                    builder: (context, value, child) =>
                        ListView.builder(
                        itemCount: value.listComments.length,
                        itemBuilder: (context, index) {
                          final dataCm = value.listComments[index];
                          return _itemComment(theme,dataCm);
                        }),
                  ),
                ),
                sizedBox(height: 8),
                _buildTextFieldComment(controller.textEditController),
                sizedBox(height: 12),
                ElevationButtonWidget(
                  height: 30,
                  width: 100,
                  borderRadius: borderRadiusTxtField,
                  call: (){
                    controller.addItemComment();
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
  _itemComment(TextTheme theme,ItemCategoryModel data)
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
                  Text(data.name!,
                    style: theme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: MyColors.blueHex
                    ),),
                  sizedBox(width: 8),
                  Expanded(child: Text(data.title,
                    style: theme.caption,))
                ],
              ),
              sizedBox(height: 8),
              Text(data.date!,style: theme.overline!.copyWith(
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
    return SizedBox(
      height: 40,
      child: TextFormFieldWidget(
        controller: controller,
          hintText: 'نطر خود را وارد کنید'),
    );
  }
}
