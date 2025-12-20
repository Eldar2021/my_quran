import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

@immutable
final class AuthRepositoryMock implements AuthRepository {
  const AuthRepositoryMock();

  @override
  AuthModel? get initialAuth => null;

  @override
  Future<void> saveUser(AuthModel user) {
    return Future.value();
  }

  @override
  Future<void> loginWithEmail(String email) {
    return Future.value();
  }

  @override
  Future<AuthModel> verifyOtp({
    required String email,
    required String otp,
    required String languageCode,
    required Gender gender,
  }) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => AuthModel.fromJson(_authJsonData),
    );
  }

  @override
  Future<AuthModel> signWithGoogle(
    String languageCode,
    Gender gender,
  ) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => AuthModel.fromJson(_authJsonData),
    );
  }

  @override
  Future<AuthModel> signWithApple(
    String languageCode,
    Gender gender,
  ) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => AuthModel.fromJson(_authJsonData),
    );
  }

  @override
  Future<UserModel> getUserData(String userId) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => UserModel.fromJson(_userJsonData),
    );
  }

  @override
  Future<void> deleteAccount() {
    return Future.value();
  }

  @override
  Future<void> logout() {
    return Future.value();
  }

  @override
  Future<void> setNotificationToken({
    required String userId,
    required String notificationToken,
    required String deviceType,
    required String deviceId,
    required String deviceTimezone,
  }) {
    return Future.value();
  }

  @override
  Future<List<NotificationModel>> getNotifications(
    String userId,
    String locale,
  ) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => notificationJsonData.map(NotificationModel.fromJson).toList(),
    );
  }

  @override
  Future<UserModel> patchUserData(UpdateUserDataParam param) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => UserModel.fromJson(_userJsonData),
    );
  }
}

const _authJsonData = <String, dynamic>{
  'key': 'user_key',
  'user': {
    'first_name': 'Test',
    'last_name': 'User',
    'username': 'test_user',
    'avatar': 'https://lh3.googleusercontent.com/a/ACg8ocLxYr0F89L5FzZv9o_VyCYm3rkX4gtZAxBzyJkpC6yQE7uKuTY2=s96-c',
    'email': 'test_user@gmail.com',
    'country': null,
    'phone_number': null,
    'gender': 'male',
    'language': 'en',
    'can_create_hatim': false,
  },
};

const _userJsonData = <String, dynamic>{
  'first_name': 'Test',
  'last_name': 'User',
  'username': 'test_user',
  'avatar': 'https://lh3.googleusercontent.com/a/ACg8ocLxYr0F89L5FzZv9o_VyCYm3rkX4gtZAxBzyJkpC6yQE7uKuTY2=s96-c',
  'email': 'test_user@gmail.com',
  'country': null,
  'phone_number': null,
  'gender': 'male',
  'language': 'en',
  'can_create_hatim': false,
};

