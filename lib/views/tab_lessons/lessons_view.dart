

import 'package:flutter/material.dart';
import 'package:project/controllers/lessons_controller.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/helpers/utility.dart';
import 'package:project/models/lessons_item_model.dart';
import 'package:project/views/login_view.dart';
import 'package:project/views/tab_lessons/create_new_lessons_view.dart';
import 'package:project/views/tab_lessons/item_lessons_view.dart';
import 'package:project/views/tab_lessons/search_view.dart';
// import 'package:project/views/tab_lessons/search_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/empty_view_widget.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../../models/item_category_model.dart';

class LessonsView extends StatelessWidget {
  const LessonsView({Key? key}) : super(key: key);
  static const String id = '/lessons_view';

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LessonsController>(context);
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
            _buildSearchWidget(context,controller),
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
                          context: context,
                      controller: controller);
                    },
                  );
                },
              ),
            )
          ],
        ),
        floatingActionButton: _buildFloatAc(context),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.startFloat,
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

  Widget _buildSearchWidget(BuildContext context,LessonsController controller) {
    return  Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: 40,
        child: TextFormFieldWidget(
          readOnly: true,
          onTap: (){
            List<ItemCategoryModel> list=[];
            for(var i in controller.listOfLessons) {
              list.add(ItemCategoryModel(title:i.title,category: 'Lesson'));
            }
            Navigator.pushNamed(context, SearchView.id,arguments: list);
          },
          hintText: 'جست و جو',
          noneEnableBorder: false,
          actionKeyboard: TextInputAction.search,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildItemLessons(
      {required LessonsItemModel data,
      required int index,
      required TextTheme theme,
      required BuildContext context,
      required LessonsController controller}) {
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
              Image.asset(
                Utility.randomImage(),
                height: 100,
                width: 100,
              ),
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
                        'تاریخ امتحان : ${(data.examDate.substring(0,10))}',
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
              Visibility( visible: sharedPreferences.getType() == 't',child:  IconButton(
                  hoverColor: Colors.white,
                  onPressed: ()async{
                    int count = 0;
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            content: const Text(
                                'از حذف این درس مطمئن هستید؟'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async => {
                                  if(await controller.deleteLesson(data.id)){
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            content: const Text(
                                                ' با موفقیت حذف شد.'),
                                            actions: <Widget>[

                                              TextButton(

                                                onPressed: () => Navigator.of(context).popUntil((_) => count++ >= 2),
                                                child: const Text('باشه'),
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
                                            title: const Text('خطا'),
                                            content: const Text(
                                                'مشکلی در حذف درس وجود دارد.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.of(context).popUntil((_) => count++ >= 2),
                                                child: const Text('باشه'),
                                              ),
                                            ],
                                          ),
                                    )
                                  }
                                },
                                child: const Text('بله'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('خیر'),
                              ),
                            ],
                          ),
                    );}, icon: const Icon(
                Icons.delete_forever_rounded,
                size:22 ,
                color:Colors.white ,))),
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
