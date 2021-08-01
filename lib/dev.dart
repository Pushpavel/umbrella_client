import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/pages/auth/LoginScreen.dart';
import 'package:umbrella_client/resources/theme/AppThemeData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: appThemeData,
        home: LoginScreen(),
      ),
    ),
  );
}
