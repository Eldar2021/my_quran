import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

@immutable
sealed class UpdateUserDataParam {
  const UpdateUserDataParam({required this.userId});

  final String userId;

  Map<String, dynamic> toJson();
}

@immutable
final class UpdateFirstNameParam extends UpdateUserDataParam {
  const UpdateFirstNameParam({
    required this.firstName,
    required super.userId,
  });

  final String firstName;

  @override
  Map<String, dynamic> toJson() => {'first_name': firstName};
}

@immutable
final class UpdateLastNameParam extends UpdateUserDataParam {
  const UpdateLastNameParam({
    required this.lastName,
    required super.userId,
  });

  final String lastName;

  @override
  Map<String, dynamic> toJson() => {'last_name': lastName};
}

@immutable
final class UpdateUsernameParam extends UpdateUserDataParam {
  const UpdateUsernameParam({
    required this.username,
    required super.userId,
  });

  final String username;

  @override
  Map<String, dynamic> toJson() => {'username': username};
}

@immutable
final class UpdateAvatarParam extends UpdateUserDataParam {
  const UpdateAvatarParam({
    required this.avatar,
    required super.userId,
  });

  final String avatar;

  @override
  Map<String, dynamic> toJson() => {'avatar': avatar};
}

@immutable
final class UpdateEmailParam extends UpdateUserDataParam {
  const UpdateEmailParam({
    required this.email,
    required super.userId,
  });

  final String email;

  @override
  Map<String, dynamic> toJson() => {'email': email};
}

@immutable
final class UpdateCountryParam extends UpdateUserDataParam {
  const UpdateCountryParam({
    required this.country,
    required super.userId,
  });

  final String country;

  @override
  Map<String, dynamic> toJson() => {'country': country};
}

@immutable
final class UpdatePhoneNumberParam extends UpdateUserDataParam {
  const UpdatePhoneNumberParam({
    required this.phoneNumber,
    required super.userId,
  });

  final String phoneNumber;

  @override
  Map<String, dynamic> toJson() => {'phone_number': phoneNumber};
}

@immutable
final class UpdateGenderParam extends UpdateUserDataParam {
  const UpdateGenderParam({
    required this.gender,
    required super.userId,
  });

  final Gender gender;

  @override
  Map<String, dynamic> toJson() => {
    'gender': gender.name.toLowerCase(),
  };
}

@immutable
final class UpdateLanguageParam extends UpdateUserDataParam {
  const UpdateLanguageParam({
    required this.language,
    required super.userId,
  });

  final String language;

  @override
  Map<String, dynamic> toJson() => {'language': language};
}

@immutable
final class UpdateCanCreateHatimParam extends UpdateUserDataParam {
  const UpdateCanCreateHatimParam({
    required this.canCreateHatim,
    required super.userId,
  });

  final bool canCreateHatim;

  @override
  Map<String, dynamic> toJson() => {'can_create_hatim': canCreateHatim};
}

@immutable
final class NotificationEnabledParam extends UpdateUserDataParam {
  const NotificationEnabledParam({
    required this.enabled,
    required super.userId,
  });

  final bool enabled;

  @override
  Map<String, dynamic> toJson() => {'notification_enabled': enabled};
}
