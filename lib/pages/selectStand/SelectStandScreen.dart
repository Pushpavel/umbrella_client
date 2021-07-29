import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umbrella_client/pages/selectStand/StandCard.dart';
import 'package:umbrella_client/widgets/PrimaryButton.dart';

class SelectStandScreen extends StatelessWidget {
  const SelectStandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text("Select Umbrella Stand"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StandCard(),
                StandCard(),
                StandCard(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                label: Text("CONFIRM"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
