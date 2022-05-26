import 'package:flutter/material.dart';
import 'package:project/controllers/create_new_subject_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class CreateNewSubjectView extends StatelessWidget {
  const CreateNewSubjectView({Key? key}) : super(key: key);
  static const String id = '/create_new_subject';

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CreateNewSubjectController>(context);
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: MyColors.greyHex,
      body: _buildBody(theme,context,controller),
    );
  }

  Widget _buildBody(TextTheme theme,BuildContext context,
      CreateNewSubjectController controller) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 300,
          margin: const EdgeInsets.only(top: 30),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8, bottom: 30, right: 12, left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  },
                      icon: const Icon(Icons.close, size: 15,),
                      splashRadius: 12),
                  _buildContent(theme,controller)],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TextTheme theme, CreateNewSubjectController controller,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText(theme, 'موضوع'),
        _buildTextField(controller: controller.controllerTitle),
        sizedBox(height: 12),
        _buildTitleText(theme, 'متن پیام'),
        _buildTextField(maxLine: true,controller: controller.controllerBody),
        _buildUploadFile(theme),
        _buildButton()
      ],
    );
  }

  _buildTitleText(TextTheme theme, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: theme.headline6!.copyWith(fontFamily: fontLotus),
      ),
    );
  }

  _buildUploadFile(TextTheme theme) {
    return Consumer<CreateNewSubjectController>(
      builder: (context, value, child) {
        if(value.file!=null)
        {
          return Container(
            height: 50,
            margin: EdgeInsets.only(top: 18),
            child: Row(
              children: [
                const Icon(Icons.insert_drive_file_outlined),
                sizedBox(
                  width: 8
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('File_Name',style: theme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold
                      ),),
                      sizedBox( height: 8),
                      const LinearProgressIndicator(value: 1,)
                    ],
                  ),
                ),
                IconButton(onPressed: (){
                  value.deleteFile();
                },
                    icon: const Icon(Icons.delete_forever, size: 15,),
                    splashRadius: 12),
              ],
            ),
          ) ;
        }
        return  GestureDetector(
          onTap: () => value.uploadFile(),
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusTxtField),
              color: Colors.grey.shade300,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 12, top: 6, bottom: 6),
              child: Row(children: [
                const Icon(Icons.cloud_upload, color: Colors.blueAccent),
                sizedBox(width: 12),
                Text(
                  'اپلود فایل',
                  style: theme.subtitle1!.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontLotus),
                )
              ]),
            ),
          ),
        ) ;
      },

    );
  }

  _buildButton() {
    return Container(
      margin: const EdgeInsets.only(top: 18),
      child: ElevationButtonWidget(
        borderRadius: 4,
        width: 80,
        height: 30,
        call: () {},
        text: 'ثبت',
      ),
    );
  }

  Widget _buildTextField({bool maxLine = false,required TextEditingController controller}) {
    return TextFormFieldWidget(
      controller: controller,
      hintText: '',
      noneEnableBorder: false,
      filled: true,
      maxLines: maxLine ? 6 : 1,
      fillColor: Colors.grey.shade300,
    );
  }
}
