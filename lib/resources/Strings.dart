import 'package:umbrella_client/data/models/Stand.dart';

class Strings {
  static const appName = "Umbrella Client";
  static const ownedUmbrellaLine = "You had picked up an umbrella";

  static String standStatusString(StandStatus status) {
    switch (status) {
      case StandStatus.BUSY:
        return "stand is busy, Please try after a minute";
      case StandStatus.EMPTY:
        return "stand is empty";
      case StandStatus.OFFLINE:
        return "stand is offline";
      case StandStatus.READY:
        return "online";
    }
  }

  static const pickupInstructionsTitle = "How to get the umbrella from stand ?";
  static const pickupInstructionsBody = "1. Make sure your name is displayed on the stands display\n"
      "2. Gently raise the topmost umbrella till it reaches the scanner\n"
      "3. get the umbrella out after a second";
}
