part of 'hatim_bloc.dart';

@immutable
sealed class HatimEvent {
  const HatimEvent();
}

@immutable
final class GetHatimDashBoardEvent extends HatimEvent {
  const GetHatimDashBoardEvent();
}

@immutable
final class ConnectToHatimdEvent extends HatimEvent {
  const ConnectToHatimdEvent(this.hatimId);
  final String hatimId;
}

@immutable
final class GetHatimJuzsEvent extends HatimEvent {
  const GetHatimJuzsEvent(this.hatimId);

  final String hatimId;
}

@immutable
final class GetHatimUserPagesEvent extends HatimEvent {
  const GetHatimUserPagesEvent();
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

  final HatimBaseResponse data;
}

@immutable
final class ReceidevJuzsDataEvent extends HatimEvent {
  const ReceidevJuzsDataEvent(this.data);

  final List<dynamic> data;
}

@immutable
final class ReceidevUserPagesEvent extends HatimEvent {
  const ReceidevUserPagesEvent(this.data);

  final List<dynamic> data;
}

@immutable
final class ReceidevJuzPagesEvent extends HatimEvent {
  const ReceidevJuzPagesEvent(this.data);

  final List<dynamic> data;
}

final class ResetJuzPagesEvent extends HatimEvent {
  const ResetJuzPagesEvent();
}
