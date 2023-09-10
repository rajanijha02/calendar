import 'package:get/get.dart';

import '../controller/calendar.controller.dart';

class CalendarBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MYCalendarController());
  }
}
