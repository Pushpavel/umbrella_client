import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/pages/SplashScreen.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';
import 'package:umbrella_client/resources/Providers.dart';
import 'package:umbrella_client/resources/Routes.dart';
import 'package:umbrella_client/services/AuthService.dart';

void main() => runApp(MultiProvider(
      providers: [Providers.authService(), Providers.standService()],
      child: MaterialApp(
        theme: appThemeData,
        home: SplashScreen(onInit),
      ),
    ));

void onInit(BuildContext context) async {
  var auth = Provider.of<AuthService>(context);

  var user = await auth.getUser().first;

  if (user == null) {
    // User Not Logged In
    user = await auth.signInWithGoogle();
    // TODO: handle user still not logged in case
    return;
  }

  await Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: Routes.pickup, maintainState: false),
  );
}
