import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_client/widgets/OwnedUmbrellaCard.dart';
import 'package:umbrella_client/widgets/SelectedStandCard.dart';

class DropScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OwnedUmbrellaCard(),
          SelectedStandCard(),
        ],
      ),
    );
  }
}
