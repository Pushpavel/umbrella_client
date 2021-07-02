import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/resources/Routes.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/services/UmbrellaService.dart';
import 'package:umbrella_client/widgets/SelectedStandCard.dart';

class HomeScreen extends StatelessWidget {
  Future<bool> onPickupRequest(context) async {
    final standService = Provider.of<StandService>(context);
    final umbrellaService = Provider.of<UmbrellaService>(context);

    final selectedStand = await standService.getSelectedStand().first;
    return umbrellaService.requestUmbrellaPickup(selectedStand);
  }

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
              onPressed: () {
                final isRequested = onPickupRequest(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: Routes.pickup(isRequested)),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
