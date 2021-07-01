import 'package:umbrella_client/models/UmbrellaRequest.dart';

abstract class UmbrellaService {
  Stream<UmbrellaRequest?> getUmbrellaRequest(String requestId);

  dispose();
}
