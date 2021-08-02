import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/extensions/AsyncSnapshotExtension.dart';
import 'package:umbrella_client/helpers/extensions/ColorExtensions.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/widgets/OutlinedCard.dart';

// TODO: generalize this card for all Request States
const int TIMEOUT_SECONDS = 60;

class PickupCard extends HookConsumerWidget {
  final EdgeInsets? margin;
  final String requestId;

  const PickupCard({Key? key, this.margin, required this.requestId}) : super(key: key);

  @override
  Widget build(context, ref) {
    final requestResult = ref.watch(requestProvider(requestId)).asResult();
    Widget content;
    final request = requestResult.getOrNull();

    Stand? stand;
    if (request != null) stand = ref.watch(standProvider(request.pickup.standId)).asResult().getOrNull();

    if (request == null || request.status != RequestStatus.PICK_UP || stand == null)
      content = Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    else {
      content = Column(
        children: [
          Text(
            "Pickup the Umbrella",
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          SizedBox(height: 24),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.place,
                color: Theme.of(context).colorScheme.onPrimary.mediumEmphasis(),
              ),
              const SizedBox(width: 8),
              Text(
                stand.name,
                style: Theme.of(context).primaryTextTheme.subtitle1,
              ),
            ],
          ),
          SizedBox(height: 24),
          _PickupTimeout(requestTime: request.requestTime),
        ],
      );
    }

    return OutlinedCard(
      color: Theme.of(context).colorScheme.primary,
      outlineColor: Theme.of(context).colorScheme.primary,
      margin: margin,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: content,
      ),
    );
  }
}

class _PickupTimeout extends StatelessWidget {
  final DateTime requestTime;

  const _PickupTimeout({Key? key, required this.requestTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: CircleBorder(),
        color: Theme.of(context).colorScheme.secondary,
      ),
      padding: EdgeInsets.all(16),
      child: StreamBuilder<int?>(
          stream: _timeoutStream(requestTime),
          builder: (context, snapshot) {
            final time = snapshot.asResult().getOrNull();
            if (time == null)
              return CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              );

            return Text(
              time.toString(),
              style: Theme.of(context).primaryTextTheme.headline3,
            );
          }),
    );
  }
}

Stream<int?> _timeoutStream(DateTime start) async* {
  Duration time = DateTime.now().difference(start);
  while (time.inSeconds <= TIMEOUT_SECONDS) {
    yield TIMEOUT_SECONDS - time.inSeconds;
    await Future.delayed(Duration(seconds: 1));
    time = DateTime.now().difference(start);
  }
  yield null;
}
