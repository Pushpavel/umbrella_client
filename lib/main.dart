import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/pages/ErrorScreen.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/auth/LoginScreen.dart';
import 'package:umbrella_client/resources/theme/AppThemeData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: appThemeData,
        home: _App(),
      ),
    ),
  );
}

class _App extends HookConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final userResult = ref.watch(authProvider).asResult();

    return userResult.when(
          (user) {
        if (user != null)
          return HomeScreen();
        else
          return LoginScreen();
      },
      error: (err) => ErrorScreen(err: err),
      loading: () => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
