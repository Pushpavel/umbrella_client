import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/models/AppState.dart';
import 'package:umbrella_client/pages/RetrySignInScreen.dart';
import 'package:umbrella_client/pages/SplashScreen.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState?>(context);

    return Navigator(
      pages: [
        if (state == null)
          MaterialPage(child: LoadingScreen())
        else
          MaterialPage(child: RetrySignInScreen())
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
