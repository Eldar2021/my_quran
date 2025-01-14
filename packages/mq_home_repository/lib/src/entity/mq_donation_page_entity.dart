import 'package:flutter/material.dart';

@immutable
final class MqDonationPageEntity {
  const MqDonationPageEntity({
    required this.pageTitleAr,
    required this.pageTitleEn,
    required this.pageTitleId,
    required this.pageTitleKk,
    required this.pageTitleKy,
    required this.pageTitleRu,
    required this.pageTitleTr,
    required this.pageDescriptionAr,
    required this.pageDescriptionEn,
    required this.pageDescriptionId,
    required this.pageDescriptionKk,
    required this.pageDescriptionKy,
    required this.pageDescriptionRu,
    required this.pageDescriptionTr,
    required this.requisites,
  });

  final String pageTitleAr;
  final String pageTitleEn;
  final String pageTitleId;
  final String pageTitleKk;
  final String pageTitleKy;
  final String pageTitleRu;
  final String pageTitleTr;
  final String pageDescriptionAr;
  final String pageDescriptionEn;
  final String pageDescriptionId;
  final String pageDescriptionKk;
  final String pageDescriptionKy;
  final String pageDescriptionRu;
  final String pageDescriptionTr;
  final List<MqDonationRequisiteEntity> requisites;

  String getTitle(String language) {
    return switch (language) {
      'ar' => pageTitleAr,
      'en' => pageTitleEn,
      'id' => pageTitleId,
      'kk' => pageTitleKk,
      'ky' => pageTitleKy,
      'ru' => pageTitleRu,
      'tr' => pageTitleTr,
      _ => pageTitleEn,
    };
  }

  String getDescription(String language) {
    return switch (language) {
      'ar' => pageDescriptionAr,
      'en' => pageDescriptionEn,
      'id' => pageDescriptionId,
      'kk' => pageDescriptionKk,
      'ky' => pageDescriptionKy,
      'ru' => pageDescriptionRu,
      'tr' => pageDescriptionTr,
      _ => pageDescriptionEn,
    };
  }
}

@immutable
final class MqDonationRequisiteEntity {
  const MqDonationRequisiteEntity({
    required this.bankType,
    required this.requisite,
    required this.requisiteForCopy,
    required this.accountName,
  });

  final String bankType;
  final String requisite;
  final String requisiteForCopy;
  final String accountName;
}
