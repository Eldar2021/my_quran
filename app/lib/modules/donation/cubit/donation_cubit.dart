import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

part 'donation_state.dart';

class DonationCubit extends Cubit<DonationState> {
  DonationCubit(this.repository) : super(const DonationInitial());

  final MqHomeRepository repository;

  Future<void> getDonation() async {
    emit(const DonationLoading());
    try {
      final donation = await repository.getDonationPageData();
      emit(DonationSuccess(donation));
    } catch (e) {
      emit(DonationError(e.toString()));
    }
  }
}
