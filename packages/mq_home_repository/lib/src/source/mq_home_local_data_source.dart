import 'package:mq_home_repository/mq_home_repository.dart';

abstract class MqHomeLocalDataSource {
  MqHomeModelResponse getLocalData();

  Future<void> saveLocalData(MqHomeModelResponse data);
}
