import 'package:mq_hatim_repository/mq_hatim_repository.dart';

abstract interface class MqHatimRepository {
  Future<MqSearchModel> searchParticipants(
    String value,
  );

  Future<MqHatimModel> getHatimDataById(
    String id,
  );

  Future<MqHatimModel> createHatim(
    MqHatimCreateModel param,
  );

  Future<MqHatimModel> updateHatim(
    MqHatimUpdateModel param,
  );

  Future<void> deleteHatim(
    String id,
  );
}
