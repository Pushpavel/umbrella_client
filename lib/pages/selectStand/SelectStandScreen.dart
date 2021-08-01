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
    final selectedStandId = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text("Select Umbrella Stand"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _StandList(selectedStandId: selectedStandId),
          ),
          _ConfirmButtonLayer(
            selectedStandId: selectedStandId,
          ),
        ],
      ),
    );
  }
}

class _StandList extends HookWidget {
  final ValueNotifier<String?> selectedStandId;

  const _StandList({Key? key, required this.selectedStandId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final standListResult = useMemoizedStreamResult(StandRepo.getStands);

    return standListResult.when(
      (stands) => Builder(
        builder: (BuildContext context) {
          final _selectedStandId = useListenable(selectedStandId);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...stands.map(
                (stand) => StandCard(
                  key: ValueKey(stand.id),
                  stand: stand,
                  selected: _selectedStandId == stand.id,
                  onTap: () {
                    if (_selectedStandId != stand.id) selectedStandId.value = stand.id;
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
  final ValueNotifier<String?> selectedStandId;

  const _ConfirmButtonLayer({Key? key, required this.selectedStandId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedStandId = useValueListenable(selectedStandId);
    if (_selectedStandId == null) return SizedBox();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: PrimaryButton(
          label: Text("CONFIRM"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onPressed: () {},
        ),
      ),
    );
  }
}
