import 'dart:async';
import 'package:flutter/material.dart';
import 'package:umbrella_client/models/UmbrellaRequest.dart';
import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/repositories/UmbrellaRepo.dart';

class PickupScreen extends StatelessWidget {
  final Stream<UmbrellaRequest> requestStream;

  const PickupScreen({Key? key, required this.requestStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: Container(
        alignment: FractionalOffset.center,
        color: Colors.white,
        child: StreamBuilder<String?>(
          stream: getLoadingMessageStream(requestStream),
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
                    child: Text('${snapshot.data}\nGo Get Your Umbrella!'),
                  )
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

Stream<String?> getLoadingMessageStream(Stream<UmbrellaRequest> requestStream) {
  final state = requestStream
      .map((request) => request.pickupStandId)
      .distinct()
      .switchMap((standId) => UmbrellaRepo.getUmbrellaPickupState(standId));

  return state.switchMap((state) async* {
    if (state?.acknowledgeTime == null) yield null;

    const TIMEOUT = 30;

    final startTime = state!.acknowledgeTime!;
    while (true) {
      final currentTime = DateTime.now().toUtc();
      final diff = currentTime.difference(startTime);

      if (diff.inSeconds > TIMEOUT) break;
      yield (TIMEOUT - diff.inSeconds.round()).toString();
      await Future.delayed(Duration(seconds: 1));
    }
    yield null;
  });
}
