
import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/item_lessons_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/models/lessons_item_model.dart';
import 'package:project/views/tab_lessons/last_topic_view.dart';
import 'package:project/views/tab_lessons/record_home_work_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/bottomAppBar.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class ItemLessonsView extends StatelessWidget {
  const ItemLessonsView({Key? key}) : super(key: key);
  static const String id = '/item_lessons_view';
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ItemLessonsController>(context);
    final theme = Theme.of(context).textTheme;
    return _buildBody(
      controller: controller,
      theme: theme,
      context: context
    );
  }
  Widget _buildBody(
      {required TextTheme theme,
        required ItemLessonsController controller,
      required BuildContext context}) {
    return Scaffold(
      appBar: const AppbarWidget(
          text: 'ریاضی 2',
          centerTitle: false,
        showIc: true,
      ),
      body: Column(
        children: [
          _buildSearchWidget(),
          _buildCategoryWidget(),
          _buildListItems(theme)
        ],
      ),
      floatingActionButton:   Visibility(
        visible: sharedPreferences.getType() == 't' &&
        controller.status == StatusCategory.LastTopics ||
        controller.status == StatusCategory.HomeWork,
        child: FloatingActionButton.extended(
            backgroundColor: MyColors.blueHex,
            onPressed: (){
              if(controller.status == StatusCategory.HomeWork)
                {
                Navigator.pushNamed(context,RecordHomeWorkView.id);
                  return;
                }
              controller.openDialog(context);
            },
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusButton)
            ),
            icon: const Icon(
              Icons.add,
              size: 18,
            ),
            label: controller.status == StatusCategory.HomeWork?
            const Text('تکلیف جدید'):const Text('مبحث جدید')),
      ),
    );

  }
  Widget _buildSearchWidget()
  {
    return  const Padding(
      padding:EdgeInsets.only(
          top: 50,
          right: 46,
          left: 46,
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

  Widget _buildCategoryWidget()
  {
    return  Consumer<ItemLessonsController>(
      builder: (context, controller, child) =>
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevationButtonWidget(
                        width: 150,
                        icon: Icons.star,
                        text: 'آخرین مباحث',
                        call: () {
                          controller.setItemCategory(StatusCategory.LastTopics);
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
                      text: 'تکالیف',
                      call: () {
                        controller.setItemCategory(StatusCategory.HomeWork);

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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: ElevationButtonWidget(
                      width: 175,
                      icon: Icons.bookmark,
                      text: 'پست های ذخیره شده',
                      fontSize: 13,
                      call: () {
                        controller.setItemCategory(StatusCategory.BookMark);
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
                      text: 'دانشجویان حاضر',
                      fontSize: 10,
                      call: () {
                        controller.setItemCategory(StatusCategory.Sp);
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
  Widget _buildListItems(TextTheme theme)
  {
    return Expanded(
      child: Consumer<ItemLessonsController>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.listModel.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20
            ),
            itemBuilder:(context, index) {
              final data =  value.listModel[index];
              if(value.status == StatusCategory.BookMark)
                {
                  return _buildBookMark(theme,data);
                }
              if(value.status == StatusCategory.Sp)
                {
                  return _buildUsers(theme,data);
                }
              return GestureDetector(
                onTap: (){
                  if(value.status == StatusCategory.LastTopics)
                    {
                      Navigator.pushNamed(context, LastTopicView.id);
                    }

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
                        value.status ==
                            StatusCategory.HomeWork ?
                        CrossAxisAlignment.start:
                        CrossAxisAlignment.center,
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
                              Text(data.endDate,
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
                            fontWeight: FontWeight.normal
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }, ),
      ),
    );
  }

  Widget _buildBookMark(TextTheme theme, LessonsItemModel data)
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
                  style: theme.headline6),
                ),
                IconButton(onPressed: (){},
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
                child: Text(data.description)),
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
                    child: Text(data.countCm.toString()+'  کامنت')),
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
                Text(data.endDate,
                style: theme.bodySmall,)

              ],
            )

          ],
        ),
      ),
    );
  }

  Widget _buildUsers(TextTheme theme, LessonsItemModel data)
  {
    return Card(
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
              child: Text(data.title,
                  style: theme.bodyLarge!.copyWith(
                    color: Colors.white
                  )),
            ),

          ],
        ),
      ),
    );
  }

}
