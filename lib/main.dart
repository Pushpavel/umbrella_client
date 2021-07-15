import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/helpers/simpleNavigator.dart';
import 'package:umbrella_client/nav.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: MaterialApp.router(
        theme: appThemeData,
        routerDelegate: NavDelegate(),
        routeInformationParser: DumbRouteInfoParser(),
      ),
    ),
  );
}
