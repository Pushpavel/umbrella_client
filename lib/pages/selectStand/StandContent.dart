import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/helpers/styles/emphasis.dart';
import 'package:umbrella_client/resources/Strings.dart';

class StandContent extends StatelessWidget {
  final Stand stand;

  const StandContent({Key? key, required this.stand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subtitle = Strings.standStatusString(stand.getStatus());
    final enabled = stand.getStatus() == StandStatus.READY;
    return ListTile(
      enabled: enabled,
      leading: Icon(Icons.place),
      horizontalTitleGap: 8,
      minLeadingWidth: 24,
      title: enabled ? HighEmphasis(child: Text(stand.name)) : Text(stand.name),
      subtitle: Text(subtitle),
    );
  }
}
