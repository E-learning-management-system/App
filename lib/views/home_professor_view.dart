import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/controllers/home_controller.dart';
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
    final controller = Provider.of<HomeController>(context);
    final theme = Theme.of(context).textTheme;
    controller.listModel = [
      for (int i = 0; i < 3; i++) ...[
        ItemCategoryModel(title: 'تست', category: 'Lesson'),
      ]
    ];
    return Scaffold(
      appBar: TopAppBar('دانیال صابر', 1, 'ww'),
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
            child: ListView.builder(
              itemExtent: 200,
              itemCount: controller.listModel.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final data = controller.listModel[index];

                return cartGenerator(data);
              },
            ),
          ),
          sizedBox(height: 12),
          Text('اخرین مباحث',
            style: theme.headline6,),
          SizedBox(
            height: 180,
            child: ListView.builder(
              itemExtent: 200,
              itemCount: controller.listModel.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final data = controller.listModel[index];

                return cartGenerator(data);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
