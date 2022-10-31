import 'package:calendar/services/calendar.dart';
import 'package:flutter/material.dart';

class FranceScreen extends StatefulWidget {
  const FranceScreen({this.franceCalendar});
  final franceCalendar;

  @override
  State<FranceScreen> createState() => _FranceScreenState();
}

class _FranceScreenState extends State<FranceScreen> {
  CalendarModel calendar = CalendarModel();
  String holidayName = '';
  int year = 0;
  int month = 0;
  int day = 0;

  void updateUI(dynamic calendarData) {
    setState(() {
      if (calendarData == null) {
        holidayName = 'Cannot get holiday information';
        year = 0;
        month = 0;
        day = 0;
        return;
      }
      holidayName = calendarData['response']['holidays'][0]['name'];
      year =
          calendarData['response']['holidays'][0]['date']['datetime']['year'];
      month =
          calendarData['response']['holidays'][0]['date']['datetime']['month'];
      day = calendarData['response']['holidays'][0]['date']['datetime']['day'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.franceCalendar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Text('holiday name: $holidayName year: $year month $month day: $day'),
    );
  }
}
