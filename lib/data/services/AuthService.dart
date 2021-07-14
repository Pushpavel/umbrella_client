import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';
import 'package:umbrella_client/data/repositories/AuthRepo.dart';
import 'package:umbrella_client/helpers/DisposableProvider.dart';
import 'package:umbrella_client/utils/stream-utils.dart';

class AuthService implements Disposable {
  final Stream<UmbrellaUser?> user = AuthRepo.getUser().toCachedSubject();

  dispose() async {
    await user.drain();
    (user as BehaviorSubject<UmbrellaUser?>).close();
  }
}
