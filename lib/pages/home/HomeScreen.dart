import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  const _HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final requestId = ref.watch(authProvider).asResult().mapData((user) => user?.requestId);

    if (requestId is Loading) return Scaffold();

    final currentRequestResult = ref.watch(requestProvider(requestId.getOrNull())).asResult();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: ProfileTopbar(),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: currentRequestResult.when(
                    (currentRequest) {
                      if (currentRequest == null)
                        return Center(child: Text("No Requests"));
                      else if (currentRequest.drop != null)
                        return RecentDropCard(recentRequest: currentRequest);
                      else if (currentRequest.pickup.time != null)
                        return RecentPickupCard(recentRequest: currentRequest);
                      else
                        return RecentRequestCard(
                          locationId: currentRequest.pickup.standId,
                          requestTimeout: currentRequest.requestTime,
                        );
                    },
                    error: (e) => ErrorScreen(err: e),
                    loading: () => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ],
            ),
            if (currentRequestResult.getOrNull() == null)
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(24),
                child: PrimaryButton(
                  label: Text("GRAB AN UMBRELLA"),
                  onPressed: () => Navigator.of(context).push(AppScreens.selectStandScreen()),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              )
          ],
        ),
      ),
    );
  }
}
