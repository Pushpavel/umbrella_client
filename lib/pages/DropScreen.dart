import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/helpers/result/Result.dart';
import 'package:umbrella_client/widgets/OwnedUmbrellaCard.dart';

class DropScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final requestResult = ref.watch(currentUmbrellaRequestProvider).asResult();

    final umbrellaId = Result.getOrThrowErr(requestResult)?.umbrellaId;

    if (umbrellaId == null) throw "This should not happen"; // TODO: check this later

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OwnedUmbrellaCard(
            umbrellaId: umbrellaId,
          ) // SelectedStandCard(),
        ],
      ),
    );
  }
}
