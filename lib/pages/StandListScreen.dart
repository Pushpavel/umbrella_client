import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/widgets/ClickableCard.dart';
import 'package:umbrella_client/widgets/StandContent.dart';

class StandListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var standService = Provider.of<StandService>(context);

    return Scaffold(
      body: StreamBuilder<UnmodifiableListView<Stand>>(
          stream: standService.getStands(),
          builder: (context, snapshot) {
            return ListView(
              children: [
                for (var stand in snapshot.data ?? [])
                  ClickableCard(
                    child: StandContent(stand),
                    onClick: () => standService.selectStand(stand),
                  )
              ],
            );
          }),
    );
  }
}
