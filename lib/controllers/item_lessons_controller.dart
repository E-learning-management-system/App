import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';

import 'package:project/models/lessons_item_model.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';

class ItemLessonsController extends ChangeNotifier{

  var status = StatusCategory.LastTopics;
  List<LessonsItemModel> listModel = [
    for (int i = 0; i < 3; i++) ...[
      LessonsItemModel(
        description: 'انتگرال یگانه',
        title: 'مبحث اول',
        endDate: '1400/11/25',
        examDate: '',
        id: i,
        startDate: '',
        teacher: ''
      ),
    ]
  ];




  void setHomeWork() {
    listModel = [
      for (int i = 0; i < 3; i++) ...[
        LessonsItemModel(
            description: 'این یک موضوع است',
            title: 'تکلیف اول',
            endDate: '1400/11/25',
            examDate: '',
            id: i,
            startDate: '',
            teacher: ''
        ),
      ]
    ];
    status = StatusCategory.HomeWork;
    notifyListeners();
  }
  void setLastTopics() {
    listModel = [
      for (int i = 0; i < 3; i++) ...[
        LessonsItemModel(
            description: 'انتگرال یگانه',
            title: 'مبحث اول',
            endDate: '1400/11/25',
            examDate: '',
            id: i,
            startDate: '',
            teacher: ''
        ),
      ]
    ];
    status = StatusCategory.LastTopics;
    notifyListeners();
  }
  void setBookMark()
  {
    listModel = [
      for (int i = 0; i < 3; i++) ...[
        LessonsItemModel(
            title: 'زمان امتحان کی هست ؟ ',
            endDate: '1400/11/25',
            name: 'دانیال صابر',
            countCm: 15,
            description: 'این تنهای یک پیغام تست است یک پیام تستتستتستتستتستتستتست تست',
            id: i,
            startDate: '',
            teacher: '',
            examDate: ''
            ),
      ]
    ];
    status = StatusCategory.BookMark;
    notifyListeners();
  }

  void setUsers()
  {
    listModel = [
      for (int i = 0; i < 3; i++) ...[
        LessonsItemModel(
            description: 'انتگرال یگانه',
            title: 'دانیال صابر',
            endDate: '1400/11/25',
            examDate: '',
            id: 4,
            startDate: '',
            teacher: ''
        ),
      ]
    ];
  }

  void setItemCategory(StatusCategory status) {

    if (status == StatusCategory.BookMark) {
      setBookMark();
      return;
    }
    if (status == StatusCategory.HomeWork) {
      setHomeWork();
      return;
    }
    if (status == StatusCategory.LastTopics) {
      setLastTopics();
      return;
    } else {
      this.status = status;
      setUsers();
      notifyListeners();
    }
  }


  void openDialog(BuildContext context)
  {
    showDialog(context: context,
        builder: (cnt)
        => AlertDialog(
          scrollable: false,
          title: Text('نام مبحث'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormFieldWidget(hintText: 'نام موضوع را وارد کنید'),
              sizedBox(height: 15),
              ElevationButtonWidget(
                  call: (){},
                text: 'ایجاد',
              )
            ],
          ),
        )

        );
  }



}