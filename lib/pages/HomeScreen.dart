import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/data/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/data/services/HomeScreenViewModel.dart';
import 'package:umbrella_client/data/services/StandService.dart';
import 'package:umbrella_client/helpers/DisposableProvider.dart';
import 'package:umbrella_client/widgets/SelectedStandCard.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        DisposableProvider(create: (_) => StandService()),
        DisposableProvider(create: (context) => HomeScreenViewModel(context))
      ],
      child: _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeScreenViewModel>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectedStandCard(
            selectedStandId$: model.selectedStandId$,
          ),
          Container(
            padding: EdgeInsets.all(32),
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              icon: Icon(Icons.umbrella),
              label: Text("REQUEST UMBRELLA"),
              onPressed: () async {
                final selectedStandId = model.selectedStandId$.value;
                await UmbrellaRepo.requestUmbrellaPickup(selectedStandId);
                // TODO: handle fail state
              },
            ),
          )
        ],
      ),
    );
  }
}
