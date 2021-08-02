import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/repositories/AuthRepo.dart';
import 'package:umbrella_client/data/repositories/StandRepo.dart';
import 'package:umbrella_client/data/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/utils/lang-utils.dart';

final authProvider = StreamProvider((_) => AuthRepo.getUser());

final currentUmbrellaRequestProvider = StreamProvider<UmbrellaRequest?>((ref) {
  final userResult = ref.watch(authProvider).asResult();

  final stream = userResult.getOrNull()?.let((user) {
    final requestId = user.requestId;

    if (requestId == null) return Stream.value(null);

    return UmbrellaRepo.getUmbrellaRequest(requestId);
  });

  return stream ?? Stream.empty();
});

final recentStandsProvider = StreamProvider<UnmodifiableListView<Stand>?>((ref) {
  final currentRequest = ref.watch(currentUmbrellaRequestProvider).asResult();

  final stream = currentRequest.getOrNull()?.let((request) {
    final pickUpStandId = request.pickupStandId;
    final dropStandId = request.dropStandId;

    return StandRepo.getStands().where((event) => event.contains(pickUpStandId) || event.contains(dropStandId));
  });

  return stream ?? Stream.empty();
});
