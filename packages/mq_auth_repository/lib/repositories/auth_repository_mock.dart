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

  @override
  Future<NotificationCount> getNotificationCount(
    String userId,
  ) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => const NotificationCount(0),
    );
  }

  @override
  Future<List<UserActivityModel>> getUserActivity(String userId) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return generateMockActivities(DateTime.now(), 365, (i) => i.isEven);
  }

  static List<UserActivityModel> generateMockActivities(
    DateTime startDate,
    int count,
    bool Function(int)? predicate,
  ) {
    final mocks = <UserActivityModel>[];
    for (var i = 0; i < count; i++) {
      final date = startDate.add(Duration(days: i));
      final isTrue = predicate?.call(i) ?? i.isEven;
      mocks.add(
        UserActivityModel(
          date: date,
          openedApp: isTrue,
          quranReadedPagesCount: isTrue ? 12 : 0,
          listenedQuranSeconds: isTrue ? 600.0 : 0.0,
          fajrDone: isTrue,
          zuhrDone: isTrue,
          asrDone: isTrue,
          maghribDone: isTrue,
          ishaDone: isTrue,
        ),
      );
    }
    return mocks;
  }

  @override
  Future<UserRatingMainModel> getUserRatingMain(String userId) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => UserRatingMainModel.fromJson(_userRatingMainJsonData),
    );
  }

  @override
  Future<RatingResponseModel> getRatingData(
    RatingRequestModel param,
  ) async {
    final data = Map<String, dynamic>.from(_ratingMockRes);
    data['period_type'] = param.periodType.getValue();
    data['area_type'] = param.areaType.getValue();
    await Future<void>.delayed(const Duration(seconds: 1));
    return RatingResponseModel.fromJson(data);
  }
}

