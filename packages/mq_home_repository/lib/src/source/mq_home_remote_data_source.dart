import 'package:mq_home_repository/mq_home_repository.dart';

abstract class MqHomeRemoteDataSource {
  Future<MqHomeModelResponse> getRemoteData();
}
