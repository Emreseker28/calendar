import 'package:flutter/material.dart';
import 'france_screen.dart';
import 'package:calendar/services/calendar.dart';
import 'package:calendar/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var calendarData = await CalendarModel().getCountryCalendar('FR', 2022);
    //print(calendarData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FranceScreen(
        franceCalendar: calendarData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: kLoadingSpin);
  }
}
