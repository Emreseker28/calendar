import 'package:flutter/material.dart';
import 'france_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:calendar/services/calendar.dart';

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

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FranceScreen(
        franceCalendar: calendarData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
