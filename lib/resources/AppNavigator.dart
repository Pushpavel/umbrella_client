import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/LoginScreen.dart';
import 'package:umbrella_client/pages/SplashScreen.dart';
import 'package:umbrella_client/services/AuthService.dart';
import 'package:umbrella_client/utils/nav-utils.dart';

class AppNavigator extends StatefulWidget {
  final AuthService authService;

  const AppNavigator({Key? key, required this.authService}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState(authService: authService);
}

class _AppNavigatorState extends State<AppNavigator> {
  final AuthService authService;
  StreamSubscription? _sub;

  _AppNavigatorState({required this.authService});

  @override
  void initState() {
    super.initState();

    _sub = authService.user.listen((user) async {
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
  void dispose() {
    super.dispose();
    _sub?.cancel();
  }

  @override
  Widget build(BuildContext context) => LoadingScreen();
}
