part of 'hatim_bloc.dart';

@immutable
sealed class HatimEvent {
  const HatimEvent();
}

@immutable
final class GetInitailDataEvent extends HatimEvent {
  const GetInitailDataEvent();
}

@immutable
final class GetHatimJuzPagesEvent extends HatimEvent {
  const GetHatimJuzPagesEvent(this.juzId);

  final String juzId;
}

@immutable
final class SelectPageEvent extends HatimEvent {
  const SelectPageEvent(this.pageId);

  final String pageId;
}

@immutable
final class UnSelectPageEvent extends HatimEvent {
  const UnSelectPageEvent(this.pageId);

  final String pageId;
}

@immutable
final class SetInProgressPagesEvent extends HatimEvent {
  const SetInProgressPagesEvent(this.pageIds);

  final List<String> pageIds;
}

@immutable
final class SetDonePagesEvent extends HatimEvent {
  const SetDonePagesEvent(this.pageIds);

  final List<String> pageIds;
}

@immutable
final class ReceidevBaseDataEvent extends HatimEvent {
  const ReceidevBaseDataEvent(this.data);

  final (HatimResponseType, List<MqHatimBaseEntity>) data;
}

@immutable
final class ResetJuzPagesEvent extends HatimEvent {
  const ResetJuzPagesEvent();
}
