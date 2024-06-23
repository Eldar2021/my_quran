import 'package:json_annotation/json_annotation.dart';
import 'package:my_quran/modules/hatim/hatim.dart';

part 'hatim_read_model.g.dart';

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

  HatimReadEntity get toEntity {
    return HatimReadEntity(
      id: id,
      status: status,
      type: type,
    );
  }
}
