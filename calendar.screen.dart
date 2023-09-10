import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../controller/calendar.controller.dart';
import '../model/calendarDate.dart';

class CalendarScreen extends GetView<MYCalendarController> {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('calendar'),
        actions: [
          Obx(
            () => controller.isLoading.isTrue
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Container(),
          )
        ],
      ),
      body: SfCalendar(
        view: CalendarView.month,
        monthCellBuilder: (context, details) {
          final f = DateFormat('yyyy-MM-dd');
          String key = f.format(details.date);
          return Obx(
            () => Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    controller.dates[key] != null ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text('${details.date.day}'),
            ),
          );
        },
        onViewChanged: (viewChangedDetails) async {
          /**
                   * This function execute when user swip calendar left and right
                   */
          print("New : ${viewChangedDetails.visibleDates[14].year}");
          String months = viewChangedDetails.visibleDates[14].month.toString();
          String year = viewChangedDetails.visibleDates[14].year.toString();

          controller.changeMonthsAndYear(months, year);
        },
        onTap: (calendarTapDetails) {
          /**
           * This function will execute when user click on date 
           * you just need make a function for delete api and call that function inside this 
           */
          print('${calendarTapDetails.date.toString()}');
          final f = DateFormat('yyyy-MM-dd');
          String key = f.format(calendarTapDetails.date ?? DateTime.now());

          CalendarData data = controller.dates[key];
          controller.deleteAvailability(data.id ?? "N/A");
        },
      ),
    );
  }
}
