import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/main.dart';
import 'package:umbrella_client/services/AuthService.dart';

class RetrySignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Google Sign In"),
          onPressed: () async {
            var user = await auth.signInWithGoogle();

            if (user != null) redirectLoggedInUser(context, user);
          },
        ),
      ),
    );
  }
}
