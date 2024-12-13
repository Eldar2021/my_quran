import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mocktail/mocktail.dart';

final class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {
  @override
  Stream<RemoteConfigUpdate> get onConfigUpdated {
    return const Stream.empty();
  }
}
