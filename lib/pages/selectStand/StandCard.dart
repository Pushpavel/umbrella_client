import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umbrella_client/pages/selectStand/StandContent.dart';
import 'package:umbrella_client/widgets/OutlinedCard.dart';

class StandCard extends StatelessWidget {
  const StandCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        child: StandContent(),
        onTap: () {},
      ),
    );
  }
}
