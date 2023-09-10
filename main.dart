import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'calendar/bindings/calendar.bindings.dart';
import 'calendar/screens/calendar.screen.dart';

void main() {
  runApp(const Calendar());
}

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Calendar",
      initialRoute: '/calendar',
      getPages: [
        GetPage(
          name: '/calendar',
          page: () => CalendarScreen(),
          binding: CalendarBindings(),
        ),
      ],
    );
  }
}
