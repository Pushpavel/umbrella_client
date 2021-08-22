import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/repositories/AuthRepo.dart';
import 'package:umbrella_client/data/repositories/RequestRepo.dart';
import 'package:umbrella_client/data/repositories/StandRepo.dart';

final authProvider = StreamProvider((_) => AuthRepo.getUser());

final currentRequestIdProvider = StreamProvider<String?>((ref) {
  return ref.read(authProvider.stream).map((user) => user?.requestId);
});

final requestProvider = StreamProvider.family<UmbrellaRequest?, String?>((ref, requestId) {
  if (requestId == null) return Stream.value(null);
  return RequestRepo.getUmbrellaRequest(requestId);
});

final standProvider = StreamProvider.family<Stand?, String>((ref, standId) => StandRepo.getStand(standId));
