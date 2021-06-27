import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/services/StandService.dart';

class StandListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var standService = Provider.of<StandService>(context);
    return StreamBuilder<UnmodifiableListView<Stand>>(
        stream: standService.getStands(),
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data?.map((e) => Text(e.name)).toList() ?? [],
          );
        });
  }
}
