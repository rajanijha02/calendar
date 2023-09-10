import 'dart:async';
import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

import '../model/calendarDate.dart';

class MYCalendarController extends GetxController {
  dynamic dummyData = {
    "data": [
      {"availability_id": "1001abcd", "date": "2023-09-09"},
      {" availability_id ": "1002hgsh", "date": "2023-09-10"},
      {" availability_id ": "1003dhgh", "date": "2023-09-11"},
      {" availability_id ": "1004dhdd", "date": "2023-09-12"}
    ],
    "status": 200
  };

  RxMap<String, dynamic> dates = <String, dynamic>{}.obs;
  RxBool isLoading = false.obs;
  RxString months = DateTime.now().month.toString().obs;
  RxString year = DateTime.now().year.toString().obs;

  @override
  void onInit() {
    dates.clear();
    fetchCalenDataFromApi(months.value, year.value);

    /**
     * This code will automatically call fetch calendarDataFromAPi when value of months and year change
     */
    everAll(
      [months, year],
      (callback) => fetchCalenDataFromApi(months.value, year.value),
    );
    super.onInit();
  }

  changeMonthsAndYear(String months, String year) {
    this.months(months);
    this.year(year);
  }

  fetchCalenDataFromApi(String months, String year) async {
    print('calling api for data of months $months and $year');
    try {
      /**
     * This function is responsible for fetch data from server using api end points 
     * 
     * Right not i am going to use timer for hold control 
     * 
     */

      isLoading(true);
      /**
       * You need to remove this timer and add api calls using http or get connect 
       */
      Timer(const Duration(seconds: 2), () {
        /**
         * 
         * Suppose [dummyData] variable contains your data which comming from server 
         * Now,
         * 
         * STEP 1: if you are using http then you need to decode response data using json.decode(response.body)
         * STEP 2: now you have create a vriable type of List<CalendarData> and parse all the data in this variable
         * STEP 3: call the function which will convert List<CalendarData> to Map<String, CalendarData>
         * 
         * note:- In Map<String, CalendarData> string is reponsible for hold date of that data.
         * 
         */

        // dynamic data = json.decode(dummyData); // uncomment this one you call api

        List<dynamic> records =
            dummyData['data']; // you  can data key in response dummy

        List<CalendarData> d = List.generate(records.length,
            (index) => CalendarData.fromJSON(records[index])).toList();
        /**
         * Above code will you parse you json data into List of class model (CalendarData)
         */

        dates.value = listToMap(dates: d);

        isLoading(false);
      });

      /**
       * 
       * When your api call completed you need to change the state of isLoading from true to false
       * 
       */
    } catch (e) {
      /**
       * Handle Your error 
       *  */
      print(e);
    }
  }

  deleteAvailability(String id) async {
    print('Delete data related to $id');
    /**
     * 
     * You have call api for this and when api respose with 200 status code you just need to call 
     * fetchCalenDataApi function for refresh data of calendar;
     * i am just removing data from map
     * 
     */

  }

  Map<String, CalendarData> listToMap({required List<CalendarData> dates}) {
    Map<String, CalendarData> map = {};
    for (var element in dates) {
      map[element.date ?? "N/A"] = element;
    }
    return map;
  }
}
