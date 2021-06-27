import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/resources/Routes.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/widgets/ClickableCard.dart';

import 'StandContent.dart';

class SelectedStandCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var standService = Provider.of<StandService>(context);

    return ClickableCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<Stand>(
              stream: standService.getSelectedStand(),
              builder: (context, snapshot) {
                if (snapshot.data == null) return CircularProgressIndicator();
                return StandContent(snapshot.data!);
              }),
          Icon(Icons.unfold_more),
        ],
      ),
      onClick: () async {
        var selectedStand = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: Routes.standList(standService.getStands())),
        );

        standService.selectStand(selectedStand);
      },
    );
  }
}
