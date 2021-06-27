import 'package:flutter/material.dart';
import 'package:umbrella_client/models/Stand.dart';

import 'StandCard.dart';

class SelectedStandCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StandContent(Stand("Nitpy Boys Hostel")),
              Icon(Icons.unfold_more),
            ],
          ),
        ),
        onTap: () => {},
      ),
    );
  }
}
