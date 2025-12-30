part of 'profile_cubit.dart';

enum ProfileLoadingType {
  initial,
  updateFirstName,
  updateLastName,
  updateUsername,
  updateAvatar,
  updateEmail,
  updateCountry,
  updatePhone,
  updateGender,
  updateLanguage,
  updateCreateHatim,
  updateAllowNotification,
  updateTimezone,
  logout,
  deleteAccount;

  factory ProfileLoadingType.fromUpdateValueType(UpdateUserDataParam type) {
    return switch (type) {
      UpdateFirstNameParam() => updateFirstName,
      UpdateLastNameParam() => updateLastName,
      UpdateUsernameParam() => updateUsername,
      UpdateAvatarParam() => updateAvatar,
      UpdateEmailParam() => updateEmail,
      UpdateCountryParam() => updateCountry,
      UpdatePhoneNumberParam() => updatePhone,
      UpdateGenderParam() => updateGender,
      UpdateLanguageParam() => updateLanguage,
      UpdateCanCreateHatimParam() => updateCreateHatim,
      NotificationEnabledParam() => updateAllowNotification,
      UpdateTimezoneParam() => updateTimezone,
    };
  }
}
