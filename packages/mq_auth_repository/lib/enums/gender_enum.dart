import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum Gender {
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  female;

  factory Gender.fromData(String? src) {
    return switch (src) {
      'male' || 'MALE' || 'Male' => Gender.male,
      'female' || 'FEMALE' || 'Female' => Gender.female,
      _ => Gender.male,
    };
  }
}

class GenderTypeConverter implements JsonConverter<Gender, String> {
  const GenderTypeConverter();

  @override
  Gender fromJson(String jsonValue) {
    return switch (jsonValue) {
      'male' || 'MALE' || 'Male' => Gender.male,
      'female' || 'FEMALE' || 'Female' => Gender.female,
      _ => Gender.male,
    };
  }

  @override
  String toJson(Gender object) {
    return switch (object) {
      Gender.male => 'male',
      Gender.female => 'female',
    };
  }
}
