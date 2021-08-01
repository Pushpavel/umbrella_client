import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/data/repositories/AuthRepo.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/helpers/result/Result.dart';
import 'package:umbrella_client/resources/AppScreens.dart';

import 'GoogleSignInButton.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlutterLogo(size: 72),
              SizedBox(height: 32),
              Text("Umbrella Login", style: Theme.of(context).textTheme.headline1),
              SizedBox(height: 72),
              _AuthSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthSection extends HookConsumerWidget {
  const _AuthSection({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final userResult = ref.watch(authProvider).asResult();

    if (userResult is! Success<UmbrellaUser?>) return CircularProgressIndicator();

    if (userResult.value != null) {
      Fluttertoast.showToast(msg: "Successfully signed in");

      // navigate signed In user to home screen
      Navigator.of(context).pushAndRemoveUntil(AppScreens.homeScreen(), (route) => false);

      return CircularProgressIndicator();
    }

    bool signingIn = false;

    return StatefulBuilder(
      builder: (context, setState) {
        if (signingIn == true)
          return Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GoogleSignInButton(disabled: true),
              SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          );

        return GoogleSignInButton(
          onPressed: () async {
            try {
              setState(() => signingIn = true);
              await AuthRepo.signInWithGoogle();
            } catch (e, stacktrace) {
              if (e is FirebaseAuthException) {
                Fluttertoast.showToast(msg: e.message ?? "Unknown Authentication Error");
              } else {
                print(e);
                print(stacktrace);
                Fluttertoast.showToast(msg: "Internal Error");
              }
            } finally {
              setState(() => signingIn = false);
            }
          },
        );
      },
    );
  }
}
