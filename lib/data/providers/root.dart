import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/repositories/AuthRepo.dart';
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
