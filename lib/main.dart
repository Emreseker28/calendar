import 'package:calendar/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'screens/france_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
