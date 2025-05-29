import 'package:flutter/material.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

@immutable
final class MqHomeRemoteDataSourceImpl implements MqHomeRemoteDataSource {
  const MqHomeRemoteDataSourceImpl(this.remoteClient);

  final MqRemoteClient remoteClient;

  @override
  Future<MqHomeModel> getRemoteData() {
    return remoteClient.getType<MqHomeModel>('/api/v1/hatim/dashboard', fromJson: MqHomeModel.fromJson);
  }

  @override
  Future<List<MqStoryModelResponse>> getStories(String language) async {
    return remoteClient.getListOfType<MqStoryModelResponse>(
      'https://eldar2021.github.io/my-quran/stories/$language/my-quran-stories.json',
      fromJson: MqStoryModelResponse.fromJson,
    );
  }

  @override
  Future<MqDonationPageResponse> getDonationPageData() async {
    return remoteClient.getType<MqDonationPageResponse>(
      'https://eldar2021.github.io/my-quran/donation-requisites/requisites.json',
      fromJson: MqDonationPageResponse.fromJson,
    );
  }

  @override
  Future<List<MqHomeBannerResponse>> getHomeBanners() async {
    return remoteClient.getListOfType<MqHomeBannerResponse>(
      'https://eldar2021.github.io/my-quran/banners/home_banners.json',
      fromJson: MqHomeBannerResponse.fromJson,
    );
  }
}
