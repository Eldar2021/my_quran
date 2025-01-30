import 'package:flutter/material.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

@immutable
final class MqHomeLocalDataSourceMock implements MqHomeLocalDataSource {
  const MqHomeLocalDataSourceMock();

  @override
  MqHomeModelResponse getLocalData() {
    return const MqHomeModelResponse(
      allDoneHatims: 0,
      allDonePages: 0,
      donePages: 0,
    );
  }

  @override
  Future<void> saveLocalData(MqHomeModelResponse data) {
    return Future.value();
  }

  @override
  List<MqHomeBannerResponse> getHomeBanners() {
    return mqMockHomeBanners
        .map(
          (e) => MqHomeBannerResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> setHomeBanners(List<MqHomeBannerResponse> banners) {
    return Future.value();
  }
}

const mqMockHomeBanners = [
  {
    'image_ru': '',
    'image_en': '',
    'image_ky': '',
    'image_tr': '',
    'has_condition': true,
    'date': '',
  },
];

const mqStoriesMock = [
  {
    'cardImageUrl': 'https://eldar2021.github.io/my-quran/assets/aa_story_card/app.jpeg',
    'cardLabel': 'MyQuran\nApp',
    'isViewed': false,
    'button': {
      'hasButton': false,
      'label': '',
      'action': '',
    },
    'screens': [
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/app_01_v1.png',
        'durationByMilliseconds': 5000,
      },
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/app_02_v1.png',
        'durationByMilliseconds': 5000,
      },
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/app_03_v1.png',
        'durationByMilliseconds': 5000,
      },
    ],
  },
  {
    'cardImageUrl': 'https://eldar2021.github.io/my-quran/assets/aa_story_card/hatim.png',
    'cardLabel': 'MyQuran\nHatim',
    'isViewed': false,
    'button': {
      'hasButton': false,
      'label': '',
      'action': '',
    },
    'screens': [
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/hatim_01_v1.png',
        'durationByMilliseconds': 5000,
      },
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/hatim_02_v1.png',
        'durationByMilliseconds': 5000,
      },
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/hatim_03_v1.png',
        'durationByMilliseconds': 5000,
      },
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/hatim_04_v1.png',
        'durationByMilliseconds': 5000,
      },
    ],
  },
  {
    'cardImageUrl': 'https://eldar2021.github.io/my-quran/assets/aa_story_card/quran_audio.png',
    'cardLabel': 'MyQuran\nAudio',
    'isViewed': false,
    'button': {
      'hasButton': false,
      'label': '',
      'action': '',
    },
    'screens': [
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/quran_audio_01_v1.png',
        'durationByMilliseconds': 5000,
      },
    ],
  },
  {
    'cardImageUrl': 'https://eldar2021.github.io/my-quran/assets/aa_story_card/quran_book.png',
    'cardLabel': 'MyQuran\nBook',
    'isViewed': false,
    'button': {
      'hasButton': false,
      'label': '',
      'action': '',
    },
    'screens': [
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/quran_book_01_v1.png',
        'durationByMilliseconds': 5000,
      },
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/quran_book_02_v1.png',
        'durationByMilliseconds': 5000,
      },
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/quran_book_03_v1.png',
        'durationByMilliseconds': 5000,
      },
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/quran_book_04_v1.png',
        'durationByMilliseconds': 5000,
      },
    ],
  },
  {
    'cardImageUrl': 'https://eldar2021.github.io/my-quran/assets/aa_story_card/app_share.jpg',
    'cardLabel': 'MyQuran\nShare',
    'isViewed': false,
    'button': {
      'hasButton': false,
      'label': '',
      'action': '',
    },
    'screens': [
      {
        'imageUrl': 'https://eldar2021.github.io/my-quran/assets/en/app_share_01_v1.png',
        'durationByMilliseconds': 5000,
      },
    ],
  }
];
