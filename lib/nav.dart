import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
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
        if (user == null) return LoginScreen();

        final requestResult = context.get<Result<UmbrellaRequest?>?>();

        if (requestResult == null) return LoadingScreen();

        return requestResult.when(
          (request) {
            // user with no request
            if (request == null) return HomeScreen();

            // user with request
            switch (request.status) {
              case UmbrellaRequestStatus.REQUESTED:
                // TODO: use this after refactoring PickupScreen to use Provider for currentRequest
                // PickupScreen(requestStream: requestStream.map((event) => event!),);
                return LoadingScreen();
              case UmbrellaRequestStatus.PICKED_UP:
                // TODO: use this after refactoring DropScreen to use Provider for currentRequest
                // DropScreen(requestStream: requestStream.map((event) => event!),);
                return LoadingScreen();
              default:
                // TODO: go to error page
                return LoadingScreen();
            }
          },
          error: (e) => LoadingScreen(), // TODO: go to error page
        );
      },
      error: (e) => LoadingScreen(), // TODO: go to error page
    );
  }
}
