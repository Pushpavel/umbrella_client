import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/helpers/result/Result.dart';
import 'package:umbrella_client/widgets/OwnedUmbrellaCard.dart';

class DropScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
            builder: (context, ref, _) {
              final requestResult = ref.watch(currentUmbrellaRequestProvider).asResult();

              final umbrellaId = Result.getOrThrowErr(requestResult)?.umbrellaId;

              if (umbrellaId == null) throw InternalErr("umbrellaId must not be null");

              return OwnedUmbrellaCard(umbrellaId: umbrellaId);
            },
          ) // SelectedStandCard(),
        ],
      ),
    );
  }
}
