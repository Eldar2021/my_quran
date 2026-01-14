import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

part 'hatim_crud_event.dart';
part 'hatim_crud_state.dart';

class HatimCrudBloc extends Bloc<HatimCrudEvent, HatimCrudState> {
  HatimCrudBloc({
    required this.repository,
    this.hatimId,
  }) : super(const HatimCrudInitial()) {
    on<GetHatimDataByIdEvent>(_onGetHatimDataByIdEvent);
    on<CreateHatimEvent>(_onCreateHatimEvent);
    on<UpdateHatimByIdEvent>(_onUpdateHatimByIdEvent);
    on<DeleteHatimByIdEvent>(_onDeleteHatimByIdEvent);
  }

  final MqHatimRepository repository;
  final String? hatimId;

  bool get isUpdate => hatimId != null;

  FutureOr<void> _onGetHatimDataByIdEvent(
    GetHatimDataByIdEvent event,
    Emitter<HatimCrudState> emit,
  ) async {
    try {
      emit(const HatimFetchedInitialDataLoading());
      final res = await repository.getHatimDataById(event.id);
      emit(HatimFetchedInitialDataSuccess(res));
    } on Object catch (e) {
      log('HatimCrudBloc _onGetHatimDataByIdEvent:', error: e);
      emit(HatimFetchedInitialDataError(e));
    }
  }

  FutureOr<void> _onCreateHatimEvent(
    CreateHatimEvent event,
    Emitter<HatimCrudState> emit,
  ) async {
    try {
      emit(const HatimCreateLoading());
      final res = await repository.createHatim(event.param);
      emit(HatimCreateSuccess(res));
    } on Object catch (e) {
      log('HatimCrudBloc _onCreateHatimEvent:', error: e);
      emit(HatimCreateError(e));
    }
  }

  FutureOr<void> _onUpdateHatimByIdEvent(
    UpdateHatimByIdEvent event,
    Emitter<HatimCrudState> emit,
  ) async {
    try {
      emit(const HatimUpdateLoading());
      final res = await repository.updateHatim(event.param);
      emit(HatimUpdateSuccess(res));
    } on Object catch (e) {
      log('HatimCrudBloc _onUpdateHatimByIdEvent:', error: e);
      emit(HatimUpdateError(e));
    }
  }

  FutureOr<void> _onDeleteHatimByIdEvent(
    DeleteHatimByIdEvent event,
    Emitter<HatimCrudState> emit,
  ) async {
    try {
      emit(const HatimDeleteLoading());
      await repository.deleteHatim(event.id);
      emit(const HatimDeleteSuccess());
    } on Object catch (e) {
      log('HatimCrudBloc _onDeleteHatimByIdEvent:', error: e);
      emit(HatimDeleteError(e));
    }
  }
}
