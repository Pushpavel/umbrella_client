import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umbrella_client/resources/icons/AppIcons.dart';
import 'package:umbrella_client/resources/theme/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlutterLogo(size: 72),
              SizedBox(height: 32),
              GoogleSignInButton(
                onPressed: () {},
              )
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
