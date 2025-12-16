import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_param.g.dart';

@JsonSerializable()
@immutable
final class LoginParam {
  const LoginParam({
    required this.name,
    required this.accessToken,
    this.identityToken,
  });

  factory LoginParam.fromJson(Map<String, dynamic> json) => _$LoginParamFromJson(json);
  Map<String, dynamic> toJson() => _$LoginParamToJson(this);

  final String name;
  final String accessToken;
  final String? identityToken;
}
