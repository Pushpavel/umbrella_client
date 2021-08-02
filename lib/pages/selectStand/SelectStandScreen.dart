import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:umbrella_client/data/repositories/RequestRepo.dart';
import 'package:umbrella_client/data/repositories/StandRepo.dart';
import 'package:umbrella_client/helpers/hooks/useMemoizedStreamResult.dart';
import 'package:umbrella_client/pages/ErrorScreen.dart';
import 'package:umbrella_client/pages/selectStand/StandCard.dart';
import 'package:umbrella_client/resources/AppScreens.dart';
import 'package:umbrella_client/widgets/PrimaryButton.dart';

class SelectStandScreen extends HookWidget {
  SelectStandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedStandIdNotifier = useState<String?>(null);
    final confirmingNotifier = useState(false);
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text("Select Umbrella Stand"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _StandList(
              selectedStandIdNotifier: selectedStandIdNotifier,
              confirmingNotifier: confirmingNotifier,
            ),
          ),
          _ConfirmButtonLayer(
            selectedStandIdNotifier: selectedStandIdNotifier,
            confirmingNotifier: confirmingNotifier,
          ),
        ],
      ),
    );
  }
}

class _StandList extends HookWidget {
  final ValueNotifier<String?> selectedStandIdNotifier;
  final ValueNotifier<bool> confirmingNotifier;

  const _StandList({
    Key? key,
    required this.selectedStandIdNotifier,
    required this.confirmingNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final standListResult = useMemoizedStreamResult(StandRepo.getStands);

    return standListResult.when(
      (stands) => HookBuilder(
        builder: (BuildContext context) {
          final selectedStandId = useValueListenable(selectedStandIdNotifier);
          final confirming = useValueListenable(confirmingNotifier);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...stands.map(
                (stand) => StandCard(
                  key: ValueKey(stand.id),
                  stand: stand,
                  selected: selectedStandId == stand.id,
                  onTap: () {
                    if (selectedStandId != stand.id && !confirming) selectedStandIdNotifier.value = stand.id;
                  },
                ),
              ),
            ],
          );
        },
      ),
      error: (err) => ErrorScreen(err: err),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

class _ConfirmButtonLayer extends HookWidget {
  final ValueNotifier<String?> selectedStandIdNotifier;
  final ValueNotifier<bool> confirmingNotifier;

  const _ConfirmButtonLayer({
    Key? key,
    required this.selectedStandIdNotifier,
    required this.confirmingNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedStandId = useValueListenable(selectedStandIdNotifier);
    final confirming = useValueListenable(confirmingNotifier);
    if (selectedStandId == null) return SizedBox();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            PrimaryButton(
              label: Text("CONFIRM"),
              disabled: confirming,
              trailing: Icon(Icons.keyboard_arrow_right),
              onPressed: () async {
                confirmingNotifier.value = true;
                final success = await RequestRepo.requestUmbrellaPickup(selectedStandId);
                if (!success) {
                  confirmingNotifier.value = false;
                  Fluttertoast.showToast(msg: "Request Failed");
                  return;
                }

                await Navigator.pushAndRemoveUntil(context, AppScreens.homeScreen(), (route) => false);
              },
            ),
            if (confirming)
              SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
          ],
        ),
      ),
    );
  }
}
