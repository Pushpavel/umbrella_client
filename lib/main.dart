import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/resources/AppScreens.dart';
import 'package:umbrella_client/resources/theme/AppThemeData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: appThemeData,
        home: HookConsumer(
          builder: (context, ref, child) {
            useEffect(() {
              handleInitialNavigation(context, ref);
            }, []);

            return child!;
          },
          child: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    ),
  );
}

handleInitialNavigation(BuildContext context, WidgetRef ref) async {
  final user = await ref.read(authProvider.stream).first;
  final screen = user == null ? AppScreens.loginScreen() : AppScreens.homeScreen();
  Navigator.of(context).pushAndRemoveUntil(screen, (route) => false);
}
