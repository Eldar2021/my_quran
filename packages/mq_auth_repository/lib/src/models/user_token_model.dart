import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_token_model.g.dart';

@JsonSerializable()
@immutable
final class UserTokenModel {
  const UserTokenModel({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.avatar,
    required this.email,
    required this.country,
    required this.phoneNumber,
    required this.gender,
    required this.language,
    required this.canCreateHatim,
  });

  factory UserTokenModel.fromJson(Map<String, dynamic> json) => _$UserTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserTokenModelToJson(this);

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
  final String? gender;
  final String? language;

  @JsonKey(name: 'can_create_hatim')
  final bool? canCreateHatim;
}
