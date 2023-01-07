import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel {
  const HomeModel({
    required this.allDoneHatims,
    required this.allDonePages,
    required this.donePages,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);

  final int allDoneHatims;
  final int allDonePages;
  final int donePages;
}
