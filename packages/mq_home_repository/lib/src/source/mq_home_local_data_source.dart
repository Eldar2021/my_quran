import 'package:mq_home_repository/mq_home_repository.dart';

abstract class MqHomeLocalDataSource {
  MqHomeModel getLocalData();

  Future<void> saveLocalData(
    MqHomeModel data,
  );
}
