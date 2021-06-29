import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/pages/SplashScreen.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';
import 'package:umbrella_client/resources/Providers.dart';
import 'package:umbrella_client/resources/Routes.dart';
import 'package:umbrella_client/services/AuthService.dart';
import 'package:umbrella_client/services/UmbrellaService.dart';

void main() => runApp(MultiProvider(
      providers: [
        Providers.authService(),
        Providers.standService(),
        Providers.umbrellaService()
      ],
      child: MaterialApp(
        theme: appThemeData,
        home: SplashScreen(onInit),
      ),
    ));

onInit(BuildContext context) async {
  var auth = Provider.of<AuthService>(context);

  var user = await auth.getUser().first;

  if (user == null) {
    // User not logged in
    user = await auth.signInWithGoogle();
    if (user == null) {
      // User still not logged in
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: Routes.retrySignIn, maintainState: false),
      );
      return;
    }
  }

  await redirectLoggedInUser(context, user);
}

redirectLoggedInUser(BuildContext context, User user) async {
  var umbrellaService = Provider.of<UmbrellaService>(context);

  var request = await umbrellaService.getLastUmbrellaRequestOfUser(user).first;

  if (request == null) {
    // user has no request
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: Routes.home, maintainState: false),
    );

    return;
  }

  await Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: Routes.timer, maintainState: false),
  );
}
