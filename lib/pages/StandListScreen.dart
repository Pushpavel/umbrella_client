import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/widgets/ClickableCard.dart';
import 'package:umbrella_client/widgets/StandContent.dart';

class StandListScreen extends StatelessWidget {
  final Stream<UnmodifiableListView<Stand>> stands;

  const StandListScreen(this.stands, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UnmodifiableListView<Stand>>(
          stream: stands,
          builder: (context, snapshot) {
            return ListView(
              children: [
                for (var stand in snapshot.data ?? [])
                  ClickableCard(
                    child: StandContent(stand),
                    onClick: () => Navigator.pop(context, stand),
                  )
              ],
            );
          }),
    );
  }
}
