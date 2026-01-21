import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

@immutable
final class MqHatimRemoteDataSourceMock implements MqHatimRemoteDataSource {
  const MqHatimRemoteDataSourceMock();

  @override
  Future<MqSearchModel> searchParticipants(String value) {
    return Future.value(_mockSearchData);
  }

  @override
  Future<MqHatimModel> createHatim(MqHatimCreateModel param) {
    return Future.value(_mockatimData);
  }

  @override
  Future<void> deleteHatim(String id) {
    return Future.value();
  }

  @override
  Future<MqHatimModel> getHatimDataById(String id) {
    return Future.value(_mockatimData);
  }

  @override
  Future<MqHatimModel> updateHatim(MqHatimUpdateModel hatim) {
    return Future.value(_mockatimData);
  }
}

const _mockSearchData = MqSearchModel(
  users: [
    MqUserIdModel(
      id: 1,
      userName: 'user1',
      email: 'user1@gmail.com',
      firstName: 'user1',
      lastName: 'user1',
    ),
  ],
);

const _mockatimData = MqHatimModel(
  id: '111',
  title: 'test hatim',
  description: 'test hatim description',
  type: 'GROUP',
  status: 'IN_PROGRESS',
  creator: MqHatimCreateUserModel(
    firstName: 'user 1',
    lastName: 'user 1',
    userName: '@user 1',
    email: 'test email',
    avatar: '',
  ),
  participants: [
    MqHatimParticipantModel(
      id: 1,
      hatim: 'test hatim',
      accepted: false,
      user: MqUserHatimModel(
        id: 1,
        userName: 'user',
        email: 'email',
        firstName: 'user',
        lastName: 'user',
        avatar: '',
      ),
    ),
  ],
);
