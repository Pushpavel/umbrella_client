import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/resources/AppNavigator.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';
import 'package:umbrella_client/services/AuthService.dart';

void main() => runApp(
      MaterialApp(
        theme: appThemeData,
        home: Provider<AuthService>(
          create: (_) => AuthService(),
          dispose: (_, service) => service.dispose(),
          child: _App(),
        ),
      ),
    );

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return AppNavigator(authService: authService);
  }
}
