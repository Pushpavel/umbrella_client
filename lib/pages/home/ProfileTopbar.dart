import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/pages/auth/UserAvatar.dart';
import 'package:umbrella_client/resources/AppScreens.dart';

class ProfileTopbar extends StatelessWidget {
  const ProfileTopbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final user = ref.watch(authProvider).asResult().getOrNull();

      if (user == null)
        return Center(
          child: CircularProgressIndicator(),
        );

      return InkWell(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
        splashFactory: InkRipple.splashFactory,
        onTap: () => Navigator.of(context).push(AppScreens.profileScreen()),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Hi\n" + user.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              UserAvatar(user: user, radius: 24),
            ],
          ),
        ),
      );
    });
  }
}
