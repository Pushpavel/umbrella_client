import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_client/repositories/AuthRepo.dart';

class RetrySignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Google Sign In"),
          onPressed: () async {
            await AuthRepo.signInWithGoogle();
            //TODO: handle states
          },
        ),
      ),
    );
  }
}
