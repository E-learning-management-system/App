

import 'package:flutter/material.dart';
import 'package:project/controllers/record_home_work_controller.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/views/tab_lessons/item_lessons_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../../models/answer_model.dart';


class AnswerView extends StatelessWidget {
  AnswerView({Key? key, this.answer }) : super(key: key);
  static const String id = '/answer';
  AnswerItemModel? answer;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RecordHomeWorkController>(context);
    final theme = Theme.of(context).textTheme;
    var enStatus = ModalRoute.of(context)!.settings.arguments as EnCreateHomeWork;
    controller.setTitle(answer?.user_email);
    controller.setDes(answer?.description);

    String? title=(answer?.exercise_title)!+'/'+(answer?.user_email)!;
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
          answer: answer,),
    );
  }

  Widget _buildBody(
      {required TextTheme theme,
        required RecordHomeWorkController controller,
        required EnCreateHomeWork enStatus,
        required BuildContext context,
        required AnswerItemModel? answer,}) {
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
                    _buildTitleText(theme, 'ایمیل دانشجو'),
                    _buildTextField(controller.titleController,enStatus)
                  ],
                ),
              ),
              sizedBox(width: 8),
            ],
          ),
          sizedBox(height: 15),
          _buildTitleText(theme, 'توضیح'),
          _buildTextField(controller.desController,enStatus, maxLine: true),
          _downloadFile(theme,enStatus),
          sizedBox(height: 15),
          sizedBox(height: 30),
          // _buildButton(theme, enStatus,controller,context),
        ],
      ),
    );
  }


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

  Widget _buildTextField(TextEditingController controller,EnCreateHomeWork enStatus, {bool maxLine = false}) {
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

  _downloadFile(TextTheme theme,EnCreateHomeWork enStatus) {
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
                  Text(
                    'دانلود فایل',
                    style: theme.subtitle1!.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontLotus),
                  ),

                ],
              ),
              Text(
                'file.pdf',
                style: theme.subtitle2!.copyWith(
                  color: Colors.red,
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }
}
