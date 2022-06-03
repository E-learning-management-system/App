import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:project/controllers/record_home_work_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class RecordHomeWorkView extends StatelessWidget {
  const RecordHomeWorkView({Key? key}) : super(key: key);
  static const String id = '/record_home_work';
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RecordHomeWorkController>(context);
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const AppbarWidget(
        text: 'ریاضی 2 - تکلیف 1',
        centerTitle: false,
        showIc: true,
      ),
      body: _buildBody(theme: theme, controller: controller),
    );
  }

  Widget _buildBody(
      {required TextTheme theme,
      required RecordHomeWorkController controller}) {
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
                    _buildTextField()
                  ],
                ),
              ),
              sizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleText(theme, 'مهلت تحویل'),
                    _buildTextField()
                  ],
                ),
              ),
            ],
          ),
          sizedBox(height: 15),
          _buildTitleText(theme, 'توضیح'),
          _buildTextField(maxLine: true),
          _downloadFile(theme),
          sizedBox(height: 15),
          _buildTitleText(theme, 'پاسخ شما'),
          _buildTextEditor(controller.keyEditor),
          sizedBox(height: 15),
          _buildUploadFile(theme),
          sizedBox(height: 15),
          _buildButton(theme)
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

  Widget _buildTextField({bool maxLine = false}) {
    return TextFormFieldWidget(
      hintText: '',
      noneEnableBorder: false,
      filled: true,
      maxLines: maxLine ? 6 : 1,
      fillColor: Colors.white,
    );
  }

  _downloadFile(TextTheme theme) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusTxtField),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 12, top: 8, bottom: 6, left: 8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'دانلود فایل',
              style: theme.subtitle1!.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontLotus),
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
    );
  }

  Widget _buildTextEditor(GlobalKey<FlutterSummernoteState> controller) {
    /// for get text type = controller.currentState.getText();
    return SizedBox(
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

  Widget _buildButton(TextTheme theme) {
    return Center(
        child: ElevationButtonWidget(
      call: () {},
      width: 120,
      text: 'ثبت',
    ));
  }
}
