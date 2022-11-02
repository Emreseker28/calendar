import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const calendarificURL = "https://calendarific.com/api/v2/holidays";
const apiKey = "33f2a05808e7f8fe6a04a289e1a7c8cb60564b48";
const franceISO = "FR";
const spainISO = "ES";

//request: curl 'https://calendarific.com/api/v2/holidays?&api_key=API_KEY&country=&year='

const kMessageTextStyle = TextStyle(
    fontFamily: 'Spartan MB',
    fontSize: 20.0,
    color: Colors.white,
    decoration: TextDecoration.none);

const kButtonTextStyle = TextStyle(
    fontSize: 30.0,
    fontFamily: 'Spartan MB',
    color: Colors.white,
    decoration: TextDecoration.none);

const kLoadingSpin = Center(
  child: SpinKitDoubleBounce(
    color: Colors.white,
    size: 100.0,
  ),
);

List<int> getList() {
  List<int> list = <int>[2022, 2021, 2020, 2019];
  return list;
}
