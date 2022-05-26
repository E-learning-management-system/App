
import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/subject_controller.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/views/tab_lessons/lessons_view.dart';
import 'package:project/widgets/bottomAppBar.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:provider/provider.dart';
import 'package:project/controllers/exercise_controller.dart';
import '../widgets/topAppBar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static const id = '/Home';


  @override
  Widget build(BuildContext context) {
    final Lessons = Provider.of<LessonsController>(context);
    final Exercise = Provider.of<ExercisesController>(context);
    final Subjects = Provider.of<SubjectsController>(context);
    final controller = Provider.of<HomeController>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: TopAppBar('دانیال صابر', 1, 'ww'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: controller.formSearchKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: (screenWidth - 50) * 0.8,
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                textDirection: TextDirection.ltr,
                              ),
                              hintTextDirection: TextDirection.rtl,
                              border: InputBorder.none,
                              hintText: "جست و جو",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            // alignment: Alignment.center,
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    primary: Colors.lightBlue),
                                onPressed: () async {
                                  // if () {
                                  //   setState(() {});
                                  //   Navigator.pushNamed(context, '/search');
                                  // }
                                },
                                child: Icon(
                                  Icons.tune,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 15),
                    child: Text(
                      "دسته بندی",
                    ),
                  ),
                  Consumer<HomeController>(
                    builder: (context, controller, child) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevationButtonWidget(
                                icon: Icons.local_fire_department,
                                text: 'همه',
                                call: () {
                                  controller
                                      .setItemCategory(StatusCategory.All);
                                },
                                iconColor:
                                    controller.status == StatusCategory.All
                                        ? Colors.lightBlue
                                        : Colors.white,
                                primaryColor:
                                    controller.status == StatusCategory.All
                                        ? Colors.lightBlue
                                        : Colors.white,
                                textColor:
                                    controller.status == StatusCategory.All
                                        ? Colors.white
                                        : Colors.black,
                                bgColorIcon:
                                    controller.status != StatusCategory.All
                                        ? Colors.lightBlue
                                        : Colors.white,
                              ),
                              ElevationButtonWidget(
                                icon: Icons.bolt,
                                text: 'دروس',
                                call: () {
                                  controller
                                      .setItemCategory(StatusCategory.Lessons);
                                },
                                iconColor:
                                    controller.status == StatusCategory.Lessons
                                        ? Colors.orange
                                        : Colors.white,
                                primaryColor:
                                    controller.status == StatusCategory.Lessons
                                        ? Colors.orange
                                        : Colors.white,
                                textColor:
                                    controller.status == StatusCategory.Lessons
                                        ? Colors.white
                                        : Colors.black,
                                bgColorIcon:
                                    controller.status != StatusCategory.Lessons
                                        ? Colors.orange
                                        : Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevationButtonWidget(
                                icon: Icons.assignment_rounded,
                                text: 'تکالیف',
                                call: () {
                                  controller
                                      .setItemCategory(StatusCategory.HomeWork);
                                },
                                iconColor:
                                    controller.status == StatusCategory.HomeWork
                                        ? Colors.green
                                        : Colors.white,
                                primaryColor:
                                    controller.status == StatusCategory.HomeWork
                                        ? Colors.green
                                        : Colors.white,
                                textColor:
                                    controller.status == StatusCategory.HomeWork
                                        ? Colors.white
                                        : Colors.black,
                                bgColorIcon:
                                    controller.status != StatusCategory.HomeWork
                                        ? Colors.green
                                        : Colors.white,
                              ),
                              ElevationButtonWidget(
                                  icon: Icons.assignment_rounded,
                                  text: 'آخرین مباحث',
                                  call: () {
                                    controller.setItemCategory(
                                        StatusCategory.LastTopics);
                                  },
                                  iconColor: controller.status ==
                                          StatusCategory.LastTopics
                                      ? Color(0xff4b2b99)
                                      : Colors.white,
                                  primaryColor: controller.status ==
                                          StatusCategory.LastTopics
                                      ? Color(0xff4b2b99)
                                      : Colors.white,
                                  textColor: controller.status ==
                                          StatusCategory.LastTopics
                                      ? Colors.white
                                      : Colors.black,
                                  bgColorIcon: controller.status !=
                                          StatusCategory.LastTopics
                                      ? Color(0xff4b2b99)
                                      : Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // ListView(
            //   scrollDirection: Axis.horizontal,
            Consumer<HomeController>(
              builder: (context, value, child) {
                print("AGAIN BUILD ${value.listModel.length}");
                return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                      value.listModel.map((e) => cartGenerator(e)).toList(),
                ),
              );
              },
            ),
            // ),
          ],
        ),
      ),
      // bottomNavigationBar: B_AppBar(
      //   onTapLessons: () {
      //     print("SAD");
      //     Navigator.of(context).pushNamed(LessonsView.id);
      //   },
      // ),
    );
  }

  Widget cartGenerator(ItemCategoryModel model) {
    return Card(
      color: model.bgColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      // elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 150,
          height: 190,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(child: Image.asset(model.urlImage)),
                Text(
                  model.title,
                  style: TextStyle(
                    color: Color.fromARGB(255, 253, 251, 251),
                    fontFamily: 'Vazir',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget emptyGenerator() {
    return const Text(
      "موردی برای نمایش موجود نیست.",
      style: TextStyle(
        color: Color.fromARGB(255, 253, 251, 251),
        fontFamily: 'Vazir',
        fontSize: 16,
      ),
    );
  }
}
