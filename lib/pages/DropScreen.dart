import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/services/StandServiceImpl.dart';
import 'package:umbrella_client/widgets/OwnedUmbrellaCard.dart';
import 'package:umbrella_client/widgets/SelectedStandCard.dart';

class DropScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StandService>(
            create: (_) => StandServiceImpl(),
            dispose: (_, service) => service.dispose()),
      ],
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OwnedUmbrellaCard(),
            SelectedStandCard(),
          ],
        ),
      ),
    );
  }
}
