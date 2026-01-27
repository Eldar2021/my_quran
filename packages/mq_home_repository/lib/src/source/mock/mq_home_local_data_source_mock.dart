import 'package:flutter/material.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

@immutable
final class MqHomeLocalDataSourceMock implements MqHomeLocalDataSource {
  const MqHomeLocalDataSourceMock();

  @override
  MqHomeModel getLocalData() {
    return const MqHomeModel(
      allDoneHatims: 0,
      allDonePages: 0,
      donePages: 0,
      enableCreationHatim: false,
      invitedHatims: [],
      hatims: [],
    );
  }

  @override
  Future<void> saveLocalData(MqHomeModel data) {
    return Future.value();
  }
}

const List<Map<String, dynamic>> mqStoriesMock = [
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
  },
];
