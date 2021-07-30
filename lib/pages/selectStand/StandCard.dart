import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/pages/selectStand/StandContent.dart';
import 'package:umbrella_client/widgets/OutlinedCard.dart';

class StandCard extends StatelessWidget {
  final Stand stand;
  final bool selected;
  final Function() onTap;

  const StandCard({Key? key, required this.stand, required this.selected, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final standContent = StandContent(
      key: ValueKey(stand.id),
      stand: stand,
    );

    switch (stand.getStatus()) {
      case StandStatus.READY:
        return OutlinedCard(
          color: selected ? Theme.of(context).primaryColorLight : null,
          outlineColor: selected ? Theme.of(context).primaryColor : null,
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            child: standContent,
            onTap: onTap,
          ),
        );
      case StandStatus.EMPTY:
        return OutlinedCard(
          elevation: 0,
          child: standContent,
        );
      case StandStatus.BUSY:
        return OutlinedCard(
          elevation: 0,
          color: Color.lerp(Colors.white, Theme.of(context).accentColor, 0.12),
          outlineColor: Color.lerp(Colors.white, Theme.of(context).accentColor, 0.5),
          child: standContent,
        );
      case StandStatus.OFFLINE:
        return OutlinedCard(
          elevation: 0,
          color: Color.lerp(Colors.white, Theme.of(context).errorColor, 0.12),
          outlineColor: Color.lerp(Colors.white, Theme.of(context).errorColor, 0.3),
          child: standContent,
        );
    }
  }
}
