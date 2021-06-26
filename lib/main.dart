import 'package:flutter/material.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';
import 'package:umbrella_client/resources/Routes.dart';

void main() => runApp(MaterialApp(
    theme: appThemeData,
    initialRoute: '/',
    routes: {'/': Routes.pickup},
  ));
