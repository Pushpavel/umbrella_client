import 'package:flutter/material.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/widgets/Home/ProfileTopbar.dart';
import 'package:umbrella_client/widgets/Home/RecentDropCard.dart';
import 'package:umbrella_client/widgets/Home/RecentPickupCard.dart';
import 'package:umbrella_client/widgets/Home/RecentRequestCard.dart';
import 'package:umbrella_client/widgets/PrimaryButton.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';

class HomeScreen extends StatelessWidget {
  final UmbrellaUser? user;
  HomeScreen({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _HomeScreenView(
      user: user,
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  final UmbrellaUser? user;
  _HomeScreenView({Key? key, required this.user}) : super(key: key);

  final isLoading = ValueNotifier(false);

  Widget getStatusCard(UmbrellaRequest currentRequest) {
    if (currentRequest.drop != null) {
      return RecentDropCard(
        recentRequest: currentRequest,
      );
    } else if (currentRequest.pickup != null) {
      return RecentPickupCard(
        recentRequest: currentRequest,
      );
    } else {
      return RecentRequestCard(locationId: currentRequest.pickup.standId);
    }
  }

  @override
  Widget build(BuildContext context) {
    /*  final model = context.get<HomeScreenViewModel>();
    final standService = context.get<StandService>();
 */
    print("object");

    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (context, loading, _) {
              if (loading) return Center(child: CircularProgressIndicator());

              try {
                return Stack(alignment: Alignment.center, fit: StackFit.expand, children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ProfileTopbar(profilePic: user?.auth.photoURL, username: user!.name),
                          SizedBox(
                            height: 48,
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              UmbrellaRequest? currentRequest =
                                  null; //ref.watch(currentUmbrellaRequestProvider).asResult().getOrNull();
                              print(currentRequest.toString());
                              if (currentRequest == null)
                                return Container(
                                  child: Center(
                                    child: Text("No requests"),
                                  ),
                                );
                              return getStatusCard(currentRequest);
                            },
                          ),
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
                      child: PrimaryButton(
                        label: Text("GRAB AN UMBRELLA"),
                        onPressed: () => null,
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                  )
                ]);
              } on LoadingErr {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
