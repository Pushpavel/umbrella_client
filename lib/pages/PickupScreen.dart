import 'package:flutter/material.dart';
import 'package:umbrella_client/widgets/SelectedStandCard.dart';

class PickupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectedStandCard(),
          Container(
            padding: EdgeInsets.all(32),
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              icon: Icon(Icons.umbrella),
              label: Text("REQUEST UMBRELLA"),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
