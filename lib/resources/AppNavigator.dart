import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/RetrySignInScreen.dart';
import 'package:umbrella_client/pages/SplashScreen.dart';
import 'package:umbrella_client/services/AppStateProvider.dart';

class AppNavigator extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(appStateProvider);

    return Navigator(
      pages: state.maybeWhen(
        data: (state) => [
          if (state.user == null)
            MaterialPage(child: RetrySignInScreen())
          else
            MaterialPage(child: HomeScreen())
        ],
        orElse: () => [MaterialPage(child: LoadingScreen())],
      ),
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
