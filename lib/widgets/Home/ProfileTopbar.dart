import 'package:flutter/material.dart';

class ProfileTopbar extends StatelessWidget {
  final String username;
  final String? profilePic;

  const ProfileTopbar({Key? key, required this.profilePic, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              "Hi\n" + username,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          profilePic != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image.network(
                    profilePic!,
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
  }
}
