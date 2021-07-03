import 'package:umbrella_client/models/UmbrellaRequest.dart';
import 'package:umbrella_client/models/UmbrellaUser.dart';

class AppState {
  final UmbrellaUser? user;
  final UmbrellaRequest? currentRequest;

  AppState({this.user, this.currentRequest});

  // beware of null
  AppState copyWith({UmbrellaUser? user, UmbrellaRequest? currentRequest}) {
    return AppState(
      user: user ?? this.user,
      currentRequest: currentRequest ?? this.currentRequest,
    );
  }
}
