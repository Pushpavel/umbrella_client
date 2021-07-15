import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/helpers/simpleNavigator.dart';
import 'package:umbrella_client/pages/DropScreen.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/LoadingScreen.dart';
import 'package:umbrella_client/pages/LoginScreen.dart';
import 'package:umbrella_client/pages/PickupScreen.dart';

class NavDelegate extends SinglePageRouterDelegate {
  @override
  Widget buildPage(context, ref) {
    final userResult = ref.watch(authProvider).asResult();

    if (userResult == null) return LoadingScreen();

    return userResult.when(
      (user) {
        if (user == null) return LoginScreen();

        final requestResult = ref.watch(currentUmbrellaRequestProvider).asResult();

        requestResult?.getOrThrow();

        if (requestResult == null) return LoadingScreen();

        return requestResult.when(
          (request) {
            // user with no request
            if (request == null) return HomeScreen();

            // user with request
            switch (request.status) {
              case UmbrellaRequestStatus.REQUESTED:
                return PickupScreen();
              case UmbrellaRequestStatus.PICKED_UP:
                return DropScreen();
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