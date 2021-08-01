import 'package:flutter/material.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/auth/LoginScreen.dart';
import 'package:umbrella_client/pages/selectStand/SelectStandScreen.dart';

class AppScreens {
  AppScreens._();

  static MaterialPageRoute homeScreen() => MaterialPageRoute(builder: (_) => HomeScreen());

  static MaterialPageRoute loginScreen() => MaterialPageRoute(builder: (_) => LoginScreen());

  static MaterialPageRoute selectStandScreen() => MaterialPageRoute(builder: (_) => SelectStandScreen());
}
