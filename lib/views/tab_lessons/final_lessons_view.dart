


import 'package:flutter/cupertino.dart';
import 'package:project/controllers/final_lessons_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/helpers/validator.dart';
import 'package:project/views/tab_lessons/lessons_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FinalLessonsView extends StatelessWidget {
  const FinalLessonsView({Key? key}) : super(key: key);
  static const String id = '/final_lessons';

  Future<String> getTitle()async{
    return await sharedPreferences.getTitle();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FinalLessonsController>(context);
    final theme = Theme.of(context).textTheme;
    return _buildBody(theme: theme, controller: controller, context: context);
  }

  Widget _buildBody(
      {required TextTheme theme,
      required FinalLessonsController controller,
      required BuildContext context}) {
    return Scaffold(
      appBar: AppbarWidget(
        text: 'دروس - درس جدید',
        showIc: true,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 30, right: 15, left: 15, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'نام درس',
                style: theme.subtitle1,
              ),
            ),
            FutureBuilder<String>(
              future: getTitle(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 4.0, 18.0, 4.0),
                child: Text(snapshot.data!, style: theme.titleLarge,));

                } else {
                   return const Center(child: CircularProgressIndicator(),);
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            _buildTextFieldAddEmail(controller: controller,),
            _buildListItems(),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Consumer<FinalLessonsController>(
                builder: (context, value, child) {
                  if(value.isLoading)
                    {
                      return CircularProgressIndicator();
                    }
                  return ElevationButtonWidget(
                    call: ()async{
                      int count = 0;
                      var res= await controller.addStudentRequest();
                      if(res){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                title: const Text(''),
                                content: const Text(
                                    'دانشجویان با موفقیت اضافه شدند.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).popUntil((_) => count++ >= 3),
                                    child: const Text('باشه'),
                                  ),
                                ],
                              ),
                        );
                      }
                      else{
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                title: const Text('خطا'),
                                content: const Text(
                                    'مشکلی در ثبت دانشجویان وجود دارد.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        context, LessonsView.id),
                                    child: const Text('باشه'),
                                  ),
                                ],
                              ),
                        );
                      }
                    },
                    borderRadius: borderRadiusTxtField,
                    text: 'ثبت نهایی',);
                },

              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _buildTextFieldAddEmail({required FinalLessonsController controller}) {
    return Form(
      key: controller.formEmail,
      child: TextFormFieldWidget(
        controller: controller.textEditController2,

        prefixIcon: const Icon(Icons.people, size: 20),
        suffixIcon: MaterialButton(
          onPressed: () {
            controller.addItemToList();
          },
          height: 0,
          minWidth: 0,
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 0,
          child: const Icon(
            Icons.add,
          ),
          padding: const EdgeInsets.all(8),
          shape: const CircleBorder(),
        ),
        hintText: 'ایمیل دانشجویان را وارد کنید',
        noneEnableBorder: false,
        filled: true,
        fillColor: Colors.white,
        functionValidate: Validator.validateEmail,

      ),
    );
  }

  Widget _buildListItems() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Consumer<FinalLessonsController>(
        builder: (context, value, child) => Scrollbar(
          controller: value.scrollController,
          isAlwaysShown: true,
          interactive: true,
          radius: Radius.circular(15),
          child: ListView.builder(
            controller: value.scrollController,
            itemCount: value.listItems.length,
            padding: const EdgeInsets.symmetric(horizontal: 12,
            vertical: 15),
            itemExtent: 48,
            itemBuilder: (context, index) {
              final data = value.listItems[index];
              return Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadiusTxtField),
                    color: MyColors.blueAccentHex),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      data,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        value.removeItem(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        height: 24,
                        width: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.remove, size: 18),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
