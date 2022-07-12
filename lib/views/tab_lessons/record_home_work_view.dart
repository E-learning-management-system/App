

import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:project/controllers/record_home_work_controller.dart';
import 'package:project/controllers/student_delivery_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/exercise_item_model.dart';
import 'package:project/views/tab_lessons/item_lessons_view.dart';
import 'package:project/views/tab_lessons/student_delivery_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../widgets/empty_view_widget.dart';

class RecordHomeWorkView extends StatelessWidget {
  RecordHomeWorkView({Key? key, this.exercise }) : super(key: key);
  static const String id = '/record_home_work';
  ExerciseItemModel? exercise;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RecordHomeWorkController>(context);
    final theme = Theme.of(context).textTheme;
    var enStatus = ModalRoute.of(context)!.settings.arguments as EnCreateHomeWork;
    final deliveryController = Provider.of<StudentDeliveryController>(context,listen: false);
    RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
    controller.setTitle(exercise?.title);
    controller.setDes(exercise?.description.replaceAll(exp, ' '));

    String? title='';
    if(enStatus==EnCreateHomeWork.CreateNew){
      title='تکلیف جدید';
    }else{
      title=exercise?.title;
    }
    return Scaffold(
      appBar: AppbarWidget(
        text: title,
        centerTitle: false,
        showIc: true,
      ),
      body: _buildBody(
          theme: theme,
          controller: controller,
          enStatus: enStatus,
          context: context,
      exercise: exercise,
      deliveryController: deliveryController),
    );
  }

  Widget _buildBody(
      {required TextTheme theme,
      required RecordHomeWorkController controller,
      required EnCreateHomeWork enStatus,
      required BuildContext context,
      required ExerciseItemModel? exercise,
      required StudentDeliveryController deliveryController}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 12, left: 12, bottom: 25, top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleText(theme, 'عنوان'),
                    _buildTextField(controller.titleController,enStatus,exercise)
                  ],
                ),
              ),
              sizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleText(theme, 'مهلت تحویل'),
                    _buildDatePick(exercise,enStatus)
                  ],
                ),
              ),
            ],
          ),
          sizedBox(height: 15),
          Visibility(
              visible: enStatus != EnCreateHomeWork.CreateNew,
              child: _buildTitleText(theme, 'توضیح')),
          Visibility(
            visible: enStatus != EnCreateHomeWork.CreateNew,
              child: _buildTextField(controller.desController,enStatus,exercise, maxLine: true),
          replacement: _buildTextEditor(controller.keyEditor, theme,
          enStatus)),
          Visibility(
            visible:  enStatus != EnCreateHomeWork.CreateNew,
            child: _downloadFile(theme,enStatus,controller),),
          sizedBox(height: 15),
          Visibility(
              visible: enStatus == EnCreateHomeWork.Student,
              child: _buildTextEditor(controller.keyEditor, theme,enStatus)),
          sizedBox(height: 15),
          Visibility(visible: enStatus != EnCreateHomeWork.Professor, child: _buildUploadFile(theme)),
          sizedBox(height: 15),
          Visibility(
              visible: enStatus == EnCreateHomeWork.Professor,
              child: _buildChart(theme, context, controller,deliveryController)),
          sizedBox(height: 30),
          _buildButton(theme, enStatus,controller,context),
        ],
      ),
    );
  }

  _buildDatePick(ExerciseItemModel? exercise,EnCreateHomeWork enStatus){
    if(enStatus!=EnCreateHomeWork.CreateNew){
      return Consumer<RecordHomeWorkController>(
        builder: (context, value, child) => InkWell(
          onTap: (){},
          child: Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusTxtField),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 8),
            child: Text(exercise!.date.substring(0,10) ),
          ),
        ),
      );
    }
   else{ return Consumer<RecordHomeWorkController>(
      builder: (context, value, child) => InkWell(
        onTap: (){
            value.showDate(context);
        },
        child: Container(
          height: 30,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusTxtField),
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 8),
          child: Text(value.date??''),
        ),
      ),
    );
  }}

  _buildTitleText(TextTheme theme, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: theme.bodyText1!
            .copyWith(fontFamily: fontLotus, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller,EnCreateHomeWork enStatus,ExerciseItemModel? exercise, {bool maxLine = false}) {
   return TextFormFieldWidget(
     controller: controller,
     noneEnableBorder: false,
     readOnly: enStatus == EnCreateHomeWork.Student? true:false,
     filled: true,
     maxLines:maxLine? 6: 1,
     fillColor: Colors.white,
     hintText: '',

   );
  }

  _downloadFile(TextTheme theme,EnCreateHomeWork enStatus,RecordHomeWorkController controller) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusTxtField),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 12, top: 8, bottom: 6, left: 8),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  GestureDetector(onTap: ()async{
                  print ( 'download');
                    await controller.downloadFile(exercise?.file,exercise?.id);
                  },child:  Text(
                    'دانلود فایل',
                    style: theme.subtitle1!.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontLotus),
                  ),),

                  Visibility(
                    visible: enStatus == EnCreateHomeWork.Professor,
                      child: const Text(' / ')),
                  Visibility(
                    visible: enStatus == EnCreateHomeWork.Professor,
                    child: Text('حذف فایل',
                    style: theme.subtitle1!.copyWith(
                      color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontLotus
                    ),),
                  )
                ],
              ),
              Text(
                'file.png',
                style: theme.subtitle2!.copyWith(
                  color: Colors.red,
                ),
              )
            ]),
          ),
        ),
        Visibility(
          visible: enStatus == EnCreateHomeWork.Professor,
          child: TextButton(
              onPressed: (){

              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontWeight: FontWeight.bold)
              ),
              child: Text('آپلود فایل جدید',)),
        )
      ],
    );
  }

  Widget _buildTextEditor(
      GlobalKey<FlutterSummernoteState> controller, TextTheme theme,EnCreateHomeWork enStatus) {
    /// for get text type = controller.currentState.getText();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText(theme, enStatus == EnCreateHomeWork.CreateNew ? 'توضیح': 'پاسخ شما'),
        SizedBox(
          height: 150,
          child: FlutterSummernote(
            hint: '',
            key: controller,
            showBottomToolbar: false,
            customToolbar: """
                [
                  ['style', ['bold', 'italic', 'underline', 'clear']],
                  ['para', ['paragraph']],
                ]
              """,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadFile(TextTheme theme) {
    return Consumer<RecordHomeWorkController>(
      builder: (context, value, child) {
        if (value.file != null) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusTxtField),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(top: 18),
            padding: EdgeInsets.only(right: 8),
            child: Row(
              children: [
                const Icon(Icons.insert_drive_file_outlined),
                sizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'File_Name',
                        style: theme.subtitle2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      sizedBox(height: 8),
                      const LinearProgressIndicator(
                        value: 1,
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      value.deleteFile();
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      size: 15,
                    ),
                    splashRadius: 12),
              ],
            ),
          );
        }
        return GestureDetector(
          onTap: () {
            value.uploadFile();
          },
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusTxtField),
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                width: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(color: Colors.blue.shade100)),
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.drive_folder_upload,
                      color: MyColors.blueHex,
                      size: 30,
                    ),
                    sizedBox(height: 8),
                    Text(
                      'فایل خود را بارگذاری کنید',
                      style: theme.subtitle1!.copyWith(
                          color: MyColors.blueHex,
                          fontFamily: fontLotus,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(TextTheme theme, EnCreateHomeWork enStatus, RecordHomeWorkController controller,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevationButtonWidget(
          call: () async{
            if(enStatus == EnCreateHomeWork.CreateNew){
              var res = await controller.newExercise(exercise?.id);
              if(res){
                Navigator.pop(context);
              }else{
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        title: const Text('خطا'),
                        content: const Text(
                            'مشکلی در ثبت تکلیف وجود دارد.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(
                                context),
                            child: const Text('باشه'),
                          ),
                        ],
                      ),
                );
              }
            }if(enStatus == EnCreateHomeWork.Student){
              var res= await controller.newAnswer(exercise?.id);
              if(res){
                Navigator.pop(context);
              }
              else{
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        title: const Text('خطا'),
                        content: const Text(
                            'مشکلی در ثبت پاسخ وجود دارد.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(
                                context),
                            child: const Text('باشه'),
                          ),
                        ],
                      ),
                );
              }
            }if(enStatus == EnCreateHomeWork.Professor){
              Navigator.pop(context);
            }
          },
          width: 120,
          text: enStatus == EnCreateHomeWork.CreateNew? 'ثبت تکلیف': 'ثبت',
        ),

        Visibility(
          visible: enStatus == EnCreateHomeWork.Professor,
          child: InkWell(

            onTap: ()async{
              int count = 0;
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      content: const Text(
                          'از حذف این تکلیف مطمئن هستید؟'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async => {
              if(await controller.deleteExercise(exercise?.id)){
              showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
              AlertDialog(
              content: const Text(
              'تکلیف با موفقیت حذف شد.'),
              actions: <Widget>[

              TextButton(

              onPressed: () => Navigator.of(context).popUntil((_) => count++ >= 3),
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
              'مشکلی در حذف تکلیف وجود دارد.'),
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
              );

            },
            child: Container(
              margin: const EdgeInsets.only(right: 30),
              child: Text(
                'حذف تکلیف',
                style: theme.bodyText1!.copyWith(
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<bool> getStudents(StudentDeliveryController deliveryController)async{
    await deliveryController.getNotAnswerStudent(exercise?.id);
    await deliveryController.getAnswerStudent(exercise?.id);
    return true;
  }

  Widget _buildChart(TextTheme theme, BuildContext context,
      RecordHomeWorkController controller,StudentDeliveryController deliveryController)  {


    return FutureBuilder(

        future: getStudents(deliveryController),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // if (!snapshot.hasData) {
          //   int delivery=0;
          //   int notDelivery=0;
          //   return Column
          //     (
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       _buildTitleText(theme, 'آمار تحویل تکلیف'),
          //       Container(
          //         color: Colors.white,
          //         padding: EdgeInsets.all(8),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Row(
          //                   children: [
          //                     Container(
          //                       height: 12,
          //                       width: 12,
          //                       decoration: const BoxDecoration(
          //                         shape: BoxShape.circle,
          //                         color: Colors.green,
          //                       ),
          //                     ),
          //                     sizedBox(width: 8),
          //                     GestureDetector(
          //                         onTap: () {
          //                           Navigator.push(context, MaterialPageRoute(
          //                               builder: (context) =>
          //                                   StudentDeliveryView(Id: exercise!.id,
          //                                     title: exercise!.title,),
          //                               settings: const RouteSettings(
          //                                   arguments: true)
          //                           )
          //                           );
          //                         },
          //                         child: Text(
          //                           delivery.toString()+"  دانشجو تحویل داده اند"
          //                              ,
          //                           style: TextStyle(color: Colors.blue),
          //                         )),
          //                   ],
          //                 ),
          //                 sizedBox(height: 15),
          //                 Row(
          //                   children: [
          //                     Container(
          //                       height: 12,
          //                       width: 12,
          //                       decoration: const BoxDecoration(
          //                         shape: BoxShape.circle,
          //                         color: Colors.red,
          //                       ),
          //                     ),
          //                     sizedBox(width: 8),
          //                     GestureDetector(
          //                       onTap: () {
          //                         Navigator.push(context, MaterialPageRoute(
          //                             builder: (context) =>
          //                                 StudentDeliveryView(Id: exercise!.id,
          //                                   title: exercise!.title,),
          //                             settings: const RouteSettings(
          //                                 arguments: false)
          //                         )
          //                         );
          //                       },
          //                       child: Text(
          //                       notDelivery.toString()+"دانشجو تحویل نداده اند" ,
          //                           style: const TextStyle(color: Colors.blue)),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //             sizedBox(width: 8),
          //             PieChart(
          //               dataMap: {
          //                 'true': delivery.toDouble(),
          //                 'false': notDelivery.toDouble()
          //               },
          //               animationDuration: const Duration(milliseconds: 800),
          //               chartLegendSpacing: 15,
          //               chartRadius: MediaQuery
          //                   .of(context)
          //                   .size
          //                   .width / 3.2,
          //               initialAngleInDegree: 0,
          //               chartType: ChartType.ring,
          //               ringStrokeWidth: 14,
          //               legendOptions: const LegendOptions(
          //                 showLegends: false,
          //               ),
          //               centerText: controller.calPercentage(
          //                   delivery, delivery + notDelivery),
          //               totalValue: delivery.toDouble() + notDelivery,
          //               colorList: const [
          //                 Colors.green,
          //                 Colors.red,
          //               ],
          //               chartValuesOptions: const ChartValuesOptions(
          //                   showChartValueBackground: false,
          //                   showChartValues: false,
          //                   showChartValuesInPercentage: true,
          //                   showChartValuesOutside: false,
          //                   decimalPlaces: 0,
          //                   chartValueStyle: TextStyle(
          //                     fontSize: 12,
          //                     color: Colors.blue,
          //                   )),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   );
          // }
          int delivery=deliveryController.answerStudent[exercise?.id]!.length;
          int notDelivery=deliveryController.notAnswerStudent[exercise?.id]!.length;
          return Column
            (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleText(theme, 'آمار تحویل تکلیف'),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 12,
                              width: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                            sizedBox(width: 8),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          StudentDeliveryView(Id: exercise!.id,
                                            title: exercise!.title,),
                                      settings: const RouteSettings(
                                          arguments: true)
                                  )
                                  );
                                },
                                child: Text(
                                  delivery.toString()+"  دانشجو تحویل داده اند"
                                      ,
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                        sizedBox(height: 15),
                        Row(
                          children: [
                            Container(
                              height: 12,
                              width: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                            sizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        StudentDeliveryView(Id: exercise!.id,
                                          title: exercise!.title,),
                                    settings: const RouteSettings(
                                        arguments: false)
                                )
                                );
                              },
                              child: Text(notDelivery.toString()+"دانشجو تحویل نداده اند"
                                  ,
                                  style: const TextStyle(color: Colors.blue)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    sizedBox(width: 8),
                    PieChart(
                      dataMap: {
                        'true': delivery.toDouble(),
                        'false': notDelivery.toDouble()
                      },
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 15,
                      chartRadius: MediaQuery
                          .of(context)
                          .size
                          .width / 3.2,
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 14,
                      legendOptions: const LegendOptions(
                        showLegends: false,
                      ),
                      centerText: controller.calPercentage(
                          delivery, delivery + notDelivery),
                      totalValue: delivery.toDouble() + notDelivery,
                      colorList: const [
                        Colors.green,
                        Colors.red,
                      ],
                      chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: false,
                          showChartValues: false,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: false,
                          decimalPlaces: 0,
                          chartValueStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }
}
