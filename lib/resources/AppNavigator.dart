import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/LoginScreen.dart';
import 'package:umbrella_client/pages/SplashScreen.dart';
import 'package:umbrella_client/services/AuthService.dart';
import 'package:umbrella_client/utils/nav-utils.dart';
import 'package:rxdart/rxdart.dart';

class AppNavigator extends StatefulWidget {
  final AuthService authService;

  const AppNavigator({Key? key, required this.authService}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState(authService: authService);
}

class _AppNavigatorState extends State<AppNavigator> {
  final AuthService authService;

  _AppNavigatorState({required this.authService});

  @override
  void initState() async {
    super.initState();
    await Firebase.initializeApp();

    authService.user.switchMap((user) async* {
      // unauthenticated user
      if (user == null) {
        await context.resetNavStackWith(LoginScreen());
        return;
      }

      // user with no request
      if (user.requestId == null) {
        await context.resetNavStackWith(HomeScreen());
        return;
      }

      // TODO: user with request
    });
  }

  @override
  Widget build(BuildContext context) => LoadingScreen();
}
