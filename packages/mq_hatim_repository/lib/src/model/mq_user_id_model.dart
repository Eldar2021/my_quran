import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'mq_user_id_model.g.dart';

@JsonSerializable()
@immutable
final class MqUserIdModel extends Equatable {
  const MqUserIdModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory MqUserIdModel.fromJson(Map<String, dynamic> json) => _$MqUserIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$MqUserIdModelToJson(this);

  final int? id;

  @JsonKey(name: 'username')
  final String? userName;

  final String? email;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  String get uiTitle {
    if (firstName != null && firstName!.isNotEmpty) {
      return firstName!;
    } else if (lastName != null && lastName!.isNotEmpty) {
      return lastName!;
    } else if (userName != null && userName!.isNotEmpty) {
      return userName!;
    } else if (email != null && email!.isNotEmpty) {
      return email!;
    }
    return '$id';
  }

  String get uiSubtitle {
    if (userName != null && userName!.isNotEmpty && userName != uiTitle) {
      return userName!;
    } else if (email != null && email!.isNotEmpty && email != uiTitle) {
      return email!;
    }
    return '$id';
  }

  @override
  List<Object?> get props => [
    id,
    userName,
    email,
    firstName,
    lastName,
  ];
}
