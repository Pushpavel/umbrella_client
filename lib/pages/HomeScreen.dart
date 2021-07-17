import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/data/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/data/services/HomeScreenViewModel.dart';
import 'package:umbrella_client/data/services/StandService.dart';
import 'package:umbrella_client/helpers/DisposableProvider.dart';
import 'package:umbrella_client/helpers/extensions/ContextExtensions.dart';
import 'package:umbrella_client/widgets/SelectedStandCard.dart';
import 'package:rxdart/rxdart.dart';

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
  final isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final model = context.get<HomeScreenViewModel>();
    final standService = context.get<StandService>();

    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, loading, _) {
          if (loading) return Center(child: CircularProgressIndicator());

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SelectedStandCard(
                selectedStandId$: model.selectedStandId$,
              ),
              Container(
                padding: EdgeInsets.all(32),
                alignment: Alignment.bottomCenter,
                child: StreamBuilder<Stand?>(
                    stream: model.selectedStandId$.switchMap((standId) => standService.getStand(standId)),
                    builder: (context, snapshot) {
                      final enabled = snapshot.data?.requestId == null;

                      return FloatingActionButton.extended(
                        icon: Icon(Icons.umbrella),
                        label: Text("REQUEST UMBRELLA"),
                        onPressed: enabled
                            ? () async {
                                final selectedStandId = model.selectedStandId$.value;
                                isLoading.value = true;
                                final success = await UmbrellaRepo.requestUmbrellaPickup(selectedStandId);
                                if (!success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Request Failed")),
                                  );
                                  isLoading.value = false;
                                }
                              }
                            : null,
                      );
                    }),
              )
            ],
          );
        },
      ),
    );
  }
}
