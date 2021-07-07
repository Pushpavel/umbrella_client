import 'package:flutter/material.dart';
import 'package:umbrella_client/widgets/OwnedUmbrellaCard.dart';

class DropScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OwnedUmbrellaCard(),
          // SelectedStandCard(),
        ],
      ),
    );
  }
}
