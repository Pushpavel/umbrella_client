import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/models/UmbrellaRequest.dart';
import 'package:umbrella_client/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/services/UmbrellaService.dart';

class UmbrellaServiceImpl extends UmbrellaService {
  final requestsMap = Map<String, BehaviorSubject<UmbrellaRequest?>>();

  @override
  Stream<UmbrellaRequest?> getUmbrellaRequest(String requestId) {
    return requestsMap.putIfAbsent(
      requestId,
      () => UmbrellaRepo.getUmbrellaRequest(requestId).toCachedSubject(),
    );
  }

  @override
  dispose() {
    for (final subject in requestsMap.values) subject.close();
  }
}
