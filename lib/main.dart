import 'package:flutter/material.dart';
import 'package:umbrella_client/resources/AppNavigator.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';
import 'package:umbrella_client/services/AppService.dart';

void main() => runApp(
      MaterialApp(
        theme: appThemeData,
        home: AppService.provider(
          child: AppNavigator(),
        ),
      ),
    );
