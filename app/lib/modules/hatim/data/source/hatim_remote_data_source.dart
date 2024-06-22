import 'package:flutter/material.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HatimRemoteDataSource {
  const HatimRemoteDataSource(this.remoteClient);

  final RemoteClient remoteClient;

  Future<Either<HatimReadModel, Exception>> getHatim(String token) {
    return remoteClient.post(
      apiConst.joinToHatim,
      fromJson: HatimReadModel.fromJson,
      token: token,
    );
  }
}
