import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}
const int ticks = 5;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}
const int ticks = 5;
Stream<int>.periodic(
        const Duration(seconds: 1), (x) => ticks - x % (ticks + 1)).listen((value) => print(value));