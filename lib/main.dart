import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/data/services/AuthService.dart';
import 'package:umbrella_client/helpers/DisposableProvider.dart';
import 'package:umbrella_client/resources/AppNavigator.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        // TODO: use this provider after migrating to different navigation
        // ResultStreamProvider<UmbrellaUser?>(create: (_) => AuthRepo.getUser()),
        DisposableProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        theme: appThemeData,
        home: Consumer<AuthService>(
          builder: (context, value, _) => AppNavigator(authService: value),
        ),
      ),
    ),
  );
}
