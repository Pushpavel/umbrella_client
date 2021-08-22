import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/pages/home/ProfileTopbar.dart';
import 'package:umbrella_client/pages/home/RecentDropCard.dart';
import 'package:umbrella_client/pages/home/RecentPickupCard.dart';
import 'package:umbrella_client/pages/home/RecentRequestCard.dart';
import 'package:umbrella_client/widgets/PrimaryButton.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _HomeScreenView();
  }
}

class _HomeScreenView extends HookConsumerWidget {
  _HomeScreenView({
    Key? key,
  }) : super(key: key);

  final isLoading = ValueNotifier(false);

  Widget getStatusCard(UmbrellaRequest currentRequest) {
    if (currentRequest.drop != null) {
      return RecentDropCard(
        recentRequest: currentRequest,
      );
    } else if (currentRequest.pickup.time != null) {
      return RecentPickupCard(
        recentRequest: currentRequest,
      );
    } else {
      return RecentRequestCard(
        locationId: currentRequest.pickup.standId,
        requestTimeout: currentRequest.requestTime,
      );
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final requestId = ref.watch(currentRequestIdProvider).asResult().getOrNull();

    if (requestId == null)
      return Center(
        child: CircularProgressIndicator(),
      );

    UmbrellaRequest? currentRequest = ref.watch(requestProvider("6iU7y7hFzEapmgNHyC1k")).asResult().getOrNull();

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
                          ProfileTopbar(),
                          SizedBox(
                            height: 48,
                          ),
                          if (currentRequest == null)
                            Container(
                              child: Center(
                                child: Text("No requests"),
                              ),
                            )
                          else
                            getStatusCard(currentRequest),
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
