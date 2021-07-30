import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/resources/Strings.dart';

class StandContent extends StatelessWidget {
  final Stand stand;

  const StandContent({Key? key, required this.stand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subtitle = Strings.standStatusString(stand.getStatus());

    return ListTile(
      enabled: stand.getStatus() == StandStatus.READY,
      leading: Icon(Icons.place),
      horizontalTitleGap: 8,
      minLeadingWidth: 24,
      title: Text(
        stand.name,
        style: TextStyle(
          // color: stand.getStatus() == StandStatus.READY ? Theme.of(context).hintColor : null,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }
}
