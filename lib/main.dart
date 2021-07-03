import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/models/AppState.dart';
import 'package:umbrella_client/resources/AppNavigator.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';
import 'package:umbrella_client/services/AppStateStreamProvider.dart';

void main() => runApp(
      MaterialApp(
        theme: appThemeData,
        home: StreamProvider<AppState?>(
          create: createAppStateStream,
          initialData: null,
          child: AppNavigator(),
        ),
      ),
    );
