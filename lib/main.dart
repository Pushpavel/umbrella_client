import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/pages/SplashScreen.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';
import 'package:umbrella_client/resources/Providers.dart';

void main() => runApp(MultiProvider(
      providers: [Providers.authService(), Providers.standService()],
      child: MaterialApp(
        theme: appThemeData,
        home: SplashScreen(onInit),
      ),
    ));

void onInit(BuildContext context) {
  // TODO: redirect to appropriate screen
}
