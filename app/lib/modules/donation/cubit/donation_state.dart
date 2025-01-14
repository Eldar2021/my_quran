part of 'donation_cubit.dart';

@immutable
sealed class DonationState {
  const DonationState();
}

@immutable
final class DonationInitial extends DonationState {
  const DonationInitial();
}

@immutable
final class DonationLoading extends DonationState {
  const DonationLoading();
}

@immutable
final class DonationSuccess extends DonationState {
  const DonationSuccess(this.data);

  final MqDonationPageEntity data;
}

@immutable
final class DonationError extends DonationState {
  const DonationError(this.error);

  final Object? error;
}
