import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/data/repositories/AuthRepo.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/helpers/result/Result.dart';
import 'package:umbrella_client/resources/icons/AppIcons.dart';
import 'package:umbrella_client/resources/theme/colors.dart';

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

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const GoogleSignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(2));

    return Card(
      color: AppColors.googleBlue,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        splashFactory: InkRipple.splashFactory,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Colors.white,
              ),
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.all(8),
              child: SvgPicture.asset(
                AppIcons.googleLogo,
                height: 24,
                width: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text("Sign in with Google", style: Theme.of(context).primaryTextTheme.headline3),
            )
          ],
        ),
      ),
    );
  }
}
