import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/result/Result.dart';
import 'package:umbrella_client/pages/ErrorScreen.dart';
import 'package:umbrella_client/pages/home/ProfileTopbar.dart';
import 'package:umbrella_client/pages/home/RecentDropCard.dart';
import 'package:umbrella_client/pages/home/RecentPickupCard.dart';
import 'package:umbrella_client/pages/home/RecentRequestCard.dart';
import 'package:umbrella_client/resources/AppScreens.dart';
import 'package:umbrella_client/widgets/PrimaryButton.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';

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
    final requestId = ref.watch(authProvider).asResult().mapData((user) => user?.requestId);

    if (requestId is Loading) return Scaffold();

    final currentRequestResult = ref.watch(requestProvider(requestId.getOrNull())).asResult();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Stack(
            children: [
              Column(
                children: [
                  ProfileTopbar(),
                  SizedBox(height: 48),
                  currentRequestResult.when(
                    (value) {
                      if (value == null)
                        return Center(
                          child: Text("No Requests"),
                        );

                      return getStatusCard(value);
                    },
                    error: (e) => ErrorScreen(err: e),
                    loading: () => Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
              if (currentRequestResult.getOrNull() == null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: PrimaryButton(
                    label: Text("GRAB AN UMBRELLA"),
                    onPressed: () => Navigator.of(context).push(AppScreens.selectStandScreen()),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
