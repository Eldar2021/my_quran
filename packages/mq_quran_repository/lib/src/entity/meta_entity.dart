import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

@immutable
final class MetaEntity {
  const MetaEntity(this.filters);

  final FiltersEnity filters;
}
