import 'package:mq_home_repository/mq_home_repository.dart';

abstract class MqHomeRemoteDataSource {
  Future<MqHomeModel> getRemoteData();

  Future<List<MqStoryModelResponse>> getStories(String language);

  Future<MqDonationPageResponse> getDonationPageData();

  Future<List<MqHomeBannerResponse>> getHomeBanners();
}
