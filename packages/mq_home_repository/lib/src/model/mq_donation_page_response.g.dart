// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mq_donation_page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqDonationPageResponse _$MqDonationPageResponseFromJson(Map<String, dynamic> json) => MqDonationPageResponse(
  pageTitleAr: json['pageTitleAr'] as String,
  pageTitleEn: json['pageTitleEn'] as String,
  pageTitleId: json['pageTitleId'] as String,
  pageTitleKk: json['pageTitleKk'] as String,
  pageTitleKy: json['pageTitleKy'] as String,
  pageTitleRu: json['pageTitleRu'] as String,
  pageTitleTr: json['pageTitleTr'] as String,
  pageDescriptionAr: json['pageDescriptionAr'] as String,
  pageDescriptionEn: json['pageDescriptionEn'] as String,
  pageDescriptionId: json['pageDescriptionId'] as String,
  pageDescriptionKk: json['pageDescriptionKk'] as String,
  pageDescriptionKy: json['pageDescriptionKy'] as String,
  pageDescriptionRu: json['pageDescriptionRu'] as String,
  pageDescriptionTr: json['pageDescriptionTr'] as String,
  requisites: (json['requisites'] as List<dynamic>)
      .map((e) => MqDonationRequisiteResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MqDonationPageResponseToJson(MqDonationPageResponse instance) => <String, dynamic>{
  'pageTitleAr': instance.pageTitleAr,
  'pageTitleEn': instance.pageTitleEn,
  'pageTitleId': instance.pageTitleId,
  'pageTitleKk': instance.pageTitleKk,
  'pageTitleKy': instance.pageTitleKy,
  'pageTitleRu': instance.pageTitleRu,
  'pageTitleTr': instance.pageTitleTr,
  'pageDescriptionAr': instance.pageDescriptionAr,
  'pageDescriptionEn': instance.pageDescriptionEn,
  'pageDescriptionId': instance.pageDescriptionId,
  'pageDescriptionKk': instance.pageDescriptionKk,
  'pageDescriptionKy': instance.pageDescriptionKy,
  'pageDescriptionRu': instance.pageDescriptionRu,
  'pageDescriptionTr': instance.pageDescriptionTr,
  'requisites': instance.requisites,
};

MqDonationRequisiteResponse _$MqDonationRequisiteResponseFromJson(Map<String, dynamic> json) =>
    MqDonationRequisiteResponse(
      bankType: json['bankType'] as String,
      requisite: json['requisite'] as String,
      requisiteForCopy: json['requisiteForCopy'] as String,
      accountName: json['accountName'] as String,
    );

Map<String, dynamic> _$MqDonationRequisiteResponseToJson(MqDonationRequisiteResponse instance) => <String, dynamic>{
  'bankType': instance.bankType,
  'requisite': instance.requisite,
  'requisiteForCopy': instance.requisiteForCopy,
  'accountName': instance.accountName,
};
