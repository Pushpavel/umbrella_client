import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/pages/selectStand/StandContent.dart';
import 'package:umbrella_client/widgets/OutlinedCard.dart';

class StandCard extends StatelessWidget {
  final Stand stand;

  const StandCard({Key? key, required this.stand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final standContent = StandContent(
      key: ValueKey(stand.id),
      stand: stand,
    );

    switch (stand.getStatus()) {
      case StandStatus.READY:
        return OutlinedCard(
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            child: standContent,
            onTap: () {},
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
          color: Color.lerp(Colors.white, Theme.of(context).colorScheme.secondary, 0.12),
          outlineColor: Color.lerp(Colors.white, Theme.of(context).colorScheme.secondary, 0.5),
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
