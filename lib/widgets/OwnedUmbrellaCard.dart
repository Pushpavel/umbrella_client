import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnedUmbrellaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text("Umbrella xyz is owned by you"),
      ),
    );
  }
}
