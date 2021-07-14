import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/providers/currentUmbrellaRequest.dart';
import 'package:umbrella_client/helpers/simpleNavigator.dart';
import 'package:umbrella_client/nav.dart';
import 'package:umbrella_client/resources/AppThemeData.dart';

import 'data/models/UmbrellaUser.dart';
import 'data/repositories/AuthRepo.dart';
import 'helpers/ResultStreamProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ResultStreamProvider<UmbrellaUser?>(create: (_) => AuthRepo.getUser()),
        ResultStreamProvider<UmbrellaRequest?>(create: currentUmbrellaRequest),
      ],
      child: MaterialApp.router(
        theme: appThemeData,
        routerDelegate: NavDelegate(),
        routeInformationParser: DumbRouteInfoParser(),
      ),
    ),
  );
}
