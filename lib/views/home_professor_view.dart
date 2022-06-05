import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/subject_controller.dart';
import 'package:project/helpers/utility.dart';
import 'package:project/models/item_category_model.dart';
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
     return controller.listModel;
   }
    mySubjects() async{
      await Subjects.getSubjectsRequest();
      await controller
          .setItemCategory(StatusCategory.LastTopics);
      return controller.listModel;
    }
    return Scaffold(
      appBar: TopAppBar('استاد', 1, 'ww'),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(right: 12, left: 12,
        bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: double.infinity,
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
                    itemExtent: 250,
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context, index) {
                      final data = controller.listModel[index];

                      return cartGenerator(data);
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
                      final data = controller.listModel[index];

                      return cartGenerator(data);
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

  Widget cartGenerator(ItemCategoryModel model) {
    return Card(
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
              height: 80,
              width: 80,),
              Text(
                model.title,
                style: TextStyle(
                  color: Color.fromARGB(255, 253, 251, 251),
                  fontFamily: 'Vazir',
                  fontSize: 16,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