const notificationJsonData = <Map<String, dynamic>>[
  {
    'id': '100',
    'is_read': false,
    'type': 'standard',
    'avatar': 'https://i.pravatar.cc/150?img=1',
    'title': 'Juma Mubarak, Ediiar!',
    'description': "May this Friday bring peace and happiness to your heart. Don't forget to read Surah Al-Kahf today.",
    'date': '2025-12-21T14:30:00.000Z',
    'image': 'https://images.unsplash.com/photo-1564121211835-e88c852648ab?w=600&q=80',
    'action': {
      'button_text': 'Read Al-Kahf',
      'is_active': true,
      'action_type': 'open_surah',
      'payload': {'surah_id': 18},
    },
  },
  {
    'id': '101',
    'is_read': false,
    'type': 'promo',
    'avatar': null,
    'title': 'Win a Trip to Umrah!',
    'description':
        'Participate in our annual Quran competition and stand a chance to win a fully paid trip to Umrah. Terms and conditions apply.',
    'date': '2025-12-21T12:15:00.000Z',
    'image': 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?w=600&q=80',
    'action': {
      'button_text': 'Apply Now',
      'is_active': true,
      'action_type': 'open_webview',
      'payload': {'url': 'https://myquran.app/contest'},
    },
  },
  {
    'id': '102',
    'is_read': true,
    'type': 'alert',
    'avatar': null,
    'title': 'System Maintenance',
    'description':
        'Our servers will be undergoing scheduled maintenance tonight from 02:00 AM to 04:00 AM. The app might be unstable during this time.',
    'date': '2025-12-21T09:00:00.000Z',
    'image': null,
    'action': null,
  },
  {
    'id': '103',
    'is_read': false,
    'type': 'standard',
    'avatar': 'https://i.pravatar.cc/150?img=5',
    'title': 'New Hatim Started',
    'description': 'Your friend Ali has started a new Hatim circle. Would you like to join and take a Juz?',
    'date': '2025-12-20T18:45:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Join Hatim',
      'is_active': true,
      'action_type': 'open_hatim',
      'payload': {'hatim_id': '8821'},
    },
  },
  {
    'id': '104',
    'is_read': true,
    'type': 'info',
    'avatar': 'https://i.pravatar.cc/150?img=8',
    'title': 'Update Available',
    'description': 'Version 2.0 is now live! We have added Dark Mode and new fonts for better readability.',
    'date': '2025-12-20T10:00:00.000Z',
    'image': 'https://images.unsplash.com/photo-1555421689-4926337752c3?w=600&q=80',
    'action': {
      'button_text': 'Update App',
      'is_active': true,
      'action_type': 'open_store',
      'payload': {'store_id': 'com.myquran.app'},
    },
  },
  {
    'id': '105',
    'is_read': true,
    'type': 'standard',
    'avatar': null,
    'title': 'Did you know?',
    'description': 'The Quran was revealed over a period of approximately 23 years.',
    'date': '2025-12-19T20:20:00.000Z',
    'image': null,
    'action': null,
  },
  {
    'id': '106',
    'is_read': true,
    'type': 'promo',
    'avatar': 'https://i.pravatar.cc/150?img=12',
    'title': 'Ramadan Early Bird Offer',
    'description': 'Get 50% off on Premium subscription before Ramadan starts. Limited time offer!',
    'date': '2025-12-19T15:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Get Premium',
      'is_active': false,
      'action_type': 'open_payment',
      'payload': {'product_id': 'premium_yearly'},
    },
  },
  {
    'id': '107',
    'is_read': false,
    'type': 'standard',
    'avatar': 'https://i.pravatar.cc/150?img=3',
    'title': 'Community Gathering',
    'description': 'Join us this Saturday at the Central Mosque for a community Iftar.',
    'date': '2025-12-19T09:30:00.000Z',
    'image': 'https://images.unsplash.com/photo-1584558837943-0955681691a5?w=600&q=80',
    'action': {
      'button_text': 'Get Directions',
      'is_active': true,
      'action_type': 'open_maps',
      'payload': {'lat': 42.87, 'lng': 74.59},
    },
  },
  {
    'id': '108',
    'is_read': true,
    'type': 'alert',
    'avatar': null,
    'title': 'Profile Incomplete',
    'description': 'Please complete your profile to access all features of the application.',
    'date': '2025-12-18T16:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Edit Profile',
      'is_active': true,
      'action_type': 'open_profile',
      'payload': {
        'id': '1',
      },
    },
  },
  {
    'id': '109',
    'is_read': true,
    'type': 'standard',
    'avatar': 'https://i.pravatar.cc/150?img=15',
    'title': 'Feedback Request',
    'description': 'How was your experience reading Surah Yasin yesterday?',
    'date': '2025-12-18T08:00:00.000Z',
    'image': null,
    'action': null,
  },
  {
    'id': '110',
    'is_read': false,
    'type': 'info',
    'avatar': null,
    'title': 'New Font Added',
    'description': "We have added the 'Uthmanic Hafs' font based on your requests.",
    'date': '2025-12-17T22:00:00.000Z',
    'image': 'https://images.unsplash.com/photo-1621159828236-0c7f07d2c31e?w=600&q=80',
    'action': null,
  },
  {
    'id': '111',
    'is_read': true,
    'type': 'standard',
    'avatar': 'https://i.pravatar.cc/150?img=33',
    'title': 'Donation Success',
    'description': 'Thank you! Your donation for the mosque construction has been received.',
    'date': '2025-12-17T14:45:00.000Z',
    'image': null,
    'action': {
      'button_text': 'View Receipt',
      'is_active': true,
      'action_type': 'open_pdf',
      'payload': {'url': 'https://myquran.app/receipts/111'},
    },
  },
  {
    'id': '112',
    'is_read': true,
    'type': 'promo',
    'avatar': null,
    'title': 'Partner Offer: Halal Food',
    'description': "Order from 'Bishkek Kebab' and get 10% discount with code QURAN10.",
    'date': '2025-12-16T19:00:00.000Z',
    'image': 'https://images.unsplash.com/photo-1599058945522-28d584b6f0ff?w=600&q=80',
    'action': {
      'button_text': 'Order Now',
      'is_active': true,
      'action_type': 'open_browser',
      'payload': {'url': 'https://foodapp.com/bishkek'},
    },
  },
  {
    'id': '113',
    'is_read': true,
    'type': 'alert',
    'avatar': null,
    'title': 'Password Changed',
    'description': "Your account password was changed successfully. If this wasn't you, contact support.",
    'date': '2025-12-16T10:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Contact Support',
      'is_active': true,
      'action_type': 'open_support',
      'payload': {
        'id': '1',
      },
    },
  },
  {
    'id': '114',
    'is_read': false,
    'type': 'standard',
    'avatar': 'https://i.pravatar.cc/150?img=20',
    'title': 'Daily Ayah',
    'description': '"Indeed, with hardship [will be] ease." (94:6)',
    'date': '2025-12-15T07:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Share',
      'is_active': true,
      'action_type': 'share_text',
      'payload': {'text': 'Surah Ash-Sharh 94:6'},
    },
  },
  {
    'id': '115',
    'is_read': true,
    'type': 'info',
    'avatar': null,
    'title': 'Privacy Policy Update',
    'description': 'We have updated our Terms of Service and Privacy Policy effective immediately.',
    'date': '2025-12-14T12:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Read Policy',
      'is_active': true,
      'action_type': 'open_webview',
      'payload': {'url': 'https://myquran.app/privacy'},
    },
  },
  {
    'id': '116',
    'is_read': true,
    'type': 'standard',
    'avatar': 'https://i.pravatar.cc/150?img=25',
    'title': 'Memorization Progress',
    'description': "You haven't practiced your memorization for 3 days. Keep the streak going!",
    'date': '2025-12-13T18:30:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Practice Now',
      'is_active': true,
      'action_type': 'open_hifz',
      'payload': {
        'id': '1',
      },
    },
  },
  {
    'id': '117',
    'is_read': true,
    'type': 'promo',
    'avatar': null,
    'title': 'Limited Time: Lifetime Access',
    'description': 'Get lifetime access to all Premium features for a one-time payment.',
    'date': '2025-12-12T09:00:00.000Z',
    'image': 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=600&q=80',
    'action': {
      'button_text': 'Upgrade',
      'is_active': false,
      'action_type': 'open_payment',
      'payload': {'product_id': 'lifetime_deal'},
    },
  },
  {
    'id': '118',
    'is_read': true,
    'type': 'standard',
    'avatar': 'https://i.pravatar.cc/150?img=40',
    'title': 'Welcome Back!',
    'description': "It's been a while since we saw you. We missed you!",
    'date': '2025-12-10T11:00:00.000Z',
    'image': null,
    'action': null,
  },
  {
    'id': '119',
    'is_read': true,
    'type': 'info',
    'avatar': null,
    'title': 'Welcome to MyQuran',
    'description': 'Thank you for installing our application. We hope it helps you in your spiritual journey.',
    'date': '2025-12-01T08:00:00.000Z',
    'image': 'https://images.unsplash.com/photo-1609599006353-e629aaabfeae?w=600&q=80',
    'action': {
      'button_text': 'Start Tour',
      'is_active': true,
      'action_type': 'start_onboarding',
      'payload': {
        'id': '1',
      },
    },
  },
];
