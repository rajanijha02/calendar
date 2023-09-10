class CalendarData {
  String?id;
  String? date;
  CalendarData({
    required this.date,
    required this.id,
  });

  CalendarData.fromJSON(Map<String, dynamic> json) {
    id = json['availability_id'] ?? "N/A";
    date = json['date'] ?? "N/A";
  }
}


  /// Data formate
/**
 * {
"data":
[
] "status": 200
{ "availability_id": "1001abcd", "date": "2023-09-09" },
{ " availability_id ": "1002hgsh", "date": "2023-09-10" }, { " availability_id ": "1003dhgh", "date": "2023-09-11" }, { " availability_id ": "1004dhdd", "date": "2023-09-12" }
},
 */