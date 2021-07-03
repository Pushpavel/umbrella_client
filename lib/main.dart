import 'package:flutter/material.dart';
import 'package:umbrella_client/models/UmbrellaUser.dart';
import 'package:umbrella_client/resources/AppNavigator.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';
import 'package:umbrella_client/resources/Routes.dart';
import 'package:umbrella_client/services/AppStateStreamProvider.dart';

void main() => runApp(
      MaterialApp(
        theme: appThemeData,
        home: AppStateStreamProvider(
          child: AppNavigator(),
        ),
      ),
    );

redirectLoggedInUser(BuildContext context, UmbrellaUser user) async {
  if (user.requestId == null) {
    // user has no request
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: Routes.home, maintainState: false),
    );

    return;
  }

  await Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: Routes.pickup(Future.value(true)), maintainState: false),
  );
}
