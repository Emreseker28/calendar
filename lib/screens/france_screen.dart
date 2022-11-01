import 'package:calendar/services/calendar.dart';
import 'package:calendar/utilities/constants.dart';
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
  var holidayList = [];
  var yearList = [];
  var monthList = [];
  var dayList = [];

  void updateUI(dynamic calendarData) {
    setState(() {
      if (calendarData == null) {
        holidayName = 'Cannot get holiday information';
        year = 0;
        month = 0;
        day = 0;
        return;
      }

      for (int i = 0; i < 24; i++) {
        var holiday = widget.franceCalendar['response']['holidays'][i]['name'];
        var yearToAdd =
            calendarData['response']['holidays'][i]['date']['datetime']['year'];
        var monthToAdd = calendarData['response']['holidays'][i]['date']
            ['datetime']['month'];
        var dayToAdd =
            calendarData['response']['holidays'][i]['date']['datetime']['day'];
        holidayList.add(holiday);
        yearList.add(yearToAdd);
        monthList.add(monthToAdd);
        dayList.add(dayToAdd);
      }
      holidayName = holidayList[0];
      year = yearList[0];
      month = monthList[0];
      day = dayList[0];
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.franceCalendar);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: List.generate(holidayList.length, (index) {
          return Container(
            child: Column(
              children: [
                Text(
                  'Holiday: ${holidayList[index]}, Date: ${dayList[index]}-${monthList[index]}-${yearList[index]}',
                  style: kMessageTextStyle,
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          );
        }),
      ),
    ]);
  }
}
