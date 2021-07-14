import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/data/models/UmbrellaPickupState.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/data/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/helpers/result/Result.dart';
import 'package:umbrella_client/pages/LoadingScreen.dart';

class PickupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<Result<UmbrellaRequest?>?>(
          builder: (context, requestResult, _) {
            if (requestResult == null) return LoadingScreen();

            return requestResult.when(
              (request) {
                if (request == null) throw Exception("this should not happen");

                final messageStream = UmbrellaRepo.getUmbrellaPickupState(request.pickupStandId)
                    .switchMap((state) => getLoadingMessageStream(state));

                return StreamBuilder<String?>(
                  stream: messageStream,
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (snapshot.data == null)
                          CircularProgressIndicator()
                        else ...[
                          const Icon(
                            Icons.access_time_rounded,
                            color: Colors.green,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(snapshot.data!),
                          )
                        ],
                      ],
                    );
                  },
                );
              },
              error: (_) => LoadingScreen(), // TODO: go to error page
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
