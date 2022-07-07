import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/subject_controller.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/helpers/utility.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/views/login_view.dart';
import 'package:project/views/tab_lessons/item_lessons_view.dart';
import 'package:project/views/tab_lessons/last_topic_view.dart';
import 'package:project/views/tab_lessons/record_home_work_view.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:provider/provider.dart';
import 'package:project/controllers/exercise_controller.dart';
import '../widgets/topAppBar.dart';
import 'tab_lessons/search_view.dart';

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

    Future<List<ItemCategoryModel>> getMyList() async {
      return controller.listModel;
    }

    Future<List<ItemCategoryModel>> myList = getMyList();

    if (sharedPreferences.isLogin) {
      return Scaffold(
        appBar: TopAppBar('دانشجو', 1, 'ww'),
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
                              readOnly: true,
                              onTap: (){
                                Navigator.pushNamed(context, SearchView.id);
                              },
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                Expanded(
                                  child: ElevationButtonWidget(
                                    icon: Icons.local_fire_department,
                                    text: 'همه',
                                    call: () async {
                                      await Lessons.getLessonsRequest();
                                      await Subjects.getSubjectsRequest();
                                      await Exercise.getExercisesRequest();
                                      await controller
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
                                ),
                                SizedBox(width: 8,),
                                Expanded(
                                  child: ElevationButtonWidget(
                                    icon: Icons.bolt,
                                    text: 'دروس',
                                    call: () async {
                                      await Lessons.getLessonsRequest();
                                      await controller.setItemCategory(
                                          StatusCategory.Lessons);
                                    },
                                    iconColor: controller.status ==
                                            StatusCategory.Lessons
                                        ? Colors.orange
                                        : Colors.white,
                                    primaryColor: controller.status ==
                                            StatusCategory.Lessons
                                        ? Colors.orange
                                        : Colors.white,
                                    textColor: controller.status ==
                                            StatusCategory.Lessons
                                        ? Colors.white
                                        : Colors.black,
                                    bgColorIcon: controller.status !=
                                            StatusCategory.Lessons
                                        ? Colors.orange
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevationButtonWidget(
                                    icon: Icons.assignment_rounded,
                                    text: 'تکالیف',
                                    call: () async {
                                      await Exercise.getExercisesRequest();
                                      await controller.setItemCategory(
                                          StatusCategory.HomeWork);
                                    },
                                    iconColor: controller.status ==
                                            StatusCategory.HomeWork
                                        ? Colors.green
                                        : Colors.white,
                                    primaryColor: controller.status ==
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
                                ),
                                SizedBox(width: 8,),
                                Expanded(
                                  child: ElevationButtonWidget(
                                      icon: Icons.assignment_rounded,
                                      text: 'آخرین مباحث',
                                      call: () async {
                                        await Subjects.getSubjectsRequest();
                                        await controller.setItemCategory(
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // Consumer<HomeController>(
              //     builder: (context, value, child) {
              //     print("AGAIN BUILD ${value.listModel.length}");
              //     return SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children:
              //           value.listModel.map((e) => cartGenerator(e)).toList(),
              //     ),
              //   );
              //   },
              // ),

              FutureBuilder<List<ItemCategoryModel>>(
                future: myList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: snapshot.data!
                              .asMap().entries.map((e) {

                                return cartGenerator(e.value,controller,context);
                          }).toList()
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
              // ),
            ],
          ),
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, LoginView.id);
      return const Text('لطفا کمی صبر کنید.');
    }
  }

  Widget cartGenerator(ItemCategoryModel model,HomeController controller,BuildContext context) {
    var lesson;
    var subject;
    var exer;
    return GestureDetector(

    onTap: ()async=>{
      if(model.category=='Lesson'){
        lesson=await controller.getLessonById(sharedPreferences.getLessonByTitle(model.title)),
        Navigator.push(context,  MaterialPageRoute(
            builder: (context) => ItemLessonsView(lesson:lesson)),
        )
      }else {
        if(model.category=='Subject'){
        subject=await controller.getTopicById(sharedPreferences.getTopicId(model.title)),
        Navigator.push(context,  MaterialPageRoute(
            builder: (context) => LastTopicView( subject: subject,)),
        )
      }else{
          exer=await controller.getExerciseById(sharedPreferences.getExerciseByTitle(model.title)),
          Navigator.push(context,  MaterialPageRoute(
              builder: (context) => RecordHomeWorkView(exercise: exer,)),
          )
        }
    }
      },
    child: Card(
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
                Container(child: Image.asset(Utility.randomImage())),
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
