import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StandContent extends StatelessWidget {
  const StandContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.place),
      title: Text("Boys Hostel, Nitpy"),
    );
  }
}
