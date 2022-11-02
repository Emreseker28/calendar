import 'package:calendar/screens/spain_screen.dart';
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
  String countryISO = 'FR';
  int dropdownValue = 2022;
  int year = 0;
  int month = 0;
  int day = 0;
  var holidayList = [];
  var yearList = [];
  var monthList = [];
  var dayList = [];
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
        holidayList.add(holiday);
        yearList.add(yearToAdd);
        monthList.add(monthToAdd);
        dayList.add(dayToAdd);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.franceCalendar);
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
                ),
              ],
            ),
          );
        }),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SpainScreen();
            }));
          },
          child: Text(
            'Spain',
            style: kButtonTextStyle,
          ))
    ]);
  }
}
