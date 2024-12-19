import 'package:json_annotation/json_annotation.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

part 'mq_hatim_read_model.g.dart';

@JsonSerializable()
class HatimReadModel {
  const HatimReadModel({
    required this.id,
    required this.status,
    required this.type,
  });

  factory HatimReadModel.fromJson(Map<String, dynamic> json) => _$HatimReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$HatimReadModelToJson(this);

  final String id;
  final String status;
  final String type;

  MqHatimReadEntity get toEntity {
    return MqHatimReadEntity(
      id: id,
      status: status,
      type: type,
    );
  }
}
