import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_client/helpers/DisposableProvider.dart';
import 'package:umbrella_client/helpers/extensions/ContextExtensions.dart';
import 'package:umbrella_client/resources/AppNavigator.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';
import 'package:umbrella_client/data/services/AuthService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      theme: appThemeData,
      home: DisposableProvider<AuthService>(
        create: (_) => AuthService(),
        child: _App(),
      ),
    ),
  );
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = context.get<AuthService>();
    return AppNavigator(authService: authService);
  }
}
