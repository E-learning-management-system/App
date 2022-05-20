import 'package:flutter/material.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/controllers/calendar_controller.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);
  static const String id = '/calendar_view';

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CalendarController>(context);
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: _buildBody(
          textTheme: theme, controller: controller, context: context),
    );
  }

  Widget _buildBody(
      {required TextTheme textTheme,
      required CalendarController controller,
      required BuildContext context}) {
    return Column(
      children: [
        _buildCalendar(context, controller),
        sizedBox(height: 12),
        _buildListView(controller,textTheme)
      ],
    );
  }

  Widget _buildCalendar(BuildContext context, CalendarController controller) {
    return SizedBox(
      height: 200,
      child: JalaliTableCalendar(
          selectedFormat: 'yyyy-m-d',
          locale: Locale("fa", "IR"),
          convertToGregorian: false,
          context: context,
          marker: (date, events) {
            return SizedBox();
          },
          onDaySelected: (date) {
            print(controller.convertToPersian(date.toString()));
          }),
    );
  }

  Widget _buildListView(CalendarController controller,TextTheme theme) {
    return Expanded(child: ListView.builder(
      padding: const EdgeInsets.only(top: 15,
      right: 12,
      left: 12,
      bottom: 15),
      itemExtent: 120,
      itemCount: controller.listModel.length,
      itemBuilder: (context, index) {
        final data= controller.listModel[index];
        return Card(
           color: data.bgColor,

          margin: const EdgeInsets.only(top: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title,style: theme.headline6,),
                sizedBox(
                  height: 20
                ),
                Text('مهلت : ${data.date}')
              ],
            ),
          ),
        );
      },
    ));
  }
}
