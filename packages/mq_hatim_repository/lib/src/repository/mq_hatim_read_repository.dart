import 'package:mq_hatim_repository/mq_hatim_repository.dart';

abstract class MqHatimRepository {
  Future<MqSearchModel> getSearch(String user);

  Future<MqHatimsModel> createHatim(
    MqHatimCreateModel hatim,
  );
}
