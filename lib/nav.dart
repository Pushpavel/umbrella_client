import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest_.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/helpers/simpleNavigator.dart';
import 'package:umbrella_client/pages/DropScreen.dart';
import 'package:umbrella_client/pages/ErrorScreen.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/LoadingScreen.dart';
import 'package:umbrella_client/pages/LoginScreen.dart';
import 'package:umbrella_client/pages/PickupScreen.dart';

class NavDelegate extends SinglePageRouterDelegate {
  @override
  Widget buildPage(context, ref) {
    final userResult = ref.watch(authProvider).asResult();

    return userResult.when(
      (user) {
        if (user == null) return LoginScreen();

        final requestResult = ref.watch(currentUmbrellaRequestProvider).asResult();

        return requestResult.when(
          (request) {
            // user with no request
            return HomeScreen(user: userResult.getOrNull());

           /*  // user with request
            switch (request.status) {
              case UmbrellaRequestStatus.REQUESTED:
                return PickupScreen();
              case UmbrellaRequestStatus.PICKED_UP:
                return DropScreen();
              default:
                return ErrorScreen(
                  err: InternalErr("Current Umbrella Request Status must not be ${request.status}"),
                );
            } */
          },
          error: (e) => ErrorScreen(err: e),
          loading: () => LoadingScreen(),
        );
      },
      error: (e) => ErrorScreen(err: e),
      loading: () => LoadingScreen(),
    );
  }
}
