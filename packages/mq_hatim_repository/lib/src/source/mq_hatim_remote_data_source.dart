import 'package:mq_hatim_repository/mq_hatim_repository.dart';

abstract class MqHatimRemoteDataSource {
  Future<MqSearchModel> getSearch(String? user);

  Future<MqHatimsModel> createHatim(
    MqHatimCreateModel hatim,
  );
}
