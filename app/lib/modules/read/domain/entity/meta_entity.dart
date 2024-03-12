import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class MetaEntity {
  const MetaEntity(this.filters);

  final FiltersEnity filters;
}
