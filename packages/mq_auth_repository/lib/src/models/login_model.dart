import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

part 'login_model.g.dart';

@JsonSerializable()
@immutable
final class LoginModel {
  const LoginModel(
    this.key,
    this.user,
  );

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

  final String key;
  final UserTokenModel user;
}
