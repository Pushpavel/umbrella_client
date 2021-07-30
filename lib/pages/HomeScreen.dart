import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';
import 'package:umbrella_client/data/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/data/services/HomeScreenViewModel.dart';
import 'package:umbrella_client/data/services/StandService.dart';
import 'package:umbrella_client/helpers/DisposableProvider.dart';
import 'package:umbrella_client/helpers/extensions/ContextExtensions.dart';
import 'package:umbrella_client/widgets/Home/ProfileTopbar.dart';
import 'package:umbrella_client/widgets/Home/RecentDropCard.dart';
import 'package:umbrella_client/widgets/Home/RecentPickupCard.dart';
import 'package:umbrella_client/widgets/Home/RecentRequestCard.dart';
import 'package:umbrella_client/widgets/SelectedStandCard.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends StatelessWidget {
  final UmbrellaUser? user;
  HomeScreen({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        DisposableProvider(create: (_) => StandService()),
        DisposableProvider(create: (context) => HomeScreenViewModel(context))
      ],
      child: _HomeScreenView(
        user: user,
      ),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  final UmbrellaUser? user;
  _HomeScreenView({Key? key, required this.user}) : super(key: key);

  final isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final model = context.get<HomeScreenViewModel>();
    final standService = context.get<StandService>();

    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, loading, _) {
            if (loading) return Center(child: CircularProgressIndicator());
            return Column(
              children: [
                Expanded(
                  child: Stack(alignment: Alignment.center, children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ProfileTopbar(profilePic: user?.auth.photoURL, username: user!.name),
                            SizedBox(
                              height: 48,
                            ),
                            RecentDropCard(
                              recentRequest: null,
                            ),
                            RecentPickupCard(
                              recentRequest: null,
                            ),
                            RecentRequestCard(location: "Boys Hostel"),
                            SizedBox(
                              height: 48,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.all(16),
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
                      ),
                    )
                  ]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
