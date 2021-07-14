import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';
import 'package:umbrella_client/helpers/extensions/ContextExtensions.dart';
import 'package:umbrella_client/helpers/result/Result.dart';
import 'package:umbrella_client/helpers/simpleNavigator.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/LoadingScreen.dart';
import 'package:umbrella_client/pages/LoginScreen.dart';

class NavDelegate extends SinglePageRouterDelegate {
  @override
  Widget buildPage(BuildContext context) {
    final userResult = context.get<Result<UmbrellaUser?>?>();

    if (userResult == null) return LoadingScreen();

    return userResult.when(
      (user) {
        if (user == null)
          return LoginScreen();
        else
          return HomeScreen();
      },
      error: (e) => LoadingScreen(),
    );
  }
}
