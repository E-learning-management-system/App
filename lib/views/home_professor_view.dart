import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/subject_controller.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/helpers/utility.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/views/tab_lessons/item_lessons_view.dart';
import 'package:project/views/tab_lessons/search_view.dart';
import 'package:project/views/tab_lessons/item_lessons_view.dart';
import 'package:project/views/tab_lessons/last_topic_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/topAppBar.dart';
import 'package:provider/provider.dart';

class HomeProfessorView extends StatelessWidget {

  const HomeProfessorView({Key? key}) : super(key: key);
  static const String id = '/home_professor';

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context,listen: false);
    final Lessons = Provider.of<LessonsController>(context);
    final Subjects = Provider.of<SubjectsController>(context);
    final theme = Theme.of(context).textTheme;
   myLessons() async{
     await Lessons.getLessonsRequest();
     await controller
         .setItemCategory(StatusCategory.Lessons);
     return controller.lessonProfessor;
   }
    mySubjects() async{
      await Subjects.getSubjectsRequest();
      await controller
          .setItemCategory(StatusCategory.LastTopics);
      return controller.subjectProfessor;
    }
    return Scaffold(
      appBar: TopAppBar('استاد', 1, 'ww'),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(right: 12, left: 12,
        bottom: 20,top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 50) * 0.8,
                height: 50,
                child: TextFormField(
                  readOnly: true,
                  onTap: (){
                    controller.setItemCategory(StatusCategory.All);
                    List<ItemCategoryModel> list=controller.listModel;
                    print(list);
                    Navigator.pushNamed(context, SearchView.id,arguments: list);
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
          sizedBox(height: 15),

          Text(
            'دروس',
            style: theme.headline6,
          ),
          SizedBox(
            height: 180,
            child:
            FutureBuilder<List<ItemCategoryModel>>(
              future:myLessons() ,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return   ListView.builder(
                    itemExtent: 270,
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context, index) {
                      final data = controller.lessonProfessor[index];

                      return cartGenerator(data,context,controller);
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(),);
                }
              },
            ),

          ),
          sizedBox(height: 12),
          Text('اخرین مباحث',
            style: theme.headline6,),
          SizedBox(
            height: 180,
            child:  FutureBuilder<List<ItemCategoryModel>>(
              future:mySubjects() ,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return   ListView.builder(
                    itemExtent: 250,
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context, index) {
                      final data = controller.subjectProfessor[index];

                      return cartGenerator(data,context,controller);
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ),

        ]),
      ),
    );
  }

  Widget cartGenerator(ItemCategoryModel model,BuildContext context,HomeController controller) {
    var lesson;
    var subject;

    return GestureDetector(
      onTap: ()async=>{
        if(model.category=='Lesson'){
          lesson=await controller.getLessonById(sharedPreferences.getLessonByTitle(model.title)),
       Navigator.push(context,  MaterialPageRoute(
         builder: (context) => ItemLessonsView(lesson:lesson)),
       )
        }else{
        subject=await controller.getTopicById(sharedPreferences.getTopicId(model.title)),
    Navigator.push(context,  MaterialPageRoute(
    builder: (context) => LastTopicView( subject: subject,)),
    )
        }
      },
      child: Card(
      margin: EdgeInsets.only(left: 20),
      color: Utility.randomColor(),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(Utility.randomImage(),
                height: 100,
                width: 100,),
              Text(
                model.title,
                style: TextStyle(
                  color: Color.fromARGB(255, 253, 251, 251),
                  fontFamily: fontLotus,
                  fontSize: 16,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
