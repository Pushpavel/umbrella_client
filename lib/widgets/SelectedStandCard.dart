import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/pages/StandListScreen.dart';
import 'package:umbrella_client/data/services/StandService.dart';
import 'package:umbrella_client/widgets/ClickableCard.dart';

import 'StandContent.dart';

class SelectedStandCard extends StatelessWidget {
  final BehaviorSubject<String> selectedStandId$;

  const SelectedStandCard({Key? key, required this.selectedStandId$}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var standService = Provider.of<StandService>(context);

    return ClickableCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<Stand?>(
              stream: selectedStandId$.switchMap((standId) => standService.getStand(standId)),
              builder: (context, snap) {
                if (snap.data == null) return CircularProgressIndicator();
                return StandContent(snap.data!);
              }),
          Icon(Icons.unfold_more),
        ],
      ),
      onClick: () async {
        var selectedStandId = await StandListScreen.push(context);
        if (selectedStandId != null) {
          selectedStandId$.add(selectedStandId);
        }
      },
    );
  }
}
