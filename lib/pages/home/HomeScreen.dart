import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/data/repositories/RequestRepo.dart';
import 'package:umbrella_client/helpers/hooks/useMemoizedStreamResult.dart';
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
    final userResult = ref.watch(authProvider).asResult();

    if (userResult is Loading) return Scaffold();
    final user = userResult.getOrNull();
    final Result<UmbrellaRequest?> recentRequestResult;
    if ((user?.requestId != null))
      recentRequestResult = ref.watch(requestProvider(user!.requestId)).asResult();
    else if (user != null)
      recentRequestResult = useMemoizedStreamResult(() => RequestRepo.getRecentUmbrellaRequest(user.auth.uid));
    else
      recentRequestResult = Result.loading();

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
                  child: recentRequestResult.when(
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
            if (user != null && user.requestId == null)
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
