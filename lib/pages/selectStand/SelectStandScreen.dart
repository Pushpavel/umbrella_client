import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:umbrella_client/data/repositories/StandRepo.dart';
import 'package:umbrella_client/helpers/hooks/useMemoizedStreamResult.dart';
import 'package:umbrella_client/pages/ErrorScreen.dart';
import 'package:umbrella_client/pages/selectStand/StandCard.dart';
import 'package:umbrella_client/widgets/PrimaryButton.dart';

class SelectStandScreen extends HookWidget {
  SelectStandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text("Select Umbrella Stand"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _StandList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                label: Text("CONFIRM"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StandList extends HookWidget {
  const _StandList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final standListResult = useMemoizedStreamResult(StandRepo.getStands);

    return standListResult.when(
      (stands) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...stands.map((stand) => StandCard(key: ValueKey(stand.id), stand: stand)),
        ],
      ),
      error: (err) => ErrorScreen(err: err),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
