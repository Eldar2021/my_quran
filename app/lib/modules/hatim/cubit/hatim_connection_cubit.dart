import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hatim_connection_state.dart';

class HatimConnectionCubit extends Cubit<HatimConnectionState> {
  HatimConnectionCubit() : super(const HatimConnectionState());

  void setConnectionState(HatimConnectionStateType value) {
    if (!isClosed) {
      emit(state.copyWith(stateType: value));
    }
  }

  void setAppLifecycleState(HatimAppLifecycleStateType value) {
    if (!isClosed) {
      emit(state.copyWith(appLifecycleStateType: value));
    }
  }

  void setInternetState(HatimInternetStateType value) {
    if (!isClosed) {
      emit(state.copyWith(internetStateType: value));
    }
  }
}
