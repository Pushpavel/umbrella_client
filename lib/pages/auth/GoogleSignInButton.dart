import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umbrella_client/resources/icons/AppIcons.dart';
import 'package:umbrella_client/resources/theme/colors.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool disabled;

  const GoogleSignInButton({
    Key? key,
    this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(2));

    return Card(
      color: disabled ? AppColors.googleBlue.withOpacity(0.4) : AppColors.googleBlue,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: disabled ? null : onPressed,
        splashFactory: disabled ? NoSplash.splashFactory : InkRipple.splashFactory,
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
