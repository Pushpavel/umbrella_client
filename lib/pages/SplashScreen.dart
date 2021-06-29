import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Future<FirebaseApp> _initialization = Firebase.initializeApp();

class SplashScreen extends StatelessWidget {
  final Function(BuildContext) onLoad;

  const SplashScreen(this.onLoad);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) onLoad(context);
        return LoadingScreen();
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
