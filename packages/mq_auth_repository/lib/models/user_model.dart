import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
final class UserModel {
  const UserModel({
    this.firstName,
    this.lastName,
    this.username,
    this.avatar,
    this.email,
    this.country,
    this.phoneNumber,
    this.gender,
    this.language,
    this.canCreateHatim,
    this.allowNotifications,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'username')
  final String? username;
  final String? avatar;
  final String? email;
  final String? country;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @GenderTypeConverter()
  final Gender? gender;
  final String? language;

  @JsonKey(name: 'can_create_hatim')
  final bool? canCreateHatim;

  @JsonKey(name: 'allow_notifications')
  final bool? allowNotifications;

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? avatar,
    String? email,
    String? country,
    String? phoneNumber,
    Gender? gender,
    String? language,
    bool? canCreateHatim,
    bool? allowNotifications,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      country: country ?? this.country,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      language: language ?? this.language,
      canCreateHatim: canCreateHatim ?? this.canCreateHatim,
      allowNotifications: allowNotifications ?? this.allowNotifications,
    );
  }
}
