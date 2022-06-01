

import 'package:flutter/material.dart';
import 'package:project/controllers/create_new_lessons_controller.dart';
import 'package:project/views/tab_lessons/final_lessons_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
class CreateNewLessonsView extends StatelessWidget {
  const CreateNewLessonsView({Key? key}) : super(key: key);
  static const String id = '/create_new_lessons';
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CreateNewLessonsController>(context);
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const AppbarWidget(
        text: 'دروس - درس جدید',
        showIc: true,
      ),
      body: _buildBody(
          textTheme: theme,
          controller: controller,
      context: context),

    );
  }
  Widget _buildBody({required TextTheme textTheme,
    required CreateNewLessonsController controller,
  required BuildContext context})
  {
    
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 15,
      right: 15,left: 15,
      bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: controller.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle('نام درس', textTheme),
                _buildTextField(text: 'نام درس را وارد کنید',
                    controller: controller.cnNameLessons),
                sizedBox(height: 8),
                _buildTitle('توضیحات', textTheme),
                _buildTextField(text: 'توضیحات را وارد کنید',
                    controller: controller.cnDesc,
                    maxLine: 4),
              ],
            ),
          ),


          const SizedBox(
            height: 15,
          ),
          _buildDate(theme: textTheme,
              controller: controller,
          context: context),
          _buildTitle('تاریخ امتحان', textTheme),
          _buildDateExam(controller, context),
          const SizedBox(
            height: 45,
          ),
          Center(
            child: ElevationButtonWidget(
              width: 140,
              call: (){
                if(controller.form.currentState!.validate())
                  {
                   var res= await controller.createNewLessonsRequest();
                   if(res){ Navigator.of(context).pushNamed(FinalLessonsView.id);}
                   else{
                     showDialog<String>(
                       context: context,
                       builder: (BuildContext context) => AlertDialog(
                         title: const Text('خطا'),
                         content: const Text('مشکلی در افزودن درس وحود دارد.'),
                         actions: <Widget>[
                           TextButton(
                             onPressed: () => Navigator.pop(context, '/create_new_lessons'),
                             child: const Text('باشه'),
                           ),
                         ],
                       ),
                     );
                   }
                  }

              },
            text: 'ثبت درس',),
          )


        ],
      ),
    );
  }

  Widget _buildDateExam(CreateNewLessonsController controller,
       BuildContext context)
  {
    return  OutlinedButton(
        style: OutlinedButton
            .styleFrom(minimumSize: const Size(double.infinity, 35),
            backgroundColor: Colors.white
        ),
        onPressed: (){
          controller.showMyDatePicker(context,null);

        },
        child: Consumer<CreateNewLessonsController>(
          builder: (context, value, child) {
            if(value.dateExam!=null)
            {
              return Text(value.dateExam!);
            }
            return const Text('انتخاب تاریخ');

          },
        ));
  }

  Widget _buildTextField({required String text ,
      required TextEditingController controller,
      int maxLine = 1}){
    return TextFormFieldWidget(
      controller: controller,
      hintText: text,
      maxLines: maxLine,
      noneEnableBorder: false,
      filled: true,
      fillColor: Colors.white,
      functionValidate: (value){
        if(value!.isEmpty)
          {
            return 'لطفا کادرها را پر کنید';
          }
        return null;
      },

    );
  }
  Padding _buildTitle(String name,TextTheme theme)
  {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: theme.subtitle1,
      ),
    );
  }

  Widget _buildDate({
    required TextTheme theme,
    required CreateNewLessonsController controller,
  required BuildContext context})
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Flexible(
           fit: FlexFit.tight,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   'تاریخ شروع',
                   style: theme.subtitle1,
                 ),
                 OutlinedButton(
                   style: OutlinedButton
                       .styleFrom(minimumSize: const Size(double.infinity, 35),
                       backgroundColor: Colors.white
                   ),
                     onPressed: (){
                       controller.showMyDatePicker(context,true);

                     },
                     child: Consumer<CreateNewLessonsController>(
                       builder: (context, value, child) {
                         if(value.startDate!=null)
                           {
                             return Text(value.startDate!);
                           }
                         return const Text('انتخاب تاریخ');

                       },
                     ))
               ],
             )
         ),
         const SizedBox(width: 15,),
         Flexible(
           fit: FlexFit.tight,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Text(
                   'تاریخ اتمام',
                   style: theme.subtitle1,
                 ),
                 OutlinedButton(
                     style: OutlinedButton
                         .styleFrom(
                         minimumSize: const Size(double.infinity, 35),
                       backgroundColor: Colors.white,
                     ),
                     onPressed: (){
                       controller.showMyDatePicker(context,false);
                     },
                     child: Consumer<CreateNewLessonsController>(
                       builder: (context, value, child) {
                         if(value.endDate !=null)
                           {
                             return Text(value.endDate!);
                           }
                         return const Text('انتخاب تاریخ');

                       },
                     )
                 )
               ],
             )
         ),

       ],
    );
  }



}
