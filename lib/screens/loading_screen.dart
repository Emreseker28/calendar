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
    getCalendar();
  }

  void getCalendar() async {
    var calendarData = await CalendarModel().getCountryCalendar('FR', 2022);
    //Because the first screen is for France, calling the getter method for France.

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FranceScreen(
        franceCalendar:
            calendarData, //Pass the obtained information to the second screen.
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: kLoadingSpin, //Show a spinning circle while loading the screen.
    );
  }
}
