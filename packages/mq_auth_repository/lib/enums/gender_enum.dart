import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum Gender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female;

  factory Gender.fromData(String? src) {
    return switch (src) {
      'male' => Gender.male,
      'female' => Gender.female,
      _ => Gender.male,
    };
  }
}
