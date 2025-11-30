import 'package:flutter/material.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

@immutable
final class MqHomeRemoteDataSourceMock implements MqHomeRemoteDataSource {
  const MqHomeRemoteDataSourceMock();

  @override
  Future<MqHomeModel> getRemoteData() async {
    return const MqHomeModel(
      allDoneHatims: 0,
      allDonePages: 0,
      donePages: 0,
      enableCreationHatim: false,
      invitedHatims: [],
      hatims: [],
    );
  }

  @override
  Future<List<MqStoryModelResponse>> getStories(String language) async {
    return mqStoriesMock.map(MqStoryModelResponse.fromJson).toList();
  }

  @override
  Future<MqDonationPageResponse> getDonationPageData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    const mockDonationPageData = {
      'pageTitleAr': 'دعم المشروع',
      'pageTitleEn': 'Support Our Project',
      'pageTitleId': 'Dukung Proyek Kami',
      'pageTitleKk': 'Жобамызды Қолдаңыз',
      'pageTitleKy': 'Проектти Колдоңуз',
      'pageTitleRu': 'Поддержите Наш Проект',
      'pageTitleTr': 'Projemize Destek Olun',
      'pageDescriptionAr':
          'يسعدنا أن تقدم الدعم المالي لمساعدتنا على تحسين مشروعنا. بفضل مساهماتكم، يمكننا الوصول إلى عدد أكبر من المستخدمين ونشر الرسالة المقدسة للقرآن الكريم. شكرا لكم.',
      'pageDescriptionEn':
          'We would be delighted if you could provide financial support to help us improve our project. Thanks to your contributions, we can reach more users and continue spreading the holy message of the Quran. Thank you in advance.',
      'pageDescriptionId':
          'Kami akan sangat senang jika Anda memberikan dukungan finansial untuk membantu meningkatkan proyek kami. Berkat kontribusi Anda, kami dapat menjangkau lebih banyak pengguna dan terus menyebarkan pesan suci Al-Quran. Terima kasih sebelumnya.',
      'pageDescriptionKk':
          'Бізге жобамызды жақсартуға көмектесу үшін қаржылық қолдау көрсетсеңіз қуанышты болар едік. Сіздің үлесіңізбен біз көбірек пайдаланушыларға жете аламыз және Құранның қасиетті хабарын тарата аламыз. Алдын ала рахмет.',
      'pageDescriptionKy':
          'Проектти өнүктүрүүгө жардам берүү үчүн финансылык колдоо көрсөткөнүңүзгө кубанычтабыз. Сиздин салымыңыз аркылуу биз көбүрөөк колдонуучуга жетип, Ыйык Куранды жайылта беребиз. Алдын ала ыраазычылык билдиребиз.',
      'pageDescriptionRu':
          'Мы будем рады, если вы окажете финансовую поддержку для улучшения нашего проекта. Благодаря вашему вкладу, мы сможем достичь большего числа пользователей и продолжить распространять священное послание Корана. Спасибо заранее.',
      'pageDescriptionTr':
          "Projemizi geliştirmemize yardımcı olmak için maddi desteklerinizi bekliyoruz. Katkılarınız sayesinde daha fazla kullanıcıya ulaşabilir ve Kur'an-ı Kerim'in kutsal mesajını yaymaya devam edebiliriz. Şimdiden teşekkür ederiz.",
      'requisites': [
        {
          'bankType': 'Visa',
          'requisite': '1030 1202 3850 1612',
          'requisiteForCopy': '1030120238501612',
          'accountName': 'АЛМАЗБЕК УУЛУ ЭЛДИЯР',
        },
      ],
    };

    return MqDonationPageResponse.fromJson(mockDonationPageData);
  }

  @override
  Future<List<MqHomeBannerResponse>> getHomeBanners() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return mqMockHomeBanners.map(MqHomeBannerResponse.fromJson).toList();
  }

  @override
  Future<void> hatimAccept(String id) => Future.value();

  @override
  Future<void> hatimReject(String id) => Future.value();
}
