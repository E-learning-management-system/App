

import 'package:flutter/material.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/controllers/verify_email_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/helpers/utility.dart';
import 'package:project/models/lessons_item_model.dart';
import 'package:project/views/login_view.dart';
import 'package:project/views/tab_lessons/create_new_lessons_view.dart';
import 'package:project/views/tab_lessons/item_lessons_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/bottomAppBar.dart';
import 'package:project/widgets/empty_view_widget.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class LessonsView extends StatelessWidget {
  const LessonsView({Key? key}) : super(key: key);
  static const String id = '/lessons_view';

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LessonsController>(context, listen: false);
    final theme = Theme.of(context).textTheme;

    if (sharedPreferences.isLogin) {
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppbarWidget(
          text: 'دروس',
          showIc: true,
          shoeIcPop: false,
          elevation: 0,
        ),
        body: Column(
          children: [
            _buildSearchWidget(),
            Expanded(
              child: FutureBuilder(
                future: controller.getLessonsRequest(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return const EmptyViewWidget();
                  }
                  return ListView.builder(
                    itemExtent: 140,
                    itemCount: controller.listOfLessons.length,
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    itemBuilder: (context, index) {
                      final data = controller.listOfLessons[index];

                      return _buildItemLessons(
                          index: index + 1,
                          data: data,
                          theme: theme,
                          context: context);
                    },
                  );
                },
              ),
            )
          ],
        ),
        floatingActionButton: _buildFloatAc(context),
        // bottomNavigationBar: B_AppBar(
        //   fromLessons: true,
        //   onTapHome: (){
        //     Navigator.of(context).pop();
        //   },
        // ),
      );
    } else {
      Navigator.pushReplacementNamed(context, LoginView.id);
      return const Text('لطفا کمی صبر کنید.');
    }
  }

  Widget _buildSearchWidget() {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        height: 40,
        child: TextFormFieldWidget(
          hintText: 'جست و جو',
          noneEnableBorder: false,
          actionKeyboard: TextInputAction.search,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildItemLessons(
      {required LessonsItemModel data,
      required int index,
      required TextTheme theme,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => ItemLessonsView(lesson:data),
        ),);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusButton)),
        color: Utility.randomColor(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(data.title,
                        style: theme.bodySmall!.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: sharedPreferences.getType() == 't',
                      child: Text(
                        'تاریخ امتحان : ${Utility.convertToPersian(data.examDate)}',
                        style: theme.caption!.copyWith(color: Colors.white),
                      ),
                      replacement: Text(
                        data.description,
                        style: theme.caption!.copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Image.asset(
                Utility.randomImage(),
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatAc(BuildContext context) {
    if (sharedPreferences.getType() == 't') {
      return FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed(CreateNewLessonsView.id);
          },
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusButton)),
          icon: const Icon(
            Icons.add,
            size: 18,
          ),
          label: const Text('درس جدید'));
    }
    return const SizedBox();
  }
}
