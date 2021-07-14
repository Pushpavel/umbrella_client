import 'package:flutter/cupertino.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';
import 'package:umbrella_client/data/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/helpers/extensions/ContextExtensions.dart';
import 'package:umbrella_client/helpers/result/Result.dart';
import 'package:umbrella_client/utils/lang-utils.dart';

Stream<UmbrellaRequest?>? currentUmbrellaRequest(BuildContext context) {
  final userResult = context.get<Result<UmbrellaUser?>?>(false);

  return userResult?.getOrNull()?.let((user) {
    final requestId = user.requestId;

    if (requestId == null) return null;

    return UmbrellaRepo.getUmbrellaRequest(requestId);
  });
}
