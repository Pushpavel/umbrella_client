import 'package:umbrella_client/data/models/Stand.dart';

class Strings {
  static const appName = "Umbrella Client";
  static const ownedUmbrellaLine = "You had picked up an umbrella";

  static String? standStatusString(StandStatus status) {
    switch (status) {
      case StandStatus.BUSY:
        return "stand is busy, Please try after a minute";
      case StandStatus.EMPTY:
        return "stand is empty";
      case StandStatus.OFFLINE:
        return "stand is offline";
      case StandStatus.READY:
        return null;
    }
  }
}
