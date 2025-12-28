import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

part 'auth_model.g.dart';

@JsonSerializable()
@immutable
final class AuthModel extends Equatable {
  const AuthModel({
    required this.key,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  final String key;
  final UserModel user;

  AuthModel copyWith({
    String? key,
    UserModel? user,
  }) {
    return AuthModel(
      key: key ?? this.key,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [key, user];
}
