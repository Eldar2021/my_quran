import 'dart:async';

import 'package:mq_hatim_repository/mq_hatim_repository.dart';

final class MqHatimRemoteDataSourceMock implements MqHatimRemoteDataSource {
  const MqHatimRemoteDataSourceMock();

  @override
  Future<MqSearchModel> getSearch(String? user) async {
    return const MqSearchModel(
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
  }

  @override
  Future<MqHatimsModel> createHatim(MqHatimCreateModel user) async {
    return const MqHatimsModel(
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
      participantsDetails: [
        MqHatimParticipantsDetailUserModel(
          id: 1,
          hatim: 'test hatim',
          accepted: false,
          user: MqUserHatimModel(
            userName: 'user',
            email: 'email',
            firstName: 'user',
            lastName: 'user',
            avatar: '',
          ),
        ),
      ],
    );
  }
}
