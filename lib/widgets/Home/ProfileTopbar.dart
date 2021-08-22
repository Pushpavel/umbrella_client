import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';

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

      return Container(
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
            user.auth.photoURL != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image.network(
                      user.auth.photoURL!,
                      height: 48.0,
                      width: 48.0,
                    ),
                  )
                : CircleAvatar(
                    child: Icon(Icons.account_circle),
                  )
          ],
        ),
      );
    });
  }
}
