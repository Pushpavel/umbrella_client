import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/data/repositories/AuthRepo.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/helpers/result/Result.dart';

import 'GoogleSignInButton.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final userResult = ref.watch(authProvider).asResult();

    Widget content;
    if (userResult is Success<UmbrellaUser?>) {
      if (userResult.value == null)
        content = GoogleSignInButton(onPressed: () async {
          try {
            // TODO: start loading
            await AuthRepo.signInWithGoogle();
          } catch (e) {
            if (e is FirebaseAuthException) {
              // TODO: toast signIn error
            } else {
              // TODO: toast Internal Error
            }
          } finally {
            // TODO: stop loading
          }
        });
      else {
        // TODO: navigate to splash screen and toast
        content = Text("Successfully SignedIn as ${userResult.value!.name}");
      }
    } else
      content = CircularProgressIndicator();

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
              content,
            ],
          ),
        ),
      ),
    );
  }
}

