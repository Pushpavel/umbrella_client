import 'package:provider/provider.dart';
import 'package:umbrella_client/pages/DropScreen.dart';
import 'package:umbrella_client/pages/PickupScreen.dart';
import 'package:umbrella_client/pages/StandListScreen.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/services/StandServiceImpl.dart';

class Routes {
  // PickupScreen
  static final pickup = (_) => PickupScreen();

  // DropScreen
  static final drop = (_) => Provider<StandService>(
        create: (_) => StandServiceImpl(),
        dispose: (_, service) => service.dispose(),
        child: DropScreen(),
      );

  // StandListScreen
  static standList(StandService standService) {
    return (_) => Provider<StandService>.value(
          value: standService,
          child: StandListScreen(),
        );
  }
}
