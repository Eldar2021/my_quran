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
  List<MqStoryModelResponse> getStories(String language) {
    return mqStoriesMock
        .map(
          (e) => MqStoryModelResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> saveStories(
    List<MqStoryModelResponse> data,
    String language,
  ) {
    return Future.value();
  }
}

const mqStoriesMock = [
  {
    'cardImageUrl': 'https://t3.ftcdn.net/jpg/05/68/99/80/360_F_568998040_m42feFA9RajqmuR5DTlWwox44fxE3MOi.jpg',
    'cardLabel': 'Hatim\nInstructions',
    'isViewed': false,
    'button': {
      'hasButton': false,
      'label': '',
      'action': '',
    },
    'screens': [
      {
        'imageUrl': 'https://t3.ftcdn.net/jpg/05/68/99/80/360_F_568998040_m42feFA9RajqmuR5DTlWwox44fxE3MOi.jpg',
        'durationByMilliseconds': 2000,
      },
      {
        'imageUrl': 'https://t3.ftcdn.net/jpg/07/02/55/16/360_F_702551695_zBR0B1IrgGCJdgZbYE6dzlExKhAxD4OC.jpg',
        'durationByMilliseconds': 2000,
      }
    ],
  },
  {
    'cardImageUrl':
        'https://thumbs.dreamstime.com/b/closeup-holy-quran-captured-near-sacred-kaaba-mecca-highlighting-its-spiritual-significance-ai-generated-image-329385127.jpg',
    'cardLabel': 'Quran\nInstructions',
    'isViewed': false,
    'button': {
      'hasButton': false,
      'label': '',
      'action': '',
    },
    'screens': [
      {
        'imageUrl':
            'https://thumbs.dreamstime.com/b/closeup-holy-quran-captured-near-sacred-kaaba-mecca-highlighting-its-spiritual-significance-ai-generated-image-329385127.jpg',
        'durationByMilliseconds': 2000,
      },
      {
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaczS5PI_ePL2HwRhlEq1PPZjpLFw3PY3D5w&s',
        'durationByMilliseconds': 2000,
      }
    ],
  },
  {
    'cardImageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-IlJBNJLlv1cdFJ7xVWMkAjfk-mSWAJFvCu2HctMMRBRRyphoZTe0wjbkUl75fR97odM&usqp=CAU',
    'cardLabel': 'Audio\nInstructions',
    'isViewed': false,
    'button': {
      'hasButton': false,
      'label': '',
      'action': '',
    },
    'screens': [
      {
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-IlJBNJLlv1cdFJ7xVWMkAjfk-mSWAJFvCu2HctMMRBRRyphoZTe0wjbkUl75fR97odM&usqp=CAU',
        'durationByMilliseconds': 2000,
      },
      {
        'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqILNo55rnX2dLPvHPlu0Rr3_KkjM_ajDTEQ&s',
        'durationByMilliseconds': 2000,
      }
    ],
  }
];
