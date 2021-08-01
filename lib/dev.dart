import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/pages/auth/ProfileScreen.dart';
import 'package:umbrella_client/resources/theme/AppThemeData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: appThemeData,
        home: ProfileScreen(),
      ),
    ),
  );
}
