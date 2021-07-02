import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/models/UmbrellaRequest.dart';

abstract class UmbrellaService {
  Stream<UmbrellaRequest?> getUmbrellaRequest(String requestId);

  Future<bool> requestUmbrellaPickup(Stand fromStand);

  dispose();
}