const _ratingMockRes = <String, dynamic>{
  'period_type': 'weekly', // weekly/monthly/three_month/year
  'area_type': 'world', // world/country
  'owner_data': {
    'rating_number': 3,
    'readed_pages_count': 9999,
  },
  'pagination': {
    'current_page': 0,
    'total_pages': 33,
    'has_next': true,
  },
  'list': [
    {
      'rating_number': 1,
      'full_name': 'Eldiiar Almazbekov',
      'email': null,
      'user_name': 'eldi_01',
      'avatar_url': null,
      'readed_pages_count': 99992,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 2,
      'full_name': 'Akyl Tashmatov',
      'email': 'akyl.tash@example.com',
      'user_name': 'akyl_t',
      'avatar_url': 'https://i.pravatar.cc/150?u=2',
      'readed_pages_count': 85430,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 3,
      'full_name': 'Alymbek Almazbekov',
      'email': null,
      'user_name': 'alym_bek',
      'avatar_url': null,
      'readed_pages_count': 72100,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 4,
      'full_name': 'Zamirbek Kaparov',
      'email': 'zamir.k@example.com',
      'user_name': 'zamir_k',
      'avatar_url': 'https://i.pravatar.cc/150?u=4',
      'readed_pages_count': 68524,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 5,
      'full_name': 'Elena Petrova',
      'email': 'elena.p@mail.ru',
      'user_name': 'elena_99',
      'avatar_url': null,
      'readed_pages_count': 54320,
      'country': '🇷🇺 Russia RUS',
    },
    {
      'rating_number': 6,
      'full_name': 'John Doe',
      'email': 'john.doe@gmail.com',
      'user_name': 'johndoe',
      'avatar_url': 'https://i.pravatar.cc/150?u=6',
      'readed_pages_count': 48210,
      'country': '🇺🇸 USA USA',
    },
    {
      'rating_number': 7,
      'full_name': 'Bakyt Asanov',
      'email': null,
      'user_name': 'bakyt_a',
      'avatar_url': null,
      'readed_pages_count': 45100,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 8,
      'full_name': 'Nurila Joldosheva',
      'email': 'nurila.j@example.com',
      'user_name': 'nurila_j',
      'avatar_url': 'https://i.pravatar.cc/150?u=8',
      'readed_pages_count': 42050,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 9,
      'full_name': 'Ahmet Yılmaz',
      'email': 'ahmet.y@yandex.com',
      'user_name': 'ahmet_y',
      'avatar_url': null,
      'readed_pages_count': 39800,
      'country': '🇹🇷 Turkey TUR',
    },
    {
      'rating_number': 10,
      'full_name': 'Sarah Connor',
      'email': null,
      'user_name': 'terminator_fan',
      'avatar_url': 'https://i.pravatar.cc/150?u=10',
      'readed_pages_count': 35600,
      'country': '🇬🇧 UK GBR',
    },
    {
      'rating_number': 11,
      'full_name': 'Ulan Saparov',
      'email': 'ulan.s@example.kg',
      'user_name': 'ulan_s',
      'avatar_url': null,
      'readed_pages_count': 31200,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 12,
      'full_name': 'Maria Garcia',
      'email': 'm.garcia@example.es',
      'user_name': 'm_garcia',
      'avatar_url': 'https://i.pravatar.cc/150?u=12',
      'readed_pages_count': 28900,
      'country': '🇪🇸 Spain ESP',
    },
    {
      'rating_number': 13,
      'full_name': 'Azamat Ismailov',
      'email': null,
      'user_name': 'azam_01',
      'avatar_url': null,
      'readed_pages_count': 25400,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 14,
      'full_name': 'Yuki Tanaka',
      'email': 'tanaka@example.jp',
      'user_name': 'yuki_t',
      'avatar_url': 'https://i.pravatar.cc/150?u=14',
      'readed_pages_count': 22150,
      'country': '🇯🇵 Japan JPN',
    },
    {
      'rating_number': 15,
      'full_name': 'Gulnara Sydykova',
      'email': 'gulnara@example.com',
      'user_name': 'gul_syd',
      'avatar_url': null,
      'readed_pages_count': 18900,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 16,
      'full_name': 'Hans Schmidt',
      'email': null,
      'user_name': 'hans_s',
      'avatar_url': 'https://i.pravatar.cc/150?u=16',
      'readed_pages_count': 15600,
      'country': '🇩🇪 Germany DEU',
    },
    {
      'rating_number': 17,
      'full_name': 'Aisuluu Keneshova',
      'email': 'aisuluu.k@mail.kg',
      'user_name': 'ais_ken',
      'avatar_url': null,
      'readed_pages_count': 12450,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 18,
      'full_name': 'Li Wei',
      'email': 'li.wei@example.cn',
      'user_name': 'li_wei_china',
      'avatar_url': 'https://i.pravatar.cc/150?u=18',
      'readed_pages_count': 9800,
      'country': '🇨🇳 China CHN',
    },
    {
      'rating_number': 19,
      'full_name': 'Nurbek Aliev',
      'email': null,
      'user_name': 'nurbek_a',
      'avatar_url': null,
      'readed_pages_count': 7500,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
    {
      'rating_number': 20,
      'full_name': 'Asema Asanbekova',
      'email': 'asema.a@example.com',
      'user_name': '@asanbekova20',
      'avatar_url': 'https://i.pravatar.cc/150?u=20',
      'readed_pages_count': 5200,
      'country': '🇰🇬 Kyrgyzstan KGZ',
    },
  ],
};

const _userRatingMainJsonData = <String, Object>{
  'world_rank': 492,
  'country_rank': 3,
  'weekly_data': [
    {'date': '2026-02-01T21:44:00.000Z', 'readed_pages_count': 3, 'listened_quran_by_hours': 1},
    {'date': '2026-02-02T21:44:00.000Z', 'readed_pages_count': 1, 'listened_quran_by_hours': 3},
    {'date': '2026-02-03T21:44:00.000Z', 'readed_pages_count': 2, 'listened_quran_by_hours': 2},
    {'date': '2026-02-04T21:44:00.000Z', 'readed_pages_count': 5, 'listened_quran_by_hours': 6},
    {'date': '2026-02-05T21:44:00.000Z', 'readed_pages_count': 1, 'listened_quran_by_hours': 4},
    {'date': '2026-02-06T21:44:00.000Z', 'readed_pages_count': 2, 'listened_quran_by_hours': 1},
    {'date': '2026-02-07T21:44:00.000Z', 'readed_pages_count': 1, 'listened_quran_by_hours': 5},
  ],
};

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
    'type': 'STANDARD',
    'avatar':
        'https://img.freepik.com/free-photo/animal-eye-staring-close-up-watch-nature-generative-ai_188544-15471.jpg?semt=ais_hybrid&w=740&q=80',
    'title': 'Juma Mubarak, Ediiar!',
    'description': "May this Friday bring peace and happiness to your heart. Don't forget to read Surah Al-Kahf today.",
    'date': '2025-12-22T14:30:00.000Z',
    'image': 'https://images.unsplash.com/photo-1564121211835-e88c852648ab?w=600&q=80',
    'action': {
      'button_text': 'Read Al-Kahf',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'surah_id': 18},
    },
  },
  {
    'id': '101',
    'is_read': false,
    'type': 'STANDARD',
    'avatar': null,
    'title': 'Win a Trip to Umrah!',
    'description':
        'Participate in our annual Quran competition and stand a chance to win a fully paid trip to Umrah. Terms and conditions apply.',
    'date': '2025-12-21T12:15:00.000Z',
    'image': 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?w=600&q=80',
    'action': {
      'button_text': 'Apply Now',
      'is_active': false,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'url': 'https://myquran.app/contest'},
    },
  },
  {
    'id': '102',
    'is_read': false,
    'type': 'STANDARD',
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
    'is_read': true,
    'type': 'STANDARD',
    'avatar': 'https://i.pravatar.cc/150?img=5',
    'title': 'New Hatim Started',
    'description': 'Your friend Ali has started a new Hatim circle. Would you like to join and take a Juz?',
    'date': '2025-12-20T18:45:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Join Hatim',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'hatim_id': '8821'},
    },
  },
  {
    'id': '104',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': 'https://i.pravatar.cc/150?img=8',
    'title': 'Update Available',
    'description': 'Version 2.0 is now live! We have added Dark Mode and new fonts for better readability.',
    'date': '2025-12-20T10:00:00.000Z',
    'image':
        'https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg?cs=srgb&dl=pexels-pixabay-56866.jpg&fm=jpg',
    'action': {
      'button_text': 'Update App',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'store_id': 'com.myquran.app'},
    },
  },
  {
    'id': '105',
    'is_read': true,
    'type': 'STANDARD',
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
    'type': 'STANDARD',
    'avatar': 'https://i.pravatar.cc/150?img=12',
    'title': 'Ramadan Early Bird Offer',
    'description': 'Get 50% off on Premium subscription before Ramadan starts. Limited time offer!',
    'date': '2025-12-19T15:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Get Premium',
      'is_active': false,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'product_id': 'premium_yearly'},
    },
  },
  {
    'id': '107',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': 'https://i.pravatar.cc/150?img=3',
    'title': 'Community Gathering',
    'description': 'Join us this Saturday at the Central Mosque for a community Iftar.',
    'date': '2025-12-19T09:30:00.000Z',
    'image':
        'https://png.pngtree.com/thumb_back/fh260/background/20240421/pngtree-stunning-4k-image-showcasing-the-beauty-of-nature-image_15718240.jpg',
    'action': {
      'button_text': 'Get Directions',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'lat': 42.87, 'lng': 74.59},
    },
  },
  {
    'id': '108',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': null,
    'title': 'Profile Incomplete',
    'description': 'Please complete your profile to access all features of the application.',
    'date': '2025-12-18T16:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Edit Profile',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {
        'id': '1',
      },
    },
  },
  {
    'id': '109',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': 'https://i.pravatar.cc/150?img=15',
    'title': 'Feedback Request',
    'description': 'How was your experience reading Surah Yasin yesterday?',
    'date': '2025-12-18T08:00:00.000Z',
    'image': null,
    'action': null,
  },
  {
    'id': '110',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': null,
    'title': 'New Font Added',
    'description': "We have added the 'Uthmanic Hafs' font based on your requests.",
    'date': '2025-12-17T22:00:00.000Z',
    'image':
        'https://png.pngtree.com/thumb_back/fh260/background/20250328/pngtree-archway-framing-a-tranquil-paradise-image_17151502.jpg',
    'action': null,
  },
  {
    'id': '111',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': 'https://i.pravatar.cc/150?img=33',
    'title': 'Donation Success',
    'description': 'Thank you! Your donation for the mosque construction has been received.',
    'date': '2025-12-17T14:45:00.000Z',
    'image': null,
    'action': {
      'button_text': 'View Receipt',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'url': 'https://myquran.app/receipts/111'},
    },
  },
  {
    'id': '112',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': null,
    'title': 'Partner Offer: Halal Food',
    'description': "Order from 'Bishkek Kebab' and get 10% discount with code QURAN10.",
    'date': '2025-12-16T19:00:00.000Z',
    'image': 'https://images.unsplash.com/photo-1599058945522-28d584b6f0ff?w=600&q=80',
    'action': {
      'button_text': 'Order Now',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'url': 'https://foodapp.com/bishkek'},
    },
  },
  {
    'id': '113',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': null,
    'title': 'Password Changed',
    'description': "Your account password was changed successfully. If this wasn't you, contact support.",
    'date': '2025-12-16T10:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Contact Support',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {
        'id': '1',
      },
    },
  },
  {
    'id': '114',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': 'https://i.pravatar.cc/150?img=20',
    'title': 'Daily Ayah',
    'description': '"Indeed, with hardship [will be] ease." (94:6)',
    'date': '2025-12-15T07:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Share',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'text': 'Surah Ash-Sharh 94:6'},
    },
  },
  {
    'id': '115',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': null,
    'title': 'Privacy Policy Update',
    'description': 'We have updated our Terms of Service and Privacy Policy effective immediately.',
    'date': '2025-12-14T12:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Read Policy',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'url': 'https://myquran.app/privacy'},
    },
  },
  {
    'id': '116',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': 'https://i.pravatar.cc/150?img=25',
    'title': 'Memorization Progress',
    'description': "You haven't practiced your memorization for 3 days. Keep the streak going!",
    'date': '2025-12-13T18:30:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Practice Now',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {
        'id': '1',
      },
    },
  },
  {
    'id': '117',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': null,
    'title': 'Limited Time: Lifetime Access',
    'description': 'Get lifetime access to all Premium features for a one-time payment.',
    'date': '2025-12-12T09:00:00.000Z',
    'image': 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=600&q=80',
  },
  {
    'id': '118',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': 'https://i.pravatar.cc/150?img=40',
    'title': 'Welcome Back!',
    'description': "It's been a while since we saw you. We missed you!",
    'date': '2025-12-10T11:00:00.000Z',
    'image': null,
    'action': {
      'button_text': 'Upgrade',
      'is_active': false,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {'product_id': 'lifetime_deal'},
    },
  },
  {
    'id': '119',
    'is_read': true,
    'type': 'STANDARD',
    'avatar': null,
    'title': 'Welcome to MyQuran',
    'description': 'Thank you for installing our application. We hope it helps you in your spiritual journey.',
    'date': '2025-12-01T08:00:00.000Z',
    'image': 'https://images.unsplash.com/photo-1609599006353-e629aaabfeae?w=600&q=80',
    'action': {
      'button_text': 'Start Tour',
      'is_active': true,
      'action_type': 'JOIN_TO_HATIM',
      'payload': {
        'id': '1',
      },
    },
  },
];
