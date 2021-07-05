import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/services/HomeScreenViewModel.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/widgets/SelectedStandCard.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StandService.provider(),
        HomeScreenViewModel.provider(),
      ],
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Builder(
              builder: (context) => SelectedStandCard(
                selectedStandId$: Provider.of<HomeScreenViewModel>(context).selectedStandId$,
              ),
            ),
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
      ),
    );
  }
}
