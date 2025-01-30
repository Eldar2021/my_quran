import 'package:mq_home_repository/mq_home_repository.dart';

abstract interface class MqHomeRepository {
  Future<MqHomeEntity> getData();

  Future<List<MqStoryEntity>> getStories(String language);

  Future<MqDonationPageEntity> getDonationPageData();

  Future<List<MqHomeBannerEntity>> getHomeBanners();
}
