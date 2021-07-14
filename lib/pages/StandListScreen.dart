import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/data/services/StandService.dart';
import 'package:umbrella_client/widgets/ClickableCard.dart';
import 'package:umbrella_client/widgets/StandContent.dart';

class StandListScreen extends StatelessWidget {
  const StandListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final standService = Provider.of<StandService>(context);
    return Scaffold(
      body: StreamBuilder<UnmodifiableListView<Stand>>(
        stream: standService.getStands(),
        builder: (context, snapshot) {
          return ListView(
            children: [
              for (Stand stand in snapshot.data ?? [])
                ClickableCard(
                  child: StandContent(stand),
                  onClick: () => Navigator.of(context).pop(stand.id),
                )
            ],
          );
        },
      ),
    );
  }

  static Future<String?> push(BuildContext context) {
    final standService = Provider.of<StandService>(context,listen: false);

    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: standService,
          child: StandListScreen(),
        ),
      ),
    );
  }
}
