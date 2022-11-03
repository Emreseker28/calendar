import 'package:calendar/services/calendar.dart';
import 'package:calendar/utilities/constants.dart';
import 'package:flutter/material.dart';

class SpainScreen extends StatefulWidget {
  const SpainScreen({this.spainCalendar});
  final spainCalendar;

  @override
  State<SpainScreen> createState() => _SpainScreenState();
}

class _SpainScreenState extends State<SpainScreen> {
  CalendarModel calendar = CalendarModel();
  String holidayName = '';
  String countryISO = 'ES';
  int dropdownValue = 2022;
  int year = 0;
  int month = 0;
  int day = 0;
  var spainHolidayList = [];
  var spainYearList = [];
  var spainMonthList = [];
  var spainDayList = [];
  var list = getList();

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
        var holiday = calendarData['response']['holidays'][i]['name'];
        var yearToAdd =
            calendarData['response']['holidays'][i]['date']['datetime']['year'];
        var monthToAdd = calendarData['response']['holidays'][i]['date']
            ['datetime']['month'];
        var dayToAdd =
            calendarData['response']['holidays'][i]['date']['datetime']['day'];
        spainHolidayList.add(holiday);
        spainYearList.add(yearToAdd);
        spainMonthList.add(monthToAdd);
        spainDayList.add(dayToAdd);
      }
      holidayName = spainHolidayList[0];
      year = spainYearList[0];
      month = spainMonthList[0];
      day = spainDayList[0];
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.spainCalendar);
  }

  void updateYear(int selectedYear) async {
    var newCalendarData =
        await calendar.getCountryCalendar(countryISO, selectedYear);
    setState(() {
      updateUI(newCalendarData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Card(
        child: DropdownButton<int>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: kMessageTextStyle,
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int? value) {
            setState(() {
              dropdownValue = value!;
              updateYear(dropdownValue);
            });
          },
          items: list.map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ),
      Column(
        children: List.generate(spainHolidayList.length, (index) {
          return Container(
            child: Column(
              children: [
                Text(
                  'Holiday: ${spainHolidayList[index]}, Date: ${spainDayList[index]}-${spainMonthList[index]}-${spainYearList[index]}',
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
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'France',
            style: kButtonTextStyle,
          ))
    ]);
  }
}
