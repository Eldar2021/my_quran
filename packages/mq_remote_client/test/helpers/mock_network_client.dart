import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

@immutable
final class MockNetworkClient extends Mock implements NetworkClient {
  @override
  Future<bool> checkInternetConnection() => Future.value(true);
}
