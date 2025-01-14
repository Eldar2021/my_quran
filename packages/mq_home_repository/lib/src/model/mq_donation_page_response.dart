import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

part 'mq_donation_page_response.g.dart';

@JsonSerializable()
@immutable
final class MqDonationPageResponse {
  const MqDonationPageResponse({
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

  factory MqDonationPageResponse.fromJson(Map<String, dynamic> json) => _$MqDonationPageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MqDonationPageResponseToJson(this);

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
  final List<MqDonationRequisiteResponse> requisites;

  MqDonationPageEntity toEntity() {
    return MqDonationPageEntity(
      pageTitleAr: pageTitleAr,
      pageTitleEn: pageTitleEn,
      pageTitleId: pageTitleId,
      pageTitleKk: pageTitleKk,
      pageTitleKy: pageTitleKy,
      pageTitleRu: pageTitleRu,
      pageTitleTr: pageTitleTr,
      pageDescriptionAr: pageDescriptionAr,
      pageDescriptionEn: pageDescriptionEn,
      pageDescriptionId: pageDescriptionId,
      pageDescriptionKk: pageDescriptionKk,
      pageDescriptionKy: pageDescriptionKy,
      pageDescriptionRu: pageDescriptionRu,
      pageDescriptionTr: pageDescriptionTr,
      requisites: requisites.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
@immutable
final class MqDonationRequisiteResponse {
  const MqDonationRequisiteResponse({
    required this.bankType,
    required this.requisite,
    required this.requisiteForCopy,
    required this.accountName,
  });

  factory MqDonationRequisiteResponse.fromJson(Map<String, dynamic> json) =>
      _$MqDonationRequisiteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MqDonationRequisiteResponseToJson(this);

  final String bankType;
  final String requisite;
  final String requisiteForCopy;
  final String accountName;

  MqDonationRequisiteEntity toEntity() {
    return MqDonationRequisiteEntity(
      bankType: bankType,
      requisite: requisite,
      requisiteForCopy: requisiteForCopy,
      accountName: accountName,
    );
  }
}
