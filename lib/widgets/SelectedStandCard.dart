import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/services/StandService.dart';

import 'StandCard.dart';

class SelectedStandCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var standService = Provider.of<StandService>(context);

    return Card(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<Stand>(
                  stream: standService.getSelectedStand(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null)
                      return CircularProgressIndicator();
                    return StandContent(snapshot.data!);
                  }),
              Icon(Icons.unfold_more),
            ],
          ),
        ),
        onTap: () => {},
      ),
    );
  }
}
