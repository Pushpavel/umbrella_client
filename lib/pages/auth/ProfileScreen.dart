import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/data/repositories/AuthRepo.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/helpers/result/Result.dart';
import 'package:umbrella_client/pages/auth/UserAvatar.dart';
import 'package:umbrella_client/resources/AppScreens.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final userResult = ref.watch(authProvider).asResult();

    if (userResult is! Success<UmbrellaUser?> || userResult.value == null)
      return Scaffold(body: Center(child: CircularProgressIndicator()));

    final user = userResult.value!;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.topLeft,
              child: BackButton(),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserAvatar(user: user),
                  SizedBox(height: 16),
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 48),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).errorColor,
                    ),
                    label: Text("Sign Out"),
                    icon: Icon(Icons.logout),
                    onPressed: () async {
                      await AuthRepo.signOut();
                      Fluttertoast.showToast(msg: "Successfully signed out");
                      Navigator.pushAndRemoveUntil(context, AppScreens.loginScreen(), (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
