import 'package:flutter/material.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';

class UserAvatar extends StatelessWidget {
  final UmbrellaUser user;

  const UserAvatar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NetworkImage? img;
    if (user.auth.photoURL != null) img = NetworkImage(user.auth.photoURL!);

    return CircleAvatar(
      radius: 36,
      backgroundImage: img,
      child: img != null ? null : Text(user.name[0], style: Theme.of(context).primaryTextTheme.headline3),
      backgroundColor: img != null ? null : Theme.of(context).primaryColor,
    );
  }
}
