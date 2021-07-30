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
    return OutlinedCard(
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        child: StandContent(stand: stand),
        onTap: () {},
      ),
    );
  }
}
