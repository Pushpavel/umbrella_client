import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_client/resources/Strings.dart';
import 'package:umbrella_client/widgets/ClickableCard.dart';

class OwnedUmbrellaCard extends StatelessWidget {
  final String umbrellaId;
  OwnedUmbrellaCard({required this.umbrellaId});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ClickableCard(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.ownedUmbrellaLine, style: theme.textTheme.headline6),
          Container(
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(umbrellaId, style: theme.textTheme.subtitle1),
                IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {}) //what is the use copying this ???
              ],
            ),
          ),
        ],
      ),
    );
  }
}
