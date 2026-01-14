part of 'hatim_crud_bloc.dart';

sealed class HatimCrudState extends Equatable {
  const HatimCrudState();

  @override
  List<Object> get props => [];
}

@immutable
final class HatimCrudInitial extends HatimCrudState {
  const HatimCrudInitial();
}

/// Hatim initial data state
@immutable
final class HatimFetchedInitialDataLoading extends HatimCrudState {
  const HatimFetchedInitialDataLoading();
}

@immutable
final class HatimFetchedInitialDataSuccess extends HatimCrudState {
  const HatimFetchedInitialDataSuccess(this.data);

  final MqHatimModel data;
}

@immutable
final class HatimFetchedInitialDataError extends HatimCrudState {
  const HatimFetchedInitialDataError(this.error);

  final Object error;
}

/// Hatim creation state
@immutable
final class HatimCreateLoading extends HatimCrudState {
  const HatimCreateLoading();
}

@immutable
final class HatimCreateSuccess extends HatimCrudState {
  const HatimCreateSuccess(this.res);

  final MqHatimModel? res;
}

@immutable
final class HatimCreateError extends HatimCrudState {
  const HatimCreateError(this.error);

  final Object error;
}

/// Hatim update state
@immutable
final class HatimUpdateLoading extends HatimCrudState {
  const HatimUpdateLoading();
}

@immutable
final class HatimUpdateSuccess extends HatimCrudState {
  const HatimUpdateSuccess(this.res);

  final MqHatimModel? res;
}

@immutable
final class HatimUpdateError extends HatimCrudState {
  const HatimUpdateError(this.error);

  final Object error;
}

/// Hatim delete state
@immutable
final class HatimDeleteLoading extends HatimCrudState {
  const HatimDeleteLoading();
}

@immutable
final class HatimDeleteSuccess extends HatimCrudState {
  const HatimDeleteSuccess();
}

@immutable
final class HatimDeleteError extends HatimCrudState {
  const HatimDeleteError(this.error);

  final Object error;
}
