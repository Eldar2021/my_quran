import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_data_response.g.dart';

@JsonSerializable()
@immutable
final class UserDataResponse {
  const UserDataResponse({
    required this.gender,
    required this.language,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) => _$UserDataResponseFromJson(json);

  final String gender;
  final String language;

  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}
