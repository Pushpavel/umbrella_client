import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/data/models/UmbrellaPickupState.dart';
import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/data/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/helpers/result/Result.dart';

class PickupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, _) {
            final requestResult = ref.watch(currentUmbrellaRequestProvider).asResult();

            final pickupStandId = Result.getOrThrowErr(requestResult)?.pickupStandId;

            if (pickupStandId == null) throw InternalErr("pickupStandId must not be null");

            final messageStream = UmbrellaRepo.getUmbrellaPickupState(pickupStandId)
                .switchMap((state) => getLoadingMessageStream(state));

            return StreamBuilder<String?>(
              stream: messageStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) return Center(child: CircularProgressIndicator());

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.access_time_rounded, color: Colors.green, size: 60),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(child: Text(snapshot.data!)),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

Stream<String?> getLoadingMessageStream(UmbrellaPickupState? state) async* {
  if (state?.acknowledgeTime == null) yield null;

  const TIMEOUT = 30;

  final startTime = state!.acknowledgeTime!;
  while (true) {
    final currentTime = DateTime.now().toUtc();
    final diff = currentTime.difference(startTime);

    if (diff.inSeconds > TIMEOUT) break;
    yield (TIMEOUT - diff.inSeconds.round()).toString() + '\nGo Get Your Umbrella!';
    await Future.delayed(Duration(seconds: 1));
  }
  yield null;
}
