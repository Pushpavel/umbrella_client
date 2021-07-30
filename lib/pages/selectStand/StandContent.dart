import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umbrella_client/data/models/Stand.dart';

class StandContent extends StatelessWidget {
  final Stand stand;

  const StandContent({Key? key, required this.stand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.place),
      title: Text(stand.name),
    );
  }
}
