import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/resources/AppNavigator.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';

void main() => runApp(
      MaterialApp(
        theme: appThemeData,
        home: ProviderScope(
          child: AppNavigator(),
        ),
      ),
    );
