part of 'hatim_bloc.dart';

@immutable
sealed class HatimEvent {
  const HatimEvent();
}

@immutable
final class GetInitialDataEvent extends HatimEvent {
  const GetInitialDataEvent();
}

@immutable
final class HatimConnectionChangedEvent extends HatimEvent {
  const HatimConnectionChangedEvent(this.connectionState);

  final ConnectionState connectionState;
}

@immutable
final class DisconnectSocketEvent extends HatimEvent {
  const DisconnectSocketEvent();
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
final class ReceivedBaseDataEvent extends HatimEvent {
  const ReceivedBaseDataEvent(this.data);

  final (HatimResponseType, List<MqHatimBaseEntity>) data;
}

@immutable
final class ResetJuzPagesEvent extends HatimEvent {
  const ResetJuzPagesEvent();
}
